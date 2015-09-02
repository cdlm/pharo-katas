packet handling
transmit: aPacket
	(self isTransmitting: aPacket)
		ifTrue: [
			packetsToTransmit remove: aPacket.
			destination receive: aPacket from: self ]