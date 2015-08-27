tests
testLoopback
	| node packet |
	node := KANetworkNode withAddress: #address.
	packet := KANetworkPacket from: #address to: #address payload: #payload.
	
	node emit: packet.
	node transmit: packet.
	
	self deny: (node emissionQueue includes: packet).
	self assert: (node receptionQueue includes: packet)