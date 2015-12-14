packet handling
receive: aPacket from: aLink
	aPacket destinationAddress = address
		ifTrue: [
			self consume: aPacket.
			arrivedPackets add: aPacket ]
		ifFalse: [ self forward: aPacket from: aLink ]