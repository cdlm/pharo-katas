accessing
nodeAt: anAddress
	^ self
		nodeAt: anAddress
		ifNone: [ NotFound signalFor: anAddress in: self ]