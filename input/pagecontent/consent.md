This page describes how a Personal Health Wallet handles consent. Consent follows **IHE Privacy Consent on FHIR (PCF) 1.1.0**. Each trust domain sets the consent policies that apply in it. The processes on this page are trust-anchor neutral: GDHCN is one possible trust anchor among others.

### Two kinds of consent

Each consent records its kind in `Consent.category` with a code from **HL7 v3 `ActConsentDirective`** ([CodeSystem v3-ActCode](https://terminology.hl7.org/CodeSystem-v3-ActCode.html)). HL7 defines every one of these codes; this guide adds none.

| | Explicit consent | Implied consent |
| --- | --- | --- |
| What it is | The holder agrees, or refuses, by their own act: on their wallet, or on a form a health worker records. | The holder does nothing. The trust domain's default policy applies. |
| Kind (`Consent.category`, HL7 ActConsentDirective) | `OPTIN` (opt-in), `OPTINR` (opt-in with restrictions), `OPTOUT` (opt-out), `OPTOUTE` (opt-out with exceptions): [PHW Explicit Consent Kind](ValueSet-PHWExplicitConsentKind.html) | `IMPLIED` (implied consent), `IMPLIEDD` (implied consent with opportunity to dissent), `NOPP` (notice of privacy practices): [PHW Implied Consent Kind](ValueSet-PHWImpliedConsentKind.html) |
| How it is recorded | A [PHW Explicit Consent](StructureDefinition-PHWExplicitConsent.html) in the Consent Registry ([process L](business-processes.html#l-record-explicit-consent), IHE PCF `[ITI-108]`). | Not recorded per holder. A document may carry it as a [PHW Implied Consent](StructureDefinition-PHWImpliedConsent.html). |
| The policy | `Consent.policyRule`: the trust domain's consent code with its version, when the domain publishes consent codes. Otherwise `Consent.policy.uri`: the IHE PCF implicit policy the consent changes. | `Consent.policy.uri`: the trust domain's default policy, normally an IHE PCF implicit policy (`Policy-basic-normal`, `Policy-all-normal`, `Policy-break-glass-only` or `Policy-deny`). |
| The evidence (`Consent.source[x]`) | The holder's recorded act: the wallet confirmation or the signed form. | The trust domain's published policy. |
| State | `Consent.status` (FHIR R4): `proposed`, `active`, `rejected`, `inactive` (withdrawn or expired), `entered-in-error`. | The same. |

IHE PCF does not allow `Consent.verification`, so the kind is carried in `category`. Both kinds are IHE PCF Intermediate Consents ([PHW Consent](StructureDefinition-PHWConsent.html)).

An opt-in trust domain has `Policy-deny` as its default, so data is shared only with explicit consent. An opt-out trust domain has `Policy-basic-normal` or `Policy-all-normal` as its default, so data is shared unless the holder dissents.

#### The kind and ODRL

Consent is decided by translating it to W3C ODRL 2.2 (`consentToOdrl()` in fhir-harness), where each IHE PCF implicit policy is an ODRL `Set`. The kind says which of those Sets a consent builds on, through ODRL's `inheritFrom`:

| Kind | Builds on (`odrl:inheritFrom`) | What the consent adds |
| --- | --- | --- |
| `OPTIN`, `OPTINR` | `Policy-deny` | Its permissions (`OPTINR`: with the holder's restrictions as prohibitions or constraints) |
| `OPTOUT` | `Policy-deny` | Nothing: the holder refuses |
| `OPTOUTE` | `Policy-basic-normal` | Its prohibitions, with the holder's exceptions as permissions |
| `IMPLIED`, `IMPLIEDD`, `NOPP` | Its own `Consent.policy` | Nothing: the implied consent is its policy's Set |

So a receiver, or the Sharer's decision point, can tell from the code alone what holds when no permission matches. Reading `category` this way is a proposed change to `consentToOdrl()`, which today reads `policy` and `policyRule` only.

### Trust domains and their consent codes

A trust domain may name its own consent policies as a terms-of-use ValueSet (`TrustDomain.termsOfUse` in the [GDHCN Trust IG](https://smart.who.int/trust/trust_domains.html)). Each code's definition is the text the holder is shown. An explicit consent names one of these codes in `policyRule`. A VHL Receiver's credential names one in its `termsOfUse` (see [process I](business-processes.html#i-decide-a-verifiable-health-link-request-under-an-existing-data-sharing-agreement)). The Sharer finds the trust domain from the ValueSet that holds the code.

For the IPS Pilgrimage trust domain, the codes are `IPS.HAJJ.CONSENT` in the IPS Pilgrimage guide, for example `CONSENT-MYS` and `CONSENT-KSA`. The [worked example](example-pilgrimage.html) shows the two Hajj consents as [PilgrimConsentOriginRelease](Consent-PilgrimConsentOriginRelease.html) and [PilgrimConsentHostUse](Consent-PilgrimConsentHostUse.html).

### Consent directives in shared and issued documents

A document that is shared or issued may carry the consent directives it is shared under, explicit or implied. Carrying them is optional: the trust domain, or the holder in the wallet, decides. [Process M](business-processes.html#m-add-consent-directives-to-a-shared-or-issued-document) adds them before the document is signed. Process B calls it at step B5a and process J at step J2a.

- Each directive is a `consent` entry of the document Bundle ([IPS document that carries its consent directives](StructureDefinition-PHWDocumentWithConsent.html)).
- The Composition's Advance Directives section (LOINC 42348-3) lists them, with a summary that a person can read.
- **The copy in the document is evidence.** The sharer enforces the copy in its own Consent Registry. A signed document cannot show a later withdrawal.

[LinaSummaryWithConsent](Bundle-LinaSummaryWithConsent.html) is an example. Lina's patient summary carries her explicit consent, an `OPTIN` ([LinaExplicitConsent](Consent-LinaExplicitConsent.html)), and the trust domain's default, an `IMPLIEDD` under `Policy-basic-normal` ([LinaImpliedConsent](Consent-LinaImpliedConsent.html)). Every person in the examples is fictional.

### Deciding access

When a link is redeemed (process C) or a request comes under an agreement (processes F and I), the sharer reads the active Consents from its registry with `[ITI-108]`. It translates them to W3C ODRL 2.2 and decides `permit`, `deny` or `unknown`. A missing, expired or unreachable consent never gives `permit`. The decision is recorded as W3C PROV-O provenance that cites `Consent.id` and `Consent.meta.versionId`.
