instance creation
initializeAddress: aNetworkAddress
	outgoingLinks := Set new.
	emissionQueue := OrderedCollection new.
	address := aNetworkAddress