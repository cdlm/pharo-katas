packet handling
consume: aPacket
	| response |
	response := aPacket payload asUppercase.
	self send: (KANetworkPacket
		from: self address
		to: aPacket sourceAddress
		payload: response)