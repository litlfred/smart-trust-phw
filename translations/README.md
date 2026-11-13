# translations/

The harness side of this IG's translations (`translation-sources`).

The catalogues are not here. smart-base's injector reads one catalogue per
locale per source directory, so they stay at
`input/{pagecontent,images,images-source}/translations/<locale>.po`, beside the
`.pot` templates smart-base's `extract_translations.py` writes. The directory
declaration in `smart-trust-phw.json` names that pattern in `catalogues`
(`input/*/translations/{locale}.po`), so `translation:glossary:check` reads them
from there.

This directory holds what the harness keeps per layer: `glossary-sense.json`,
the adjudicator's sense verdicts for the glossary check, once there are any.
