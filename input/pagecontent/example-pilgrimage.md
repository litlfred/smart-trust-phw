This page is a worked example. It applies the [business processes](business-processes.html) A, B, C, F and I of this guide to one case: the **IPS Pilgrimage** (Hajj) implementation guide (`smart-ips-pilgrimage`, FHIR R4, IHE PCF 1.1.0). It follows the analysis written for [folio-assistant#2702](https://github.com/litlfred/folio-assistant/issues/2702) on 2026-10-30.

The case: during Hajj, the host country (KSA) is the **VHL Receiver**. It asks the pilgrim's origin country (for example Malaysia) for the pilgrim's International Patient Summary (IPS) over a Verifiable Health Link (VHL). The origin country's health information exchange (HIE) is the **VHL Sharer**. The IPS carries two consent statements from the pilgrim, and those two Consents are the policy for the exchange.

The page does not change the IPS Pilgrimage guide. The gaps below say what that guide, or the specifications it uses, would need. Gap G1 has since been resolved in that guide by [smart-ips-pilgrimage#3](https://github.com/litlfred/smart-ips-pilgrimage/pull/3).

### The pilgrim's consents are the policy

For Hajj, there is no separate data sharing agreement for the Sharer to look up. The pilgrim's two Consents are the policy, and each is coded in `Consent.policyRule` (owner, Q-DRAIN-5, 2026-11-01 07:44Z). That is how the IPS Pilgrimage guide models them since [smart-ips-pilgrimage#3](https://github.com/litlfred/smart-ips-pilgrimage/pull/3). `policyRule` holds a code from that guide's `IPS.HAJJ.CONSENT` CodeSystem, with `coding.version` set to the CodeSystem version whose consent text the pilgrim was shown. Any arrangement between KSA and the origin country, such as a memorandum of understanding, stays outside the computable decision. Each Consent binds the party it names:

| Consent | What it allows | Who is bound, and where it is checked |
| --- | --- | --- |
| **Origin release** (`CONSENT-<origin>`, for example `CONSENT-MYS`) | The origin HIE may release the IPS to the KSA Ministry of Health, as information recipient, for treatment, during the Hajj period. | The **origin HIE**. It enforces this Consent from **its own Consent Registry** (`[ITI-108]`) at step 10. The Consent's `decide()` result is one row of the default DMN decision [`PHW.DT.AgreementAccess`](business-processes.html#combining-several-agreements-dmn-phwdtagreementaccess) (`PHW.F.10`). |
| **Host use** (`CONSENT-KSA`) | The KSA Ministry of Health may use the IPS for care during Hajj and any follow-up. | **KSA**, which follows it after receipt (step 14). The origin does not enforce it. |

The receiver is identified by trust: its key or certificate is accepted in the `ips-pilgrimage` trust domain (`PHW.I.2`, `PHW.I.3`). There is no agreement lookup at `PHW.I.4`.

"Patient-mediated" then means three things, each an existing mechanism:

1. The pilgrim records the consents (PCF `[ITI-108]`, process A).
2. The pilgrim carries the link (the VHL QR code, `[ITI-YY4]`, process C).
3. The pilgrim is present at the encounter. Giving the **passcode** (the VHL `P` flag; ITI-YY5 §2:3.YY5.5.8) is the in-person act.

**The registry copy is enforced; the IPS copy is evidence.** The IPS Bundle also carries copies of both Consents. They travel with the data as evidence for KSA. The Sharer does not enforce them: it enforces the copy in its own Consent Registry. The IPS is signed once, when it is issued, so its copy cannot show a later withdrawal (consent rule 4).

### The flow, step by step

The Hajj encounter, mapped onto VHL and onto the activities of this guide. Steps that hit a gap name it; the gaps are listed in the next section.

#### Before Hajj

| # | Step | Actor | PHW activities | Transaction | Gap |
| --- | --- | --- | --- | --- | --- |
| 1 | **Trust.** The origin HIE publishes its signing keys to the `ips-pilgrimage` trust domain. GDHCN is the trust anchor here, as one option among others. KSA must also publish its own keys or certificates there, so that the origin can authenticate it at step 9. | Origin HIE, Trust Anchor | `PHW.B.1`, `PHW.B.2` | `[ITI-YY1]` | G3 |
| 2 | **Registration.** With the OAuth with SSRAA option, KSA's EMR registers with the origin HIE by UDAP (HL7 SSRAA), using a certificate that chains to an anchor of the `ips-pilgrimage` trust domain. With HTTP Message Signatures, nothing is registered: the origin reads KSA's key from the trust list. No agreement URL is involved. | Origin HIE, KSA EMR | `PHW.D.9`, `PHW.D.10` | — | G3 |
| 3 | **Counselling and consent.** A counsellor explains the plain-language text of each consent (consent rule 3). The wallet records both Consents in the origin's Consent Registry. Each Consent's `policyRule` names which Hajj consent it is (`CONSENT-<origin>` or `CONSENT-KSA`), and its `coding.version` names the `IPS.HAJJ.CONSENT` version whose text the pilgrim was shown. That version pins the text, which is the role consent rule 2 gives `policy.uri` elsewhere. | Pilgrim, Consent Recorder, Consent Registry | `PHW.A.1`, `PHW.A.2`, `PHW.A.3`, `PHW.A.5`, `PHW.A.6` | `[ITI-108]` | |
| 4 | **IPS.** The origin HIE generates the Hajj IPS Bundle, with both Consents as entries, and signs it. | Origin HIE | — (IPS Pilgrimage guide) | — | G2 |
| 5 | **VHL.** The wallet asks for a VHL with a passcode and an expiry. The Sharer checks that the Consents are active, then signs the link. The link's expiry should not run past the Consents' `provision.period`. | Pilgrim, Origin HIE | `PHW.B.3`, `PHW.B.4`, `PHW.B.5`, `PHW.B.6`, `PHW.B.7` | `[ITI-YY3]`, `[ITI-108]` | |

#### At the encounter in KSA

| # | Step | Actor | PHW activities | Transaction | Gap |
| --- | --- | --- | --- | --- | --- |
| 6 | The pilgrim shows the QR code and gives the passcode. | Pilgrim | `PHW.C.1` | `[ITI-YY4]` | |
| 7 | The KSA EMR verifies the HCERT/CWT signature against the trust list. | KSA EMR, Trust Anchor | `PHW.C.2`, `PHW.C.3`, `PHW.C.4` | `[ITI-YY2]` | |
| 8 | The KSA EMR registers the pilgrim with the pilgrimage number. | KSA EMR | — (IPS Pilgrimage guide, step 03) | — | |
| 9 | **The KSA EMR sends Retrieve Manifest with the passcode, authenticated by one VHL option.** The IPS Pilgrimage guide uses mTLS node authentication (`[ITI-19]`) today, which is not one of VHL's options. | KSA EMR | `PHW.I.1` | `[ITI-YY5]` | G3, G4, G5 |
| 10 | **The origin HIE decides.** (a) It authenticates KSA by trust in the `ips-pilgrimage` trust domain. There is no agreement lookup: the Consents are the policy. (b) It searches its own registry for the pilgrim's active origin-release Consent (`policyRule` = `CONSENT-<origin>`). (c) It evaluates that Consent with `decide()` (see the conditions below). The result is the Consent's row in the default DMN decision `PHW.DT.AgreementAccess`, whose `outcome` routes the request. (d) Anything missing gives `unknown`, and `unknown` is never `permit`. | Origin HIE, Consent Registry | (a) `PHW.I.2`, `PHW.I.3`; (b) `PHW.I.5` → `PHW.F.8`, `PHW.F.9`; (c) `PHW.F.10`; (d) `PHW.F.11`, `PHW.I.6` or `PHW.I.7` | `[ITI-YY5]`, `[ITI-YY2]`, `[ITI-108]` | G2 |
| 11 | **Audit.** The origin HIE records an audit event. It cites the governing Consents by `policyRule` code and CodeSystem version, the `id` and `meta.versionId` of each Consent read for the decision, which of them permitted, the DMN decision used, the receiver, the purpose, and the documents released or the refusal. | Origin HIE, writing to the Audit Record Repository | `PHW.I.9` (with `PHW.G.1`) | `[ITI-20]` | |
| 12 | The origin HIE returns the `List` and its `DocumentReference`s (`_include=List:item`, VHL's Include DocumentReference Option), then the IPS. | Origin HIE | `PHW.I.6` | `[ITI-YY5]`, `[ITI-68]` | |
| 13 | The KSA EMR verifies the IPS signature, stores a copy and shows it. | KSA EMR | `PHW.I.11` | — | |
| 14 | **KSA follows `CONSENT-KSA` after receipt.** Its duties (for example, keep the IPS for follow-up care only) come from that Consent's text. Nothing machine-readable travels with the document to say so yet. | KSA Ministry of Health | process G (`PHW.G.5`, `PHW.G.6`) | — | G6 |

**When does step 10 permit?** Only when every one of these holds:

* the passcode is valid;
* the link has not expired;
* the origin-release Consent is active in the origin's own registry;
* the KSA Ministry of Health, as verified by trust in the `ips-pilgrimage` trust domain, is the consented actor (`provision.actor`);
* the purpose is treatment (`provision.purpose` = `TREAT`);
* today is inside the Hajj period (`provision.period`).

The origin-release Consent is found by its `policyRule` code (`CONSENT-<origin>`), and its `coding.version` names the consent text the pilgrim was shown. The KSA-use Consent binds KSA, not the origin, so the origin does not need it to permit. With only one Consent applicable, the default DMN decision returns that Consent's own result.

### Gaps

Ordered by how much each one blocks a computable decision. Each row names the existing standard that would close it. Nothing here invents a field.

| Gap | What is missing | What would close it |
| --- | --- | --- |
| **G1. The Hajj consents are not computable as written. Resolved** by [smart-ips-pilgrimage#3](https://github.com/litlfred/smart-ips-pilgrimage/pull/3). | Was: the consent *type* sat in `provision.purpose`, the examples had display names only, and `policyRule.text` was `"some policy"`, so `decide()` would return `unknown` every time. Still open in that guide: the consent texts for two origin countries (`CONSENT-IDN`, `CONSENT-OMN`) are placeholders (consent rule 3). | `HajjConsent` now requires `policyRule` with an `IPS.HAJJ.CONSENT` code and `coding.version` (CodeSystem version 2.1.0). `policyRule` also satisfies R4 invariant `ppc-1`, so no `policy.uri` is needed. It also requires `provision.actor` (an Organization by identifier, role `IRCP`), `provision.purpose` from v3 PurposeOfUse (`TREAT`), and `provision.period`. See the [examples](#example-consents) below. |
| **G2. Which copy of a consent counts.** | The specifications do not say whether the Sharer enforces the registry copy or the copy inside the IPS, or what KSA should do with its copy. | A rule in the implementation guide, not a new field: the Sharer enforces the registry copy (PCF `[ITI-108]`); the IPS copy is evidence, carrying its `meta.versionId` so that KSA can cite it. |
| **G3. mTLS is not a VHL option.** | The IPS Pilgrimage guide's sequence diagram still authenticates the KSA node with mTLS (`[ITI-19]`). Since smart-ips-pilgrimage#3, its transaction page says that mTLS is not one of VHL `[ITI-YY5]`'s three options and recommends OAuth with SSRAA. How KSA's certificate or key is published in the `ips-pilgrimage` trust domain is still not specified. | Choose one VHL option: **OAuth with SSRAA (UDAP)**, approved for process D and I, which is X.509-based like mTLS; or HTTP Message Signatures (RFC 9421). KSA publishes the matching key in the trust domain (`[ITI-YY1]`). |
| **G4. The facility and the clinician are invisible.** | `CONSENT-KSA` is limited to healthcare facilities in the Hajj district, but the request comes from one national KSA EMR. With HTTP Message Signatures, the Sharer sees only KSA, so it cannot check the district limit and the audit cannot name who looked. | HL7 SSRAA: the `hl7-b2b` extension carries `organization_id` and the requesting user (SSRAA §5.2.1.1). |
| **G5. The purpose of use is not carried.** | `[ITI-YY5]` has no purpose parameter, so the decision assumes `TREAT` from the Consent's `provision.purpose`. This is open point 3 of [process I](business-processes.html#i-decide-a-verifiable-health-link-request-under-an-existing-data-sharing-agreement). | HL7 SSRAA `purpose_of_use` in `hl7-b2b` (SSRAA §5.2.1.1), with HL7 v3 PurposeOfUse codes. |
| **G6. KSA's duties after receipt are not machine-readable.** | `CONSENT-KSA` allows "any follow up care" and says nothing about retention or onward sharing. Nothing in VHL, IPS or PCF carries such obligations with the document. | Either HL7 Data Segmentation for Privacy (DS4P) obligation codes in `meta.security` (**needs owner approval**: not final), or, with approved standards only, KSA keeps following the `CONSENT-KSA` text it is bound by and audits against it in process G, with no labels on the document. |
| **G7. What the audit event cites. Resolved** by smart-ips-pilgrimage#3. | Was: the IPS Pilgrimage guide had `[ITI-20]` at the origin HIE but did not say what the event contains. | That guide now states it, as process I gives it (`PHW.I.9`): the Consents by `policyRule` code and CodeSystem version, each Consent's `id` and `meta.versionId`, receiver, purpose and documents released or the refusal. KSA, as an ATNA Secure Node (VHL Vol 1 §1:XX.3), also audits what it receives. IHE BALP patterns need owner approval. |
| **G8. Break the glass has no VHL.** | In phase 2 of the IPS Pilgrimage guide (process 5.0) the pilgrim may be unconscious: no QR code and no passcode, so the lookup is by pilgrimage number, outside VHL entirely. | Its own search transaction (likely IHE PDQm `[ITI-78]` with IHE MHD `[ITI-67]`), a separate opt-in Consent (the wallet's "break the glass" setting), and the emergency purpose of use `ETREAT`. Not specified today. |
| **G9. Versions and status.** | The IPS Pilgrimage guide does not depend on VHL. It describes the VHL steps in its own transaction pages, partly in older SMART Health Links wording ("modified ITI-67"). Its `HajjConsent` notes on FHIR R5 (`verification.verifiedBy`, `Consent.period`) are for later. | Depend on IHE VHL and cite it as what it is: 1.0.0-comment, a public-comment ballot. The guide's `_include=List:item` already matches VHL's Include DocumentReference Option. FHIR R4 with PCF 1.1.0 already matches the approved PCF version. |

### Example consents

The two Consents below match the `HajjConsent` examples of [smart-ips-pilgrimage#3](https://github.com/litlfred/smart-ips-pilgrimage/pull/3). They are **FHIR R4** resources on the IHE PCF 1.1.0 profile `IHE.PCF.consentIntermediate`, which `HajjConsent` is built on. This guide is built on FHIR R4 4.0.1 too, and the two are instances of its [PHW Explicit Consent](StructureDefinition-PHWExplicitConsent.html) profile: each names a Hajj consent code in `policyRule` and has the consent text the pilgrim was shown as its evidence.

Every name, identifier, URL and date is a fictional example:

* The pilgrim, the Malaysian HIE and the Saudi Ministry of Health are stand-ins, as in smart-ips-pilgrimage#3. Their identifiers are `example.org` URLs.
* 2025-05-01 to 2025-08-31 stands in for the Hajj period (Hajj 1446/2025, as the `IPS.HAJJ.CONSENT` 2.1.0 text says), with time for follow-up care.

Both Consents permit the same recipient, for the same purpose and period. They differ in which Hajj consent they are (`policyRule`), and so in the text the pilgrim was shown (`sourceAttachment`) and in whom they bind: the first lets the origin release the IPS, and the second lets the host use it. Only existing elements are used: `policyRule` (with `coding.version`), `provision.actor`, `provision.purpose` and `provision.period`. There is no `policy.uri`, because there is no separate agreement.

The instances are in this guide's artefacts: [PilgrimConsentOriginRelease](Consent-PilgrimConsentOriginRelease.html) and [PilgrimConsentHostUse](Consent-PilgrimConsentHostUse.html), both [PHW Explicit Consent](StructureDefinition-PHWExplicitConsent.html), with the [pilgrim](Patient-PilgrimExample.html), the [origin HIE](Organization-OriginHIEExample.html) and the [host Ministry of Health](Organization-HostMoHExample.html).

How step 10 reads them: the origin HIE takes the active Consent whose `policyRule` is its own release code (`CONSENT-MYS`) from its registry (`PHW.F.8`). It matches `provision.actor.reference.identifier` against the receiver as verified by trust in the `ips-pilgrimage` trust domain (`PHW.I.2`), `provision.purpose` against the purpose (`TREAT`; see G5), and `provision.period` against today. That Consent's `decide()` result feeds the default DMN decision `PHW.DT.AgreementAccess` (`PHW.F.10`). `PilgrimConsentHostUse` (`CONSENT-KSA`) binds the host Ministry of Health after receipt and is not part of the origin's decision. The audit event (`PHW.I.9`) cites each Consent read, by `policyRule` code and version and by the `id` and `meta.versionId` the registry assigned at `PHW.A.5`.

### Open questions for the owner

* **G6:** approve DS4P obligation codes, or keep KSA's duties in the `CONSENT-KSA` text only?
* **G8:** is break the glass in scope now?
