testing
hasLinkTo: aNetworkNode
	^ outgoingLinks
		anySatisfy: [ :any | any destination == aNetworkNode ]