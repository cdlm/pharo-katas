initialization
initialize
	loopback := KANetworkLink from: self to: self.
	outgoingLinks := Set new.
	arrivedPackets := OrderedCollection new