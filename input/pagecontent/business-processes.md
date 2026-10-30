This page describes the core business processes and workflows for the **Personal Health Wallet (PHW)** Implementation Guide, integrating **IHE IT Infrastructure Privacy Consent on FHIR (PCF) v1.1.0** (`https://profiles.ihe.net/ITI/PCF/1.1.0/`) and **IHE IT Infrastructure Verifiable Health Links (VHL) v1.0.0-comment** (`https://profiles.ihe.net/ITI/VHL/1.0.0-comment/`).

A business process is a set of related activities or tasks performed together by system actors and human personas to achieve a health information exchange objective. Each workflow below is authored in **BPMN 2.0** (`input/business-processes/PHW.A.bpmn`, `input/business-processes/PHW.B.bpmn`, `input/business-processes/PHW.C.bpmn`) with full BPMN Diagram Interchange (`bpmndi:BPMNDiagram`) layout and rendered to SVG (`input/images/PHW.A.svg`, `input/images/PHW.B.svg`, `input/images/PHW.C.svg`).

### Architectural Principles

1. **Trust-Anchor Neutrality**: Every process models PKI key publication (`[ITI-YY1]`) and trust list retrieval (`[ITI-YY2]`) against an abstract **Trust Anchor** actor (`https://profiles.ihe.net/ITI/VHL/ActorDefinition/TrustAnchor`). The **WHO Global Digital Health Certification Network (GDHCN)** is one possible Trust Anchor implementation among others (such as national health PKI roots, regional cross-border trust networks, or bilateral federation anchors).
2. **Explicit IHE PCF and VHL Transaction Binding**: Every cross-actor task names its normative IHE transaction (`[ITI-108]` Access Consent, `[ITI-YY1]` Submit PKI Material with DID, `[ITI-YY2]` Retrieve Trust List with DID, `[ITI-YY3]` Generate VHL, `[ITI-YY4]` Provide VHL, `[ITI-YY5]` Retrieve Manifest).
3. **No IHE IUA Claim**: Consent management and enforcement operate over IHE PCF `[ITI-108]` Access Consent and VHL `[ITI-YY1]`–`[ITI-YY5]` without claiming conformance to IHE Internet User Authorization (IUA `[ITI-71]`).
4. **Three-Valued Consent Decision and PROV-O Provenance**: During VHL redemption (Process C), patient privacy consent directives retrieved via `[ITI-108]` are translated to W3C ODRL 2.2 policies (`consentToOdrl()`) and evaluated via three-valued `decide()` (`permit` | `deny` | `unknown`), recording a W3C PROV-O `prov:Activity` citing `Consent.id` and `Consent.meta.versionId`.

### Overview of Key Business Processes

The following table summarizes the three BPMN 2.0 business processes defined in this Implementation Guide.

| # | Process Name | Process ID | Personas | Objectives |
| --- | --- | --- | --- | --- |
| A | Record and Manage Patient Privacy Consent | PHW.A | Holder, Consent Recorder, Consent Registry | Capture, update, or revoke a patient privacy consent directive (`IHE.PCF.consentBasic` or `IHE.PCF.consentIntermediate`) in a PCF Consent Registry via `[ITI-108]` Access Consent (`Post`, `Put`, `Delete`). |
| B | Issue Consent-Backed Verifiable Health Link | PHW.B | Holder, VHL Sharer, Consent Registry, Trust Anchor | Register VHL Sharer signing keys with a Trust Anchor (`[ITI-YY1]`), verify or record active patient consent (`[ITI-108]`), and generate a signed Verifiable Health Link (`[ITI-YY3]`) stored in the Holder's Personal Health Wallet. |
| C | Present and Redeem Verifiable Health Link with PCF Consent Enforcement | PHW.C | Holder, VHL Receiver, Trust Anchor, VHL Sharer, Consent Registry | Present a VHL (`[ITI-YY4]`), verify cryptographic trust via a Trust Anchor (`[ITI-YY2]`), request the manifest (`[ITI-YY5]`), query active PCF Consent (`[ITI-108]`), and enforce three-valued (`permit` / `deny` / `unknown`) ODRL consent evaluation with PROV-O provenance. |

### Workflows

#### A. Record and Manage Patient Privacy Consent

* **Process ID**: `PHW.A`
* **BPMN Source**: `input/business-processes/PHW.A.bpmn`
* **Objective**: Capture, update, or revoke a patient privacy consent directive (`IHE.PCF.consentBasic` or `IHE.PCF.consentIntermediate`) in a PCF Consent Registry using the IHE PCF Access Consent `[ITI-108]` transaction (`Post`, `Put`, `Delete`), trust-anchor neutral and with no IUA claim.

<figure style="width:100%">
  <img src="PHW.A.svg" alt="Process A — Record and Manage Patient Privacy Consent (PCF [ITI-108])" style="width:100%; max-width:1100px;" />
</figure>

| Activity ID | Lane / Actor | Task Name | IHE PCF / VHL Transaction & Conformance Profile |
| --- | --- | --- | --- |
| `PHW.A.1` | VHL Holder (Patient / Personal Health Wallet) | Select base policy & disclosure scope (PCF Basic / Intermediate Consent) | Selection of base policy (`Consent.policy.uri`), `PCFPurposeOfUseVS` purpose of use, authorized actors, validity period, and clinical data scope |
| `PHW.A.2` | PCF Consent Recorder (Wallet / VHL Sharer) | Construct FHIR Consent & Provenance (`IHE.PCF.consentBasic` / `Intermediate`) | `https://profiles.ihe.net/ITI/PCF/StructureDefinition/IHE.PCF.consentBasic`, `IHE.PCF.consentIntermediate`, `IHE.PCF.provenance` |
| `PHW.A.3` | PCF Consent Recorder (Wallet / VHL Sharer) | Create consent directive `[ITI-108]` Access Consent: Post | **`[ITI-108]` Access Consent** (`POST [base]/Consent` or transaction `Bundle` with `Provenance`) |
| `PHW.A.4` | PCF Consent Recorder (Wallet / VHL Sharer) | Update or revoke directive `[ITI-108]` Access Consent: Put / Delete | **`[ITI-108]` Access Consent** (`PUT [base]/Consent/[id]` or `DELETE [base]/Consent/[id]`) |
| `PHW.A.5` | PCF Consent Registry | Validate, version & persist Consent + Provenance `[ITI-108]` Access Consent | **`[ITI-108]` Access Consent** responder (`IHE.PCF.consentRegistry`), assigning `Consent.id` and `Consent.meta.versionId` |
| `PHW.A.6` | VHL Holder (Patient / Personal Health Wallet) | Confirm recorded `Consent.id` & `versionId` `[ITI-108]` Access Consent response | **`[ITI-108]` Access Consent** response (`201 Created` / `200 OK`) |

#### B. Issue Consent-Backed Verifiable Health Link

* **Process ID**: `PHW.B`
* **BPMN Source**: `input/business-processes/PHW.B.bpmn`
* **Objective**: Publish VHL Sharer PKI signing keys to an abstract Trust Anchor (`[ITI-YY1]`), verify or record an active patient privacy consent directive (`[ITI-108]`), and generate a signed Verifiable Health Link (`[ITI-YY3]`) for storage in the Holder's Personal Health Wallet. Trust-anchor neutral (WHO GDHCN is one possible Trust Anchor among others).

<figure style="width:100%">
  <img src="PHW.B.svg" alt="Process B — Issue Consent-Backed Verifiable Health Link (VHL [ITI-YY1], [ITI-YY3], PCF [ITI-108])" style="width:100%; max-width:1100px;" />
</figure>

| Activity ID | Lane / Actor | Task Name | IHE PCF / VHL Transaction & Conformance Profile |
| --- | --- | --- | --- |
| `PHW.B.1` | VHL Sharer (grouped with PCF Consent Recorder) | Submit Sharer PKI signing key `[ITI-YY1]` Submit PKI Material with DID | **`[ITI-YY1]` Submit PKI Material with DID** (`https://profiles.ihe.net/ITI/VHL/Requirements/PublishPKIMaterial`) |
| `PHW.B.2` | Trust Anchor (e.g. GDHCN, national, or regional anchor) | Publish key in Trust Anchor trust list `[ITI-YY1]` (GDHCN or other anchor) | **`[ITI-YY1]` Submit PKI Material with DID** (`https://profiles.ihe.net/ITI/VHL/CapabilityStatement/IHE.VHL.TrustAnchor`) |
| `PHW.B.3` | VHL Holder (Patient / Personal Health Wallet) | Request VHL generation `[ITI-YY3]` Generate VHL (`$generate-vhl`) | **`[ITI-YY3]` Generate VHL** (`https://profiles.ihe.net/ITI/VHL/OperationDefinition/GenerateVHL`) |
| `PHW.B.4` | VHL Sharer (grouped with PCF Consent Recorder) | Query or record active Consent `[ITI-108]` Access Consent: Search / Post | **`[ITI-108]` Access Consent** (`GET [base]/Consent?patient=...&status=active` or `POST [base]/Consent`) |
| `PHW.B.5` | PCF Consent Registry | Return active PCF Consent (`Consent.id` + `versionId`) `[ITI-108]` Access Consent | **`[ITI-108]` Access Consent** responder (`IHE.PCF.consentRegistry`) |
| `PHW.B.6` | VHL Sharer (grouped with PCF Consent Recorder) | Assemble & sign VHL payload bound to Consent `[ITI-YY3]` Generate VHL | **`[ITI-YY3]` Generate VHL** (`IHE.VHL.VHLSharer`), signing with `[ITI-YY1]` key material |
| `PHW.B.7` | VHL Holder (Patient / Personal Health Wallet) | Store signed VHL in Personal Health Wallet `[ITI-YY3]` Generate VHL | **`[ITI-YY3]` Generate VHL** response received by `VHLHolder` |

#### C. Present and Redeem Verifiable Health Link with PCF Consent Enforcement

* **Process ID**: `PHW.C`
* **BPMN Source**: `input/business-processes/PHW.C.bpmn`
* **Objective**: Present a Verifiable Health Link (`[ITI-YY4]`), verify cryptographic signatures against a Trust Anchor's trust list (`[ITI-YY2]`), request the health document manifest (`[ITI-YY5]`), query active PCF Consent (`[ITI-108]`), and enforce three-valued (`permit` | `deny` | `unknown`) ODRL consent evaluation with W3C PROV-O decision provenance. Trust-anchor neutral (WHO GDHCN is one possible Trust Anchor among others) and makes no IUA claim.

<figure style="width:100%">
  <img src="PHW.C.svg" alt="Process C — Present and Redeem Verifiable Health Link with PCF Consent Enforcement (VHL [ITI-YY2], [ITI-YY4], [ITI-YY5], PCF [ITI-108])" style="width:100%; max-width:1100px;" />
</figure>

| Activity ID | Lane / Actor | Task Name | IHE PCF / VHL Transaction & Conformance Profile |
| --- | --- | --- | --- |
| `PHW.C.1` | VHL Holder (Patient / Personal Health Wallet) | Present VHL payload to Receiver `[ITI-YY4]` Provide VHL | **`[ITI-YY4]` Provide VHL** (`https://profiles.ihe.net/ITI/VHL/Requirements/UtilizeVHL`) |
| `PHW.C.2` | VHL Receiver (Verifier / Relying Party) | Request Trust Anchor key list `[ITI-YY2]` Retrieve Trust List with DID | **`[ITI-YY2]` Retrieve Trust List with DID** (`https://profiles.ihe.net/ITI/VHL/Requirements/RetrievePKIMaterial`) |
| `PHW.C.3` | Trust Anchor (e.g. GDHCN, national, or regional anchor) | Return signed trust list `[ITI-YY2]` (GDHCN or other Trust Anchor) | **`[ITI-YY2]` Retrieve Trust List with DID** (`IHE.VHL.TrustAnchor`) |
| `PHW.C.4` | VHL Receiver (Verifier / Relying Party) | Verify VHL signature & request manifest `[ITI-YY5]` Retrieve Manifest | **`[ITI-YY5]` Retrieve Manifest** (`https://profiles.ihe.net/ITI/VHL/Requirements/RequestVHLDocuments`) |
| `PHW.C.5` | VHL Sharer (grouped with PCF Consent Authorization Server) | Query active patient Consent `[ITI-108]` Access Consent: Search | **`[ITI-108]` Access Consent: Search** (`GET [base]/Consent?patient=...&status=active`) |
| `PHW.C.6` | PCF Consent Registry | Return active PCF Consent Bundle `[ITI-108]` Access Consent | **`[ITI-108]` Access Consent** responder (`IHE.PCF.consentRegistry`), returning `Consent.id` and `Consent.meta.versionId` |
| `PHW.C.7` | VHL Sharer (grouped with PCF Consent Authorization Server) | Evaluate PCF Consent (ODRL `decide`: `permit` / `deny` / `unknown`) & PROV-O log | `consentToOdrl()` + three-valued `decide()` (`permit` \| `deny` \| `unknown`) + W3C PROV-O `prov:Activity` citing `Consent.id` and `Consent.meta.versionId` |
| `PHW.C.8` | VHL Sharer (grouped with PCF Consent Authorization Server) | Return authorized manifest & documents `[ITI-YY5]` Retrieve Manifest (`permit`) | **`[ITI-YY5]` Retrieve Manifest** (`200 OK` `Bundle` of `DocumentReference` / clinical resources when decision is `permit`) |
| `PHW.C.9` | VHL Sharer (grouped with PCF Consent Authorization Server) | Refuse disclosure with `OperationOutcome` `[ITI-YY5]` (`deny` or `unknown`) | **`[ITI-YY5]` Retrieve Manifest** (`403 Forbidden` `OperationOutcome` when decision is `deny` or `unknown`) |
| `PHW.C.10` | VHL Receiver (Verifier / Relying Party) | Process clinical documents or refusal notice `[ITI-YY5]` response | **`[ITI-YY5]` Retrieve Manifest** consumer (`IHE.VHL.VHLReceiver`) |
