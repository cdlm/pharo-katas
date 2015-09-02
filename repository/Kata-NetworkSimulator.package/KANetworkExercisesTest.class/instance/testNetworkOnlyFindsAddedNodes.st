tests - accessing
testNetworkOnlyFindsAddedNodes
	self
		should: [ net nodeAt: alone address ]
		raise: NotFound