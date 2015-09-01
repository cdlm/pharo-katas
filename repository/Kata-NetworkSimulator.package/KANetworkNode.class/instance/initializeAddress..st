instance creation
initializeAddress: aNetworkAddress
	loopback := KANetworkLink from: self to: self.
	outgoingLinks := Set new.
	receivedPackets := OrderedCollection new.
	address := aNetworkAddress