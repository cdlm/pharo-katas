tests - packet transmission
testDirectSend
	| packet ping pong link |
	packet := KANetworkPacket from: #ping to: #pong payload: #ball.
	ping := net nodeAt: #ping.
	pong := net nodeAt: #pong.
	link := net linkFrom: #ping to: #pong.
	
	ping send: packet.
	self assert: (link isTransmitting: packet).
	self deny: (pong hasReceived: packet).
	
	link transmit: packet.
	self deny: (link isTransmitting: packet).
	self assert: (pong hasReceived: packet)