!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:09:58'!
test01MarsRoverWithLogObserverStartsWithEmptyLoggedChanges

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
	
	self assert: OrderedCollection new equals: logChanges positions.
	self assert: OrderedCollection new equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:07:41'!
test02MarsRoverWithLogObserverMovesForwardLogsEmptyHeadingAndNewPosition

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 0@1) equals: logChanges positions.
	self assert: OrderedCollection new equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:07:45'!
test03MarsRoverWithLogObserverMovesBackwardLogsEmptyHeadingAndNewPosition

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
	
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 0@-1) equals: logChanges positions.
	self assert: OrderedCollection new equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:07:10'!
test04MarsRoverWithLogObserverRotatesLeftLogsEmptyMovementAndHeadsWest

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
	
	marsRover process: 'l'.
	
	self assert: OrderedCollection new equals: logChanges positions.
	self assert: (OrderedCollection with: 'West') equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:07:28'!
test05MarsRoverWithLogObserverRotatesRightLogsEmptyMovementAndHeadsEast

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
	
	marsRover process: 'r'.
	
	self assert: OrderedCollection new equals: logChanges positions.
	self assert: (OrderedCollection with: 'East') equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:09:18'!
test06MarsRoverWithLogObserverRotatesTwiceLogsEmptyMovementAndTwoHeadings

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.

	marsRover process: 'rr'.
	
	self assert: OrderedCollection new equals: logChanges positions.
	self assert: (OrderedCollection with: 'East' with: 'South') equals: logChanges heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:08:46'!
test07MarsRoverWithLogObserverMovesAndRotatesAndLogsNewHeadingAndPosition

	| logChanges marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: logChanges.
			
	marsRover process: 'fr'.
	
	self assert: (OrderedCollection with: 0@1 with: 'East') equals: logChanges headingAndPosition.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:13:47'!
test08MarsRoverWithWindowObserverStartsWithEmptyWindow

	| window marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	
	marsRover addObserver: window.
	
	self assert: MarsRoverWindow defaultPositionValue equals: window position.
	self assert: '' equals: window heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:15:00'!
test09MarsRoverWithWindowObserverMovesForwardAndShowsNewPositionAndEmptyHeading

	| window marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	
	marsRover addObserver: window.
	
	marsRover process: 'f'.
	
	self assert: 0@1 equals: window position.
	self assert: '' equals: window heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:15:30'!
test10MarsRoverWithWindowObserverMovesForwardAndRotatesAndShowsNewPositionAndNewHeading

	| window marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	
	marsRover addObserver: window.
	
	marsRover process: 'fr'.
	
	self assert: 0@1 equals: window position.
	self assert: 'Apuntando al Este' equals: window heading.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:17:09'!
test11MarsRoverWithWindowObserverMovesForwardAndRotatesCanShowNewPositionAndNewHeadingSimultaneously

	| window marsRover |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	
	marsRover addObserver: window.
	
	marsRover process: 'fr'.
	
	self assert: 'Posicion: 0@1; Apuntando al Este' equals: window headingAndPosition.
! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'vw&ic 6/3/2023 16:17:04'!
test12MarsRoverWithWindowAndLogObserverMovesForwardAndRotatesCanShowNewPositionAndNewHeadingSimultaneously

	| window marsRover logChanges |
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := MarsRoverWindow new.
	logChanges := MarsRoverLogChanges new.
	
	marsRover addObserver: window.
	marsRover addObserver: logChanges.
	
	marsRover process: 'fr'.
	
	self assert: 'Posicion: 0@1; Apuntando al Este' equals: window headingAndPosition.
	self assert: (OrderedCollection with: 0@1 with: 'East') equals: logChanges headingAndPosition.

! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'vw&ic 6/2/2023 12:46:37'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'vw&ic 6/2/2023 12:46:37'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'vw&ic 6/2/2023 12:46:37'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'vw&ic 6/2/2023 12:46:37'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'vw&ic 6/2/2023 12:46:37'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'vw&ic 6/2/2023 12:46:37'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #InstanceWithObservers category: 'MarsRover-WithHeading'!
Object subclass: #InstanceWithObservers
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!InstanceWithObservers methodsFor: 'initialization' stamp: 'vw&ic 6/3/2023 15:48:45'!
initializeWith: anInstance

	observers := OrderedCollection new.
	value := anInstance.! !


!InstanceWithObservers methodsFor: 'value' stamp: 'vw&ic 6/3/2023 15:43:42'!
value
	^value! !

!InstanceWithObservers methodsFor: 'value' stamp: 'vw&ic 6/3/2023 15:59:09'!
value: aNewValue

	value := aNewValue.
	observers do: [:anObserver | anObserver value: aNewValue]! !


!InstanceWithObservers methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:59:29'!
addObserver: anObserver

	observers add: anObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InstanceWithObservers class' category: 'MarsRover-WithHeading'!
InstanceWithObservers class
	instanceVariableNames: ''!

!InstanceWithObservers class methodsFor: 'instance creation' stamp: 'vw&ic 6/3/2023 15:56:47'!
with: anInstance

	^self new initializeWith: anInstance! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head movingObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'vw&ic 6/2/2023 12:46:36'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'vw&ic 6/2/2023 12:46:36'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'vw&ic 6/3/2023 15:47:52'!
initializeAt: aPosition heading: aHeadingType

	position := InstanceWithObservers with: aPosition.
	head := InstanceWithObservers with: (aHeadingType for: self).! !


!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:49:29'!
headEast
	
	head value: (MarsRoverHeadingEast for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:49:46'!
headNorth
	
	head value: (MarsRoverHeadingNorth for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:49:58'!
headSouth
	
	head value: (MarsRoverHeadingSouth for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:50:05'!
headWest
	
	head value: (MarsRoverHeadingWest for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:50:13'!
rotateLeft
	
	head value rotateLeft.
! !

!MarsRover methodsFor: 'heading' stamp: 'vw&ic 6/3/2023 15:50:21'!
rotateRight
	
	head value rotateRight.
! !


!MarsRover methodsFor: 'testing' stamp: 'vw&ic 6/3/2023 15:51:35'!
isAt: aPosition heading: aHeadingType

	^position value = aPosition and: [ head value isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'vw&ic 6/2/2023 12:46:36'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'vw&ic 6/2/2023 12:46:36'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'vw&ic 6/2/2023 12:46:36'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'vw&ic 6/2/2023 12:46:36'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:51:58'!
moveBackward
	
	head value moveBackward.
! !

!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:52:26'!
moveEast
	
	position value: position value + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:52:05'!
moveForward
	
	head value moveForward.
! !

!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:52:38'!
moveNorth
	
	position value: position value + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:52:45'!
moveSouth
	
	position value: position value + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'vw&ic 6/3/2023 15:52:51'!
moveWest
	
	position value: position value + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'vw&ic 6/2/2023 12:46:36'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'vw&ic 6/2/2023 12:46:36'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:58:42'!
addObserver: anObserver

	position addObserver: anObserver updatePosition.
	head addObserver: anObserver updateHeading.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'vw&ic 6/2/2023 12:46:36'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:36'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:36'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'vw&ic 6/2/2023 12:46:36'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:36'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:36'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'vw&ic 6/2/2023 12:46:36'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'vw&ic 6/2/2023 12:46:36'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:36'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:38:33'!
updateObserver: anObserver

	anObserver updateHeadingEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:38:59'!
updateObserver: anObserver

	anObserver updateHeadingNorth! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:39:14'!
updateObserver: anObserver

	anObserver updateHeadingSouth! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'vw&ic 6/2/2023 12:46:37'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'vw&ic 6/2/2023 12:46:37'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'observers' stamp: 'vw&ic 6/3/2023 15:39:29'!
updateObserver: anObserver

	anObserver updateHeadingWest! !


!classDefinition: #MarsRoverLogChanges category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogChanges
	instanceVariableNames: 'positions heading headingAndPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogChanges methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:00:30'!
heading
	
	^heading.! !

!MarsRoverLogChanges methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:13:41'!
headingAndPosition
	^headingAndPosition! !

!MarsRoverLogChanges methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:00:25'!
positions
	
	^positions.! !


!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:35:40'!
updateHeading
		
	^[:aHeading | aHeading updateObserver: self]! !

!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:35:54'!
updateHeadingEast
		
	heading add: 'East'.
	headingAndPosition add: 'East'! !

!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:36:07'!
updateHeadingNorth
		
	heading add: 'North'.
	headingAndPosition add: 'North'! !

!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:36:17'!
updateHeadingSouth
		
	heading add: 'South'.
	headingAndPosition add: 'South'! !

!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:36:27'!
updateHeadingWest
		
	heading add: 'West'.
	headingAndPosition add: 'West'! !

!MarsRoverLogChanges methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:27:19'!
updatePosition
		
	^[:aPosition | positions add: aPosition. headingAndPosition add: aPosition]! !


!MarsRoverLogChanges methodsFor: 'initialization' stamp: 'vw&ic 6/2/2023 13:14:00'!
initialize

	positions := OrderedCollection new.
	heading := OrderedCollection new.
	headingAndPosition := OrderedCollection new.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'vw&ic 6/3/2023 16:13:43'!
initialize

	position := self class defaultPositionValue.
	heading := ''.! !


!MarsRoverWindow methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:31:33'!
heading
	^heading.! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:31:49'!
headingAndPosition

	^'Posicion: ', (position asString),'; ', heading! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'vw&ic 6/2/2023 13:22:18'!
position

	^position .! !


!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:31:17'!
updateHeading
	
	^[:aHeading | aHeading updateObserver: self ]! !

!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:31:25'!
updateHeadingEast 
	
	heading := 'Apuntando al Este'.
! !

!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:31:30'!
updateHeadingNorth 
	
	heading := 'Apuntando al Norte'.
! !

!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:31:34'!
updateHeadingSouth 
	
	heading := 'Apuntando al Sur'.
! !

!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:31:43'!
updateHeadingWest
	
	heading := 'Apuntando al Oeste'.
! !

!MarsRoverWindow methodsFor: 'updates' stamp: 'vw&ic 6/3/2023 15:11:54'!
updatePosition
	
	^[:aPosition | position := aPosition]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'constants' stamp: 'vw&ic 6/3/2023 16:12:48'!
defaultPositionValue

	^'No se movio'! !
