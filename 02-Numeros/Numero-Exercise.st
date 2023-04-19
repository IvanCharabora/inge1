!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:12:34'!
addToEntero: anEnteroBeingAdded

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:13:39'!
addToFraccion: aFraccionBeingAdded

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:10'!
dividesEntero: anEnteroBeingDivided

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:25'!
dividesFraccion: aFraccionBeingDivided

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'ic 4/17/2023 23:15:35'!
multiplyToEntero: anEnteroBeingMultiplied

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'ic 4/18/2023 00:16:13'!
multiplyToFraccion: aFraccionBeingMultiplied

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:50'!
subtractFromEntero: anEnteroBeingSubtracted

	^self subclassResponsibility ! !

!Numero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:23:05'!
subtractFromFraccion: aFraccionBeingSubtracted

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 15:47:26'!
addToEntero: anEnteroBeingAdded

	^self class with: (self integerValue) + anEnteroBeingAdded integerValue! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:13:39'!
addToFraccion: aFraccionBeingAdded

	^self + aFraccionBeingAdded ! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 11:02:45'!
dividesEntero: anEnteroBeingDivided

	^anEnteroBeingDivided over: self! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:25'!
dividesFraccion: aFraccionBeingDivided

	^aFraccionBeingDivided numerator / (aFraccionBeingDivided denominator * self)! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 15:48:08'!
multiplyToEntero: anEnteroBeingMultiplied

	^self class with: (self integerValue) * anEnteroBeingMultiplied integerValue ! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'ic 4/17/2023 23:19:58'!
multiplyToFraccion: aFraccionBeingMultiplied

	^self * aFraccionBeingMultiplied! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 10:58:20'!
over: anEnteroDivisor
	| denominator greatestCommonDivisor numerator |
	
	greatestCommonDivisor := self greatestCommonDivisorWith: anEnteroDivisor. 
	numerator := self // greatestCommonDivisor.
	denominator := anEnteroDivisor // greatestCommonDivisor.
	
	^denominator useAsDenominatorOf: numerator! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 15:48:23'!
subtractFromEntero: anEnteroBeingSubtracted

	^ self class with: anEnteroBeingSubtracted integerValue - (self integerValue)! !

!Entero methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:23:05'!
subtractFromFraccion: aFraccionBeingSubtracted
	
	^ (self - aFraccionBeingSubtracted) negated.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'ic 4/17/2023 23:08:03'!
* aMultiplier 

	^aMultiplier multiplyToEntero: self
	
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:12:34'!
+ anAdder 

	^anAdder addToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:22:50'!
- aSubtrahend 

	^aSubtrahend subtractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:22:10'!
/ aDivisor 

	^aDivisor dividesEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 15:46:14'!
// aDivisor 
	
	^self class with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 14:04:41'!
fibonacci
	^self subclassResponsibility 

	
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 15:46:31'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: ((self integerValue) gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'VW 4/18/2023 15:56:45'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'VW 4/18/2023 15:57:07'!
hash

	^self integerValue hash! !


!Entero methodsFor: 'value' stamp: 'VW 4/18/2023 14:05:35'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^self subclassResponsibility! !


!Entero methodsFor: 'printing' stamp: 'VW 4/18/2023 15:58:08'!
printOn: aStream

	aStream print: (self integerValue)! !


!Entero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:27:23'!
isNegative
	
	^self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:27:19'!
isOne
	
	^self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:27:14'!
isZero
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'ic 4/19/2023 00:22:37'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [ ^Cero new].
	aValue = 1 ifTrue: [ ^Uno new].
	aValue < 0 ifTrue: [^Negativo new initializeWith: aValue ].
	aValue > 1 ifTrue: [^PositivoMayorAUno new initializeWith: aValue ].
	^self error: Numero invalidNumberTypeErrorDescription 
	"^self new initalizeWith: aValue"! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:04:51'!
isNegative
	^false ! !

!Cero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:04:46'!
isOne
	^false ! !

!Cero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:04:38'!
isZero
	^true ! !


!Cero methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 11:06:25'!
dividesEntero: anEnteroBeingDivided

	^self error: Entero canNotDivideByZeroErrorDescription ! !

!Cero methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 10:48:59'!
over: anEnteroDivisor

	^self! !


!Cero methodsFor: 'arithmetic operations' stamp: 'ic 4/18/2023 00:40:01'!
fibonacci
	^Entero with: 1! !


!Cero methodsFor: 'value' stamp: 'VW 4/18/2023 14:06:17'!
integerValue
	
	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'instance creation' stamp: 'VW 4/18/2023 13:58:33'!
new
	^self basicNew! !


!classDefinition: #EnteroQueNoEsUnoNiCero category: 'Numero-Exercise'!
Entero subclass: #EnteroQueNoEsUnoNiCero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroQueNoEsUnoNiCero methodsFor: 'value' stamp: 'VW 4/18/2023 14:06:49'!
integerValue

	^value! !


!EnteroQueNoEsUnoNiCero methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 11:10:55'!
useAsDenominatorOf: anEntero
	
	^Fraccion with: anEntero over: self.! !


!EnteroQueNoEsUnoNiCero methodsFor: 'arithmetic operations' stamp: 'ic 4/19/2023 00:25:56'!
fibonacci

		^self subclassResponsibility 
! !


!EnteroQueNoEsUnoNiCero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:26:04'!
isNegative

	^self subclassResponsibility! !

!EnteroQueNoEsUnoNiCero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:05:15'!
isOne
	^false! !

!EnteroQueNoEsUnoNiCero methodsFor: 'testing' stamp: 'ic 4/19/2023 00:05:12'!
isZero
	^false! !


!EnteroQueNoEsUnoNiCero methodsFor: 'initialization' stamp: 'VW 4/18/2023 15:05:07'!
initializeWith: aValue 
	
	value := aValue! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
EnteroQueNoEsUnoNiCero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'testing' stamp: 'ic 4/19/2023 00:14:10'!
isNegative
	^true! !


!Negativo methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 11:08:39'!
dividesEntero: anEnteroBeingDivided

	^anEnteroBeingDivided negated / self negated! !


!Negativo methodsFor: 'arithmetic operations' stamp: 'ic 4/19/2023 00:14:46'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription! !


!classDefinition: #PositivoMayorAUno category: 'Numero-Exercise'!
EnteroQueNoEsUnoNiCero subclass: #PositivoMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositivoMayorAUno methodsFor: 'testing' stamp: 'ic 4/19/2023 00:16:22'!
isNegative
	^false! !


!PositivoMayorAUno methodsFor: 'arithmetic operations' stamp: 'ic 4/19/2023 00:16:07'!
fibonacci
	^ ((self - (Entero with: 1)) fibonacci) + ((self - (Entero with: 2)) fibonacci)! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'ic 4/18/2023 00:40:24'!
fibonacci
	^self! !


!Uno methodsFor: 'testing' stamp: 'ic 4/19/2023 00:05:50'!
isNegative
	^false! !

!Uno methodsFor: 'testing' stamp: 'ic 4/19/2023 00:05:43'!
isOne
	^true! !

!Uno methodsFor: 'testing' stamp: 'ic 4/19/2023 00:05:47'!
isZero
	^false! !


!Uno methodsFor: 'value' stamp: 'VW 4/18/2023 14:06:31'!
integerValue

	^1! !


!Uno methodsFor: 'private arithmetic operations' stamp: 'ic 4/19/2023 10:57:15'!
useAsDenominatorOf: anEnteroNumerator
	
	^anEnteroNumerator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'instance creation' stamp: 'VW 4/18/2023 13:58:59'!
new
	^self basicNew! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:12:34'!
addToEntero: anEnteroBeingAdded

	^anEnteroBeingAdded value * denominator + numerator / denominator ! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:13:39'!
addToFraccion: aFraccionBeingAdded
	| newNumerator newDenominator |

	newNumerator := (numerator * aFraccionBeingAdded denominator) + (denominator * aFraccionBeingAdded numerator).
	newDenominator := denominator * aFraccionBeingAdded denominator.
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:10'!
dividesEntero: anEnteroBeingDivided

	^anEnteroBeingDivided * denominator / numerator! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:25'!
dividesFraccion: aFraccionBeingDivided

	^(aFraccionBeingDivided numerator * denominator) / (aFraccionBeingDivided denominator * numerator)! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'ic 4/17/2023 23:17:23'!
multiplyToEntero: anEnteroBeingMultiplied

	^anEnteroBeingMultiplied value * self numerator / self denominator! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'ic 4/17/2023 23:18:57'!
multiplyToFraccion: aFraccionBeingMultiplied

	^(aFraccionBeingMultiplied numerator * numerator) / (aFraccionBeingMultiplied denominator * denominator)! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:22:50'!
subtractFromEntero: anEnteroBeingSubtracted

	^anEnteroBeingSubtracted * denominator - numerator / denominator! !

!Fraccion methodsFor: 'private arithmetic operations' stamp: 'VW 4/18/2023 13:23:05'!
subtractFromFraccion: aFraccionBeingSubtracted
	| newDenominator newNumerator |
	
	newNumerator := (aFraccionBeingSubtracted numerator * denominator) - (aFraccionBeingSubtracted denominator *  numerator).
	newDenominator := denominator * aFraccionBeingSubtracted denominator. 
	^newNumerator / newDenominator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'ic 4/17/2023 23:20:46'!
* aMultiplier 

	^aMultiplier multiplyToFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:13:39'!
+ anAdder 
	
	^anAdder addToFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:23:05'!
- aSubtrahend 
	
	^aSubtrahend subtractFromFraccion: self 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'VW 4/18/2023 13:22:25'!
/ aDivisor 

	^aDivisor dividesFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'ic 4/19/2023 15:48:50'!
with: aDividend over: aDivisor

	"This message is only used in valid fractions"
	^self new initializeWith: aDividend over: aDivisor
	! !
