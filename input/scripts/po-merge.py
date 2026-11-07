#!/usr/bin/env python3
"""Make or update a locale's catalogues from this IG's .pot templates.

The templates are smart-base's layout: every source directory that is translated
has a `translations/` directory of `.pot` files (one per page for
input/pagecontent/, one `images.pot` for input/images/, one `diagrams.pot` for
input/images-source/). smart-base's injector (`inject_translations.py`) reads ONE
catalogue per locale per directory, `<dir>/translations/<locale>.po`. This merges
every `.pot` of a directory into that catalogue:

- a msgid appears once, in template order, with every template's references;
- a msgstr already in `<locale>.po` is kept, so re-running after the source
  changes keeps the translation (new msgids arrive empty, as msgmerge does);
- an entry whose msgid left the templates is kept as an obsolete `#~` entry;
- the header names the locale and says the translation is UNOFFICIAL: an agent
  translation is never signed off here.

gettext's msgmerge does this too, but the container and CI need not have it; this is
standard library only.

Run:
  python3 -I input/scripts/po-merge.py --locale fr            # write/update
  python3 -I input/scripts/po-merge.py --locale fr --status   # report only
  python3 -I input/scripts/po-merge.py --all --status         # every existing locale
--status exits 0; it reports, it does not judge (an untranslated string is not a failure).
"""
import argparse
import glob
import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DIRS = ["input/pagecontent/translations", "input/images/translations", "input/images-source/translations"]
LOCALES = ["ar", "es", "fr", "ru", "zh"]
NAMES = {"ar": "Arabic", "es": "Spanish", "fr": "French", "ru": "Russian", "zh": "Chinese (Simplified)"}
PLURALS = {
    "ar": "nplurals=6; plural=(n==0 ? 0 : n==1 ? 1 : n==2 ? 2 : n%100>=3 && n%100<=10 ? 3 : n%100>=11 ? 4 : 5);",
    "es": "nplurals=2; plural=(n != 1);",
    "fr": "nplurals=2; plural=(n > 1);",
    "ru": "nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);",
    "zh": "nplurals=1; plural=0;",
}
STR = re.compile(r'^"(.*)"$')


def parse(path):
    """Entries of a PO/POT file: dicts with comments, msgctxt, msgid, msgstr (escaped), obsolete."""
    entries, cur, key = [], None, None

    def flush():
        nonlocal cur
        if cur is not None and cur.get("msgid") is not None:
            entries.append(cur)
        cur = None

    for raw in open(path, encoding="utf-8").read().splitlines():
        obsolete = raw.startswith("#~ ")
        line = raw[3:] if obsolete else raw
        if not line.strip():
            flush()
            key = None
            continue
        if line.startswith("#") and not obsolete:
            if cur is None or cur.get("msgid") is not None and key == "msgstr":
                flush()
                cur = {"comments": [], "obsolete": False}
            cur["comments"].append(line)
            continue
        m = re.match(r'^(msgctxt|msgid|msgstr) (".*")$', line)
        if m:
            if cur is None or (m.group(1) in ("msgctxt", "msgid") and cur.get("msgid") is not None and key == "msgstr"):
                flush()
                cur = {"comments": [], "obsolete": obsolete}
            key = m.group(1)
            cur[key] = STR.match(m.group(2)).group(1)
            cur["obsolete"] = cur.get("obsolete") or obsolete
            continue
        m = STR.match(line)
        if m and cur is not None and key:
            cur[key] = cur.get(key, "") + m.group(1)
    flush()
    return entries


def ident(e):
    return (e.get("msgctxt"), e["msgid"])


def lit(key, value, prefix=""):
    return f'{prefix}{key} "{value}"'


def build(directory, locale):
    pots = sorted(glob.glob(os.path.join(ROOT, directory, "*.pot")))
    if not pots:
        return None
    order, merged = [], {}
    for pot in pots:
        for e in parse(pot):
            if e["msgid"] == "":
                continue
            k = ident(e)
            if k not in merged:
                merged[k] = {"comments": [], "msgctxt": e.get("msgctxt"), "msgid": e["msgid"]}
                order.append(k)
            for c in e["comments"]:
                if c.startswith("#,") and "fuzzy" in c:
                    continue
                if c not in merged[k]["comments"]:
                    merged[k]["comments"].append(c)
    po_path = os.path.join(ROOT, directory, f"{locale}.po")
    old = {ident(e): e for e in parse(po_path)} if os.path.exists(po_path) else {}
    for k in order:
        prev = old.get(k)
        merged[k]["msgstr"] = prev.get("msgstr", "") if prev and not prev.get("obsolete") else (prev or {}).get("msgstr", "")
        if prev and any(c.startswith("#,") and "fuzzy" in c for c in prev["comments"]):
            merged[k]["comments"].append("#, fuzzy")
    obsolete = [e for k, e in old.items() if k not in merged and k[1] != "" and e.get("msgstr")]
    return po_path, order, merged, obsolete


def header(locale, label):
    return "\n".join([
        f"# {NAMES[locale]} translation of this IG ({label}). UNOFFICIAL: an agent",
        "# translation, not signed off by a person. Generated by input/scripts/po-merge.py.",
        'msgid ""',
        'msgstr ""',
        '"Project-Id-Version: WHO SMART Guidelines\\n"',
        '"Last-Translator: agent (unofficial)\\n"',
        f'"Language-Team: {NAMES[locale]} (unofficial)\\n"',
        f'"Language: {locale}\\n"',
        '"MIME-Version: 1.0\\n"',
        '"Content-Type: text/plain; charset=UTF-8\\n"',
        '"Content-Transfer-Encoding: 8bit\\n"',
        f'"Plural-Forms: {PLURALS[locale]}\\n"',
        '"X-Official: false\\n"',
        '"X-Generated-By: agent\\n"',
    ])


def write(po_path, order, merged, obsolete, locale):
    label = os.path.relpath(os.path.dirname(os.path.dirname(po_path)), ROOT)
    old_header = None
    if os.path.exists(po_path):
        for e in parse(po_path):
            if e["msgid"] == "" and not e.get("obsolete"):
                old_header = e
                break
    out = []
    if old_header and old_header.get("msgstr"):
        out.append("\n".join(old_header["comments"] + ['msgid ""', 'msgstr ""']
                             + [f'"{p}\\n"' for p in old_header["msgstr"].split("\\n") if p]))
    else:
        out.append(header(locale, label))
    for k in order:
        e = merged[k]
        lines = list(e["comments"])
        if e.get("msgctxt") is not None:
            lines.append(lit("msgctxt", e["msgctxt"]))
        lines += [lit("msgid", e["msgid"]), lit("msgstr", e["msgstr"])]
        out.append("\n".join(lines))
    for e in obsolete:
        lines = []
        if e.get("msgctxt") is not None:
            lines.append(lit("msgctxt", e["msgctxt"], "#~ "))
        lines += [lit("msgid", e["msgid"], "#~ "), lit("msgstr", e["msgstr"], "#~ ")]
        out.append("\n".join(lines))
    with open(po_path, "w", encoding="utf-8") as fh:
        fh.write("\n\n".join(out) + "\n")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--locale", choices=LOCALES)
    g.add_argument("--all", action="store_true", help="every locale that already has a catalogue")
    ap.add_argument("--status", action="store_true", help="report only; write nothing")
    a = ap.parse_args()
    locales = [a.locale] if a.locale else [l for l in LOCALES if any(
        os.path.exists(os.path.join(ROOT, d, f"{l}.po")) for d in DIRS)]
    for locale in locales:
        for d in DIRS:
            r = build(d, locale)
            if r is None:
                continue
            po_path, order, merged, obsolete = r
            done = sum(1 for k in order if merged[k]["msgstr"])
            fuzzy = sum(1 for k in order if "#, fuzzy" in merged[k]["comments"])
            print(f"{locale} {os.path.relpath(po_path, ROOT)}: {done}/{len(order)} translated, "
                  f"{len(order) - done} empty, {fuzzy} fuzzy, {len(obsolete)} obsolete")
            if not a.status:
                write(po_path, order, merged, obsolete, locale)
    return 0


if __name__ == "__main__":
    sys.exit(main())
