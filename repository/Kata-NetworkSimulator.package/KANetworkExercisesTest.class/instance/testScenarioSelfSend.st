tests
testScenarioSelfSend
	| packet |
	packet := KANetworkPacket
		from: alone address
		to: alone address
		payload: #something.

	alone send: packet.
	alone loopback transmit: packet.
	
	self assert: (packet isAdressedTo: alone).
	self assert: (packet isOriginatingFrom: alone).
	self assert: (alone hasReceived: packet)