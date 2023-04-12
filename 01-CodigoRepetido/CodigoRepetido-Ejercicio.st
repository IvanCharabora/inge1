!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:28:10'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook addCustomer |
	
	customerBook := CustomerBook new.
	addCustomer := [customerBook addCustomerNamed: 'John Lennon'.].
	
	self action:  addCustomer  runsInLessThan: 50*millisecond! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:28:43'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney removeCustomer |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	removeCustomer := [customerBook removeCustomerNamed: paulMcCartney.].
	
	self action: removeCustomer  runsInLessThan: 100*millisecond .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:45:47'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook addCustomerWithEmptyName assertIfErrorDoToEmptyName |
	
	customerBook := CustomerBook new.
	addCustomerWithEmptyName := [customerBook addCustomerNamed: ''].
	
	assertIfErrorDoToEmptyName := [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	
	self if:  addCustomerWithEmptyName throwsErrorMessage: Error run: 				assertIfErrorDoToEmptyName
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:48:40'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon isJohnLennonTheOnlyCustomer removeNonExistentCustomer |
	
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	removeNonExistentCustomer := [customerBook removeCustomerNamed: 'Paul McCartney'].
	isJohnLennonTheOnlyCustomer := self askIfIn: customerBook theOnlyCustomerIs: johnLennon .
	
	self if: removeNonExistentCustomer throwsErrorMessage: NotFound run: 				isJohnLennonTheOnlyCustomer! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:44:52'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspendNewCustomer: paulMcCartney.
	
	self  ifIn:  customerBook theNumberOfActiveCustomersIs:  0 theNumberOfSuspendedCustomersIs: 1 andTheTotalIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:44:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	customerBook addAndSuspendNewCustomer: paulMcCartney .
	customerBook removeCustomerNamed: paulMcCartney.
	
	self ifIn:  customerBook theNumberOfActiveCustomersIs: 0 theNumberOfSuspendedCustomersIs: 0 andTheTotalIs:   0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:48:59'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon isJohnLennonTheOnlyCustomer suspendNonExistentCustomer |
	
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	suspendNonExistentCustomer := [customerBook suspendCustomerNamed: 'George Harrison'].
	isJohnLennonTheOnlyCustomer := self askIfIn: customerBook  theOnlyCustomerIs: johnLennon .
	
	self if: suspendNonExistentCustomer throwsErrorMessage: CantSuspend run: 				isJohnLennonTheOnlyCustomer! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VW 4/12/2023 17:49:10'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon isJohnLennonTheOnlyCustomer suspendSuspendedCustomer |
	
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	
	customerBook addAndSuspendNewCustomer: johnLennon .
	
	suspendSuspendedCustomer := [customerBook suspendCustomerNamed: johnLennon].
	isJohnLennonTheOnlyCustomer := self askIfIn: customerBook theOnlyCustomerIs:  johnLennon .
	
	self if: suspendSuspendedCustomer throwsErrorMessage: CantSuspend run: 				isJohnLennonTheOnlyCustomer
	! !


!CustomerBookTest methodsFor: 'asserts' stamp: 'VW 4/12/2023 14:45:26'!
action: anActionToMeasure runsInLessThan: aTimeLimitToCompare
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anActionToMeasure value .
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning < aTimeLimitToCompare)
! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'VW 4/12/2023 17:47:46'!
askIfIn: aCustomerBook theOnlyCustomerIs: aCustomer
^ [ :anError | 
		self assert: aCustomerBook numberOfCustomers = 1.
		self assert: (aCustomerBook includesCustomerNamed: aCustomer) ].! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'VW 4/12/2023 14:53:57'!
if: aBlockThatFails throwsErrorMessage: anErrorMessage run: aBlockToRun
	[aBlockThatFails value. 
		self fail] 
	on: anErrorMessage 
	do: aBlockToRun ! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'VW 4/12/2023 17:43:47'!
ifIn: aCustomerBook theNumberOfActiveCustomersIs: expectedActive theNumberOfSuspendedCustomersIs: expectedSuspended andTheTotalIs: expectedTotal 
	self assert: expectedActive equals: aCustomerBook numberOfActiveCustomers.
	self assert: expectedSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: expectedTotal equals: aCustomerBook numberOfCustomers.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'VW 4/12/2023 17:44:19'!
addAndSuspendNewCustomer: customerToAddAndSuspend

	self addCustomerNamed: customerToAddAndSuspend.
	self suspendCustomerNamed: customerToAddAndSuspend.! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
