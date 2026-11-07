# Review: consent codes backed by a specification

Owner, 2026-11-07: no invented consent codes. Use codes that a specification
defines, with a well-defined glossary and states, and check their use for
ODRL. This review compares the candidates. The owner chose the first row, the
layered HL7 and IHE PCF option.

| Candidate | What it defines | Status | Use here |
| --- | --- | --- | --- |
| HL7 v3 `ActConsentDirective` (CodeSystem v3-ActCode, in `hl7.terminology` 5.5.0, which this guide pins) | Kinds of consent, each with a definition: `OPTIN`, `OPTINR`, `OPTOUT`, `OPTOUTE`, `GRANTORCHOICE`, `IMPLIED`, `IMPLIEDD`, `NOPP`, `NOCONSENT`, `EMRGONLY` | HL7 terminology (THO) | **Chosen**: `Consent.category`; explicit = `OPTIN`/`OPTINR`/`OPTOUT`/`OPTOUTE`, implied = `IMPLIED`/`IMPLIEDD`/`NOPP` |
| FHIR R4 `Consent.status` | States: `draft`, `proposed`, `active`, `rejected`, `inactive`, `entered-in-error` | HL7 FHIR R4 (normative for this resource's status codes) | **Chosen**: the state of a consent |
| IHE PCF 1.1.0 implicit policies (Volume 1 §1:53.2.1) | `Policy-basic-normal`, `Policy-all-normal`, `Policy-break-glass-only`, `Policy-deny` | IHE Trial Implementation, pinned | **Chosen**: a trust domain's default, and the base an explicit consent changes |
| GDHCN Trust IG `TrustDomain.termsOfUse` (litlfred/smart-trust) | A trust domain's own consent codes, each defined by the consent text shown | Draft logical model | Only where a real domain publishes them (IPS-PILGRIMAGE: `IPS.HAJJ.CONSENT`) |
| W3C Data Privacy Vocabulary (DPV) | Consent types (implied, expressed, explicitly expressed) and states (given, withdrawn, expired, refused) | W3C Community Group, not a Recommendation; GDPR-oriented | Possible later mapping for the VC and ODRL side; the current spec could not be read from this session (`w3c.github.io` blocked) |
| ISO/IEC TS 27560:2023, Kantara Consent Receipt v1.1 | The structure of a consent record or receipt, not codes | ISO text paywalled; Kantara open (2018) | Not used: structure, not codes |
| GA4GH Data Use Ontology (DUO) | Permitted research uses of data | GA4GH standard (2019) | Not used: research data access, not care |
| W3C VC 2.0 `termsOfUse` with ODRL 2.2 | How a policy is named, not codes | W3C Recommendations | Already used to name a trust domain's policy |

## ODRL

fhir-harness's `consentToOdrl()` translates each IHE PCF implicit policy into
an ODRL 2.2 `Set`. It reads `Consent.policy` and `Consent.policyRule`, but not
`Consent.category`. The kind of consent says which of those Sets a consent
builds on, through `odrl:inheritFrom`: `OPTIN`, `OPTINR` and `OPTOUT` on
`Policy-deny`, `OPTOUTE` on `Policy-basic-normal`, and an implied consent on
its own policy. The Consent page sets out this mapping. Reading `category`
in `consentToOdrl()` is a proposed change to fhir-harness, which this
repository does not change.

## Sources

- HL7 Terminology, ValueSet v3-ActConsentDirective: https://terminology.hl7.org/ValueSet-v3-ActConsentDirective.html
- W3C DPVCG, Consent States: https://www.w3.org/community/dpvcg/wiki/Consent_States ; consent concepts proposal: https://lists.w3.org/Archives/Public/public-dpvcg/2022Jul/0003.html
- Implementing ISO/IEC TS 27560:2023 consent records and receipts: https://arxiv.org/pdf/2405.04528 ; Kantara resources: https://kantara.atlassian.net/wiki/x/E4As
- GA4GH, DUO approved as a technical standard: https://ga4gh.org/news/data-use-ontology-approved-as-a-ga4gh-technical-standard
