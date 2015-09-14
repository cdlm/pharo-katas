packet handling
transmit: aPacket
	"Transmit aPacket to the destination node of the receiver link."
	(self isTransmitting: aPacket)
		ifTrue: [
			packetsToTransmit remove: aPacket.
			destination receive: aPacket from: self ]