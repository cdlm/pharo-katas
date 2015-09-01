topology
linksTowards: anAddress do: aBlock
	"no routing"
	anAddress = address
		ifTrue: [ aBlock value: self loopback ]
		ifFalse: [ outgoingLinks do: aBlock ]