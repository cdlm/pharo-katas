tests
testLoopback
	| node packet |
	node := KANetworkNode withAddress: #address.
	packet := KANetworkPacket from: #address to: #address payload: #payload.
	
	node send: packet.
	node loopback transmit: packet.
	
	self assert: (node hasReceived: packet).
	self deny: (node loopback isTransmitting: packet)