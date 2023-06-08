!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setUp' stamp: 'IC&VW 6/7/2023 23:53:37'!
setUp
	cart := Cart acceptsItems: (Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal').! !


!CartTest methodsFor: 'tests - private' stamp: 'IC&VW 6/8/2023 00:14:04'!
addItem: anItem withAmount: anAmount andItem: anotherItem withAmount: anotherAmount expects: anExpectedCart 

	cart add: anItem amount: anAmount.
	cart add: anotherItem amount: anotherAmount.
	self assert: anExpectedCart equals: cart contents! !

!CartTest methodsFor: 'tests - private' stamp: 'IC&VW 6/8/2023 00:01:47'!
addingItem: anItem withAmount: anAmount shouldRaise: aMessageError  

	^ self should: [cart add: anItem amount: anAmount.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: aMessageError equals: anError messageText]! !


!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:46:56'!
test01_newCartShouldBeEmpty
	
	self	assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:47:14'!
test02_NewCartThatAddsOneBookShouldNotBeEmpty
	
	cart add: 'Harry Potter y la piedra filosofal' amount: 1.
	self	deny: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/8/2023 00:05:32'!
test03_NewCartThatAddsMinusOneBookShouldThrowsAnError
	
	self addingItem: 'Harry Potter y la piedra filosofal' withAmount: -1 shouldRaise: Cart messageErrorCantAddANotNaturalAmountOfItems .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/8/2023 00:05:32'!
test04_NewCartThatAddsOneAndAHalfBookShouldThrowsAnError

	self addingItem: 'Harry Potter y la piedra filosofal' withAmount: 1.5 shouldRaise: Cart messageErrorCantAddANotNaturalAmountOfItems .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/8/2023 00:05:50'!
test05_NewCartThatAddsNotValidBookShouldThrowAnError

	self addingItem: 'asdfghjk' withAmount: 5 shouldRaise: Cart messageErrorCantAddNotValidItem .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/8/2023 00:14:59'!
test06_NewCartThatAddsOneOfEachBookCanListThem
	
	self  addItem: 'La biblia' withAmount: 1
		andItem: 'Harry Potter y la piedra filosofal' withAmount: 1 
		expects: (Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal').! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/8/2023 00:14:21'!
test07_NewCartThatAddsMoreThanOneBookOfEachCanListThem

	self  addItem: 'La biblia' withAmount: 2 
		andItem: 'Harry Potter y la piedra filosofal' withAmount: 2 
		expects: (Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal' with: 'La biblia' with: 'Harry Potter y la piedra filosofal').! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents validItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/8/2023 00:06:29'!
assertValidAmountOfItemsToBeAddedToCart: anAmount

	^ (anAmount < 0 or: anAmount isFloat) ifTrue: [self class errorCantAddANotNaturalAmountOfItems ]! !

!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/8/2023 00:06:07'!
assertValidItem: anItem 
	(validItems includes: anItem) ifFalse: [self class errorCantAddNotValidItem]. ! !


!Cart methodsFor: 'adding' stamp: 'IC&VW 6/7/2023 23:51:45'!
add: anItem amount: anAmount  
	self assertValidAmountOfItemsToBeAddedToCart: anAmount.
	self assertValidItem: anItem.
 	contents add: anItem withOccurrences: anAmount.! !


!Cart methodsFor: 'contents' stamp: 'IC&VW 6/6/2023 17:58:45'!
contents
	^ contents! !

!Cart methodsFor: 'contents' stamp: 'IC&VW 6/6/2023 17:08:38'!
isEmpty
	^contents isEmpty ! !


!Cart methodsFor: 'initialization' stamp: 'IC&VW 6/7/2023 23:53:08'!
initializeAcceptingItems: aListOfItems
	contents:= Bag new.
	validItems := aListOfItems! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'IC&VW 6/7/2023 23:53:44'!
acceptsItems: aListOfItems
	^self new initializeAcceptingItems: aListOfItems
! !


!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/8/2023 00:06:29'!
errorCantAddANotNaturalAmountOfItems
	^self error: self messageErrorCantAddANotNaturalAmountOfItems
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/8/2023 00:06:07'!
errorCantAddNotValidItem
	^self error: self messageErrorCantAddNotValidItem.
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/8/2023 00:05:36'!
messageErrorCantAddANotNaturalAmountOfItems
	^'No se puede agregar una cantitad no natural de items'
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/8/2023 00:05:56'!
messageErrorCantAddNotValidItem
	^'No se puede agrega un item no valido'
! !
