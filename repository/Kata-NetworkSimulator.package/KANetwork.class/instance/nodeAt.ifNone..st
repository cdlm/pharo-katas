accessing
nodeAt: anAddress ifNone: noneBlock
	^ nodes
		detect: [ :any | any address = anAddress ]
		ifNone: noneBlock