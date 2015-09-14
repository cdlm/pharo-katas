topology
linksTowards: anAddress do: aBlock
	"Simple flood algorithm: route via all outgoing links.
	However, just loopback if the receiver node is the routing destination."
	anAddress = address
		ifTrue: [ aBlock value: self loopback ]
		ifFalse: [ outgoingLinks do: aBlock ]