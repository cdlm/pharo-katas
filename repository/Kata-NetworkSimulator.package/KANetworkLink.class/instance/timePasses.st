simulating
timePasses
	packetsToTransmit ifNotEmpty:
		[ self transmit: packetsToTransmit first ]