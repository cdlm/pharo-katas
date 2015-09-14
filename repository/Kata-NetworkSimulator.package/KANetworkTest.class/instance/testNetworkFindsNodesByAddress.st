tests - accessing
testNetworkFindsNodesByAddress
	self
		assert: (net nodeAt: hub address ifNone: [ self fail ])
		equals: hub