!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setUp' stamp: 'IC&VW 6/6/2023 17:52:47'!
setUp
	cart := Cart acceptsBooks: (Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal').! !


!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:46:56'!
test01_newCartShouldBeEmpty
	
	self	assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:47:14'!
test02_NewCartThatAddsOneBookShouldNotBeEmpty
	
	cart add: 'Harry Potter y la piedra filosofal' amount: 1.
	self	deny: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:47:22'!
test03_NewCartThatAddsMinusOneBookShouldThrowsAnError
	
	self should: [cart add: 'Harry Potter y la piedra filosofal' amount: -1.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: Cart messageErrorCantAddANotNaturalAmountOfBooks equals: anError messageText] .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:47:30'!
test04_NewCartThatAddsOneAndAHalfBookShouldThrowsAnError
	
	self should: [cart add: 'Harry Potter y la piedra filosofal' amount: 1.5 .] 
		raise: Error 
		withExceptionDo: [:anError | self assert: Cart messageErrorCantAddANotNaturalAmountOfBooks equals: anError messageText] .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:47:37'!
test05_NewCartThatAddsNotValidBookShouldThrowAnError

	self should: [cart add: 'asdfghjk' amount: 5.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: Cart messageErrorCantAddNotValidBook equals: anError messageText] .! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:53:54'!
test06_NewCartThatAddsOneOfEachBookCanListThem

	cart add: 'La biblia' amount: 1.
	cart add: 'Harry Potter y la piedra filosofal' amount: 1.
	
	self assert: (Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal') equals: cart contents.! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/6/2023 17:59:25'!
test07_NewCartThatAddsMoreThanOneBookOfEachCanListThem

	|expectedBag|
	cart add: 'La biblia' amount: 2.
	cart add: 'Harry Potter y la piedra filosofal' amount: 2.
	expectedBag := Bag with: 'La biblia' with: 'Harry Potter y la piedra filosofal' with: 'La biblia' with: 'Harry Potter y la piedra filosofal'.
	
	self assert: expectedBag equals: cart contents.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents validBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/6/2023 17:22:14'!
assertValidAmountOfBooksToBeAddedToCart: anAmount

	^ (anAmount < 0 or: anAmount isFloat) ifTrue: [self class errorCantAddANotNaturalAmountOfBooks ]! !

!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/6/2023 17:39:09'!
assertValidBook: aBook 
	(validBooks includes: aBook) ifFalse: [self class errorCantAddNotValidBook]. ! !


!Cart methodsFor: 'adding' stamp: 'IC&VW 6/6/2023 17:58:13'!
add: aBook amount: anAmount  
	self assertValidAmountOfBooksToBeAddedToCart: anAmount.
	self assertValidBook: aBook.
 	contents add: aBook withOccurrences: anAmount.! !


!Cart methodsFor: 'contents' stamp: 'IC&VW 6/6/2023 17:58:45'!
contents
	^ contents! !

!Cart methodsFor: 'contents' stamp: 'IC&VW 6/6/2023 17:08:38'!
isEmpty
	^contents isEmpty ! !


!Cart methodsFor: 'initialization' stamp: 'IC&VW 6/6/2023 17:53:23'!
initializeAcceptingBooks: aListOfBooks
	contents:= Bag new.
	validBooks := aListOfBooks! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'IC&VW 6/6/2023 17:44:15'!
acceptsBooks: aListOfBooks
	^self new initializeAcceptingBooks: aListOfBooks
! !


!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/6/2023 17:19:19'!
errorCantAddANotNaturalAmountOfBooks
	^self error: self messageErrorCantAddANotNaturalAmountOfBooks
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/6/2023 17:31:02'!
errorCantAddNotValidBook
	^self error: self messageErrorCantAddNotValidBook.
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/6/2023 17:18:50'!
messageErrorCantAddANotNaturalAmountOfBooks
	^'No se puede agregar una cantitad no natural de libros'
! !

!Cart class methodsFor: 'errors' stamp: 'IC&VW 6/6/2023 17:27:14'!
messageErrorCantAddNotValidBook
	^'No se puede agrega un libro no valido'
! !
