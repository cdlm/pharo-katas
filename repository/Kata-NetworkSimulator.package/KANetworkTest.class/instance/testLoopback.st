tests
testLoopback
	| node packet |
	node := KANetworkNode withAddress: #address.
	packet := KANetworkPacket from: #address to: #address payload: #payload.
	
	node send: packet.
	
	self assert: (node receivedPackets includes: packet)