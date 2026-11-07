// An example trust domain's terms of use, for the examples of this guide only.
// A real trust domain names its own ValueSet in TrustDomain.termsOfUse
// (GDHCN Trust IG); for Hajj it is IPS.HAJJ.CONSENT in smart-ips-pilgrimage.
CodeSystem: PHWExampleTermsOfUse
Id: PHWExampleTermsOfUse
Title: "Example trust domain terms of use (examples only)"
Description: "The consent codes of a fictional example trust domain, used by the examples of this guide. Each code's definition is the text the holder is shown. Not for use outside the examples."
* ^experimental = true
* ^caseSensitive = true
* ^status = #draft
* ^version = "0.1.0"
* #SHARE-FOR-CARE-ABROAD "Share my summary for care abroad" "I agree that health workers in a country I travel to may read my patient summary to treat me, for the dates I choose. I can withdraw this at any time in my wallet."

ValueSet: PHWExampleTermsOfUse
Id: PHWExampleTermsOfUse
Title: "Example trust domain terms of use (examples only)"
Description: "The terms-of-use ValueSet of the fictional example trust domain of this guide's examples."
* ^experimental = true
* ^status = #draft
* include codes from system PHWExampleTermsOfUse
