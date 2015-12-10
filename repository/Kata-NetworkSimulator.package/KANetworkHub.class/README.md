I represent a network hub or repeater.

Any packet I receive gets forwarded through all outgoing links except the one(s) leading back to the node the packet came from. No attempt is made at routing beyond this.

A limitation of the model is that I inherit an address and a #consume: method from KANetworkNode; however, because real-world hubs operate at the physical layer of the OSI model, it is not meaningful to address packets to my instances.