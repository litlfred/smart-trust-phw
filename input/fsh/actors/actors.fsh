Instance: TrustNetworkAnchor
InstanceOf: SGActor
Usage: #definition
* name = "Trust Network Anchor"
* title = "Trust Network Anchor"
* description = "Trust Anchor which receives and distributes PKI-material within a Trust Network"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system

Instance: TrustNetworkParticipant
InstanceOf: SGActor
Usage: #definition
* name = "Trust Network Participant"
* title = "Trust Network Participant"
* description = "Trust Network Participant which publishes and or receives PKI-material within a Trust Network"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system

Instance: Holder
InstanceOf: SGActor
Usage: #definition
* name = "Holder"
* title = "Holder"
* description = "Holder (person) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#person

Instance: Receiver
InstanceOf: SGActor
Usage: #definition
* name = "Receiver"
* title = "Receiver"
* description = "Receiver (system) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system
* derivedFrom = Canonical(TrustNetworkParticipant)

Instance: Issuer
InstanceOf: SGActor
Usage: #definition
* name = "Issuer"
* title = "Issuer"
* description = "Issuer (system) of [Verifiable Health Certificate](https://smart.who.int/trust/concepts.html#verifiable-digital-health-certificate) or [Verifiable Health Link](https://build.fhir.org/ig/IHE/ITI.VHL/branches/master/index.html)"
* status = $pubStatus#active
* publisher = "WHO"
* type = $actorType#system
* derivedFrom = Canonical(TrustNetworkParticipant)
