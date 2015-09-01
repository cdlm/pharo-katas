packet handling
send: aPacket
	self
		linksTowards: aPacket destinationAddress
		do: [ :link | self send: aPacket via: link ]