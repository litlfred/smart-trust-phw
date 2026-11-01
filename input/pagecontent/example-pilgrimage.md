This page is a worked example. It applies the [business processes](business-processes.html) A, B, C, F and I of this guide to one case: the **IPS Pilgrimage** (Hajj) implementation guide (`smart-ips-pilgrimage`, FHIR R4, IHE PCF 1.1.0). It follows the analysis written for [folio-assistant#2702](https://github.com/litlfred/folio-assistant/issues/2702) on 2026-10-30.

The case: during Hajj, the host country (KSA) is the **VHL Receiver**. It asks the pilgrim's origin country (for example Malaysia) for the pilgrim's International Patient Summary (IPS) over a Verifiable Health Link (VHL). The origin country's health information exchange (HIE) is the **VHL Sharer**. The IPS carries two consent statements from the pilgrim, so the exchange is a patient-mediated computable data sharing agreement (CDSA).

The page does not change the IPS Pilgrimage guide. The gaps below say what that guide, or the specifications it uses, would need.

### Two layers: the agreement and the pilgrim's consents

The case fits processes A, B, C and I, with process F making the decision, when "patient-mediated CDSA" is read as two layers.

| Layer | What it is | Parties | Where it is checked |
| --- | --- | --- | --- |
| **The agreement** | The arrangement between KSA and the origin country for Hajj (today a memorandum of understanding, or the "Agreed IPS workflow" in the IPS Pilgrimage guide). Its legal basis is **consent** (consent rule 1 under [process A](business-processes.html#a-record-and-manage-patient-privacy-consent)). | Origin country HIE (Sharer) and KSA Ministry of Health (Receiver) | `PHW.I.4`: the Sharer finds the agreement from KSA's verified identity |
| **The pilgrim's consents** | Two PCF `Consent`s: one lets the origin release the IPS (`CONSENT-<origin>` in the IPS Pilgrimage guide), one lets KSA use it for care during Hajj and follow-up (`CONSENT-KSA`). | The pilgrim grants them; the KSA Ministry of Health is the recipient; the origin HIE holds them | `PHW.F.8`–`PHW.F.10`: a consent-based agreement also needs an active PCF `Consent`, read from the origin's Consent Registry (`[ITI-108]`) |

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
| 2 | **Agreement.** The origin HIE registers KSA's EMR as a client under the agreement's fixed-version URL, with UDAP (HL7 SSRAA) or HTTP Message Signature keys. | Origin HIE, KSA EMR | `PHW.D.6`, `PHW.D.9`, `PHW.D.10` | — | |
| 3 | **Counselling and consent.** A counsellor explains the plain-language text of each consent (consent rule 3). The wallet records both Consents in the origin's Consent Registry. Each Consent's `policy.uri` is the agreement version's fixed URL (consent rule 2). | Pilgrim, Consent Recorder, Consent Registry | `PHW.A.1`, `PHW.A.2`, `PHW.A.3`, `PHW.A.5`, `PHW.A.6` | `[ITI-108]` | G1 |
| 4 | **IPS.** The origin HIE generates the Hajj IPS Bundle, with both Consents as entries, and signs it. | Origin HIE | — (IPS Pilgrimage guide) | — | G2 |
| 5 | **VHL.** The wallet asks for a VHL with a passcode and an expiry. The Sharer checks that the Consents are active, then signs the link. The link's expiry should not run past the Consents' `provision.period`. | Pilgrim, Origin HIE | `PHW.B.3`, `PHW.B.4`, `PHW.B.5`, `PHW.B.6`, `PHW.B.7` | `[ITI-YY3]`, `[ITI-108]` | |

#### At the encounter in KSA

| # | Step | Actor | PHW activities | Transaction | Gap |
| --- | --- | --- | --- | --- | --- |
| 6 | The pilgrim shows the QR code and gives the passcode. | Pilgrim | `PHW.C.1` | `[ITI-YY4]` | |
| 7 | The KSA EMR verifies the HCERT/CWT signature against the trust list. | KSA EMR, Trust Anchor | `PHW.C.2`, `PHW.C.3`, `PHW.C.4` | `[ITI-YY2]` | |
| 8 | The KSA EMR registers the pilgrim with the pilgrimage number. | KSA EMR | — (IPS Pilgrimage guide, step 03) | — | |
| 9 | **The KSA EMR sends Retrieve Manifest with the passcode, authenticated by one VHL option.** The IPS Pilgrimage guide uses mTLS node authentication (`[ITI-19]`) today, which is not one of VHL's options. | KSA EMR | `PHW.I.1` | `[ITI-YY5]` | G3, G4, G5 |
| 10 | **The origin HIE decides.** (a) It authenticates KSA against the trust list and finds the Hajj agreement from KSA's verified identity. (b) The agreement's legal basis is consent, so it searches its own registry for the pilgrim's active Consents. (c) It evaluates the request (see the conditions below). (d) Anything missing gives `unknown`, and `unknown` is never `permit`. | Origin HIE, Consent Registry | (a) `PHW.I.2`, `PHW.I.3`, `PHW.I.4`; (b) `PHW.I.5` → `PHW.F.8`, `PHW.F.9`; (c) `PHW.F.10`; (d) `PHW.F.11`, `PHW.I.7` | `[ITI-YY5]`, `[ITI-YY2]`, `[ITI-108]` | G1, G2 |
| 11 | **Audit.** The origin HIE records an audit event that cites the agreement URL, the `id` and `meta.versionId` of both Consents, the receiver and the documents released. | Origin HIE, Audit Record Repository | `PHW.I.9`, `PHW.I.10` (with `PHW.G.1`) | `[ITI-20]` | G7 |
| 12 | The origin HIE returns the `List` and its `DocumentReference`s (`_include=List:item`, VHL's Include DocumentReference Option), then the IPS. | Origin HIE | `PHW.I.6` | `[ITI-YY5]`, `[ITI-68]` | |
| 13 | The KSA EMR verifies the IPS signature, stores a copy and shows it. | KSA EMR | `PHW.I.11` | — | |
| 14 | **KSA's own duties** (for example, keep the IPS for follow-up care only) come from the text of the KSA-use consent. Nothing machine-readable travels with the document to say so yet. | KSA Ministry of Health | process G (`PHW.G.5`, `PHW.G.6`) | — | G6 |

**When does step 10 permit?** Only when every one of these holds:

* the passcode is valid;
* the link has not expired;
* the origin-release Consent is active;
* the KSA-use Consent is active;
* the KSA Ministry of Health is the consented actor (`provision.actor`);
* the purpose is treatment (`provision.purpose` = `TREAT`);
* today is inside the Hajj period (`provision.period`).

Both Consents must also cite the agreement version the Sharer found at `PHW.I.4` in `policy.uri` (`PHW.F.8`).

### Gaps

Ordered by how much each one blocks a computable decision. Each row names the existing standard that would close it. Nothing here invents a field.

| Gap | What is missing | What would close it |
| --- | --- | --- |
| **G1. The Hajj consents are not computable as written.** | The IPS Pilgrimage guide's `HajjConsent` puts the consent *type* (`CONSENT-KSA`, `CONSENT-MYS`) in `provision.purpose`, where FHIR R4 and PCF expect a purpose of use. Its example has `patient.display` and `organization.display` only, and `policyRule.text = "some policy"`. `decide()` would return `unknown` every time. The consent texts for two origin countries are still placeholders, so nothing can be hashed or consented to (consent rule 3). | Existing FHIR R4 / PCF 1.1.0 elements: `provision.actor` (the KSA Ministry of Health by identifier, role `IRCP`), `provision.purpose` = v3 PurposeOfUse `TREAT`, `provision.period` = the Hajj dates, `policy.uri` = the agreement's fixed-version URL. The consent type moves to `category`, or stays a code that the agreement's version text defines. See the [examples](#example-consents) below. |
| **G2. Which copy of a consent counts.** | The specifications do not say whether the Sharer enforces the registry copy or the copy inside the IPS, or what KSA should do with its copy. | A rule in the implementation guide, not a new field: the Sharer enforces the registry copy (PCF `[ITI-108]`); the IPS copy is evidence, carrying its `meta.versionId` so that KSA can cite it. |
| **G3. mTLS is not a VHL option.** | The IPS Pilgrimage guide authenticates the KSA node with mTLS (`[ITI-19]`). VHL `[ITI-YY5]` names three options (HTTP Message Signatures, Verifiable Credential, OAuth with SSRAA), and does not say how a receiver's client certificate reaches the Sharer's trust list. Whether the `ips-pilgrimage` trust domain carries KSA client certificates has not been checked. | Choose one VHL option: **OAuth with SSRAA (UDAP)**, approved for process D and I, which is X.509-based like mTLS; or HTTP Message Signatures (RFC 9421). KSA publishes the matching key in the trust domain (`[ITI-YY1]`). |
| **G4. The facility and the clinician are invisible.** | `CONSENT-KSA` is limited to healthcare facilities in the Hajj district, but the request comes from one national KSA EMR. With HTTP Message Signatures, the Sharer sees only KSA, so it cannot check the district limit and the audit cannot name who looked. | HL7 SSRAA: the `hl7-b2b` extension carries `organization_id` and the requesting user (SSRAA §5.2.1.1). |
| **G5. The purpose of use is not carried.** | `[ITI-YY5]` has no purpose parameter, so the decision assumes `TREAT` from the agreement. This is open point 3 of [process I](business-processes.html#i-decide-a-verifiable-health-link-request-under-an-existing-data-sharing-agreement). | HL7 SSRAA `purpose_of_use` in `hl7-b2b` (SSRAA §5.2.1.1), with HL7 v3 PurposeOfUse codes. |
| **G6. KSA's duties after receipt are not machine-readable.** | `CONSENT-KSA` allows "any follow up care" and says nothing about retention or onward sharing. Nothing in VHL, IPS or PCF carries such obligations with the document. | Either HL7 Data Segmentation for Privacy (DS4P) obligation codes in `meta.security` (**needs owner approval**: not final), or, with approved standards only, the duties in the ODRL 2.2 Agreement, which KSA audits against in process G with no labels on the document. |
| **G7. What the audit event cites.** | The IPS Pilgrimage guide has `[ITI-20]` at the origin HIE but does not say what the event contains. | IHE ATNA `[ITI-20]` with the content process I gives (`PHW.I.9`): agreement URL, Consent `id`s and `meta.versionId`s, receiver, purpose and documents released. KSA, as an ATNA Secure Node (VHL Vol 1 §1:XX.3), also audits what it receives. IHE BALP patterns need owner approval. |
| **G8. Break the glass has no VHL.** | In phase 2 of the IPS Pilgrimage guide (process 5.0) the pilgrim may be unconscious: no QR code and no passcode, so the lookup is by pilgrimage number, outside VHL entirely. | Its own search transaction (likely IHE PDQm `[ITI-78]` with IHE MHD `[ITI-67]`), a separate opt-in Consent (the wallet's "break the glass" setting), and the emergency purpose of use `ETREAT`. Not specified today. |
| **G9. Versions and status.** | The IPS Pilgrimage guide does not depend on VHL. It describes the VHL steps in its own transaction pages, partly in older SMART Health Links wording ("modified ITI-67"). Its `HajjConsent` notes on FHIR R5 (`verification.verifiedBy`, `Consent.period`) are for later. | Depend on IHE VHL and cite it as what it is: 1.0.0-comment, a public-comment ballot. The guide's `_include=List:item` already matches VHL's Include DocumentReference Option. FHIR R4 with PCF 1.1.0 already matches the approved PCF version. |

### Example consents

The two Consents below follow G1. They are **FHIR R4** resources on the IHE PCF 1.1.0 profile `IHE.PCF.consentIntermediate`, as the IPS Pilgrimage guide uses. This guide is built on FHIR R5, where `Consent` has no `policy.uri`, so they are given here as FSH and are not instances of this guide. They were compiled with SUSHI 3.21.0 against `hl7.fhir.r4.core` 4.0.1 and `ihe.iti.pcf` 1.1.0, with no errors.

Every name, identifier, URL and date is a fictional example:

* The pilgrim, the "Origin Country A" HIE and the "Host Country K" Ministry of Health stand in for a real pilgrim, the origin HIE and the KSA Ministry of Health. Their identifiers are `example.org` URLs.
* `https://agreements.example.org/hajj/origin-a--host-k/v1` stands in for the fixed-version URL of the agreement.
* 2027-04-15 to 2027-07-15 stands in for the Hajj period, with time for follow-up care.

Both Consents permit the same recipient, for the same purpose and period, under the same agreement version. They differ in what the pilgrim was shown (`sourceAttachment`) and agreed to: the first lets the origin release the IPS, the second lets the host use it. Only existing elements are used: `provision.actor`, `provision.purpose`, `provision.period` and `policy.uri`. Where the IPS Pilgrimage guide's `CONSENT-<origin>` and `CONSENT-KSA` codes would go (`category`, or the agreement's version text) is left to that guide (G1).

```fsh
Alias: $PCFIntermediate = https://profiles.ihe.net/ITI/PCF/StructureDefinition/IHE.PCF.consentIntermediate
Alias: $v3-ActReason = http://terminology.hl7.org/CodeSystem/v3-ActReason
Alias: $v3-ParticipationType = http://terminology.hl7.org/CodeSystem/v3-ParticipationType
Alias: $consentscope = http://terminology.hl7.org/CodeSystem/consentscope
Alias: $LOINC = http://loinc.org

// FHIR R4 (4.0.1) and IHE PCF 1.1.0. All names, identifiers and URLs are fictional examples.

Instance: PilgrimExample
InstanceOf: Patient
Title: "Pilgrim (fictional)"
Usage: #example
* identifier.system = "https://hie.origin-a.example.org/fhir/sid/pilgrimage-number"
* identifier.value = "PILG-0000-0001"
* name.family = "Example"
* name.given = "Amina"
* gender = #female
* birthDate = "1970-01-01"

Instance: OriginHIEExample
InstanceOf: Organization
Title: "Origin country HIE (fictional): Sharer and Consent Registry custodian"
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://hie.origin-a.example.org/"
* name = "Origin Country A Health Information Exchange (example)"

Instance: HostMoHExample
InstanceOf: Organization
Title: "Host country Ministry of Health (fictional): VHL Receiver"
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://moh.host-k.example.org/"
* name = "Host Country K Ministry of Health (example)"

Instance: PilgrimConsentOriginRelease
InstanceOf: $PCFIntermediate
Title: "Pilgrim consent: the origin HIE may release the IPS to the host Ministry of Health"
Description: "The first of the pilgrim's two Hajj consents (the origin-release consent, the role CONSENT-<origin> plays in the IPS Pilgrimage IG). Permit, to the host Ministry of Health as information recipient, for treatment, during the example Hajj period, under one fixed version of the agreement."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* patient = Reference(PilgrimExample)
* dateTime = "2027-03-01T09:00:00+00:00"
* performer = Reference(PilgrimExample)
* organization = Reference(OriginHIEExample)
* sourceAttachment.contentType = #text/plain
* sourceAttachment.url = "https://agreements.example.org/hajj/origin-a--host-k/v1/consent-origin-release.txt"
* sourceAttachment.title = "Plain-language summary shown to the pilgrim: origin release (agreement v1)"
* policy.uri = "https://agreements.example.org/hajj/origin-a--host-k/v1"
* provision.type = #permit
* provision.period.start = "2027-04-15"
* provision.period.end = "2027-07-15"
* provision.actor.role = $v3-ParticipationType#IRCP "information recipient"
* provision.actor.reference.identifier.system = "urn:ietf:rfc:3986"
* provision.actor.reference.identifier.value = "https://moh.host-k.example.org/"
* provision.actor.reference.display = "Host Country K Ministry of Health (example)"
* provision.purpose = $v3-ActReason#TREAT "treatment"

Instance: PilgrimConsentHostUse
InstanceOf: $PCFIntermediate
Title: "Pilgrim consent: the host Ministry of Health may use the IPS for care during Hajj"
Description: "The second of the pilgrim's two Hajj consents (the host-use consent, the role CONSENT-KSA plays in the IPS Pilgrimage IG). Permit, to the host Ministry of Health as information recipient, for treatment, during the example Hajj period and its follow-up, under the same fixed version of the agreement."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* patient = Reference(PilgrimExample)
* dateTime = "2027-03-01T09:05:00+00:00"
* performer = Reference(PilgrimExample)
* organization = Reference(OriginHIEExample)
* sourceAttachment.contentType = #text/plain
* sourceAttachment.url = "https://agreements.example.org/hajj/origin-a--host-k/v1/consent-host-use.txt"
* sourceAttachment.title = "Plain-language summary shown to the pilgrim: host use (agreement v1)"
* policy.uri = "https://agreements.example.org/hajj/origin-a--host-k/v1"
* provision.type = #permit
* provision.period.start = "2027-04-15"
* provision.period.end = "2027-07-15"
* provision.actor.role = $v3-ParticipationType#IRCP "information recipient"
* provision.actor.reference.identifier.system = "urn:ietf:rfc:3986"
* provision.actor.reference.identifier.value = "https://moh.host-k.example.org/"
* provision.actor.reference.display = "Host Country K Ministry of Health (example)"
* provision.purpose = $v3-ActReason#TREAT "treatment"
```

How step 10 reads them: the Sharer matches `provision.actor.reference.identifier` against the receiver's verified identity (`PHW.I.2`), `policy.uri` against the agreement found at `PHW.I.4` (`PHW.F.8`), `provision.purpose` against the purpose (`TREAT`; see G5), and `provision.period` against today. It then cites each Consent's `id` and `meta.versionId`, assigned by the registry at `PHW.A.5`, in the audit event (`PHW.I.9`).

### Open questions for the owner

* **G6:** approve DS4P obligation codes, or keep KSA's duties in the ODRL Agreement only?
* **G8:** is break the glass in scope now?
