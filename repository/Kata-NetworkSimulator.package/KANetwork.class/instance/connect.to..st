topology
connect: aNode to: anotherNode
	self add: aNode.
	self add: anotherNode.
	links add: (self makeLinkFrom: aNode to: anotherNode) attach.
	links add: (self makeLinkFrom: anotherNode to: aNode) attach