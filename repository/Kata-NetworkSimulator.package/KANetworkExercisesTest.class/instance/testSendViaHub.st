tests - packet transmission
testSendViaHub
	| hello mac pc1 firstLink secondLink |
	hello := KANetworkPacket from: #mac to: #pc1 payload: 'Hello!'.
	mac := net nodeAt: #mac.
	pc1 := net nodeAt: #pc1.
	firstLink := net linkFrom: #mac to: #hub.
	secondLink := net linkFrom: #hub to: #pc1.
	
	self assert: (hello isAdressedTo: pc1).
	self assert: (hello isOriginatingFrom: mac).

	mac send: hello.
	self deny: (pc1 hasReceived: hello).
	self assert: (firstLink isTransmitting: hello).
	
	firstLink transmit: hello.
	self deny: (pc1 hasReceived: hello).
	self assert: (secondLink isTransmitting: hello).

	secondLink transmit: hello.
	self assert: (pc1 hasReceived: hello).