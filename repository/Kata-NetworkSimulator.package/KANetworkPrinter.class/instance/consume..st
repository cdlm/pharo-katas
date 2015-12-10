packet handling
consume: aPacket
	supply > 0 ifTrue: [ ^ self "no paper, do nothing" ].
	
	supply := supply - 1.
	tray add: aPacket payload