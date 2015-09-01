packet handling
receive: aPacket from: aLink
	aPacket destinationAddress = address
		ifTrue: [ self consume: aPacket ]