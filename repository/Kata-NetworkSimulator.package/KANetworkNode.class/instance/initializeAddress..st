instance creation
initializeAddress: aNetworkAddress
	outgoingLinks := Set new.
	receivedPackets := OrderedCollection new.
	address := aNetworkAddress