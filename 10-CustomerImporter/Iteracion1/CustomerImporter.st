!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'vw&ic 6/25/2023 17:12:06'!
test01Import

	| customers |
	self importCustomers.
	
	self assertNumberOfCustomersImported.	
	self assertAllCustomersAreCreated.

	
! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'vw&ic 6/22/2023 20:32:26'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'vw&ic 6/22/2023 20:34:15'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'vw&ic 6/25/2023 17:54:01'!
assertAddresses: addresses with: addressesExpected 
	
	self assert: addressesExpected size equals: addresses size.
	
	addressesExpected do: [:anAddress | self assert: (self address: anAddress isIn: addressesExpected)]
	! !

!ImportTest methodsFor: 'assertions' stamp: 'vw&ic 6/25/2023 17:12:06'!
assertAllCustomersAreCreated 
	
	self expectedCustomers do: [:anExpectedCustomer | self assertIfCustomerIsCreated: anExpectedCustomer ]! !

!ImportTest methodsFor: 'assertions' stamp: 'vw&ic 6/25/2023 17:49:47'!
assertIfCustomerIsCreated: anExpectedCustomer  
	
	| customerInSession |
	customerInSession := self getCustomerWithIdentificationType: anExpectedCustomer identificationType 
					 		  andIdentificationNumber: anExpectedCustomer identificationNumber.
					
	self assert: (self compareCustomer: anExpectedCustomer with: customerInSession).
	self assertAddresses: anExpectedCustomer addresses with: customerInSession addresses
	
! !

!ImportTest methodsFor: 'assertions' stamp: 'vw&ic 6/25/2023 18:08:07'!
assertNumberOfCustomersImported

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !


!ImportTest methodsFor: 'sessionPetitions' stamp: 'vw&ic 6/25/2023 16:39:49'!
getCustomerWithIdentificationType: anIdentificationType andIdentificationNumber: anIdentificationNumber

^(session select: [:aCustomer | 
	aCustomer identificationType = anIdentificationType and: [ aCustomer identificationNumber = anIdentificationNumber ]
] 
	ofType: Customer) anyOne! !


!ImportTest methodsFor: 'addresses' stamp: 'vw&ic 6/25/2023 17:47:05'!
addressAlem1122

	|address|

	address := Address new.
	address streetName: 'Alem'.
	address streetNumber: 1122.
	address town: 'CABA'.
	address zipCode: 1001.
	address province: 'CABA'.
	^address! !

!ImportTest methodsFor: 'addresses' stamp: 'vw&ic 6/25/2023 17:47:10'!
addressMaipu888

	| address |
	
	address := Address new.
	address streetName: 'Maipu'.
	address streetNumber: 888.
	address town: 'Florida'.
	address zipCode: 1122.
	address province: 'Buenos Aires'.
	^address! !

!ImportTest methodsFor: 'addresses' stamp: 'vw&ic 6/25/2023 17:46:09'!
addressSanMartin3322
	| address|
	
	address := Address new.
	address streetName: 'San Martin'.
	address streetNumber: 3322.
	address town: 'Olivos'.
	address zipCode: 1636.
	address province: 'BsAs'.
	
	^address.! !


!ImportTest methodsFor: 'customers' stamp: 'vw&ic 6/25/2023 17:47:23'!
customerJuanPerez

	^ self createExpectedCustomer: 'Juan' withLastName: 'Perez' identificationType: 'C' identificationNumber: '23-25666777-9' 
		andAddresses: (OrderedCollection with: self addressAlem1122).! !

!ImportTest methodsFor: 'customers' stamp: 'vw&ic 6/25/2023 17:47:30'!
customerPepeSanchez

	^ self createExpectedCustomer: 'Pepe' withLastName: 'Sanchez' identificationType: 'D' identificationNumber: '22333444' 
		andAddresses: (OrderedCollection with: self addressSanMartin3322 with: self addressMaipu888).! !

!ImportTest methodsFor: 'customers' stamp: 'vw&ic 6/25/2023 17:27:59'!
expectedCustomers

	^OrderedCollection with: self customerPepeSanchez with: self customerJuanPerez
	
! !


!ImportTest methodsFor: 'tests - private' stamp: 'vw&ic 6/25/2023 18:11:45'!
address: anAddress IsEqualsTo: anAddressToFind

	^ anAddress streetName = anAddressToFind streetName &
	  anAddress streetNumber = anAddressToFind streetNumber &
	  anAddress zipCode = anAddressToFind zipCode &
	  anAddress town = anAddressToFind town &
	  anAddress province = anAddressToFind province! !

!ImportTest methodsFor: 'tests - private' stamp: 'vw&ic 6/25/2023 18:12:05'!
address: anAddressToFind isIn: addresses 
	
	^addresses anySatisfy: [:anAddress | self address: anAddress IsEqualsTo: anAddressToFind]! !

!ImportTest methodsFor: 'tests - private' stamp: 'vw&ic 6/25/2023 17:48:35'!
compareCustomer: aCustomer with: anExpectedCustomer 
	
	^ (aCustomer firstName = anExpectedCustomer firstName) &
	  (aCustomer lastName = anExpectedCustomer lastName) &
	  (aCustomer identificationType = anExpectedCustomer identificationType) &
	  (aCustomer identificationNumber = anExpectedCustomer identificationNumber)
! !

!ImportTest methodsFor: 'tests - private' stamp: 'vw&ic 6/25/2023 17:31:00'!
createExpectedCustomer: aCustomerName withLastName: aCustomerLastName identificationType: anIdType identificationNumber: anIdNumber andAddresses: addresses 

	|newCustomer|
	newCustomer := Customer new.
	newCustomer firstName: aCustomerName.
	newCustomer lastName: aCustomerLastName.
	newCustomer identificationType: anIdType.
	newCustomer identificationNumber: anIdNumber.
	addresses do: [:anAddress | newCustomer addAddress: anAddress].
	^newCustomer ! !


!ImportTest methodsFor: 'streams' stamp: 'vw&ic 6/25/2023 16:12:59'!
fileStreamToOpenCustomers

	^ UniFileStream new open: 'input.txt' forWrite: false! !

!ImportTest methodsFor: 'streams' stamp: 'vw&ic 6/25/2023 16:28:21'!
readStreamToOpenCustomers

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'import' stamp: 'vw&ic 6/25/2023 18:07:16'!
importCustomers
	(CustomerImporter withSession: session andStream: self readStreamToOpenCustomers) import! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'vw&ic 6/22/2023 20:03:37'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'vw&ic 6/22/2023 20:03:37'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'vw&ic 6/22/2023 20:03:37'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'vw&ic 6/22/2023 20:03:37'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'vw&ic 6/22/2023 20:03:37'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'vw&ic 6/22/2023 20:03:37'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'vw&ic 6/22/2023 20:03:37'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'vw&ic 6/22/2023 20:03:37'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'vw&ic 6/22/2023 20:03:37'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'vw&ic 6/22/2023 20:03:37'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'vw&ic 6/22/2023 20:03:37'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'vw&ic 6/22/2023 20:03:37'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'vw&ic 6/22/2023 20:03:37'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'vw&ic 6/22/2023 20:03:37'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'vw&ic 6/22/2023 20:03:37'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'vw&ic 6/22/2023 20:03:37'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'vw&ic 6/22/2023 20:03:37'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'vw&ic 6/22/2023 20:03:37'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'vw&ic 6/22/2023 20:03:37'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'vw&ic 6/22/2023 20:03:37'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'vw&ic 6/22/2023 20:03:37'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'importing' stamp: 'vw&ic 6/22/2023 20:21:15'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'vw&ic 6/25/2023 15:35:03'!
initializeWithSession: aSession andStream: aStream 

	session := aSession.
	inputStream := aStream.
! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'vw&ic 6/25/2023 16:32:56'!
import

	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.
			].

		line := inputStream nextLine. ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'vw&ic 6/25/2023 15:36:05'!
withSession: aSession andStream: aStream 
	^self new initializeWithSession: aSession andStream: aStream! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'vw&ic 6/22/2023 20:03:37'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'vw&ic 6/22/2023 20:03:37'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'vw&ic 6/22/2023 20:03:37'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'vw&ic 6/22/2023 20:03:37'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'vw&ic 6/22/2023 20:03:37'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'vw&ic 6/22/2023 20:03:37'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'vw&ic 6/22/2023 20:03:37'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'vw&ic 6/22/2023 20:03:37'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'vw&ic 6/22/2023 20:03:37'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'vw&ic 6/22/2023 20:03:37'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'vw&ic 6/22/2023 20:03:37'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'vw&ic 6/22/2023 20:03:37'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'vw&ic 6/22/2023 20:03:37'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
