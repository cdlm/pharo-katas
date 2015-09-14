tests - accessing
testNetworkFindsLinks
	| link |
	self
		shouldnt: [ link := net linkFrom: #pong to: #ping ]
		raise: NotFound.
	self
		assert: link source
		equals: (net nodeAt: #pong).
	self
		assert: link destination
		equals: (net nodeAt: #ping)
	