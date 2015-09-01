packet handling
transmit: aPacket
	packetsToTransmit
		remove: aPacket
		ifAbsent: [ self error: 'packet not found' ].
	destination receive: aPacket from: self