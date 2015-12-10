instance creation
withAddress: anAddress initialSupply: paperSheets
	^ (self withAddress: anAddress)
		resupply: paperSheets;
		yourself