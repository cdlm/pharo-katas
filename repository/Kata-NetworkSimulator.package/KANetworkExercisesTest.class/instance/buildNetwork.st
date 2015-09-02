fixture
buildNetwork
	alone := KANetworkNode withAddress: #alone.
	
	net := KANetwork new.
	hub := KANetworkNode withAddress: #hub.
	net add: hub.
	
	#(mac pc1 pc2 prn) do: [ :addr |
		| node |
		node := KANetworkNode withAddress: addr.
		net add: node;
			connect: node to: hub ]