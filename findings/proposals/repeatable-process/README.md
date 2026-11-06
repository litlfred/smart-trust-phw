# Proposal: bring smart-trust-phw into the repeatable instance process

Status: **proposal, for the owner's choice.** No cleanup is made until the
owner picks options. This document is the only change in its pull request.

Where it lives: the brief asked for `docs/proposals/repeatable-process/`,
but `docs/` here is declared as wholly generated at publish and is
gitignored (`AGENTS.md`, the one rule). Authored review material goes in
`findings/`, as smart-ips-pilgrimage does (`1ef036c`).

Compared against `litlfred/smart-trust-demo` (main `aea4f64` and branch
`claude/confident-hypatia-6g67t9-device-screens` `51d4a12`) and
`litlfred/smart-ips-pilgrimage` (main `71e5db8` and branch
`claude/confident-hypatia-6g67t9-device-screens` `3a9acdd`), and the
`litlfred/folio-assistant` index (main), all read on 2026-11-06.

Tags used below:

- **[pin]**: the change moves what the folio-assistant index pins or
  mounts. The index follows `main` of this repository by standing consent
  (2026-11-01), so a merge here reaches the index on the next re-pin train.
- **[site]**: the change shows on the published site.
- Effort: **S** (under an hour), **M** (a session), **L** (several sessions).

## 1. What smart-trust-phw is today

- A FHIR R5 IG (`input/`, `sushi-config.yaml`) built by the IG Publisher,
  with no harness of its own. `index.config.json` mounts `smart-base` and
  its closure (`who-iris`, `fhir-harness`, `folio-assistant-core`,
  `cat-harness`, `cat-harness-tools`, `bootstrap`, `bootstrap-tools`) and
  itself at `.`; the DAK identity is `contentTypes.dak`.
- `smart-trust-phw.json` declares six directories: `fhir-ast/`,
  `fhir-artifact-index/`, `document-kinds/`, `docs/`, `library/`,
  `catalogue/`.
- **folio-assistant** pins it at `13b9359` (this repository's current
  `main`) and mounts **four** of them: `library`, `smart-trust-phw-catalogue`,
  `smart-trust-phw-artifact-index`, `smart-trust-phw-document-kinds`.
  `folio-assistant/package.json` carries the `smart-trust-phw:pages` script.
- CI: `harness-pr-checks.yml` (cat-harness-tools `layer-pr-checks.yml`,
  index mode) and `ig-ast-refresh.yml` run on events; `fhirbuild.yml`,
  `release.yml` and `site-publish.yml` are manual.
- Content: eleven BPMN processes `PHW.A` to `PHW.K`, one DMN decision
  (`PHW.DT.AgreementAccess`), the IHE PCF 1.1.0 and VHL 1.0.0-comment
  snapshots in `library/`, a catalogue, and a worked example of the Hajj
  case (`example-pilgrimage.md`).
- Open PR: #33 (draft, `claude/declare-ig-outputs`) also edits
  `smart-trust-phw.json`; any change below to the declaration rebases on it.

## 2. The pattern the two other instances follow

Read from their `AGENTS.md`, declarations, workflows, tools and the last
two weeks of commits.

| Pattern element | smart-trust-demo | smart-ips-pilgrimage | smart-trust-phw |
|---|---|---|---|
| `<name>.json` with directories and graph typologies | yes, 13 directories, a visualiser | yes, 11 directories (branch), `journeys` visualiser, avatar, `builtAtPublish` | yes, 6 directories, no visualiser, no avatar, no `builtAtPublish` in the declaration (it is in `.gitignore` text only) |
| `index.config.json` / `index.lock.json` pinning layers with consent | yes | yes, 2026-11-05 freeze set | yes, **2026-11-02 set** (round 8), behind both |
| Business processes declared as a directory | `processes/` | `input/business-processes/` declared (`business-processes`) | **not declared**; the processes viewer draws nothing for PHW |
| `scenarios/` actors with `meta.persona`, `roles.json` | yes | yes (branch) | **no**; `personas.md` and `scenarios.md` are template text |
| `user-scenarios/` in `user-scenario/0.2.0`, partOf / follows | yes | yes (branch): parent journey plus one sub-journey per moment | **no** |
| `workshops/` (`workshop/0.1.0`) | yes | yes (branch) | **no**; the policy questions sit as prose gaps in `example-pilgrimage.md` |
| `device-screens/` | yes (branch) | yes (branch) | no |
| Generators with `--check` | `ig_gen.py --check`, `render_bpmn.ts --check`, `bpmn:checklist` compare | harness checks only (`layer-pr-checks`) | harness checks only; BPMN SVGs are hand-copied |
| `check:journey-refs` and other CI checks | yes | yes, via the re-pinned cat-harness-tools | not reachable at the current pins |
| gh-pages published by an agent; `main` to root, branches to `branches/<slug>/` | yes (`365f696`) | yes (`gh-pages` exists) | **no `gh-pages` branch**; `site-publish.yml` is a verbatim template copy still saying `STAGING/<branch>/` |
| Illustrations with no baked-in text, titles as page text | yes | yes (`ddf95cc`: titles cropped out, alt text, `illustrationStyle` says "no readable text") | no illustrations; the BPMN and PlantUML drawings carry English labels from their sources |
| `AGENTS.md` with a cold start | yes, runnable | short, with a Builds section | short; no cold start, no Rules; its mount table is wrong |
| Every person fictional, stated as a rule | yes | yes | not stated (no personas yet) |

## 3. Findings: stale, duplicated, hand-maintained, inconsistent, dead

1. **Duplicated BPMN drawings.** `input/business-processes/PHW.{A..I}.svg`
   and `input/images/PHW.{A..I}.svg` both exist. D to I are byte-identical;
   **A, B and C differ**; J and K exist only in `input/images/`. The pages
   embed `input/images/`. Nothing regenerates either copy or checks it.
2. **Template residue.** Twelve pages still hold
   `[insert health domain here]` (concepts, decision-logic, dictionary,
   functional-requirements, index, index-dak, index-ig, indicators,
   indicators-measures, personas, reference-implementations,
   security-privacy). `badges.md` has `<REPO_OWNER>/<REPO_NAME>`.
   `input/data/features.yaml` names `smart-empty`. `_build.new.bat` (April)
   and a root-level `Requirements-fromNarrative.json` (an empty Requirements
   stub outside `input/`) are leftovers. Sixteen `input/` folders hold only
   a `.gitignore`. `business-process.md` and `trust_domain_use_cases.md` are
   empty; `trust_domain_policy.md` and `trust_domain_specifications.md` are
   not in the menu.
3. **A committed machine-local file.** `.claude/settings.local.json` is one
   contributor's local permission list, with absolute Windows paths to their
   home directory and downloads. It is not configuration for this
   repository.
4. **`AGENTS.md` says the index mounts six directories**; folio-assistant
   mounts four (not `fhir-ast/`, not `docs/`).
5. **The site has never been published from this fork**: no `gh-pages`
   branch. `site-publish.yml` is the platform template copied unchanged; its
   header says "No instance declaration, no `package.json`", which this
   repository has, and it publishes previews to `STAGING/<branch>/`, which
   the harness replaced with `branches/<slug>/` on 2026-11-05.
6. **Pins are four days behind** the set smart-ips-pilgrimage and
   smart-trust-demo publish with, which carry `user-scenario/0.2.0`,
   `workshop/0.1.0`, the journeys viewer, `check:journey-refs` and
   `branches/` previews.
7. **The README and `publication-request.json` point at the WHO
   repository's CI build and QA badges**, which is right for the upstream
   but says nothing about this fork's own site.
8. **Personas and actors live in three places that do not meet**:
   `input/fsh/actors/actors.fsh` (SGActor instances: Trust Anchor, Trust
   Network Participant, Holder, Receiver, Issuer, Consent Registry, ...),
   `system-actors.md` (hand-written restatement of the same list), and
   BPMN lanes.

## 4. Proposed changes, ordered by value

### C1. Remove `.claude/settings.local.json` and ignore it — S

- **What:** delete the file; add `.claude/settings.local.json` to
  `.gitignore`.
- **Why:** it is a contributor's machine-local file with personal paths;
  it was never meant to be shared.
- **Pros:** privacy hygiene; no effect on any build.
- **Cons/risks:** none known; history still holds it (rewriting history
  is not proposed).
- **Tags:** none.

### C2. Re-pin to the current freeze set — S/M

- **What:** move `index.config.json` / `index.lock.json` and the workflow
  `uses:` pins to the set smart-ips-pilgrimage pins (2026-11-05), or to
  folio-assistant's current set, with a consent record for each layer.
- **Why:** every pattern element below (journeys viewer, user scenarios
  0.2.0, workshops, `check:journey-refs`, `branches/` previews) needs it.
- **Pros:** one step unlocks the rest; reduces drift from the index.
- **Cons/risks:** a re-pin can surface new gate failures in
  `harness-pr-checks` that must be fixed in the same PR; the device-screen
  kind is still on a cat-harness-tools branch, so pin `main` and leave
  device screens for later.
- **Tags:** **[pin]** (lock content changes), **[site]** (chrome).

### C3. One source for each BPMN drawing, generated and checked — M

- **What:** keep `input/business-processes/PHW.*.bpmn` as the only
  source; render every `.svg` into one place with the harness's
  `render-bpmn` (as smart-ips-pilgrimage does), delete the other copy, and
  fail CI when a committed drawing differs from what the renderer makes.
  Declare `input/business-processes/` as a `business-processes` directory.
- **Why:** A to C already disagree; J and K have only one copy. Declared,
  the processes viewer draws PHW and the journeys can link to its tasks.
- **Pros:** removes the duplication and the drift; the drawings follow the
  BPMN, so a translated BPMN label yields a translated drawing.
- **Cons/risks:** the A to C drawings will change to whatever the BPMN
  says today (review the diff); the renderer needs Chromium in CI.
- **Tags:** **[site]**; **[pin]** only if the index chooses to mount the
  new directory.

### C4. Clean the template residue — M

- **What:** fill or remove the twelve placeholder pages (with the owner
  choosing per page: write PHW content, or drop the page and its menu
  entry); delete `badges.md`, `_build.new.bat`, the root
  `Requirements-fromNarrative.json`, the empty pages, and the
  `.gitignore`-only folders under `input/` that the `ig` content type does
  not need; fix `input/data/features.yaml`; link or drop the two orphan
  trust-domain pages.
- **Why:** each placeholder becomes a string the translation team would
  translate for nothing; the site shows "[insert health domain here]".
- **Pros:** smaller, honest site; smaller translation surface.
- **Cons/risks:** some folders are kept for the WHO template's tooling; the
  `ig` content type's `include` list in `index.config.json` names them, so
  trim it in the same change. Diverges further from the WHO upstream
  template (merges from upstream get more conflicts).
- **Tags:** **[site]**; **[pin]** if `index.config.json` changes.

### C5. Personas and roles as harness content — M

- **What:** `scenarios/roles.json` naming the guide's actors (the SGActor
  instances in `input/fsh/actors/actors.fsh`), and `scenarios/actors/` with
  one file per fictional person and per system, each person with a
  `meta.persona`. `personas.md` then shows them instead of template text.
- **Why:** this is the shape both other instances use; journeys, workshops
  and device screens all refer to actors by id.
- **Pros:** one place for personas; the journeys viewer and
  `check:journey-refs` can resolve them.
- **Cons/risks:** a second list of actors beside the FSH ones unless
  `roles.json` points to them by URL (recommended), rather than restating.
- **Tags:** **[site]**; declaration change.

### C6. User scenarios and a workshop — L

Three options for whose story PHW tells:

- **A (recommended). A PHW journey of its own.** One fictional holder
  across processes A (consent), B (issue a VHL), C (present and redeem),
  H (revoke), plus a server-to-server case (D to G, I). Parent journey and
  one `user-scenario/0.2.0` sub-journey per moment, `realisedBy` the PHW
  BPMN tasks; a workshop with the policy question of each moment.
  - Pros: PHW's processes get a story that exercises all of them; no
    overlap with the pilgrimage guide.
  - Cons: the largest effort; new illustrations from the owner.
- **B. Reference the pilgrimage's journeys.** Keep `example-pilgrimage.md`
  as the worked example, and make its steps link to smart-ips-pilgrimage's
  `user-scenarios/` by id; PHW adds only a workshop of its gaps G1..Gn.
  - Pros: no second copy of Kamal's story; small.
  - Cons: cross-instance references; PHW's DSA processes (D to I) get no
    journey.
- **C. Do nothing now.**
- **Tags:** **[site]** (journeys page); declaration change; **[pin]** only
  if the index mounts the new directories.

### C7. Publish the site by an agent; retire the template workflow — S/M

- **What:** publish with `stage-local.ts` from an agent's checkout:
  `main` to the gh-pages root, every other branch to `branches/<slug>/`.
  Either delete `site-publish.yml` (as smart-ips-pilgrimage has no such
  workflow), or keep it with its template header replaced by what this
  repository is.
- **Why:** there is no published site for this fork; the template's text
  contradicts the repository.
- **Pros:** the translation team and reviewers get a URL per branch.
- **Cons/risks:** creates a `gh-pages` branch and a public site under
  `litlfred.github.io/smart-trust-phw/`; the first publish may surface link
  failures that must be fixed first.
- **Tags:** **[site]** (first publish).

### C8. `AGENTS.md` and README in the instance shape — S

- **What:** fix the mount table (four directories mounted by the index);
  add a runnable Cold start (as smart-trust-demo has), a Rules section
  (every person fictional; every dependency pinned, no packages added; WHO
  repositories read-only; gh-pages by an agent; no text baked into
  pictures), and a Builds section (which workflows run on events). Point
  the README at the fork's site once C7 lands.
- **Why:** the cold start is how the next agent starts; today it is wrong
  about the mounts.
- **Pros:** cheap; prevents repeat mistakes.
- **Cons/risks:** none.
- **Tags:** **[pin]** (`AGENTS.md` and README are declared assets the
  index carries).

### C9. Translation readiness — M (after C3 and C4)

- **What:** declare a `translations/` directory (`translation-sources`, as
  smart-base does) for gettext templates extracted from the pages, BPMN
  labels and PlantUML sources, one folder per target locale (ar, es, fr,
  ru, zh); keep every title, caption and label in text (page Markdown,
  BPMN `name`, PlantUML source, `alt`), never in a raster image; any
  future illustration follows `illustrationStyle` "no readable text".
  The `.pot` files are generated, not hand-written.
- **Why:** the UN-language team translates PHW next.
- **Pros:** the team translates sources once; drawings re-render per
  locale.
- **Cons/risks:** depends on smart-base's extraction tooling at the pinned
  commit; until a translation service is registered (that needs a secret
  the owner sets), the `.pot` files are produced but not pulled back.
- **Tags:** **[site]**; declaration change.

### C10. Leave the inherited WHO workflows manual — S

- **What:** keep `fhirbuild.yml` and `release.yml` manual and say so in
  `AGENTS.md` (as smart-ips-pilgrimage does).
- **Why / pros:** they are the upstream's build; running them here gains
  nothing. **Cons:** none. **Tags:** none.

### Not proposed

- Local Python tools copied from smart-trust-demo (`tools/repo-checks`,
  `tools/ig-gen`). smart-ips-pilgrimage shows an IG instance can rely on the
  harness's checks instead; adding a local `tools/` would be a second copy
  to keep in step.
- Device screens: wait until the kind is on cat-harness-tools `main`.

## 5. Suggested bundles

| Bundle | Changes | Effort |
|---|---|---|
| Minimal | C1, C4 (residue only), C8 | S/M |
| Recommended | C1, C2, C3, C4, C5, C7, C8, C9 | M/L |
| Full pattern | Recommended + C6 A | L |

## 6. The repeatable process, as steps another instance can follow

1. **Declare.** Write `<name>.json` (`cat-harness-declaration/1.0.0`):
   assets `AGENTS.md` and `README.md`; one directory per thing an index may
   mount, each with its `graphTypologies`; `builtAtPublish` for everything
   computed at publish; `readOnly` for generated directories; a visualiser
   when it has journeys.
2. **Mount.** `index.config.json` names the layers and itself at `.`, each
   remote layer with a commit and a consent record (`by`, `on`, `ref`,
   `evidence`); `contentTypes` holds the DAK identity and the `ig`
   include list. `bun run cat mount:lock` writes `index.lock.json`; the
   mounts are gitignored, the lock committed.
3. **Processes.** BPMN in one declared directory; drawings rendered from it
   by the harness renderer and checked for drift; DMN beside the tasks it
   serves.
4. **People.** `scenarios/roles.json` and `scenarios/actors/`, every person
   fictional, each with `meta.persona`.
5. **Journeys.** `user-scenarios/` in `user-scenario/0.2.0`: a parent
   journey and one sub-journey per moment (`partOf`, `follows`), steps
   `realisedBy` BPMN tasks, `examples` and `references`, with `gaps` for
   what is not yet specified. Not nested inside another declared directory.
6. **Workshops.** `workshops/*.workshop.json`, one question per moment.
7. **Pictures.** Illustrations carry no text; the step title, caption and
   `alt` are page text; the style prompt lives in `illustrationStyle`.
8. **Generated content.** Generated files are never hand-edited; each
   generator has a `--check` that CI runs; directory READMEs come from
   `readme:subgraphs`.
9. **CI.** One reusable `layer-pr-checks.yml` call in index mode, pinned to
   the lock's commit; draft PRs run the fast tier. Actions pinned by SHA,
   least-privilege `permissions:`.
10. **Publish.** An agent runs `stage-local.ts`: `main` to the gh-pages
    root, other branches to `branches/<slug>/`.
11. **Cold start.** `AGENTS.md`: what the instance is, its rules, the
    commands that lay down the mounts, and how to publish.
12. **Translate.** Extract `.pot` templates from text sources into a
    declared `translations/` directory; translators never edit images.
