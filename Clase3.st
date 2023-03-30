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

!I class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:36:42'!
divideFrom: aNaturalNumber
	^aNaturalNumber ! !

!I class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 10:15:01'!
multiplyFrom:aNaturalNumber
^aNaturalNumber ! !

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


!I class methodsFor: '--** private fileout/in **--' stamp: 'IC 3/30/2023 11:55:01'!
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

!II class methodsFor: 'logic operations' stamp: 'IC 3/30/2023 10:41:23'!
>aNaturalNumber
(aNaturalNumber = I) ifTrue: [^true] ifFalse: [^self previous > aNaturalNumber previous] 
! !


!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 10:20:22'!
* aNaturalNumber
   ^aNaturalNumber multiplyFrom: self! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/28/2023 02:57:11'!
+ aNaturalNumber
^self previous + aNaturalNumber next! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 10:04:48'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:51:49'!
/ aNaturalNumber
(aNaturalNumber > self) 
ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ] 
ifFalse: [^aNaturalNumber divideFrom: self]
! !


!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:49:19'!
divideFrom: aNaturalNumber
(aNaturalNumber = self) ifTrue: [^I] ifFalse:  [^I+((aNaturalNumber-self) / self)]! !

!II class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 10:19:21'!
multiplyFrom:aNaturalNumber
^ (self) + (self * aNaturalNumber previous)! !

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


!II class methodsFor: '--** private fileout/in **--' stamp: 'IC 3/30/2023 11:55:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Clase3'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Clase3'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'logic operations' stamp: 'IC 3/30/2023 11:53:56'!
>aNaturalNumber
(aNaturalNumber = I) ifTrue: [^true] ifFalse: [^self previous > aNaturalNumber previous] 
! !


!III class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:57'!
* aNaturalNumber
   ^aNaturalNumber multiplyFrom: self! !

!III class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:57'!
+ aNaturalNumber
^self previous + aNaturalNumber next! !

!III class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:57'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!III class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:57'!
/ aNaturalNumber
(aNaturalNumber > self) 
ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ] 
ifFalse: [^aNaturalNumber divideFrom: self]
! !


!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
divideFrom: aNaturalNumber
(aNaturalNumber = self) ifTrue: [^I] ifFalse:  [^I+((aNaturalNumber-self) / self)]! !

!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
multiplyFrom:aNaturalNumber
^ (self) + (self * aNaturalNumber previous)! !

!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
next
next ifNil: [
	next:=self cloneNamed: (self name, 'I').
	next previous: self
	].
^next! !

!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
previous
^previous! !

!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
previous:aNaturalNumber
previous:=aNaturalNumber ! !

!III class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:57'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!III class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:53:57'!
canNotDivideByBiggerNumberErrorDescription
^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:53:57'!
negativeNumbersNotSupportedErrorDescription
^'El objeto no es representable (es negativo)'! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'IC 3/30/2023 11:55:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Clase3'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Clase3'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'logic operations' stamp: 'IC 3/30/2023 11:53:58'!
>aNaturalNumber
(aNaturalNumber = I) ifTrue: [^true] ifFalse: [^self previous > aNaturalNumber previous] 
! !


!IIII class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:58'!
* aNaturalNumber
   ^aNaturalNumber multiplyFrom: self! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:58'!
+ aNaturalNumber
^self previous + aNaturalNumber next! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:58'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'IC 3/30/2023 11:53:58'!
/ aNaturalNumber
(aNaturalNumber > self) 
ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ] 
ifFalse: [^aNaturalNumber divideFrom: self]
! !


!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
divideFrom: aNaturalNumber
(aNaturalNumber = self) ifTrue: [^I] ifFalse:  [^I+((aNaturalNumber-self) / self)]! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
multiplyFrom:aNaturalNumber
^ (self) + (self * aNaturalNumber previous)! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
next
next ifNil: [
	next:=self cloneNamed: (self name, 'I').
	next previous: self
	].
^next! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
previous
^previous! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
previous:aNaturalNumber
previous:=aNaturalNumber ! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'IC 3/30/2023 11:53:58'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIII class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:53:59'!
canNotDivideByBiggerNumberErrorDescription
^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'errors descriptions' stamp: 'IC 3/30/2023 11:53:59'!
negativeNumbersNotSupportedErrorDescription
^'El objeto no es representable (es negativo)'! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'IC 3/30/2023 11:55:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!