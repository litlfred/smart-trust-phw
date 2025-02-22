Profile: SGTransaction
Parent: SGGraphDefinition
Description: "SMART Guidelines Transaction Definition"

* node 2..2

* node ^slicing.discriminator[+].type = #value
* node ^slicing.discriminator[=].path = "nodeId"
* node ^slicing.rules = #closed


* node contains
    source 1..1 MS and
    target 1..1 MS

* node[source].nodeId = "source"
* node[target].nodeId = "target"

* link 1..1
* link.sourceId = "source"
* link.targetId = "target"

* link.extension contains  
    SGDocumentation named requestTrigger 1.. MS and
    SGDocumentation named requestSemantics 1.. MS and
    SGDocumentation named requestActions 1.. MS and
    SGDocumentation named responseTrigger 1.. MS and
    SGDocumentation named responseSemantics 1.. MS and
    SGDocumentation named responseActions 1.. MS and
    SGDocumentation named securityConsiderations 1..1 MS

* link.extension[requestTrigger].valueCoding =   $DocumentationSection#request-trigger
* link.extension[requestSemantics].valueCoding =   $DocumentationSection#request-semantics
* link.extension[requestActions].valueCoding =   $DocumentationSection#request-semantics

* link.extension[responseTrigger].valueCoding =   $DocumentationSection#response-trigger
* link.extension[responseSemantics].valueCoding =   $DocumentationSection#response-semantics
* link.extension[responseActions].valueCoding =   $DocumentationSection#response-semantics


