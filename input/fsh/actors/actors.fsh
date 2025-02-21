Instance: TrustNetworkAnchor
InstanceOf: ActorDefinition
Usage: #definition
* name = "Trust Network Anchor"
* title = "Trust Network Anchor"
* description = "Trust Anchor which receives and distributes PKI-material within a Trust Network"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system

Instance: TrustNetworkParticipant
InstanceOf: ActorDefinition
Usage: #definition
* name = "Trust Network Participant"
* title = "Trust Network Participant"
* description = "Trust Network Participant which publishes and or receives PKI-material within a Trust Network"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system

Instance: Holder
InstanceOf: ActorDefinition
Usage: #definition
* name = "Holder"
* title = "Holder"
* description = "Holder (person) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#person

Instance: Receiver
InstanceOf: ActorDefinition
Usage: #definition
* name = "Receiver"
* title = "Receiver"
* description = "Receiver (system) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system
* baseDefinition = Canonical(TrustNetworkParticipant)

Instance: Issuer
InstanceOf: ActorDefinition
Usage: #definition
* name = "Issuer"
* title = "Issuer"
* description = "Issuer (system) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system
* baseDefinition = Canonical(TrustNetworkParticipant)
