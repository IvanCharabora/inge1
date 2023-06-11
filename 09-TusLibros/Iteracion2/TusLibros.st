!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:45:02'!
test01NewCartsAreCreatedEmpty

	self assert: TestProvider createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test02CanNotAddItemsThatDoNotBelongToStore

	cart := TestProvider createCart.
	
	self 
		should: [ cart add: TestProvider itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	
	cart := TestProvider createCart.
	
	cart add: TestProvider itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test04CanNotAddNonPositiveNumberOfItems

	cart := TestProvider createCart.
	
	self 
		should: [cart add: 0 of: TestProvider itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test05CanNotAddMoreThanOneItemNotSellByTheStore
	
	cart := TestProvider createCart.
	
	self 
		should: [cart add: 2 of: TestProvider itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test06CartRemembersAddedItems

	cart := TestProvider createCart.
	
	cart add: TestProvider itemSellByTheStore.
	self assert: (cart includes: TestProvider itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test07CartDoesNotHoldNotAddedItems

	cart := TestProvider createCart.
	
	self deny: (cart includes: TestProvider itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'IC&VW 6/9/2023 14:50:43'!
test08CartRemembersTheNumberOfAddedItems
	
	cart := TestProvider createCart.
	
	cart add: 2 of: TestProvider itemSellByTheStore.
	self assert: (cart occurrencesOf: TestProvider itemSellByTheStore) = 2! !


!CartTest methodsFor: 'test - private' stamp: 'IC&VW 6/9/2023 14:50:43'!
setUp
	cart := TestProvider createCart.! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: 'cashier card cart date merchant expiredCard invalidFormatNumberCard cardWithNoCredit stolenCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'tests - private' stamp: 'IC&VW 6/11/2023 13:08:19'!
checkoutWithCard: aCard throwsErrorMessage: anErrorMessage
	
	cart add: TestProvider itemSellByTheStore.
	self should: [cashier initializeToCheckout: cart charging: aCard on: date withMerchant: merchant.] 
		raise: Error  
		withExceptionDo: [:anError | self assert: anErrorMessage equals: anError messageText ]! !

!CheckoutTest methodsFor: 'tests - private' stamp: 'IC&VW 6/11/2023 13:02:20'!
setUp
	cashier := Cashier new. 
	cart := TestProvider createCart.
	date := Date today.
	merchant := TestProvider createMerchant.
	card := TestProvider createCard.
	expiredCard := TestProvider createExpiredCard.
	invalidFormatNumberCard := TestProvider createInvalidFormatNumberCard.
	cardWithNoCredit := TestProvider createCardWithNoCredit.
	stolenCard := TestProvider createStolenCard.
	
	
	merchant addCardWithNoCredit: cardWithNoCredit.
	merchant addStolenCard: stolenCard.
	! !


!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 12:59:13'!
test01CheckoutThrowsErrorWhenReceivingAnEmptyCart

	self should: [cashier initializeToCheckout: cart charging: card on: date withMerchant: merchant ] 
		 raise: Error
		 withExceptionDo: [:anError | self assert: Cashier emptyCartErrorMessage equals: anError messageText]! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 12:59:13'!
test02CheckoutCanHandleACartWithOneItem 

	|total|
	cart add: TestProvider itemSellByTheStore.
	total := cashier initializeToCheckout: cart charging: card on: date withMerchant: merchant .
	
	self assert: 100 equals: total
	! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 12:59:13'!
test03CheckoutCanHandleACartWithMultipleItems 

	| total |
	cart add: TestProvider itemSellByTheStore.
	cart add: TestProvider anotherItemSellByTheStore.
	total := cashier initializeToCheckout: cart charging: card on: date withMerchant: merchant.
	
	self assert: 300 equals: total! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 13:08:19'!
test04CheckoutThrowsErrorWhenReceivenAnExpiredCard 
	
	self checkoutWithCard: expiredCard throwsErrorMessage: Cashier expiredCardErrorMessage.

	! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 13:08:19'!
test05CheckoutThrowsErrorWhenReceivingAnInvalidFormatNumberCard 
	
	self checkoutWithCard: invalidFormatNumberCard throwsErrorMessage: Cashier invalidFormatNumberCardErrorMessage.

	! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 13:08:19'!
test06CheckoutThrowsErrorWhenReceivingACardWithNoCredit 
	
	self checkoutWithCard: cardWithNoCredit throwsErrorMessage: Cashier cardWithNoCreditErrorMessage.! !

!CheckoutTest methodsFor: 'tests' stamp: 'IC&VW 6/11/2023 13:08:19'!
test07CheckoutThrowsErrorWhenReceivingAStolenCard
	
	self checkoutWithCard: stolenCard throwsErrorMessage: Cashier stolenCardErrorMessage.! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'name number securityNumber expireMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'testing' stamp: 'IC&VW 6/11/2023 12:16:12'!
hasValidFormatNumber	

	^ number asString size = 16! !

!Card methodsFor: 'testing' stamp: 'IC&VW 6/9/2023 15:38:24'!
isExpiredOn: aDate	

	^ expireMonth start  < aDate start! !


!Card methodsFor: 'initalization' stamp: 'IC&VW 6/9/2023 15:28:55'!
initializeWithName: aName number: aNumber securityNumber: aSecurityNumber expireMonth: aMonth  
	name := aName.
	number := aNumber.
	securityNumber  := aSecurityNumber.
	expireMonth  := aMonth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'IC&VW 6/9/2023 15:28:36'!
name: aName number: aNumber securityNumber: aSecurityNumber expireMonth: aMonth  
	^self new initializeWithName: aName number: aNumber securityNumber: aSecurityNumber expireMonth: aMonth! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/9/2023 14:41:25'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'IC&VW 6/9/2023 14:31:17'!
calculateTotalPrice

	^items sum: [:item| catalog at: item].! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'IC&VW 6/9/2023 14:51:21'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initalization' stamp: 'IC&VW 6/11/2023 12:29:16'!
initializeToCheckout: aCart charging: aCard on: aDate withMerchant: aMerchant  
	
	aCart isEmpty ifTrue: [^ self class emptyCartError.].
	self isValidCard: aCard on: aDate.
	aMerchant validateCard: aCard.
	
	^aCart calculateTotalPrice! !


!Cashier methodsFor: 'testing' stamp: 'IC&VW 6/11/2023 12:27:44'!
isValidCard: aCard on: aDate 

	(aCard isExpiredOn: aDate) ifTrue: [^self class expiredCardError.].
	(aCard hasValidFormatNumber) ifFalse: [^self class invalidFormatNumberCardError.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'message errors' stamp: 'IC&VW 6/11/2023 12:36:41'!
cardWithNoCreditErrorMessage
	^'La tarjeta no tiene credito'! !

!Cashier class methodsFor: 'message errors' stamp: 'IC&VW 6/9/2023 14:27:47'!
emptyCartErrorMessage
	^'El carrito no esta a la venta'! !

!Cashier class methodsFor: 'message errors' stamp: 'IC&VW 6/9/2023 15:14:16'!
expiredCardErrorMessage
	^'La tarjeta se encuentra vencida'! !

!Cashier class methodsFor: 'message errors' stamp: 'IC&VW 6/11/2023 12:11:13'!
invalidFormatNumberCardErrorMessage
	^'El numero de la tarjeta es invalido'! !

!Cashier class methodsFor: 'message errors' stamp: 'IC&VW 6/11/2023 12:44:17'!
stolenCardErrorMessage
	^'La tarjeta fue robada'! !


!Cashier class methodsFor: 'errors' stamp: 'IC&VW 6/11/2023 12:37:02'!
cardWithNoCreditError
	^self error: self cardWithNoCreditErrorMessage ! !

!Cashier class methodsFor: 'errors' stamp: 'IC&VW 6/9/2023 14:30:52'!
emptyCartError
	self error: self emptyCartErrorMessage! !

!Cashier class methodsFor: 'errors' stamp: 'IC&VW 6/9/2023 15:14:28'!
expiredCardError
	^self error: self expiredCardErrorMessage! !

!Cashier class methodsFor: 'errors' stamp: 'IC&VW 6/11/2023 12:11:26'!
invalidFormatNumberCardError
	^self error: self invalidFormatNumberCardErrorMessage ! !

!Cashier class methodsFor: 'errors' stamp: 'IC&VW 6/11/2023 12:44:26'!
stolenCardError
	^self error: self stolenCardErrorMessage ! !


!classDefinition: #MerchantProccesorSimulator category: 'TusLibros'!
Object subclass: #MerchantProccesorSimulator
	instanceVariableNames: 'cardsWithNoCredit stolenCards invalidCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProccesorSimulator methodsFor: 'initalization' stamp: 'IC&VW 6/11/2023 12:53:26'!
initialize
	
	invalidCards := Dictionary new.
	! !


!MerchantProccesorSimulator methodsFor: 'testing' stamp: 'IC&VW 6/11/2023 12:53:33'!
validateCard: aCard

	(invalidCards includesKey: aCard) ifTrue: [^(invalidCards at: aCard) value]! !


!MerchantProccesorSimulator methodsFor: 'adding' stamp: 'IC&VW 6/11/2023 12:52:36'!
add: aCard withBehavior: aBehavior
	
	invalidCards add: (Association key: aCard value: aBehavior).
	
	! !

!MerchantProccesorSimulator methodsFor: 'adding' stamp: 'IC&VW 6/11/2023 12:54:04'!
addCardWithNoCredit: aCard 
	
	self add: aCard withBehavior: [^Cashier cardWithNoCreditError ].
	
	! !

!MerchantProccesorSimulator methodsFor: 'adding' stamp: 'IC&VW 6/11/2023 12:54:08'!
addStolenCard: aCard 

	self add: aCard withBehavior: [^Cashier stolenCardError ].
	
	! !


!classDefinition: #TestProvider category: 'TusLibros'!
Object subclass: #TestProvider
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestProvider class' category: 'TusLibros'!
TestProvider class
	instanceVariableNames: ''!

!TestProvider class methodsFor: 'accesing catalog items' stamp: 'IC&VW 6/9/2023 14:51:57'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!TestProvider class methodsFor: 'accesing catalog items' stamp: 'IC&VW 6/9/2023 14:25:54'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestProvider class methodsFor: 'accesing catalog items' stamp: 'IC&VW 6/9/2023 14:40:12'!
itemSellByTheStore
	
	^ 'validBook'! !


!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:10:15'!
createCard
	
	^Card name: 'Harry Potter' number: 1234567812345678 securityNumber: 934 expireMonth: (Month month: 07 year: 2023) .! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:58:48'!
createCardWithNoCredit
	
	^Card name: 'Kim Kardashian' number: 1234123412341234 securityNumber: 000 expireMonth: (Month month: 07 year: 2024) .! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/9/2023 14:25:02'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:10:11'!
createExpiredCard
	
	^Card name: 'Harry Potter' number: 1234567812345678 securityNumber: 934 expireMonth: (Month month: 05 year: 2023) .! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:10:25'!
createInvalidFormatNumberCard
	
	^Card name: 'Harry Potter' number: 123 securityNumber: 934 expireMonth: (Month month: 07 year: 2023) .! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:35:23'!
createMerchant
	
	^MerchantProccesorSimulator new.! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/11/2023 12:58:18'!
createStolenCard
	
	^Card name: 'La Rana Rene' number: 1111222233334444 securityNumber: 934 expireMonth: (Month month: 07 year: 2024) .! !

!TestProvider class methodsFor: 'instance creation' stamp: 'IC&VW 6/9/2023 14:25:43'!
defaultCatalog
	|listPrices|
	listPrices := Dictionary new.
	listPrices add: (Association key: 'validBook' value: 100).
	listPrices add: (Association key: 'validBook2' value: 200). 
	listPrices add: (Association key: 'validBook3' value: 300).
	^ listPrices
	! !
