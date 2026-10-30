# AGENTS.md — smart-trust-phw

This file is agent-generic: Claude Code, Gemini CLI, Cursor, Copilot and others
read it natively. What binds everywhere is the harness's
[`AGENTS.md`](https://github.com/litlfred/cat-harness/blob/HEAD/AGENTS.md); what
this repository *is* is [`README.md`](README.md).

## What this instance is

The WHO SMART Guidelines Personal Health Wallet (PHW) implementation guide on
the GDHCN Trust Network: FHIR IG source under `input/`, built by the IG
Publisher. It takes the smart-hiv shape (owner, 2026-10-14). It has no harness
of its own: `index.config.json` mounts `smart-base` and the layers below it,
and `smart-trust-phw.json` declares what an index may mount from here.

## The one rule

**The mounted graphs are generated from the IG's AST at publish, never authored.**
`fhir-artifact-index/` is not committed: fhir-harness's `ig-index:build`
writes its `index.json`, `menu.json`, `releases.json` and `package.tgz` at
publish from the IG's AST (fhir-harness#124), so never commit, hand-edit or
re-ingest them. `document-kinds/` holds this IG's DAK coverage report,
generated at publish from `fhir-artifact-index/` by `smart-base:document-kinds`.
`fhir-artifact-index/` is declared `readOnly`. A hand edit silently changes
what this repository claims upstream published; `check:materialized-fixity`
and the writers' `--check` catch one.

## What an index mounts from here

folio-assistant mounts two directories, `fhir-artifact-index/` and
`document-kinds/`, plus this file and the README as declared assets. The IG
source (`input/`) is not mounted. Neither is `docs/`, which is built at publish
by `smart-trust-phw:pages` (fhir-harness's `gen-ig-pages.ts`) and never
committed. `fhir-ast/` is restored from its cache branch by `ig-cache.sh`.

## Before running SUSHI

Read fhir-harness's [`fhir-validation`](https://github.com/litlfred/fhir-harness/blob/main/skills/content/fhir-ig-authoring/fhir-validation.md#when-a-package-host-refuses-you)
§"When a package host refuses you" first. Where packages.fhir.org is refused,
`fhir-cache-seed-npm` fills the package cache from npm and
fhir-package-mirror at exact versions only. Never report "SUSHI cannot run
here" before running the seeder, and never stand in another version for a pin;
its `--missing-out` list is what the mirror still needs.
