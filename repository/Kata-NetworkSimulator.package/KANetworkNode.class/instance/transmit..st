packet handling
transmit: aPacket 
	aPacket destinationAddress == self address
		ifTrue: [
			emissionQueue remove: aPacket.
			receptionQueue add: aPacket ]