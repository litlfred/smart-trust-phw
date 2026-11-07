// Every person, organization, identifier and URL here is fictional.

// ---------------------------------------------------------------------------
// Lina's patient summary, shared from her wallet with both kinds of consent.
// ---------------------------------------------------------------------------

Instance: LinaPatient
InstanceOf: Patient
Title: "Lina (fictional wallet holder)"
Usage: #example
* identifier.system = "https://hie.home.example.org/fhir/sid/health-id"
* identifier.value = "HID-0000-0042"
* name.family = "Example"
* name.given = "Lina"
* gender = #female
* birthDate = "1992-03-14"

Instance: HomeHIE
InstanceOf: Organization
Title: "Lina's home health information exchange (fictional): VHL Sharer and Consent Registry custodian"
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://hie.home.example.org/"
* name = "Home Health Information Exchange (example)"

Instance: LinaWalletConfirmation
InstanceOf: DocumentReference
Title: "Lina's confirmation on her wallet (fictional)"
Description: "The evidence of Lina's explicit consent: the confirmation her wallet recorded when she agreed to the consent text shown to her (process L)."
Usage: #example
* status = #current
* type = $LOINC#59284-0 "Patient Consent"
* subject = Reference(LinaPatient)
* date = "2026-06-01T10:15:00Z"
* content.attachment.contentType = #application/json
* content.attachment.url = "https://wallet.example.org/lina/confirmations/2026-06-01-share-for-care-abroad.json"
* content.attachment.title = "Wallet confirmation: share my summary for care abroad, 1 to 30 June 2026"

Instance: LinaExplicitConsent
InstanceOf: PHWExplicitConsent
Title: "Lina's explicit consent: share her summary for care abroad"
Description: "Lina agreed on her wallet that health workers abroad may read her patient summary to treat her, from 1 to 30 June 2026: an opt-in (HL7 ActConsentDirective OPTIN) that adds this permission to the opt-in default, the IHE PCF implicit policy Policy-deny. Her wallet confirmation is the evidence. The example trust domain publishes no consent codes, so there is no policyRule."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* category[+] = $v3-ActCode#OPTIN "opt-in"
* patient = Reference(LinaPatient)
* dateTime = "2026-06-01T10:15:00Z"
* performer = Reference(LinaPatient)
* organization = Reference(HomeHIE)
* sourceReference = Reference(LinaWalletConfirmation)
* policy.uri = "https://profiles.ihe.net/ITI/PCF/Policy-deny"
* provision.type = #permit
* provision.period.start = "2026-06-01"
* provision.period.end = "2026-06-30"
* provision.purpose = $v3-ActReason#TREAT "treatment"

Instance: LinaImpliedConsent
InstanceOf: PHWImpliedConsent
Title: "Implied consent: the trust domain's default policy (Policy-basic-normal)"
Description: "No act of Lina's: implied consent with an opportunity to dissent (HL7 ActConsentDirective IMPLIEDD) under the example trust domain's default policy, the IHE PCF implicit policy Policy-basic-normal, under which normal data may be used for treatment. Carried in the document so the receiver can see the policy the summary was shared under."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* category[+] = $v3-ActCode#IMPLIEDD "implied consent with opportunity to dissent"
* patient = Reference(LinaPatient)
* dateTime = "2026-06-01T10:15:00Z"
* performer = Reference(HomeHIE)
* organization = Reference(HomeHIE)
* sourceAttachment.contentType = #text/html
* sourceAttachment.url = "https://trust-domain.example.org/policy/default.html"
* sourceAttachment.title = "Example trust domain: default privacy policy"
* policy.uri = "https://profiles.ihe.net/ITI/PCF/Policy-basic-normal"
* provision.type = #permit
* provision.purpose = $v3-ActReason#TREAT "treatment"

Instance: LinaSummaryComposition
InstanceOf: Composition-uv-ips
Title: "Lina's patient summary (Composition) with its consent directives"
Usage: #inline
* status = #final
* type = $LOINC#60591-5 "Patient summary Document"
* subject = Reference(urn:uuid:7c1c6d1e-0000-4000-8000-00000000a001)
* date = "2026-06-01T10:16:00Z"
* author = Reference(urn:uuid:7c1c6d1e-0000-4000-8000-00000000a002)
* title = "Patient Summary: Lina Example"
* confidentiality = #N
* section[sectionMedications].title = "Medications"
* section[sectionMedications].code = $LOINC#10160-0
* section[sectionMedications].text.status = #generated
* section[sectionMedications].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">No medications known.</div>"
* section[sectionMedications].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"
* section[sectionAllergies].title = "Allergies and intolerances"
* section[sectionAllergies].code = $LOINC#48765-2
* section[sectionAllergies].text.status = #generated
* section[sectionAllergies].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">No allergies known.</div>"
* section[sectionAllergies].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"
* section[sectionProblems].title = "Problems"
* section[sectionProblems].code = $LOINC#11450-4
* section[sectionProblems].text.status = #generated
* section[sectionProblems].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">No problems known.</div>"
* section[sectionProblems].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"
* section[sectionAdvanceDirectives].title = "Advance directives: consent"
* section[sectionAdvanceDirectives].code = $LOINC#42348-3
* section[sectionAdvanceDirectives].text.status = #generated
* section[sectionAdvanceDirectives].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Shared with Lina's consent to share her summary for care abroad (1 to 30 June 2026), under the trust domain's default policy.</div>"
* section[sectionAdvanceDirectives].entry[0] = Reference(urn:uuid:7c1c6d1e-0000-4000-8000-00000000a003)
* section[sectionAdvanceDirectives].entry[+] = Reference(urn:uuid:7c1c6d1e-0000-4000-8000-00000000a004)

Instance: LinaSummaryWithConsent
InstanceOf: PHWDocumentWithConsent
Title: "Lina's patient summary, shared with its consent directives (explicit and implied)"
Description: "An IPS document from Lina's wallet that carries the two consent directives it is shared under: her explicit consent and the trust domain's implied default. The Advance Directives section lists both. The copies here are evidence for the receiver; the home HIE enforces the copies in its Consent Registry."
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a000"
* type = #document
* timestamp = "2026-06-01T10:16:00Z"
* entry[composition].fullUrl = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a005"
* entry[composition].resource = LinaSummaryComposition
* entry[patient].fullUrl = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a001"
* entry[patient].resource = LinaPatient
* entry[+].fullUrl = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a002"
* entry[=].resource = HomeHIE
* entry[consent][0].fullUrl = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a003"
* entry[consent][=].resource = LinaExplicitConsent
* entry[consent][+].fullUrl = "urn:uuid:7c1c6d1e-0000-4000-8000-00000000a004"
* entry[consent][=].resource = LinaImpliedConsent
