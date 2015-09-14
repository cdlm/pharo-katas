tests - packet transmission
testSelfSend
	| packet |
	packet := KANetworkPacket
		from: alone address
		to: alone address
		payload: #something.
	self assert: (packet isAdressedTo: alone).
	self assert: (packet isOriginatingFrom: alone).

	alone send: packet.
	self deny: (alone hasReceived: packet).
	self assert: (alone loopback isTransmitting: packet).
	
	alone loopback transmit: packet.
	self deny: (alone loopback isTransmitting: packet).
	self assert: (alone hasReceived: packet)