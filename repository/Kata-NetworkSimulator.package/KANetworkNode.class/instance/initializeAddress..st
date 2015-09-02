instance creation
initializeAddress: aNetworkAddress
	loopback := KANetworkLink from: self to: self.
	outgoingLinks := Set new.
	arrivedPackets := OrderedCollection new.
	address := aNetworkAddress