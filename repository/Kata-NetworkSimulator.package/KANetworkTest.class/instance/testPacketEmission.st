tests
testPacketEmission
	| src dest packet |
	src := KANetworkNode withAddress: 1.
	dest := KANetworkNode withAddress: 2.
	packet := KANetworkPacket from: src to: dest payload: #payload.
	
	src emit: packet.
	
	self assert: (src emissionQueue includes: packet)