// The two Hajj consents of the worked example (example-pilgrimage.md), matching
// smart-ips-pilgrimage's HajjConsent examples, as instances of this guide's
// PHWExplicitConsent (IHE PCF 1.1.0 Intermediate).
// FHIR R4 (4.0.1) and IHE PCF 1.1.0. All names, identifiers and URLs are fictional examples.
// The Consents are the policy: policyRule names which Hajj consent each one is, with the
// IPS.HAJJ.CONSENT CodeSystem version whose text the pilgrim was shown (smart-ips-pilgrimage#3).

Instance: PilgrimExample
InstanceOf: Patient
Title: "Pilgrim (fictional)"
Usage: #example
* identifier.system = "https://hie.mys.example.org/fhir/sid/pilgrimage-number"
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
* identifier.value = "https://hie.mys.example.org/"
* name = "Ministry of Health Malaysia Health Information Exchange (example)"

Instance: HostMoHExample
InstanceOf: Organization
Title: "Host country Ministry of Health (fictional): VHL Receiver"
Usage: #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "https://moh.ksa.example.org/"
* name = "Ministry of Health Saudi Arabia (example)"

Instance: PilgrimConsentOriginRelease
InstanceOf: PHWExplicitConsent
Title: "Pilgrim consent: the origin HIE may release the IPS to the host Ministry of Health"
Description: "The first of the pilgrim's two Hajj consents (CONSENT-MYS, origin release). Permit, to the host Ministry of Health as information recipient, for treatment, during the example Hajj period. The origin HIE enforces it from its own Consent Registry."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* patient = Reference(PilgrimExample)
* dateTime = "2025-04-01T09:00:00+08:00"
* performer = Reference(PilgrimExample)
* organization = Reference(OriginHIEExample)
* sourceAttachment.contentType = #text/plain
* sourceAttachment.url = "https://hie.mys.example.org/consents/hajj-1446/consent-mys.txt"
* sourceAttachment.title = "Consent text shown to the pilgrim: CONSENT-MYS (example)"
* policyRule = $IPSHajjConsent|2.1.0#CONSENT-MYS "Consent for Malaysia"
* provision.type = #permit
* provision.period.start = "2025-05-01"
* provision.period.end = "2025-08-31"
* provision.actor.role = $v3-ParticipationType#IRCP "information recipient"
* provision.actor.reference.identifier.system = "urn:ietf:rfc:3986"
* provision.actor.reference.identifier.value = "https://moh.ksa.example.org/"
* provision.actor.reference.display = "Ministry of Health Saudi Arabia (example)"
* provision.purpose = $v3-ActReason#TREAT "treatment"

Instance: PilgrimConsentHostUse
InstanceOf: PHWExplicitConsent
Title: "Pilgrim consent: the host Ministry of Health may use the IPS for care during Hajj"
Description: "The second of the pilgrim's two Hajj consents (CONSENT-KSA, host use). Permit, to the host Ministry of Health as information recipient, for treatment, during the example Hajj period and its follow-up. It binds the host Ministry of Health after receipt."
Usage: #example
* status = #active
* scope = $consentscope#patient-privacy
* category[0] = $LOINC#59284-0 "Patient Consent"
* patient = Reference(PilgrimExample)
* dateTime = "2025-04-01T09:05:00+08:00"
* performer = Reference(PilgrimExample)
* organization = Reference(OriginHIEExample)
* sourceAttachment.contentType = #text/plain
* sourceAttachment.url = "https://hie.mys.example.org/consents/hajj-1446/consent-ksa.txt"
* sourceAttachment.title = "Consent text shown to the pilgrim: CONSENT-KSA (example)"
* policyRule = $IPSHajjConsent|2.1.0#CONSENT-KSA "Consent for Kingdom of Saudi Arabia"
* provision.type = #permit
* provision.period.start = "2025-05-01"
* provision.period.end = "2025-08-31"
* provision.actor.role = $v3-ParticipationType#IRCP "information recipient"
* provision.actor.reference.identifier.system = "urn:ietf:rfc:3986"
* provision.actor.reference.identifier.value = "https://moh.ksa.example.org/"
* provision.actor.reference.display = "Ministry of Health Saudi Arabia (example)"
* provision.purpose = $v3-ActReason#TREAT "treatment"

