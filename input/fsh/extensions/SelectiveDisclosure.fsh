Extension: SelectiveDisclosure
Description: "Guidance that a document signing service with selective disclosure support (e.g. SD-JWT) should perform a selective disclosure of the content of the containing node of the extension in the JSON representation of the FHIR instance.

The code value should be from a code system containing appropriate disclosure statements for the use case.  The disclosure statement should describe the content that is to be disclosed at that node.  For example a code such as 'disclose-date-of-birth' or 'disclose-vaccine-history'.
"
* value[x] only code
* valueCode 1.. MS


Invariant: has-selective-disclosure-on-entries
Description: "Ensure there is a selective disclosure exension for each entry of a document bundle"
Severity: #warning
Expression: "
  entry.extension.where(url='http://smart.who.int/trust-phw/SelectiveDisclosure').count() = entry.count()
  and
  entry.extension.where(url='http://smart.who.int/trust-phw/SelectiveDisclosure').valueCode.empty().not()
"


