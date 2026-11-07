// Consent in a Personal Health Wallet, on IHE PCF 1.1.0 (owner, 2026-11-07).
// Two kinds, told apart by the policy and the evidence, since PCF forbids
// Consent.verification:
//  - explicit: the holder's own recorded act is the evidence (source[x]), and
//    policyRule names the trust domain's consent code (a code in the domain's
//    terms-of-use ValueSet, TrustDomain.termsOfUse in the GDHCN Trust IG);
//  - implied: no act of the holder; the trust domain's default policy (an IHE
//    PCF implicit policy such as Policy-basic-normal) is Consent.policy, and the
//    domain's published policy is the evidence.
// Either kind may be carried in an issued document (PHWDocumentWithConsent).

Invariant: phw-consent-explicit
Description: "An explicit consent names the trust domain's consent code in policyRule, with the code system version whose text the holder was shown."
Severity: #error
Expression: "policyRule.coding.where(system.exists() and version.exists() and code.exists()).exists()"

Invariant: phw-consent-implied
Description: "An implied consent names the trust domain's default policy in Consent.policy.uri."
Severity: #error
Expression: "policy.uri.exists()"

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
* policyRule MS
* policyRule ^short = "The trust domain's consent code (a code in the domain's terms-of-use ValueSet), with the code system version"
* policy MS
* provision.actor MS
* provision.purpose MS
* provision.period MS

Profile: PHWExplicitConsent
Parent: PHWConsent
Id: PHWExplicitConsent
Title: "PHW Explicit Consent"
Description: "A consent the holder gave by their own act: on the wallet, or on a form a health worker recorded (process L). The act is the evidence (source[x]); policyRule names the trust domain's consent code and the version of its text the holder was shown."
* obeys phw-consent-explicit
* policyRule 1..1
* policyRule.coding 1..1
* policyRule.coding.system 1..1
* policyRule.coding.version 1..1
* policyRule.coding.code 1..1
* source[x] only Attachment or Reference(DocumentReference or QuestionnaireResponse)
* source[x] ^short = "The holder's recorded act: the signed form, or the wallet confirmation"

Profile: PHWImpliedConsent
Parent: PHWConsent
Id: PHWImpliedConsent
Title: "PHW Implied Consent"
Description: "A consent the holder did not give by any act: the trust domain's default policy applies, normally an IHE PCF implicit policy (Volume 1 §1:53.2.1). Consent.policy names it, and the domain's published policy is the evidence (sourceAttachment). Carried in a document so that a receiver can see which policy the data was shared under."
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
