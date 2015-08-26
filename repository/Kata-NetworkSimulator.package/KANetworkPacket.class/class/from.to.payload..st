instance creation
from: sourceAddress to: destinationAddress payload: anObject
	^ self new
		initializeSource: sourceAddress
		destination: destinationAddress
		payload: anObject