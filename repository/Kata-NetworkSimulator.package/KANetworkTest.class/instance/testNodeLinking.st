tests
testNodeLinking
	| node1 node2 link |
	node1 := KANetworkNode withAddress: 1.
	node2 := KANetworkNode withAddress: 2.
	link := KANetworkLink new.
	
	link connect: node1 to: node2.
	
	self assert: (node1 hasLinkTo: node2)