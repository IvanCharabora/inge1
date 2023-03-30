!classDefinition: #I category: 'Clase3'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Clase3'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 13:24:33'!
isLowerThan:aNaturalNumber
"devuelve true porque el mensaje isLowerThan no puede ser llamado por el objeto I, entonces aNaturalNumber no es I"
^true! !

!I class methodsFor: 'private auxiliary operations' stamp: 'IC 3/28/2023 02:55:50'!
next
next ifNil: [
	next:=self cloneNamed: (self name, 'I').
	next previous: self
	].
^next! !

!I class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 10:03:17'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:19:46'!
canNotDivideByBiggerNumberErrorDescription
^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:19:25'!
negativeNumbersNotSupportedErrorDescription
^'El objeto no es representable (es negativo)'! !


!I class methodsFor: 'logic operations' stamp: 'IC 3/30/2023 10:34:15'!
>aNaturalNumber
^false! !


!I class methodsFor: 'arithmetic operations' stamp: 'IC 3/28/2023 02:56:32'!
* aNaturalNumber
^aNaturalNumber ! !

!I class methodsFor: 'arithmetic operations' stamp: 'IC 3/28/2023 02:56:37'!
+ aNaturalNumber
^aNaturalNumber next ! !

!I class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:24:51'!
- aNaturalNumber
self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:24:56'!
/ aNaturalNumber
(aNaturalNumber > self) ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ] ifFalse: [^I]! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'ic 3/30/2023 17:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Clase3'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Clase3'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'logic operations' stamp: 'IC 3/30/2023 13:17:40'!
>aNaturalNumber
^aNaturalNumber isLowerThan: self
! !


!II class methodsFor: 'arithmetic operations' stamp: 'ic 3/30/2023 17:18:45'!
* aNaturalNumber
   ^aNaturalNumber + (self previous * aNaturalNumber )! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/28/2023 02:57:11'!
+ aNaturalNumber
^self previous + aNaturalNumber next! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 10:04:48'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 12:27:45'!
/ aNaturalNumber
(aNaturalNumber > self) 
ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ] 
ifFalse: [(aNaturalNumber = self) ifTrue: [^I] ifFalse:  [^I+(self-aNaturalNumber / aNaturalNumber )]]
! !


!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 12:58:32'!
isLowerThan: aNaturalNumber
^aNaturalNumber previous > self previous! !

!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/28/2023 02:56:50'!
next
next ifNil: [
	next:=self cloneNamed: (self name, 'I').
	next previous: self
	].
^next! !

!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/28/2023 02:57:23'!
previous
^previous! !

!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/28/2023 02:57:31'!
previous:aNaturalNumber
previous:=aNaturalNumber ! !

!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 10:03:34'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:17:09'!
canNotDivideByBiggerNumberErrorDescription
^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:17:53'!
negativeNumbersNotSupportedErrorDescription
^'El objeto no es representable (es negativo)'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'ic 3/30/2023 17:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

I initializeAfterFileIn!
II initializeAfterFileIn!