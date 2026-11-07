// Consent in a Personal Health Wallet, on IHE PCF 1.1.0 (owner, 2026-11-07).
// Two kinds, each coded by HL7 v3 ActConsentDirective in Consent.category
// (owner, 2026-11-07: codes backed by a spec, no invented ones):
//  - explicit (OPTIN, OPTINR, OPTOUT, OPTOUTE): the holder's own recorded act
//    is the evidence (source[x]); policyRule names the trust domain's consent
//    code when the domain publishes one (TrustDomain.termsOfUse in the GDHCN
//    Trust IG, e.g. IPS.HAJJ.CONSENT), and otherwise policy.uri names the
//    IHE PCF implicit policy the consent changes;
//  - implied (IMPLIED, IMPLIEDD, NOPP): no act of the holder; the trust
//    domain's default policy (an IHE PCF implicit policy) is Consent.policy,
//    and the domain's published policy is the evidence.
// The kind tells consentToOdrl() which implicit-policy ODRL Set a consent
// builds on (odrl:inheritFrom): OPTIN/OPTINR/OPTOUT on Policy-deny, OPTOUTE
// on Policy-basic-normal; an implied consent is its policy's Set.
// Either kind may be carried in an issued document (PHWDocumentWithConsent).

ValueSet: PHWExplicitConsentKind
Id: PHWExplicitConsentKind
Title: "Kinds of explicit consent (HL7 ActConsentDirective)"
Description: "The HL7 v3 ActConsentDirective codes for consent the holder gives by their own act: opt-in, opt-in with restrictions, opt-out, opt-out with exceptions. Each code's definition is HL7's (terminology.hl7.org, CodeSystem v3-ActCode)."
* ^status = #draft
* ^experimental = false
* $v3-ActCode#OPTIN "opt-in"
* $v3-ActCode#OPTINR "opt-in with restrictions"
* $v3-ActCode#OPTOUT "op-out"
* $v3-ActCode#OPTOUTE "opt-out with exceptions"

ValueSet: PHWImpliedConsentKind
Id: PHWImpliedConsentKind
Title: "Kinds of implied consent (HL7 ActConsentDirective)"
Description: "The HL7 v3 ActConsentDirective codes for consent presumed from the holder's behaviour: implied consent, implied consent with opportunity to dissent, and notice of privacy practices. Each code's definition is HL7's (terminology.hl7.org, CodeSystem v3-ActCode)."
* ^status = #draft
* ^experimental = false
* $v3-ActCode#IMPLIED "implied consent"
* $v3-ActCode#IMPLIEDD "implied consent with opportunity to dissent"
* $v3-ActCode#NOPP "notice of privacy practices"

Invariant: phw-consent-explicit
Description: "An explicit consent is categorized with an HL7 ActConsentDirective code for explicit consent (OPTIN, OPTINR, OPTOUT, OPTOUTE)."
Severity: #error
Expression: "category.coding.where(system = 'http://terminology.hl7.org/CodeSystem/v3-ActCode' and (code = 'OPTIN' or code = 'OPTINR' or code = 'OPTOUT' or code = 'OPTOUTE')).exists()"

Invariant: phw-consent-implied
Description: "An implied consent is categorized with an HL7 ActConsentDirective code for implied consent (IMPLIED, IMPLIEDD, NOPP) and names the trust domain's default policy in Consent.policy.uri."
Severity: #error
Expression: "category.coding.where(system = 'http://terminology.hl7.org/CodeSystem/v3-ActCode' and (code = 'IMPLIED' or code = 'IMPLIEDD' or code = 'NOPP')).exists() and policy.uri.exists()"

Invariant: phw-consent-implied-pcf
Description: "An implied consent's policy is normally one of the IHE PCF implicit policies (Policy-basic-normal, Policy-all-normal, Policy-break-glass-only, Policy-deny); a trust domain may publish its own."
Severity: #warning
Expression: "policy.uri.all($this.startsWith('https://profiles.ihe.net/ITI/PCF/Policy-'))"

Profile: PHWConsent
Parent: $IHE_PCF_ConsentIntermediate
Id: PHWConsent
Title: "PHW Consent"
Description: "A privacy consent directive held for, and shown to, the holder of a Personal Health Wallet: an IHE PCF 1.1.0 Intermediate Consent whose policy is set by a trust domain. Either explicit (PHWExplicitConsent) or implied (PHWImpliedConsent). Trust-anchor neutral: GDHCN is one possible trust anchor among others."
* ^status = #draft
* ^experimental = true
* category MS
* category ^short = "Includes the kind of consent: an HL7 v3 ActConsentDirective code (explicit: OPTIN, OPTINR, OPTOUT, OPTOUTE; implied: IMPLIED, IMPLIEDD, NOPP)"
* policyRule MS
* policyRule ^short = "The trust domain's consent code, when the domain publishes one (a code in its terms-of-use ValueSet), with the code system version"
* policy MS
* provision.actor MS
* provision.purpose MS
* provision.period MS

Profile: PHWExplicitConsent
Parent: PHWConsent
Id: PHWExplicitConsent
Title: "PHW Explicit Consent"
Description: "A consent the holder gave by their own act: on the wallet, or on a form a health worker recorded (process L). Categorized with an HL7 ActConsentDirective code (OPTIN, OPTINR, OPTOUT or OPTOUTE). The act is the evidence (source[x]). When the trust domain publishes consent codes, policyRule names the code and the version of its text the holder was shown; otherwise policy.uri names the IHE PCF implicit policy the consent changes."
* obeys phw-consent-explicit
* policyRule.coding.system 1..1
* policyRule.coding.version 1..1
* policyRule.coding.code 1..1
* source[x] only Attachment or Reference(DocumentReference or QuestionnaireResponse)
* source[x] ^short = "The holder's recorded act: the signed form, or the wallet confirmation"

Profile: PHWImpliedConsent
Parent: PHWConsent
Id: PHWImpliedConsent
Title: "PHW Implied Consent"
Description: "A consent the holder did not give by any act: categorized with an HL7 ActConsentDirective code (IMPLIED, IMPLIEDD or NOPP); the trust domain's default policy applies, normally an IHE PCF implicit policy (Volume 1 §1:53.2.1). Consent.policy names it, and the domain's published policy is the evidence (sourceAttachment). Carried in a document so that a receiver can see which policy the data was shared under."
* obeys phw-consent-implied and phw-consent-implied-pcf
* policy 1..1
* policy.uri 1..1
* source[x] only Attachment
* source[x] ^short = "The trust domain's published policy"

Profile: PHWDocumentWithConsent
Parent: Bundle-uv-ips
Id: PHWDocumentWithConsent
Title: "IPS document that carries its consent directives"
Description: "An International Patient Summary document a Personal Health Wallet shares or an issuer issues, carrying the consent directives it is shared under, explicit or implied. Carrying them is optional (0..*); when they are carried, the Composition's Advance Directives section (LOINC 42348-3) lists them. The copy in the document is evidence for the receiver; the copy in the sharer's Consent Registry is the one enforced."
* ^status = #draft
* ^experimental = true
* entry[consent] MS
* entry[consent] ^short = "A consent directive the document is shared under (optional; IPS defines the slice)"
* entry[consent].resource only PHWExplicitConsent or PHWImpliedConsent
