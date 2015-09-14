tests
testNodeCreation
	| address node |
	address := Object new.
	node := KANetworkNode withAddress: address.
	
	self assert: node address equals: address