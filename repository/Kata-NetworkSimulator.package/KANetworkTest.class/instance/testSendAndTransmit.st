tests
testSendAndTransmit
	| srcNode destNode link packet |
	srcNode := KANetworkNode withAddress: #src.
	destNode := KANetworkNode withAddress: #dest.
	link := KANetworkLink new connect: srcNode to: destNode.
	packet := KANetworkPacket from: #address to: #address payload: #payload.
	
	srcNode send: packet via: link.
	self assert: (link packetsToTransmit includes: packet).
	
	link transmit: packet.
	self deny: (link packetsToTransmit includes: packet).