tests
testPacketEmission
	| src dest packet |
	src := KANetworkNode withAddress: #sourceAddress.
	dest := KANetworkNode withAddress: #destinationAddress.
	packet := KANetworkPacket from: #sourceAddress to: #destinationAddress payload: #payload.
	
	src emit: packet.
	
	self assert: (src emissionQueue includes: packet)