printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: ' ('.
	self sourceAddress printOn: aStream.
	aStream nextPutAll: ' -> '.
	self destinationAddress printOn: aStream.
	aStream nextPutAll: ')'