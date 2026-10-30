# AGENTS.md — smart-trust-phw

This file is agent-generic: Claude Code, Gemini CLI, Cursor, Copilot and others
read it natively. What binds everywhere is the harness's
[`AGENTS.md`](https://github.com/litlfred/cat-harness/blob/HEAD/AGENTS.md); what
this repository *is* is [`README.md`](README.md).

## What this instance is

The Personal Health Wallet (PHW) implementation guide: FHIR IG source under
`input/`, built by the IG Publisher. It takes the `smart-trust` / `smart-hiv`
shape (owner, 2026-10-14 and 2026-10-30, beans `folio-assistant-nr5p` and
`folio-assistant-y0o0`). It has no harness of its own: `index.config.json`
mounts `smart-base` and the layers below it, and `smart-trust-phw.json`
declares what an index may mount from here.

## Privacy Consent on FHIR (IHE PCF 1.1.0) and Verifiable Health Links (IHE VHL)

Before authoring, translating, or evaluating privacy consent directives or
consent-bearing health links in this repository, read fhir-harness's
[`pcf-consent`](https://github.com/litlfred/fhir-harness/blob/main/skills/content/fhir-ig-authoring/pcf-consent.md)
skill:

- **Model (`pcf-consent` §1):** IHE PCF 1.1.0 (Trial Implementation) and HL7
  FHIR R4 `Consent` (Trial Use) are approved (owner decision, 2026-10-30,
  `litlfred/folio-assistant#2702`). Pin `ihe.iti.pcf: 1.1.0` and
  `ihe.iti.vhl: 1.0.0-comment` in `sushi-config.yaml` and reference IHE
  profiles (`IHE.PCF.consentBasic`, `IHE.PCF.consentIntermediate`,
  `IHE.PCF.consentAdvanced`) and value sets (`BasicPurposeVS`,
  `AdvancedSecurityTagVS`) **by canonical URL only** — never re-declare them
  locally. Implement Basic consent and Additional `PurposeOfUse` first, make
  **no IUA claim**, and keep every process and profile **trust-anchor neutral**
  (GDHCN is only one possible trust anchor among others).
- **Translate (`pcf-consent` §2):** `consentToOdrl()` in
  `fhir-harness/schemas/pcf-consent.ts` (`folio-assistant-jx7m`, PCF5)
  translates PCF `Consent` resources and the four IHE PCF Volume 1 §1:53.2.1
  implicit-policy `Set`s (`Policy-basic-normal`, `Policy-all-normal`,
  `Policy-break-glass-only`, `Policy-deny`) into W3C ODRL 2.2 `Set` policies
  using HL7 v3 `ActReason` `PurposeOfUse` (`odrl:purpose` `odrl:isA`) and
  `odrl:dateTime` period constraints.
- **Decide (`pcf-consent` §3):** `decide()` / `permits()` evaluates access
  requests to `"permit" | "deny" | "unknown"` (never silent `"permit"` on a
  missing, expired, or unreachable `Consent`), integrates with IHE ITI-108
  Consent Registry reads (`fhir-harness/schemas/iti-108-consent-client.ts`,
  `folio-assistant-r9vk`, PCF7) and `odrl:obtainConsent` duties
  (`folio-assistant-a7c1`, PCF6), and cites `Consent.id` +
  `Consent.meta.versionId` in hash-chained PROV-O decision records
  (`folio-assistant-2egb`, PCF8).

## The one rule

**Mounted artefact indexes are generated copies, never hand-edited.**
`fhir-artifact-index/` is written at publish by fhir-harness's `ig-index:build`
from the IG's AST, and `library/` snapshots of external specifications (such as
IHE PCF 1.1.0 and IHE VHL 1.0.0-comment, `folio-assistant-sl5v`, PCF2) carry
checked SHA-256 fixity (`check:materialized-fixity`).

## Before running SUSHI

Read fhir-harness's
[`fhir-validation`](https://github.com/litlfred/fhir-harness/blob/main/skills/content/fhir-ig-authoring/fhir-validation.md#when-a-package-host-refuses-you)
§"When a package host refuses you" first. Where `packages.fhir.org` is refused,
`fhir-cache-seed-npm` fills the package cache from npm and
`fhir-package-mirror` at exact versions only. Never report "SUSHI cannot run
here" before running the seeder, and never stand in another version for a pin;
when an R5 IG build against `ihe.iti.pcf@1.1.0` hits an R4-in-R5 cross-version
resolver error, report it as `could-not-determine` with its exact diagnostic.
