packet handling
send: aPacket
	"Send aPacket, leaving the responsibility of routing to the node."
	self
		linksTowards: aPacket destinationAddress
		do: [ :link | self send: aPacket via: link ]