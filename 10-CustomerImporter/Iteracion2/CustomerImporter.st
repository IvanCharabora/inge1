!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 20:51:13'!
test01ImportFromValidStream

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:52:49'!
test02ImportFromEmptyStream
	
	CustomerImporter valueFrom: self emptyImportData into: session.
	self assert: self assertNoCustomersWasImported
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:03:31'!
test03ImportFromStreamWithInvalidPrefix
	
	self should: [CustomerImporter valueFrom: self invalidPrefixImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithInvalidPrefixErrorMessage ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:06:28'!
test04ImportFromStreamWithDoubleValidPrefix
	
	self should: [CustomerImporter valueFrom: self doubleValidPrefixImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithDoubleValidPrefixErrorMessage ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:13:35'!
test05ImportFromStreamWithAddressForNoCustomer
	
	self should: [CustomerImporter valueFrom: self addressForNoCustomerImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithAddressForNoCustomerErrorMessage ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:26:05'!
test06ImportFromStreamWithCustomerWithLessFields
	
	self should: [CustomerImporter valueFrom: self customerWithLessFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithCustomerWithInvalidAmountOfFieldsErrorMessage ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:26:05'!
test07ImportFromStreamWithCustomerWithMoreFields
	
	self should: [CustomerImporter valueFrom: self customerWithMoreFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithCustomerWithInvalidAmountOfFieldsErrorMessage ].
	! !

!ImportTest methodsFor: 'tests' stamp: 'IC&VW 6/26/2023 21:29:38'!
test08ImportFromStreamWithAddressWithInvalidAmountOfFields
	
	self should: [CustomerImporter valueFrom: self addressWithLessFieldsImportData into: session.] 
		raise: Error 
		withExceptionDo: [:anError | self assert: anError messageText equals: CustomerImporter streamWithAddressWithInvalidAmountOfFieldsErrorMessage ].
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'IC&VW 6/26/2023 21:52:49'!
assertNoCustomersWasImported
	
	^true! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:13:11'!
addressForNoCustomerImportData

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:30:11'!
addressWithLessFieldsImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,Mi Casa,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:17:15'!
customerWithLessFieldsImportData

	^ ReadStream on:
'C,Pepe,,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:22:13'!
customerWithMoreFieldsImportData

	^ ReadStream on:
'C,Pepe,Sanchez,A+,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:07:21'!
doubleValidPrefixImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 20:36:17'!
emptyImportData

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'IC&VW 6/26/2023 21:02:49'!
invalidPrefixImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
V,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
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

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'line session readStream newCustomer data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:29:03'!
addAddress

	| newAddress |
	(data size = 6) ifFalse: [self class streamWithAddressWithInvalidAmountOfFieldsError ].
	newCustomer ifNil: [self class streamWithAddressForNoCustomerError ].
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: data second.
	newAddress streetNumber: data third asNumber .
	newAddress town: data fourth.
	newAddress zipCode: data fifth asNumber .
	newAddress province: data sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:26:34'!
addAndPersistCustomer 

	(data size = 5) ifFalse: [self class streamWithCustomerWithInvalidAmountOfFieldsError].
	newCustomer  := Customer new.
	newCustomer firstName: data second.
	newCustomer lastName: data third.
	newCustomer identificationType: data fourth.
	newCustomer identificationNumber: data fifth.
	
	session persist: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:45:07'!
checkStreamIsEmpty

	^ [readStream isEmpty] ifTrue: [self error: 'a']! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 20:15:44'!
createRecord

	^ data := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:46:58'!
getNextLineAndHasLinesLeft

	line := readStream nextLine.
	^ line notNil.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:18:57'!
importRecord

	(self isCustomerData) ifTrue: [ ^	self addAndPersistCustomer.].
	(self isAddressData) ifTrue: [ ^self addAddress].
	self class streamWithInvalidPrefixError.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:18:50'!
isAddressData

	^ data first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:18:57'!
isCustomerData

	^ data first =  'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'IC&VW 6/26/2023 21:50:09'!
value
	
	"self checkStreamIsEmpty."
	[ self getNextLineAndHasLinesLeft ] whileTrue: [
		self createRecord.
		self importRecord.
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 20:41:40'!
emptyStreamError
	self error: self emptyStreamErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 20:41:55'!
emptyStreamErrorMessage
	'No se importo nada crack'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:13:58'!
streamWithAddressForNoCustomerError
	self error: self streamWithAddressForNoCustomerErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:13:51'!
streamWithAddressForNoCustomerErrorMessage
	'No podes arrancar con una direcc capo'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:27:55'!
streamWithAddressWithInvalidAmountOfFieldsError
	self error: self streamWithAddressWithInvalidAmountOfFieldsErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:27:44'!
streamWithAddressWithInvalidAmountOfFieldsErrorMessage
	'No podes importar a una direcc con otra cantidad de fields'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:26:34'!
streamWithCustomerWithInvalidAmountOfFieldsError
	self error: self streamWithCustomerWithInvalidAmountOfFieldsErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:26:19'!
streamWithCustomerWithInvalidAmountOfFieldsErrorMessage
	'No podes importar a un chabon con otra cantidad de fields'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:06:58'!
streamWithDoubleValidPrefixError
	self error: self streamWithDoubleValidPrefixErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:06:45'!
streamWithDoubleValidPrefixErrorMessage
	'No podes arrancar con AAAAAAAAAAA'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:04:03'!
streamWithInvalidPrefixError
	self error: self streamWithInvalidPrefixErrorMessage.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'IC&VW 6/26/2023 21:04:21'!
streamWithInvalidPrefixErrorMessage
	'No podes arrancar con el pie izquierdo'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
