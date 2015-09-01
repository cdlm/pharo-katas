packet handling
receive: aPacket from: aLink
	aPacket destinationAddres = address
		ifTrue: [ self consume: aPacket ]