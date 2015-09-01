tests
testSendAndTransmit
	| srcNode destNode link packet |
	srcNode := KANetworkNode withAddress: #src.
	destNode := KANetworkNode withAddress: #dest.
	link := KANetworkLink from: srcNode to: destNode.
	packet := KANetworkPacket from: #address to: #dest payload: #payload.
	
	srcNode send: packet via: link.
	self assert: (link isTransmitting: packet).
	self deny: (destNode hasReceived: packet).
	
	link transmit: packet.
	self deny: (link isTransmitting: packet).
	self assert: (destNode hasReceived: packet)