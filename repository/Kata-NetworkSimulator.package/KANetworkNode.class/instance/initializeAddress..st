instance creation
initializeAddress: aNetworkAddress
	outgoingLinks := Set new.
	emissionQueue := OrderedCollection new.
	receptionQueue := OrderedCollection new.
	address := aNetworkAddress