instance creation
withAddress: aNetworkAddress 
	^ self new
		initializeAddress: aNetworkAddress;
		yourself