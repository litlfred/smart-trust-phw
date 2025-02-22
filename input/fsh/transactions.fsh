Instance: GenerateVHL
InstanceOf: SGTransaction
* title = "Generate VHL Request"
* description = "A Holder requests an Issuer to generate a VHL"
* name = "GenerateVHL"
* status = #active
* experimental = true
* publisher = "WHO"

* node[source].extension[actor].valueReference = Reference(Holder)
* node[target].extension[actor].valueReference = Reference(Issuer)

* link[+].extension[requestTrigger].extension[doc].valueMarkdown = """
A Holder wishes to request a VHL from an Issuer.

Optionally: The holder has selected consent and selective disclosure directives. """
* link[=].extension[requestSemantics].extension[doc].valueMarkdown = """none defined. up to a content profile to define """
* link[=].extension[requestActions].extension[doc].valueMarkdown = """ The Issuer will generate a VHL"""
* link[=].extension[responseTrigger].extension[doc].valueMarkdown = """Issuer has performed any necceasry document generation, digital signatures and has generated a VHL according to a content profile."""
* link[=].extension[responseSemantics].extension[doc].valueMarkdown = """none defined. up to content profile to define """
* link[=].extension[responseActions].extension[doc].valueMarkdown = """ The Holder accepts the VHL for storage on wallet or other utilization"""
* link[=].extension[securityConsiderations].extension[doc].valueMarkdown = """ Depends on the content profile """

