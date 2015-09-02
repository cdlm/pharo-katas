tests - packet transmission
testSendViaHub
	| packet1 packet2 mac pc1 |
	packet1 := KANetworkPacket from: #mac to: #pc1 payload: 'Hello, I''m a Mac!'.
	packet2 := KANetworkPacket from: #pc1 to: #mac payload: 'And I''m a PC'.
	mac := net nodeAt: #mac.
	pc1 := net nodeAt: #pc1.
	
	self assert: (packet1 isAdressedTo: pc1).
	self assert: (packet1 isOriginatingFrom: mac).
	self assert: (packet2 isAdressedTo: mac).
	self assert: (packet2 isOriginatingFrom: pc1).

	mac send: packet1.
	self deny: (pc1 hasReceived: packet1).
	
	net timePasses.
	pc1 send: packet2.
	self deny: (pc1 hasReceived: packet1).
	self deny: (mac hasReceived: packet2).

	net timePasses.
	self assert: (pc1 hasReceived: packet1).
	self deny: (mac hasReceived: packet2).
	
	net timePasses.
	self assert: (mac hasReceived: packet2)