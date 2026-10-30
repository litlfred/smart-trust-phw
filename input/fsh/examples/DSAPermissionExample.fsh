// Bean folio-assistant-jfbm, for litlfred/folio-assistant#2702.
// Owner card 2026-10-30 19:23Z: FHIR R5 Permission (Trial Use) is approved for
// OUTPUT ONLY. The ODRL 2.2 Agreement stays the source of truth; nothing reads
// a Permission back. This file is a worked example of the one-way rendering:
// the renderer code itself needs a repository that can hold code (this one
// declares no Tool directory).
//
// Source: an illustrative ODRL 2.2 Agreement (JSON-LD, ODRL context):
//
// {
//   "@context": "http://www.w3.org/ns/odrl.jsonld",
//   "@type": "Agreement",
//   "uid": "https://ministry-m.example.org/dsa/42/v3",
//   "conflict": "prohibit",
//   "assigner": "https://ministry-m.example.org/",
//   "assignee": "https://institute-i.example.org/",
//   "permission": [{
//     "target": "https://ministry-m.example.org/dataset/immunization-coverage",
//     "action": "use",
//     "constraint": [
//       { "leftOperand": "purpose", "operator": "isA",
//         "rightOperand": "http://terminology.hl7.org/CodeSystem/v3-ActReason#PUBHLTH" },
//       { "leftOperand": "dateTime", "operator": "gteq", "rightOperand": "2026-01-01" },
//       { "leftOperand": "dateTime", "operator": "lt",   "rightOperand": "2028-01-01" }
//     ],
//     "duty": [
//       { "action": "delete",
//         "constraint": [{ "leftOperand": "dateTime", "operator": "lt", "rightOperand": "2028-04-01" }] },
//       { "action": "inform", "informedParty": "https://ministry-m.example.org/" }
//     ]
//   }],
//   "prohibition": [{
//     "target": "https://ministry-m.example.org/dataset/immunization-coverage",
//     "action": "distribute"
//   }]
// }
//
// The agreement version is published at its fixed-version URL (= the ODRL uid)
// with a SHA-256 in a DCAT 3 distribution (spdx:checksum). The Permission's
// Description lists the mapping and every ODRL term the rendering drops.

Instance: MinistryM
InstanceOf: Organization
Title: "Ministry M (data provider)"
Description: "Ministry M, the data provider: the ODRL `assigner` of the example data sharing agreement."
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://ministry-m.example.org/"
* name = "Ministry M"

Instance: InstituteI
InstanceOf: Organization
Title: "Institute I (data recipient)"
Description: "Institute I, the data recipient: the ODRL `assignee` of the example data sharing agreement."
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://institute-i.example.org/"
* name = "Institute I"

Instance: DSAPermissionExample
InstanceOf: Permission
Title: "Data sharing agreement 42 v3 rendered as a FHIR R5 Permission (output only)"
Description: """A worked example of the one-way rendering of an ODRL 2.2 `Agreement` to a FHIR R5 `Permission` (bean folio-assistant-jfbm; output only, the ODRL Agreement stays the source of truth). Ministry M shares its immunization coverage dataset with Institute I for public health use in 2026-2027, and may not have it redistributed.

Mapped: `conflict` prohibit to `combining` deny-overrides; `assigner` to `asserter`; the permission's `dateTime` constraints to `validity`; `uid` (the fixed-version URL) to `justification.evidence` as a logical reference; `permission` / `prohibition` to `rule.type` permit / deny; `target` to `rule.data.resource`; `assignee` to `rule.activity.actor`; `action` to `rule.activity.action` (consentaction); `purpose` to `rule.activity.purpose` (HL7 PurposeOfUse); the `delete` duty to `rule.limit` (v3 ObligationPolicy DELAU).

Dropped, with no home in Permission: the policy type `Agreement`; the agreement's SHA-256 (`spdx:checksum`; `Attachment.hash` is SHA-1 and `Reference` has no hash); the operator `isA` (only the code is kept); the exclusive bound of `lt` (Period end is inclusive, so the end is rendered as the last second before the bound); the `delete` duty's deadline constraint; the `inform` duty and its `informedParty`. Also without a home in Permission, though not used in this example: `refinement` on actions, assets or parties; the `elapsedTime` and other per-action constraints; `remedy` and `consequence`; logical constraints (`or`, `xone`, `and`, `andSequence`); `AssetCollection` / `PartyCollection` and `partOf`; `inheritFrom`; `profile`; `conflict` `invalid`; and duties other than those with an ObligationPolicy code (these map only roughly to `rule.limit`)."""
Usage: #example
* status = #active
* asserter = Reference(MinistryM)
* validity.start = "2026-01-01T00:00:00Z"
* validity.end = "2027-12-31T23:59:59Z"
* justification.evidence.identifier.system = "urn:ietf:rfc:3986"
* justification.evidence.identifier.value = "https://ministry-m.example.org/dsa/42/v3"
* justification.evidence.display = "Data sharing agreement 42, version 3 (fixed-version URL = ODRL uid)"
* combining = #deny-overrides
* rule[0].type = #permit
* rule[=].data[0].resource[0].meaning = #instance
* rule[=].data[=].resource[=].reference.identifier.system = "urn:ietf:rfc:3986"
* rule[=].data[=].resource[=].reference.identifier.value = "https://ministry-m.example.org/dataset/immunization-coverage"
* rule[=].data[=].resource[=].reference.display = "Ministry M immunization coverage dataset"
* rule[=].activity[0].actor[0] = Reference(InstituteI)
* rule[=].activity[=].action[0] = http://terminology.hl7.org/CodeSystem/consentaction#use "use"
* rule[=].activity[=].purpose[0] = http://terminology.hl7.org/CodeSystem/v3-ActReason#PUBHLTH "public health"
* rule[=].limit[0] = http://terminology.hl7.org/CodeSystem/v3-ActCode#DELAU "delete after use"
* rule[+].type = #deny
* rule[=].data[0].resource[0].meaning = #instance
* rule[=].data[=].resource[=].reference.identifier.system = "urn:ietf:rfc:3986"
* rule[=].data[=].resource[=].reference.identifier.value = "https://ministry-m.example.org/dataset/immunization-coverage"
* rule[=].data[=].resource[=].reference.display = "Ministry M immunization coverage dataset"
* rule[=].activity[0].actor[0] = Reference(InstituteI)
* rule[=].activity[=].action[0] = http://terminology.hl7.org/CodeSystem/consentaction#disclose "disclose"
