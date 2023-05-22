!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'asserts' stamp: 'IC&VW 5/20/2023 15:50:16'!
assertAccountAlreadyAddedWhileTryingToAdd: anAccountToAdd in: anAccount
	
	self should: [anAccount add: anAccountToAdd] raise: Error withExceptionDo: [:AnError| 
		self assert: Portfolio accountAlreadyAddedErrorMessage equals: AnError messageText.
	]
	! !


!PortfolioTest methodsFor: 'tests' stamp: 'icvw 5/15/2023 20:43:57'!
test01NewPortfolioMustHaveBalanceZero

	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'icvw 5/15/2023 21:20:50'!
test02PortfolioCanAddAccountWithBalanceZero

	| portfolio  |
	
	portfolio := self createPortfolioWithAccountWithNoBalance.
		
	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'icvw 5/15/2023 21:17:06'!
test03PortfolioCanAddAccountWithBalanceNotZero

	| portfolio  |
	
	portfolio := self createPortfolioWithAccountWithBalanceFifty.
		
	self assert: 50 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:33:21'!
test04PortfolioCanAddTwoAccountWithBalanceZero

	| portfolio  |
	
	portfolio := self createPortfolioWithAccountWithNoBalance.	
	
	self addNewReceptiveAccountTo: portfolio.
		
	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:36:31'!
test05PortfolioCanAddTwoAccountWithBalanceNotZero

	| portfolio  |

	portfolio := self createPortfolioWithAccountWithBalanceFifty.
	
	self addReceptiveAccountWithBalanceTwentyTo: portfolio.
		
	self assert: 70 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:40:06'!
test06PortfolioCanAddPortfolioWithAccountWithBalanceNotZero

	| porfolioWithPortfolio  portfolioWithAccount  |

	portfolioWithAccount := self createPortfolioWithAccountWithBalanceFifty.
	porfolioWithPortfolio := self createPortfolioWith: portfolioWithAccount.
		
	self assert: 50 equals: porfolioWithPortfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ic&vw 5/18/2023 13:59:27'!
test07PortfolioWithNoAccountHasNoTransaction
	
	
	self deny: (Portfolio new hasRegistered: (Deposit for: 50))
! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:39:28'!
test08PortfolioWithAccountWithTransactionHasThatTransaction

	| portfolio |

	portfolio := self createPortfolioWithAccountWithBalanceFifty.
	self assert: (portfolio hasRegistered: (Deposit for: 50))
! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:41:09'!
test09PortfolioWithPortfolioWithTransaction

	| portfolioWithPortfolio |

	portfolioWithPortfolio := self createPortfolioWith: self createPortfolioWithAccountWithBalanceFifty.
		
	self assert: (portfolioWithPortfolio hasRegistered: (Deposit for: 50))! !

!PortfolioTest methodsFor: 'tests' stamp: 'ic&vw 5/18/2023 14:28:50'!
test10NewPortfolioHasNoTransactions

		
	self assert: (Portfolio new transactions isEmpty)! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:42:40'!
test11PortfolioWithAccountWithTransactions
	
	| account portfolio |
	
	account := self createReceptiveAccountWithBalanceFifty.
	Deposit register: 70 on: account.
	
	portfolio := self createPortfolioWith: account.
			
	self assert: 2 equals: (portfolio transactions size).
	self assert: (portfolio transactions includes: (Deposit for: 50)).
	self assert: (portfolio transactions includes: (Deposit for: 70))
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 15:46:13'!
test12PortfolioWithPorfolioWithTransactions
	
	| portfolioWithAccountAndPortfolio |
	
	portfolioWithAccountAndPortfolio := self createPortfolioWith: self createReceptiveAccountWithBalanceTwenty
									 with: self createPortfolioWithAccountWithBalanceFifty.
		
	self assert: 2 equals: (portfolioWithAccountAndPortfolio transactions size).
	self assert: (portfolioWithAccountAndPortfolio transactions includes: (Deposit for: 50)).
	self assert: (portfolioWithAccountAndPortfolio transactions includes: (Deposit for: 20))
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 16:04:16'!
test13PortfolioCantAddAnAlreadyAddedAccount
	
	| account portfolio |
	
	account := self createReceptiveAccountWithBalanceTwenty.

	portfolio := self createPortfolioWith: account.
	
	self assertAccountAlreadyAddedWhileTryingToAdd: account in: portfolio. 

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 16:03:35'!
test14PortfolioCantAddAPortfolioWithAnAlreadyAddedAccount
	
	| account rootPortfolio portfolioWithAccount |
	
	account := self createReceptiveAccountWithBalanceTwenty.
	
	rootPortfolio := self createPortfolioWith: account.
	portfolioWithAccount := self createPortfolioWith: account.
	
	self assertAccountAlreadyAddedWhileTryingToAdd: portfolioWithAccount in: rootPortfolio. 
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 16:06:16'!
test15PortfolioCantAddAnAlreadyAddedAccountByFather
	
	| account portfolio |
	
	account := self createReceptiveAccountWithBalanceTwenty.

	portfolio := Portfolio new.
	self createPortfolioWith: portfolio with: account. 
	
	self assertAccountAlreadyAddedWhileTryingToAdd: account in: portfolio.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 16:06:20'!
test16PortfolioCantAddAPortfolioWithAnAlreadyAddedAccountByFather
	
	| account portfolioTryingToAdd portfolioWithAccount|
	
	account := self createReceptiveAccountWithBalanceTwenty.
	
	portfolioTryingToAdd := Portfolio new.
	portfolioWithAccount := self createPortfolioWith: account.
	self createPortfolioWith: account with: portfolioTryingToAdd.
		
	self assertAccountAlreadyAddedWhileTryingToAdd: portfolioWithAccount in: portfolioTryingToAdd.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'IC&VW 5/20/2023 16:06:24'!
test17PortfolioCantAddAnAccountAlreadyAddedByFirstFather
	
	| account portfolioTryingToAdd|
	
	account := self createReceptiveAccountWithBalanceTwenty.
	
	portfolioTryingToAdd := Portfolio new.
	self createPortfolioWith: account with: portfolioTryingToAdd.
	self createPortfolioWith: portfolioTryingToAdd.
	
	self assertAccountAlreadyAddedWhileTryingToAdd: account in: portfolioTryingToAdd.
	! !


!PortfolioTest methodsFor: 'actions' stamp: 'IC&VW 5/20/2023 15:33:09'!
addNewReceptiveAccountTo: aPortfolio

	aPortfolio add: ReceptiveAccount new.	! !

!PortfolioTest methodsFor: 'actions' stamp: 'IC&VW 5/20/2023 15:36:10'!
addReceptiveAccountWithBalanceTwentyTo: aPortfolio

	aPortfolio add: self createReceptiveAccountWithBalanceTwenty.	! !


!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:40:11'!
createPortfolioWith: anAccount
	| portfolio |

	portfolio := Portfolio new.
	^portfolio add: anAccount.
	
		
! !

!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:44:30'!
createPortfolioWith: anAccount with: anotherAccount
	| portfolio |

	portfolio := Portfolio new.
	portfolio add: anAccount.
	^portfolio add: anotherAccount.
	
	
		
! !

!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:33:49'!
createPortfolioWithAccountWithBalanceFifty
	| portfolio account |

	portfolio := Portfolio new.
	account := self createReceptiveAccountWithBalanceFifty.
	^portfolio add: account.
	
		
! !

!PortfolioTest methodsFor: 'creations' stamp: 'icvw 5/15/2023 21:23:47'!
createPortfolioWithAccountWithNoBalance
	| portfolio account |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	^portfolio add: account.
	
		
! !

!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:33:38'!
createReceptiveAccountWithBalance: anAmount
	|account|
	
	account := ReceptiveAccount new.	
	Deposit register: anAmount on: account.
	^account! !

!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:33:49'!
createReceptiveAccountWithBalanceFifty
	
	^self createReceptiveAccountWithBalance: 50! !

!PortfolioTest methodsFor: 'creations' stamp: 'IC&VW 5/20/2023 15:34:00'!
createReceptiveAccountWithBalanceTwenty
	
	^self createReceptiveAccountWithBalance: 20! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'fathers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'VW&IC 5/20/2023 12:13:01'!
initialize
	self  subclassResponsibility.! !


!Account methodsFor: 'balance' stamp: 'VW&IC 5/20/2023 12:10:58'!
balance
	self  subclassResponsibility.! !


!Account methodsFor: 'adding' stamp: 'VW&IC 5/20/2023 13:11:42'!
addFather: aPortfolio
	fathers add: aPortfolio! !


!Account methodsFor: 'transactions' stamp: 'VW&IC 5/20/2023 12:12:34'!
hasRegistered: aTransaction
	self  subclassResponsibility.! !

!Account methodsFor: 'transactions' stamp: 'VW&IC 5/20/2023 12:13:44'!
transactions
	self  subclassResponsibility.! !


!Account methodsFor: 'adding - private' stamp: 'IC&VW 5/20/2023 14:02:35'!
canBeAddedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'balance accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'VW&IC 5/20/2023 12:35:30'!
addTransactionsFrom: anAccount in: aListOfTransactions 
	
	aListOfTransactions addAllLast: anAccount transactions.
	^aListOfTransactions.! !

!Portfolio methodsFor: 'transactions' stamp: 'VW&IC 5/20/2023 12:36:40'!
hasRegistered: aTransaction 
	^accounts anySatisfy: [:account | account hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'transactions' stamp: 'IC&VW 5/20/2023 13:54:57'!
transactions
		
	^ accounts inject: OrderedCollection new into: [:transactions :account |
			self addTransactionsFrom: account in: transactions
		]! !


!Portfolio methodsFor: 'accounts' stamp: 'VW&IC 5/20/2023 12:36:40'!
accounts
	^accounts ! !


!Portfolio methodsFor: 'adding - private' stamp: 'IC&VW 5/20/2023 14:09:50'!
canAddReceptiveAccount: aReceptiveAccount

	fathers ifEmpty: [ ^self checkIfReceptiveAccountsIsAlreadyAdded: aReceptiveAccount].
	^fathers do:[:father| father canAddReceptiveAccount: aReceptiveAccount ] ! !

!Portfolio methodsFor: 'adding - private' stamp: 'VW&IC 5/20/2023 12:36:40'!
canBeAddedTo: aPortfolio
	accounts do: [:account| account canBeAddedTo: aPortfolio]! !

!Portfolio methodsFor: 'adding - private' stamp: 'IC&VW 5/20/2023 14:14:10'!
checkIfReceptiveAccountsIsAlreadyAdded: aReceptiveAccount

	^ (accounts includes: aReceptiveAccount) ifTrue: [self class accountAlreadyAddedError]! !


!Portfolio methodsFor: 'adding' stamp: 'IC&VW 5/20/2023 13:56:09'!
add: anAccount

	anAccount canBeAddedTo: self.
	accounts add: anAccount.
	anAccount addFather: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'VW&IC 5/20/2023 13:10:42'!
initialize
	accounts := OrderedCollection new.
	fathers := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'IC&VW 5/20/2023 13:54:31'!
balance
	^ accounts sum: [:account | account balance]  ifEmpty: [0]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errorsMessages' stamp: 'IC&VW 5/20/2023 14:57:45'!
accountAlreadyAddedErrorMessage
	^'No se puede agregar una cuenta ya agregada'! !


!Portfolio class methodsFor: 'errors' stamp: 'IC&VW 5/20/2023 14:57:45'!
accountAlreadyAddedError

	self error: self accountAlreadyAddedErrorMessage! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'VW&IC 5/20/2023 13:10:54'!
initialize

	transactions := OrderedCollection new.
	fathers := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'icvw 5/15/2023 21:10:05'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'icvw 5/15/2023 19:56:06'!
balance

	^transactions inject: 0 into: [:accountBalance :aTransaction | aTransaction addValueToBalance: accountBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding - private' stamp: 'VW&IC 5/20/2023 12:28:01'!
canBeAddedTo: aPortfolio
	aPortfolio canAddReceptiveAccount: self! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'comparing' stamp: 'ic&vw 5/18/2023 01:08:06'!
= anAccountTransaction

	^(self class = anAccountTransaction class) & self value = anAccountTransaction value.! !

!AccountTransaction methodsFor: 'comparing' stamp: 'ic&vw 5/18/2023 01:08:36'!
hash

	self identityHash ! !


!AccountTransaction methodsFor: 'value' stamp: 'icvw 5/15/2023 19:56:06'!
addValueToBalance: aBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'icvw 5/15/2023 19:56:06'!
addValueToBalance: aBalance
	
	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'icvw 5/15/2023 19:56:06'!
addValueToBalance: aBalance

	^ aBalance-value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
