!classDefinition: #MarsRoverTest category: 'MarsRoverTDD'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/15/2023 00:33:48'!
assertMarsRover: aMarsRover positionIs: aPosition andFaces: anOrientation 

	self assert: aPosition equals: aMarsRover position.
	self assertMarsRoverOrientation: aMarsRover orientation is: anOrientation! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 17:14:15'!
assertMarsRoverDontMoveAfterCreatedIn: aPosition facing: anOrientation
	
	|marsRover|
	marsRover := MarsRover position: aPosition facing: anOrientation new.
	self assertMarsRover: marsRover positionIs: aPosition andFaces: anOrientation.! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/15/2023 00:33:27'!
assertMarsRoverOrientation: aMarsRoverOrientation is: anOrientation

	self assert: (aMarsRoverOrientation isKindOf: anOrientation)! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:41:42'!
assertNewMarsRover: aMarsRover IsInPosition: aPosition facing: anOrientation afterReading: aSerieOfCommands
	
	aMarsRover readCommands: aSerieOfCommands.
	self assertMarsRover: aMarsRover positionIs: aPosition andFaces: anOrientation! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:42:21'!
assertNewMarsRover: aMarsRover IsInPosition: aPosition facing: anOrientation afterReadingWithError: aSerieOfCommands
	
	self should: [ aMarsRover readCommands: aSerieOfCommands]
	       raise: Error
	       withExceptionDo: [ :anError |
			self assert: anError messageText equals: (aMarsRover class erroredCommandErrorMessage).
			self assertMarsRover: aMarsRover positionIs: aPosition andFaces: anOrientation
		]! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:13:29'!
assertNewMarsRoverFacingEastIsInPosition: aPosition facing: anOrientation afterReading: aSerieOfCommands
	
	self assertNewMarsRover: self createMarsRoverIn0x0FacingEast 
	       IsInPosition: aPosition 
	       facing: anOrientation 
	       afterReading: aSerieOfCommands.

! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:07:23'!
assertNewMarsRoverFacingNorthIsInPosition: aPosition facing: anOrientation afterReading: aSerieOfCommands
	
	self assertNewMarsRover: self createMarsRoverIn0x0FacingNorth
	       IsInPosition: aPosition 
	       facing: anOrientation 
	       afterReading: aSerieOfCommands.

! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:43:40'!
assertNewMarsRoverFacingNorthIsInPosition: aPosition facing: anOrientation afterReadingWithError: aSerieOfCommands
	
	self assertNewMarsRover: self createMarsRoverIn0x0FacingNorth
	       IsInPosition: aPosition 
	       facing: anOrientation 
	       afterReadingWithError: aSerieOfCommands.

! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:10:34'!
assertNewMarsRoverFacingSouthIsInPosition: aPosition facing: anOrientation afterReading: aSerieOfCommands
	
	self assertNewMarsRover: self createMarsRoverIn0x0FacingSouth 
	       IsInPosition: aPosition 
	       facing: anOrientation 
	       afterReading: aSerieOfCommands.! !

!MarsRoverTest methodsFor: 'asserts' stamp: 'ic&vw 5/14/2023 00:13:23'!
assertNewMarsRoverFacingWestIsInPosition: aPosition facing: anOrientation afterReading: aSerieOfCommands
	
	self assertNewMarsRover: self createMarsRoverIn0x0FacingWest 
	       IsInPosition: aPosition 
	       facing: anOrientation 
	       afterReading: aSerieOfCommands.

! !


!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_01AssertInitialPosition0x0FacingNorth
	
	self assertMarsRoverDontMoveAfterCreatedIn: 0@0 
	       facing: MarsRoverFacingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:11'!
test_02AssertInitialPosition0x1FacingSouth
	
	self assertMarsRoverDontMoveAfterCreatedIn: 0@1 
	       facing: MarsRoverFacingSouth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_03AssertMarsRoverReadEmptyCommand
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingNorth
	       afterReading: ''! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_04AssertMarsRoverReadFowardCommandWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 1@0 
	       facing:  MarsRoverFacingNorth
	       afterReading: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_05AssertMarsRoverReadBackwardCommandWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: -1@0 
	       facing:  MarsRoverFacingNorth
	       afterReading: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:19'!
test_06AssertMarsRoverReadLeftCommandWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingWest 
	       afterReading: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:12:51'!
test_07AssertMarsRoverReadRightCommandWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingEast 
	       afterReading: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_08AssertMarsRoverReadTwoForwardCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 2@0 
	       facing:  MarsRoverFacingNorth
	       afterReading: 'ff'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:11'!
test_09AssertMarsRoverReadTwoLeftCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingSouth 
	       afterReading: 'll'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:11'!
test_10AssertMarsRoverReadTwoRightCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingSouth 
	       afterReading: 'rr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:12:51'!
test_11AssertMarsRoverReadThreeLeftCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingEast 
	       afterReading: 'lll'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:19'!
test_12AssertMarsRoverReadThreeRightCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingWest 
	       afterReading: 'rrr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_13AssertMarsRoverReadFourLeftCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingNorth 
	       afterReading: 'llll'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_14AssertMarsRoverReadFourRightCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0 
	       facing:  MarsRoverFacingNorth 
	       afterReading: 'rrrr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:12:51'!
test_15AssertMarsRoverReadRightForwardCommandsWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@-1
	       facing:  MarsRoverFacingEast
	       afterReading: 'rf'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:19'!
test_16AssertMarsRoverReadForwardTwiceAndRightCommandsWhenFacingSouth
	
	self assertNewMarsRoverFacingSouthIsInPosition: -2@0
	       facing:  MarsRoverFacingWest 
	       afterReading: 'ffr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_17AssertMarsRoverReadForwardTwiceAndRightCommandsWhenFacingWest
	
	self assertNewMarsRoverFacingWestIsInPosition: 0@2
	       facing:  MarsRoverFacingNorth
	       afterReading: 'ffr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:11'!
test_18AssertMarsRoverReadForwardTwiceAndRightCommandsWhenFacingEast
	
	self assertNewMarsRoverFacingEastIsInPosition: 0@-2
	       facing:  MarsRoverFacingSouth 
	       afterReading: 'ffr'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_19AssertMarsRoverDontDoAnythingWithErroredCommandWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0
	       facing:  MarsRoverFacingNorth 
	       afterReadingWithError: 'x'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:05'!
test_20AssertMarsRoverWithErroredCommandAtBeginningWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 0@0
	       facing:  MarsRoverFacingNorth 
	       afterReadingWithError: 'xffrb'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:12:51'!
test_21AssertMarsRoverWithErroredCommandAtEndWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: 2@1
	       facing:  MarsRoverFacingEast 
	       afterReadingWithError: 'ffrbx'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ic&vw 5/14/2023 17:13:11'!
test_22AssertMarsRoverWithErroredCommandInMiddleWhenFacingNorth
	
	self assertNewMarsRoverFacingNorthIsInPosition: -3@0
	       facing:  MarsRoverFacingSouth 
	       afterReadingWithError: 'bbllfxfffff'! !


!MarsRoverTest methodsFor: 'creations' stamp: 'ic&vw 5/14/2023 17:12:51'!
createMarsRoverIn0x0FacingEast
	
	^MarsRover position: 0@0 facing: (MarsRoverFacingEast new).
! !

!MarsRoverTest methodsFor: 'creations' stamp: 'ic&vw 5/14/2023 17:13:05'!
createMarsRoverIn0x0FacingNorth
	
	^MarsRover position: 0@0 facing: (MarsRoverFacingNorth new).
! !

!MarsRoverTest methodsFor: 'creations' stamp: 'ic&vw 5/14/2023 17:13:11'!
createMarsRoverIn0x0FacingSouth
	
	^MarsRover position: 0@0 facing: (MarsRoverFacingSouth new).
! !

!MarsRoverTest methodsFor: 'creations' stamp: 'ic&vw 5/14/2023 17:13:19'!
createMarsRoverIn0x0FacingWest
	
	^MarsRover position: 0@0 facing: (MarsRoverFacingWest new).
! !


!classDefinition: #MarsRover category: 'MarsRoverTDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'testing' stamp: 'ic&vw 5/13/2023 23:51:22'!
isBackwardCommand: aCommand
	
	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'ic&vw 5/13/2023 23:51:05'!
isForwardCommand: aCommand
	
	^aCommand 	= $f! !

!MarsRover methodsFor: 'testing' stamp: 'ic&vw 5/13/2023 23:51:31'!
isLeftCommand: aCommand
	
	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'ic&vw 5/13/2023 23:51:35'!
isRightCommand: aCommand
	
	^aCommand = $r! !


!MarsRover methodsFor: 'orientation and position' stamp: 'VW 5/13/2023 16:28:22'!
orientation
	^orientation! !

!MarsRover methodsFor: 'orientation and position' stamp: 'VW 5/13/2023 16:28:14'!
position
	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'VW 5/13/2023 16:31:33'!
initializePosition: aPosition facing: anOrientation 
	position := aPosition.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/14/2023 00:30:20'!
erroredCommand

	(self class) erroredCommandError! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/14/2023 00:33:27'!
executeACommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [^ self moveForward]. 
	(self isBackwardCommand: aCommand) ifTrue: [^ self moveBackward]. 
	(self isLeftCommand: aCommand) ifTrue: [^ self rotateLeft]. 
	(self isRightCommand: aCommand) ifTrue: [^ self rotateRight]. 
	
	self erroredCommand! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/13/2023 23:53:21'!
moveBackward

	^ orientation moveBackward: self! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/13/2023 23:53:11'!
moveForward

	^ orientation moveForward: self! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/13/2023 23:48:42'!
readCommands: aSerieOfCommands 
		
	aSerieOfCommands do: [:aCommand | self executeACommand: aCommand]
! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/13/2023 23:54:10'!
rotateLeft

	^ orientation rotateLeft: self! !

!MarsRover methodsFor: 'commands' stamp: 'ic&vw 5/13/2023 23:54:17'!
rotateRight

	^ orientation rotateRight: self! !


!MarsRover methodsFor: 'move' stamp: 'VW 5/13/2023 18:15:40'!
moveToEast
	position := position + (0@-1).! !

!MarsRover methodsFor: 'move' stamp: 'VW 5/13/2023 18:15:48'!
moveToNorth
	position := position + (1@0).! !

!MarsRover methodsFor: 'move' stamp: 'VW 5/13/2023 18:16:00'!
moveToSouth
	position := position + (-1@0).! !

!MarsRover methodsFor: 'move' stamp: 'VW 5/13/2023 18:16:08'!
moveToWest
	position := position + (0@1).! !


!MarsRover methodsFor: 'face' stamp: 'ic&vw 5/14/2023 16:56:38'!
faceEast
	orientation:= MarsRoverFacingEast new.! !

!MarsRover methodsFor: 'face' stamp: 'ic&vw 5/14/2023 16:56:59'!
faceNorth
	orientation:= MarsRoverFacingNorth new.! !

!MarsRover methodsFor: 'face' stamp: 'ic&vw 5/14/2023 16:57:12'!
faceSouth
	orientation:= MarsRoverFacingSouth new.! !

!MarsRover methodsFor: 'face' stamp: 'ic&vw 5/14/2023 16:57:22'!
faceWest
	orientation:= MarsRoverFacingWest new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverTDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'errors' stamp: 'ic&vw 5/14/2023 00:30:46'!
erroredCommandError

	self error: self erroredCommandErrorMessage! !

!MarsRover class methodsFor: 'errors' stamp: 'ic&vw 5/14/2023 00:31:34'!
erroredCommandErrorMessage

	^'The command is not recognisable'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'VW 5/13/2023 16:26:33'!
position: aPosition facing: anOrientation

	^self new initializePosition: aPosition facing: anOrientation ! !


!classDefinition: #MarsRoverFacing category: 'MarsRoverTDD'!
Object subclass: #MarsRoverFacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacing methodsFor: 'move' stamp: 'ic&vw 5/13/2023 23:55:54'!
moveBackward: aMarsRover
	
	self subclassResponsibility ! !

!MarsRoverFacing methodsFor: 'move' stamp: 'ic&vw 5/13/2023 23:56:02'!
moveForward: aMarsRover
	
	self subclassResponsibility ! !


!MarsRoverFacing methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:56:14'!
rotateLeft: aMarsRover
	
	self subclassResponsibility ! !

!MarsRoverFacing methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:56:16'!
rotateRight: aMarsRover
	
	self subclassResponsibility ! !


!classDefinition: #MarsRoverFacingEast category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingEast methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:09:41'!
rotateLeft: aMarsRover
	aMarsRover faceNorth.! !

!MarsRoverFacingEast methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:09:50'!
rotateRight: aMarsRover
	aMarsRover faceSouth.! !


!MarsRoverFacingEast methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:57'!
moveBackward: aMarsRover
	aMarsRover moveToWest.! !

!MarsRoverFacingEast methodsFor: 'move' stamp: 'VW 5/13/2023 18:11:01'!
moveForward: aMarsRover
	aMarsRover moveToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingEast class' category: 'MarsRoverTDD'!
MarsRoverFacingEast class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingEast category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingEast methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:09:41'!
rotateLeft: aMarsRover
	aMarsRover faceNorth.! !

!MarsRoverFacingEast methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:09:50'!
rotateRight: aMarsRover
	aMarsRover faceSouth.! !


!MarsRoverFacingEast methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:57'!
moveBackward: aMarsRover
	aMarsRover moveToWest.! !

!MarsRoverFacingEast methodsFor: 'move' stamp: 'VW 5/13/2023 18:11:01'!
moveForward: aMarsRover
	aMarsRover moveToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingEast class' category: 'MarsRoverTDD'!
MarsRoverFacingEast class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingNorth category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingNorth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:08:51'!
rotateLeft: aMarsRover
	aMarsRover faceWest.! !

!MarsRoverFacingNorth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:08:59'!
rotateRight: aMarsRover
	aMarsRover faceEast.! !


!MarsRoverFacingNorth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:43'!
moveBackward: aMarsRover
	aMarsRover moveToSouth.! !

!MarsRoverFacingNorth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:47'!
moveForward: aMarsRover
	aMarsRover moveToNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingNorth class' category: 'MarsRoverTDD'!
MarsRoverFacingNorth class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingNorth category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingNorth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:08:51'!
rotateLeft: aMarsRover
	aMarsRover faceWest.! !

!MarsRoverFacingNorth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:08:59'!
rotateRight: aMarsRover
	aMarsRover faceEast.! !


!MarsRoverFacingNorth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:43'!
moveBackward: aMarsRover
	aMarsRover moveToSouth.! !

!MarsRoverFacingNorth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:47'!
moveForward: aMarsRover
	aMarsRover moveToNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingNorth class' category: 'MarsRoverTDD'!
MarsRoverFacingNorth class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingSouth category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingSouth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:39'!
moveBackward: aMarsRover
	aMarsRover moveToNorth.! !

!MarsRoverFacingSouth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:34'!
moveForward: aMarsRover
	aMarsRover moveToSouth.! !


!MarsRoverFacingSouth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:07:34'!
rotateLeft: aMarsRover
	aMarsRover faceEast.! !

!MarsRoverFacingSouth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:07:45'!
rotateRight: aMarsRover
	aMarsRover faceWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingSouth class' category: 'MarsRoverTDD'!
MarsRoverFacingSouth class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingSouth category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingSouth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:39'!
moveBackward: aMarsRover
	aMarsRover moveToNorth.! !

!MarsRoverFacingSouth methodsFor: 'move' stamp: 'VW 5/13/2023 18:10:34'!
moveForward: aMarsRover
	aMarsRover moveToSouth.! !


!MarsRoverFacingSouth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:07:34'!
rotateLeft: aMarsRover
	aMarsRover faceEast.! !

!MarsRoverFacingSouth methodsFor: 'rotate' stamp: 'VW 5/13/2023 18:07:45'!
rotateRight: aMarsRover
	aMarsRover faceWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingSouth class' category: 'MarsRoverTDD'!
MarsRoverFacingSouth class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingWest category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingWest methodsFor: 'move' stamp: 'VW 5/13/2023 18:06:38'!
moveBackward: aMarsRover
	aMarsRover moveToEast.! !

!MarsRoverFacingWest methodsFor: 'move' stamp: 'VW 5/13/2023 18:07:04'!
moveForward: aMarsRover
	aMarsRover moveToWest.! !


!MarsRoverFacingWest methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:41:56'!
rotateLeft: aMarsRover
	aMarsRover faceSouth.! !

!MarsRoverFacingWest methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:42:01'!
rotateRight: aMarsRover
	aMarsRover faceNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingWest class' category: 'MarsRoverTDD'!
MarsRoverFacingWest class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #MarsRoverFacingWest category: 'MarsRoverTDD'!
MarsRoverFacing subclass: #MarsRoverFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverFacingWest methodsFor: 'move' stamp: 'VW 5/13/2023 18:06:38'!
moveBackward: aMarsRover
	aMarsRover moveToEast.! !

!MarsRoverFacingWest methodsFor: 'move' stamp: 'VW 5/13/2023 18:07:04'!
moveForward: aMarsRover
	aMarsRover moveToWest.! !


!MarsRoverFacingWest methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:41:56'!
rotateLeft: aMarsRover
	aMarsRover faceSouth.! !

!MarsRoverFacingWest methodsFor: 'rotate' stamp: 'ic&vw 5/13/2023 23:42:01'!
rotateRight: aMarsRover
	aMarsRover faceNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingWest class' category: 'MarsRoverTDD'!
MarsRoverFacingWest class
	instanceVariableNames: 'uniqueInstance'!
