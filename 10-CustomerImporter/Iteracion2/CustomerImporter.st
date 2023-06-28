!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:30:14'!
test01ImportFromValidStream

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers: 2.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:32:00'!
test02ImportFromEmptyStream
	
	CustomerImporter valueFrom: self emptyImportData into: session.
	self assertNoCustomersWasImported
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:32:23'!
test03ImportFromStreamWithInvalidPrefix
	
	self should: [CustomerImporter valueFrom: self invalidPrefixImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter streamWithInvalidPrefixErrorMessage.
			self assertImportedRightNumberOfCustomers: 1].
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:45:44'!
test04ImportFromStreamWithDoubleValidPrefix
	
	self should: [CustomerImporter valueFrom: self doubleValidPrefixImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter streamWithInvalidPrefixErrorMessage.
			self assertImportedRightNumberOfCustomers: 1].
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:33:01'!
test05ImportFromStreamWithAddressForNoCustomer
	
	self should: [CustomerImporter valueFrom: self addressForNoCustomerImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter streamWithAddressForNoCustomerErrorMessage.
			self assertNoCustomersWasImported ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:33:42'!
test06ImportFromStreamWithCustomerWithLessFields
	
	self should: [CustomerImporter valueFrom: self customerWithLessFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 
			CustomerImporter streamWithCustomerWithInvalidAmountOfFieldsErrorMessage.
			self assertNoCustomersWasImported ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:34:05'!
test07ImportFromStreamWithCustomerWithMoreFields
	
	self should: [CustomerImporter valueFrom: self customerWithMoreFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 
			CustomerImporter streamWithCustomerWithInvalidAmountOfFieldsErrorMessage.
			self assertNoCustomersWasImported ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'ic&vw 6/27/2023 22:34:27'!
test08ImportFromStreamWithAddressWithInvalidAmountOfFields
	
	self should: [CustomerImporter valueFrom: self addressWithLessFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 
			CustomerImporter streamWithAddressWithInvalidAmountOfFieldsErrorMessage.
			 self assertImportedRightNumberOfCustomers: 1].
	! !


!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:26:58'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:26:58'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:30:28'!
assertImportedRightNumberOfCustomers: anAmountOfCustomersExpected

	^ self assert: anAmountOfCustomersExpected equals: self numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:26:58'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:29:41'!
assertNoCustomersWasImported
	
	^self assert: 0 equals: self numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'ic&vw 6/27/2023 22:26:58'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'ic&vw 6/27/2023 22:26:58'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'ic&vw 6/27/2023 22:26:58'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'ic&vw 6/27/2023 22:26:58'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!ImportTest methodsFor: 'customer' stamp: 'ic&vw 6/27/2023 22:28:42'!
numberOfCustomers

	^ (session selectAllOfType: Customer)size! !


!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
addressForNoCustomerImportData

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
addressWithLessFieldsImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,Mi Casa,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
customerWithLessFieldsImportData

	^ ReadStream on:
'C,Pepe,,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
customerWithMoreFieldsImportData

	^ ReadStream on:
'C,Pepe,Sanchez,A+,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
doubleValidPrefixImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
emptyImportData

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
invalidPrefixImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
V,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'ic&vw 6/27/2023 22:26:58'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'ic&vw 6/27/2023 22:26:57'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'ic&vw 6/27/2023 22:26:57'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'ic&vw 6/27/2023 22:26:57'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'ic&vw 6/27/2023 22:26:57'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'ic&vw 6/27/2023 22:26:57'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'ic&vw 6/27/2023 22:26:57'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'ic&vw 6/27/2023 22:26:57'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'ic&vw 6/27/2023 22:26:57'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'ic&vw 6/27/2023 22:26:57'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'ic&vw 6/27/2023 22:26:57'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'ic&vw 6/27/2023 22:26:57'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'ic&vw 6/27/2023 22:26:57'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'ic&vw 6/27/2023 22:26:57'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'ic&vw 6/27/2023 22:26:57'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'ic&vw 6/27/2023 22:26:57'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'ic&vw 6/27/2023 22:26:57'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'ic&vw 6/27/2023 22:26:57'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'ic&vw 6/27/2023 22:26:57'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'ic&vw 6/27/2023 22:26:57'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'ic&vw 6/27/2023 22:26:57'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'ic&vw 6/27/2023 22:26:57'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'ic&vw 6/27/2023 22:26:57'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'ic&vw 6/27/2023 22:26:57'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'line session readStream newCustomer data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'ic&vw 6/27/2023 22:26:57'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:38:23'!
addAddress

	| newAddress |
	self validateAmountOfAddressFields.
	self validateCustomerNotNil.
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: data second.
	newAddress streetNumber: data third asNumber .
	newAddress town: data fourth.
	newAddress zipCode: data fifth asNumber .
	newAddress province: data sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:39:10'!
addAndPersistCustomer 

	self validateAmountOfCustomerFields.
	newCustomer  := Customer new.
	newCustomer firstName: data second.
	newCustomer lastName: data third.
	newCustomer identificationType: data fourth.
	newCustomer identificationNumber: data fifth.
	
	session persist: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:26:57'!
createRecord

	^ data := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:26:57'!
getNextLineAndHasLinesLeft

	line := readStream nextLine.
	^ line notNil.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:26:57'!
importRecord

	(self isCustomerData) ifTrue: [ ^	self addAndPersistCustomer.].
	(self isAddressData) ifTrue: [ ^self addAddress].
	self class streamWithInvalidPrefixError.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:26:57'!
isAddressData

	^ data first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:26:57'!
isCustomerData

	^ data first =  'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'ic&vw 6/27/2023 22:41:53'!
value
	
	[ self getNextLineAndHasLinesLeft ] whileTrue: [
		self createRecord.
		self importRecord.
	].

	! !


!CustomerImporter methodsFor: 'validations' stamp: 'ic&vw 6/27/2023 22:38:00'!
validateAmountOfAddressFields

	^ (data size = 6) ifFalse: [self class streamWithAddressWithInvalidAmountOfFieldsError ]! !

!CustomerImporter methodsFor: 'validations' stamp: 'ic&vw 6/27/2023 22:39:10'!
validateAmountOfCustomerFields

	^ (data size = 5) ifFalse: [self class streamWithCustomerWithInvalidAmountOfFieldsError]! !

!CustomerImporter methodsFor: 'validations' stamp: 'ic&vw 6/27/2023 22:38:23'!
validateCustomerNotNil

	^ newCustomer ifNil: [self class streamWithAddressForNoCustomerError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'ic&vw 6/27/2023 22:26:58'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'ic&vw 6/27/2023 22:26:58'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error handling' stamp: 'ic&vw 6/27/2023 22:26:58'!
emptyStreamError
	self error: self emptyStreamErrorMessage.! !

!CustomerImporter class methodsFor: 'error handling' stamp: 'ic&vw 6/27/2023 22:26:58'!
streamWithAddressForNoCustomerError
	self error: self streamWithAddressForNoCustomerErrorMessage.! !

!CustomerImporter class methodsFor: 'error handling' stamp: 'ic&vw 6/27/2023 22:26:58'!
streamWithAddressWithInvalidAmountOfFieldsError
	self error: self streamWithAddressWithInvalidAmountOfFieldsErrorMessage.! !

!CustomerImporter class methodsFor: 'error handling' stamp: 'ic&vw 6/27/2023 22:26:58'!
streamWithCustomerWithInvalidAmountOfFieldsError
	self error: self streamWithCustomerWithInvalidAmountOfFieldsErrorMessage.! !

!CustomerImporter class methodsFor: 'error handling' stamp: 'ic&vw 6/27/2023 22:26:58'!
streamWithInvalidPrefixError
	self error: self streamWithInvalidPrefixErrorMessage.! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'ic&vw 6/27/2023 22:43:07'!
emptyStreamErrorMessage
	'No hay nada para importar'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'ic&vw 6/27/2023 22:43:27'!
streamWithAddressForNoCustomerErrorMessage
	'No se puede cargar direccion sin previamente haber asignado un cliente'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'ic&vw 6/27/2023 22:44:03'!
streamWithAddressWithInvalidAmountOfFieldsErrorMessage
	'Invalida cantidad de campos en la direccion'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'ic&vw 6/27/2023 22:44:09'!
streamWithCustomerWithInvalidAmountOfFieldsErrorMessage
	'Invalida cantidad de campos en el cliente'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'ic&vw 6/27/2023 22:44:47'!
streamWithInvalidPrefixErrorMessage
	'Invalido identificador de direccion o cliente'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'ic&vw 6/27/2023 22:26:58'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'ic&vw 6/27/2023 22:26:58'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'ic&vw 6/27/2023 22:26:58'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'ic&vw 6/27/2023 22:26:58'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'ic&vw 6/27/2023 22:26:58'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'ic&vw 6/27/2023 22:26:58'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'ic&vw 6/27/2023 22:26:58'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'ic&vw 6/27/2023 22:26:58'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'ic&vw 6/27/2023 22:26:58'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'ic&vw 6/27/2023 22:26:58'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'ic&vw 6/27/2023 22:26:58'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'ic&vw 6/27/2023 22:26:58'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'ic&vw 6/27/2023 22:26:58'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
