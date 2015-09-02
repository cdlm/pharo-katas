topology
connect: aNode to: anotherNode
	links add: (self makeLinkFrom: aNode to: anotherNode) attach.
	links add: (self makeLinkFrom: anotherNode to: aNode) attach