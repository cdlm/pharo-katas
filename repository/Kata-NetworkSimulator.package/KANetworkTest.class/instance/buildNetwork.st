fixture
buildNetwork
	alone := KANetworkNode withAddress: #alone.
	
	net := KANetwork new.
	
	hub := KANetworkHub withAddress: #hub.
	#(mac pc1 pc2 prn) do: [ :addr |
		| node |
		node := KANetworkNode withAddress: addr.
		net connect: node to: hub ].
	
	net
		connect: (KANetworkNode withAddress: #ping)
		to: (KANetworkNode withAddress: #pong)