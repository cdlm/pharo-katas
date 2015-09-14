tests
testPacketCreation
	| src dest payload packet |
	src := Object new.
	dest := Object new.
	payload := Object new.
	
	packet := KANetworkPacket from: src to: dest payload: payload.
	
	self assert: packet sourceAddress equals: src.
	self assert: packet destinationAddress equals: dest.
	self assert: packet payload equals: payload