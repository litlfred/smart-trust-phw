Instance: GenerateVHL
InstanceOf: SGTransaction
* title = "Generate VHL Request"
* description = "A Holder requests an Issuer to generate a VHL"
* name = "GenerateVHL"
* status = #active
* experimental = false
* publisher = "WHO"

* node[source].actor.valueReference = Reference(Holder)
* node[source].actor.valueReference = Reference(Issuer)



* link[+].extension[requestEvents].valueMarkdown = """
A Holder wishes to request a VHL from an Issuer.

Optionally: The holder has selected consent and selective disclosure directives. """
* link[=].extension[requestSemantics].valueMarkdown = """none defined. up to a content profile to define """
* link[=].extension[requestActions].valueMarkdown = """ The Issuer will generate a VHL"""

* link[+].extension[responseEvents].valueMarkdown = """Issuer has performed any necceasry document generation, digital signatures and has generated a VHL according to a content profile."""
* link[=].extension[responseSemantics].valueMarkdown = """none defined. up to content profile to define """
* link[=].extension[responseActions].valueMarkdown = """ The Holder accepts the VHL for storage on wallet or other utilization"""

* link[=].extension[securityConsiderations].valueMarkdown = """ Depends on the content profile """

