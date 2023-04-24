!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptySentence onlySpacesSentence spacesInMiddleSentence spacesAfterCharactersSentence emptyStack stackWithOneElement stackWithMultipleElements sentenceFinderByPrefixWithEmptyStack sentenceFinderByPrefixWithOneElementStack sentenceFinderByPrefixWithMultipleElementStack notFoundSentence foundOneElementSentence foundMultipleElementsSentence caseSensitiveSentence wordCompleteSentence'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 15:14:18'!
createStackWith: aCollectionWithElementsToAddInTheStack
	| newStack |
	
	newStack := OOStack new.
	(aCollectionWithElementsToAddInTheStack) do: [:elem | newStack push: elem].
	^newStack! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 19:16:49'!
createStackWithMultiplesElements
	| multipleElementsCollection |
	
	multipleElementsCollection := OrderedCollection with: 'stark is king in the north' with: 'winter is coming' 
											  with: 	'dracarys' with: 'wint !!' with: 'winter is here' with: 'WiNteR'.

	^self createStackWith: multipleElementsCollection
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 19:17:11'!
createStackWithNoElements
	^OOStack new.
	! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 19:14:39'!
createStackWithOneElement
	| oneElementCollection |
	
	oneElementCollection := OrderedCollection new.
	oneElementCollection add: 'stark is king in the north'.
	^self createStackWith: oneElementCollection.
	
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 15:36:07'!
setUpSentenceFinders
	
	sentenceFinderByPrefixWithEmptyStack := SentenceFinderByPrefix with: emptyStack .
	sentenceFinderByPrefixWithOneElementStack := SentenceFinderByPrefix with: stackWithOneElement .
	sentenceFinderByPrefixWithMultipleElementStack := SentenceFinderByPrefix with: stackWithMultipleElements .
	! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 16:00:53'!
setUpSentences	

	emptySentence := ''.
	onlySpacesSentence := '  '.
	spacesInMiddleSentence := 'winter is'.
	spacesAfterCharactersSentence := 'coming '.
	foundOneElementSentence := 'stark'.
	foundMultipleElementsSentence := 'wint'.
	notFoundSentence := 'notFound'.
	caseSensitiveSentence := 'WiNt'.
	wordCompleteSentence := 'dracarys'.
	
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setup - private' stamp: 'ic 4/21/2023 19:17:29'!
setUpStacks
	
	emptyStack := self createStackWithNoElements .
	stackWithOneElement := self createStackWithOneElement .
	stackWithMultipleElements := self createStackWithMultiplesElements .	
	
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'ic 4/21/2023 19:30:26'!
assert: aStack hasSameElementsWithSameOrderAndSizeThan: anotherStack

	self assert: aStack hasSameSizeThan: anotherStack.
	self assert: aStack hasSameElementsWithSameOrderThan: anotherStack.
	! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'ic 4/21/2023 19:41:09'!
assert: aStack hasSameElementsWithSameOrderThan: anotherStack
	| aStackInCollection anotherStackInCollection |
	
	aStackInCollection := self getCollectionWithStackElements: aStack.
	anotherStackInCollection := self getCollectionWithStackElements: anotherStack.
	
	self assert: aStackInCollection equals: anotherStackInCollection .
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'ic 4/21/2023 19:31:28'!
assert: aStack hasSameSizeThan: anotherStack

	self assert: aStack size equals: anotherStack size
	! !


!SentenceFinderByPrefixTest methodsFor: 'test - private' stamp: 'ic 4/21/2023 19:06:09'!
find: aSentence inMultipleElementStackWillAssert: anErrorWhenFindingSentence

	self should: [sentenceFinderByPrefixWithMultipleElementStack find: aSentence 	] 
	 	raise: Error 
		withExceptionDo: [:anError |  self assert: anError messageText equals: anErrorWhenFindingSentence ]! !

!SentenceFinderByPrefixTest methodsFor: 'test - private' stamp: 'ic 4/21/2023 19:46:43'!
getCollectionWithStackElements: anStack
	| stackElements |
	
	stackElements := OrderedCollection new.
	self popFrom: anStack andAddFirstIn: stackElements.
	self pushTo: anStack from: stackElements.
	^stackElements  ! !

!SentenceFinderByPrefixTest methodsFor: 'test - private' stamp: 'ic 4/21/2023 19:45:57'!
popFrom: anStack andAddFirstIn: aCollection

	(anStack size) timesRepeat: [aCollection 	addFirst: (anStack pop)]
	! !

!SentenceFinderByPrefixTest methodsFor: 'test - private' stamp: 'ic 4/21/2023 19:46:34'!
pushTo: anStack from: aCollection
	
	(aCollection) do: [:elem | anStack push: elem].
	! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:07:33'!
test01PrefixCantBeEmpty

	self find: emptySentence inMultipleElementStackWillAssert: 
				sentenceFinderByPrefixWithMultipleElementStack prefixIsEmptyErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:05:55'!
test02PrefixCantBeOnlySpaces

	self find: onlySpacesSentence inMultipleElementStackWillAssert: 
				sentenceFinderByPrefixWithMultipleElementStack prefixHasSpaceErrorDescription
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:07:23'!
test03PrefixCantEndWithSpaces

	self find: spacesAfterCharactersSentence inMultipleElementStackWillAssert: 
				sentenceFinderByPrefixWithMultipleElementStack prefixHasSpaceErrorDescription
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:07:16'!
test04PrefixCantHaveSpacesInTheMiddle

	self find: spacesInMiddleSentence inMultipleElementStackWillAssert: 
				sentenceFinderByPrefixWithMultipleElementStack prefixHasSpaceErrorDescription
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 18:58:18'!
test05NotFindInEmptyStack
	| foundSentences |
	
	foundSentences := sentenceFinderByPrefixWithEmptyStack find: foundMultipleElementsSentence .
	self assert: foundSentences isEmpty.
	self assert: emptyStack isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:33:12'!
test06NotFindInStackWithElements
	| foundSentences |
	
	foundSentences := sentenceFinderByPrefixWithMultipleElementStack find: notFoundSentence .
	self assert: foundSentences isEmpty.
	
	self assert: self createStackWithMultiplesElements 
		hasSameElementsWithSameOrderAndSizeThan: stackWithMultipleElements! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:59:56'!
test07FindTheOnlyElementInStack
	| foundSentences realSentences |
		
	foundSentences := sentenceFinderByPrefixWithOneElementStack find: foundOneElementSentence .
	realSentences := OrderedCollection with: 'stark is king in the north'.
	
	self assert: realSentences equals: foundSentences .	
	
	self assert: self createStackWithOneElement 
		hasSameElementsWithSameOrderAndSizeThan: stackWithOneElement 
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:59:51'!
test08FindOneElementInStackWithMultipleElements
	| foundSentences realSentences |
		
	foundSentences := sentenceFinderByPrefixWithMultipleElementStack find: foundOneElementSentence .
	realSentences := OrderedCollection with: 'stark is king in the north'.
	
	self assert: realSentences equals: foundSentences.
	
	self assert: self createStackWithMultiplesElements 
		hasSameElementsWithSameOrderAndSizeThan: stackWithMultipleElements ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 19:59:46'!
test09FindMultipleElementsInStackWithMultipleElements
	| foundSentences realSentences |
		
	foundSentences := sentenceFinderByPrefixWithMultipleElementStack find: foundMultipleElementsSentence .
	realSentences := OrderedCollection with: 'winter is coming' with: 'wint !!' with: 'winter is here'.
	
	self assert: realSentences equals: foundSentences .

	self assert: self createStackWithMultiplesElements 
		hasSameElementsWithSameOrderAndSizeThan: stackWithMultipleElements 
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 20:01:01'!
test10FindOnlyOneElementBecauseIsCaseSensitive
	| foundSentences realSentences |
		
	foundSentences := sentenceFinderByPrefixWithMultipleElementStack find: caseSensitiveSentence .
	realSentences := OrderedCollection with: 'WiNteR'.
	
	self assert: realSentences equals: foundSentences .
	
	self assert: self createStackWithMultiplesElements 
		hasSameElementsWithSameOrderAndSizeThan: stackWithMultipleElements 
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ic 4/21/2023 20:01:43'!
test11FindWherePrefixIsAllTheSentence
	| foundSentences realSentences |
		
	foundSentences := sentenceFinderByPrefixWithMultipleElementStack find: wordCompleteSentence .
	realSentences := OrderedCollection with: 'dracarys'.
	
	self assert: realSentences equals: foundSentences .
	
	self assert: self createStackWithMultiplesElements 
		hasSameElementsWithSameOrderAndSizeThan: stackWithMultipleElements 
! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'ic 4/21/2023 15:59:53'!
setUp
	"cases to test:	
		- sentence: empty, only spaces, spaces after characters, spaces in the middle of characters, all characters
		-  stack: empty, one element, more than one element
		- found: zero, one, more than one
		- extra: case sensitive, stack dont change after operations, find word that prefix=word
	"
	
	self setUpSentences.
	self setUpStacks.
	self setUpSentenceFinders.
	
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'ic 4/21/2023 01:27:03'!
isEmpty
	^top isEmpty ! !


!OOStack methodsFor: 'stack-actions' stamp: 'ic 4/21/2023 01:48:30'!
pop
	| lastElement |
	lastElement:= top .
	top := top previous.
	^lastElement value! !

!OOStack methodsFor: 'stack-actions' stamp: 'ic 4/21/2023 01:34:41'!
push: anElement
	top := top push: anElement.
	! !


!OOStack methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:39:10'!
size
	^top size! !

!OOStack methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:49:44'!
top
	^top value! !


!OOStack methodsFor: 'initialization' stamp: 'ic 4/23/2023 13:31:48'!
initialize
	top := OOStackEmptyLinkedList new
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackLinkedList category: 'Stack-Exercise'!
Object subclass: #OOStackLinkedList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackLinkedList methodsFor: 'stack-actions' stamp: 'VW 4/23/2023 14:09:53'!
push: anElement
	^OOStackLinkedListElement newWith: anElement andPrevious: self ! !


!OOStackLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 02:02:28'!
previous
	self subclassResponsibility ! !

!OOStackLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 02:02:34'!
size
	self subclassResponsibility ! !

!OOStackLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 02:02:37'!
value
	self subclassResponsibility ! !


!OOStackLinkedList methodsFor: 'testing' stamp: 'ic 4/21/2023 02:01:59'!
isEmpty
	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyLinkedList category: 'Stack-Exercise'!
OOStackLinkedList subclass: #OOStackEmptyLinkedList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:33:12'!
previous
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackEmptyLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:39:49'!
size
	^0! !

!OOStackEmptyLinkedList methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:51:28'!
value

	self error: OOStack stackEmptyErrorDescription ! !



!OOStackEmptyLinkedList methodsFor: 'testing' stamp: 'ic 4/21/2023 01:27:21'!
isEmpty
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackEmptyLinkedList class' category: 'Stack-Exercise'!
OOStackEmptyLinkedList class
	instanceVariableNames: ''!

!OOStackEmptyLinkedList class methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2023 01:25:23'!
new
	^self basicNew ! !


!classDefinition: #OOStackLinkedListElement category: 'Stack-Exercise'!
OOStackLinkedList subclass: #OOStackLinkedListElement
	instanceVariableNames: 'previous value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!OOStackLinkedListElement methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:33:31'!
previous
	^previous! !

!OOStackLinkedListElement methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:39:42'!
size
	^1+previous size! !

!OOStackLinkedListElement methodsFor: 'stack-information' stamp: 'ic 4/21/2023 01:46:59'!
value
	^value! !


!OOStackLinkedListElement methodsFor: 'initialization' stamp: 'VW 4/23/2023 14:08:06'!
initializeWith: aValue andPrevious: aStackLinkedListElement
	previous := aStackLinkedListElement.
	value := aValue ! !


!OOStackLinkedListElement methodsFor: 'testing' stamp: 'ic 4/21/2023 01:27:28'!
isEmpty
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackLinkedListElement class' category: 'Stack-Exercise'!
OOStackLinkedListElement class
	instanceVariableNames: ''!

!OOStackLinkedListElement class methodsFor: 'as yet unclassified' stamp: 'VW 4/23/2023 14:09:29'!
newWith: aValue andPrevious: aStackLinkedList
	^(self basicNew) initializeWith: aValue andPrevious: aStackLinkedList  ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackToSearch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'error descriptions' stamp: 'ic 4/21/2023 13:37:58'!
prefixHasSpaceErrorDescription
	
	^'Prefix cant have spaces'! !

!SentenceFinderByPrefix methodsFor: 'error descriptions' stamp: 'ic 4/21/2023 13:36:52'!
prefixIsEmptyErrorDescription
	
	^'Prefix cant be empty'! !


!SentenceFinderByPrefix methodsFor: 'asserts' stamp: 'ic 4/21/2023 14:26:20'!
assertPrefixHasNoSpace: aPrefix
	
	(aPrefix includes: (Character space)) ifTrue: [self error: self prefixHasSpaceErrorDescription ]
	
! !

!SentenceFinderByPrefix methodsFor: 'asserts' stamp: 'ic 4/21/2023 14:13:42'!
assertPrefixIsNotEmpty: aPrefix

	aPrefix ifEmpty: [self error: self prefixIsEmptyErrorDescription]! !


!SentenceFinderByPrefix methodsFor: 'error handling' stamp: 'ic 4/21/2023 13:29:24'!
validatePrefix: aSentenceToUseAsPrefix
	self assertPrefixIsNotEmpty: aSentenceToUseAsPrefix.
	self assertPrefixHasNoSpace: 	aSentenceToUseAsPrefix.! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'ic 4/23/2023 13:25:19'!
find: aSentenceToUseAsPrefix
	| stackElements |
	
	self validatePrefix: aSentenceToUseAsPrefix.
	
	stackElements := self getStackElements.
	
	^self selectElementsFrom: stackElements withPrefix: aSentenceToUseAsPrefix .
	! !


!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ic 4/23/2023 13:25:11'!
getStackElements
	| stackElements |
	
	stackElements := self popStackElementsInCollectionAndReturnIt .
	self pushElementsToMakeOriginalStackWith: stackElements.
	
	^stackElements .
	! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ic 4/21/2023 13:04:27'!
popStackElementsIn: aCollection
	
	(stackToSearch size) timesRepeat: [aCollection 	addFirst: (stackToSearch pop)].

	! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ic 4/21/2023 13:07:39'!
popStackElementsInCollectionAndReturnIt
	|stackElements|
	
	stackElements := OrderedCollection new.
	self popStackElementsIn: stackElements.
	
	^stackElements 
	! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ic 4/21/2023 12:22:52'!
pushElementsToMakeOriginalStackWith: aCollection
	
	(aCollection) do: [:elem | stackToSearch push: elem].
	
	! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'ic 4/21/2023 12:25:30'!
selectElementsFrom: aCollection withPrefix: aSentence

	^aCollection select: [:elem|elem beginsWith: aSentence].
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'ic 4/21/2023 13:26:22'!
initializeWith: aStack
	stackToSearch := aStack.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'ic 4/21/2023 13:26:11'!
with: aStack
	^self new initializeWith: aStack! !
