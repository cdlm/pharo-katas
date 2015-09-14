packet handling
emit: aPacket
	"Packets are not transmitted right away, but stored.
	Transmission is explicitly triggered later, by sending #transmit:."
	packetsToTransmit add: aPacket