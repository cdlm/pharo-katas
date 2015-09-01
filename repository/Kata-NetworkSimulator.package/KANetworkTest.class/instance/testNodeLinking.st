tests
testNodeLinking
	| node1 node2 link |
	node1 := KANetworkNode withAddress: #address1.
	node2 := KANetworkNode withAddress: #address2.
	link := KANetworkLink from: node1 to: node2.
	
	link attach.
	
	self assert: (node1 hasLinkTo: node2)