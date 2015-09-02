tests - packet transmission
testSelfSend
	| packet |
	packet := KANetworkPacket
		from: alone address
		to: alone address
		payload: #something.

	alone send: packet.
	alone timePasses.
	
	self assert: (packet isAdressedTo: alone).
	self assert: (packet isOriginatingFrom: alone).
	self assert: (alone hasReceived: packet)