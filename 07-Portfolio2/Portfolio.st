!classDefinition: #AccountSummaryTest category: 'Portfolio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 20:38:30'!
test01NewAccountSumaryTestHasOnlyBalance

	| accountSummary |
	
	accountSummary := AccountSummary for: ReceptiveAccount new.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: accountSummary summary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:39:57'!
test02AccountWithDepositHasDepositAndBalance

	| accountSummary account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountSummary := AccountSummary for: account.
	
	self assert: (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100') equals: accountSummary summary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:40:02'!
test03AccountWithWithdrawHasWithdrawAndBalance

	| accountSummary account |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	accountSummary := AccountSummary for: account.
	
	self assert: (OrderedCollection with: 'Extracción por 100' with: 'Balance = -100') equals: accountSummary summary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:42:40'!
test04AccountWithTransferDespositHasTransferDespositAndBalance

	| accountSummary senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	accountSummary := AccountSummary for: receiverAccount.
	
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100') equals: accountSummary summary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:40:42'!
test05AccountWithTransferWithdrawHasTransferWithdrawAndBalance

	| accountSummary senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	accountSummary := AccountSummary for: senderAccount.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100') equals: accountSummary summary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:40:38'!
test06PortfolioWithAccountsShowTransferTwice

	| portfolioSummary senderAccount receiverAccount portfolio |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	portfolio := Portfolio with: senderAccount with: receiverAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	portfolioSummary := AccountSummary for: portfolio.
		
	self assert: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Entrada por transferencia de 100' with: 'Balance = 0') 
	      equals: portfolioSummary summary.! !


!classDefinition: #PortfolioReport category: 'Portfolio'!
TestCase subclass: #PortfolioReport
	instanceVariableNames: 'indents portfolio tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioReport methodsFor: 'indentations' stamp: 'ic&vw 5/31/2023 16:53:48'!
addIndentation

	indents := '    ', indents.! !

!PortfolioReport methodsFor: 'indentations' stamp: 'ic&vw 5/31/2023 16:53:57'!
removeIndentation

	indents := indents allButLast: 4.
	! !


!PortfolioReport methodsFor: 'initialization' stamp: 'ic&vw 5/31/2023 16:58:40'!
initializeFor: aPortfolio 
	
	portfolio := aPortfolio.! !


!PortfolioReport methodsFor: 'accessing' stamp: 'ic&vw 5/31/2023 16:59:40'!
summary

	tree := OrderedCollection new.
	indents := ''.
	
	portfolio registerInTree: self.
	
	^tree! !


!PortfolioReport methodsFor: 'register' stamp: 'ic&vw 5/31/2023 17:00:35'!
registerMessage: aMessage

	tree add: indents,aMessage.
! !

!PortfolioReport methodsFor: 'register' stamp: 'ic&vw 5/31/2023 17:04:00'!
registerPortfolio: aPortfolio

	self subclassResponsibility ! !

!PortfolioReport methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:16'!
registerPortfolio: aPortfolio andAfterAddingAccountsAddBalance: aBlock

	self registerMessage: aPortfolio name.
	self addIndentation.
	
	aPortfolio registerAccountsInTree: self.
	aBlock value.
	
	self removeIndentation.! !

!PortfolioReport methodsFor: 'register' stamp: 'ic&vw 5/31/2023 17:04:08'!
registerReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !

!PortfolioReport methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:41'!
registerReceptiveAccount: aReceptiveAccount andAddSummary: aBlock

	self registerMessage: aReceptiveAccount name.
	aBlock value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'initialization' stamp: 'ic&vw 5/31/2023 16:57:59'!
for: aPortfolio 
	
	^self new initializeFor: aPortfolio.! !


!classDefinition: #PortfolioSummary category: 'Portfolio'!
PortfolioReport subclass: #PortfolioSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!PortfolioSummary methodsFor: 'messages' stamp: 'ic&vw 5/31/2023 15:31:34'!
balanceMessageFor: anAccount

	^ 'Balance = ', anAccount balance asString! !


!PortfolioSummary methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:16'!
registerPortfolio: aPortfolio

	self registerPortfolio: aPortfolio andAfterAddingAccountsAddBalance: [self registerMessage: (self balanceMessageFor: aPortfolio)]
	
! !

!PortfolioSummary methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:41'!
registerReceptiveAccount: aReceptiveAccount

	| accountSummary |
	self registerReceptiveAccount: aReceptiveAccount andAddSummary: [
		
		self addIndentation.		
		accountSummary := (AccountSummary for: aReceptiveAccount) summary.
		tree addAllLast: (accountSummary collect: [:aSummaryLine | indents,aSummaryLine]).
		self removeIndentation.
		
	].

	
! !


!classDefinition: #PortfolioTreeFormat category: 'Portfolio'!
PortfolioReport subclass: #PortfolioTreeFormat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTreeFormat methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:16'!
registerPortfolio: aPortfolio

	self registerPortfolio: aPortfolio andAfterAddingAccountsAddBalance: []
! !

!PortfolioTreeFormat methodsFor: 'register' stamp: 'IC&VW 6/1/2023 15:50:41'!
registerReceptiveAccount: aReceptiveAccount

	self registerReceptiveAccount: aReceptiveAccount andAddSummary: [].
! !


!classDefinition: #PortfolioSummaryTest category: 'Portfolio'!
TestCase subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioSummaryTest methodsFor: 'portfoliosSummaries' stamp: 'ic&vw 5/31/2023 16:42:13'!
portfolioSummaryWithAccountsAndAllPossibleTransactions

	| portfolioSummary |
	portfolioSummary := OrderedCollection new.
	portfolioSummary add: 'Portfolio de la familia'.
	portfolioSummary add: '    Cuenta Mia'.
	portfolioSummary add: '        Depósito por 100'.
	portfolioSummary add: '        Extracción por 50'.
	portfolioSummary add: '        Salida por transferencia de 20'.
	portfolioSummary add: '        Balance = 30'.
	portfolioSummary add: '    Portfolio de hijos'.
	portfolioSummary add: '        Cuenta de Juan'.
	portfolioSummary add: '            Entrada por transferencia de 20'.
	portfolioSummary add: '            Depósito por 15'.
	portfolioSummary add: '            Balance = 35'.
	portfolioSummary add: '        Balance = 35'.
	portfolioSummary add: '    Balance = 65'.
	^portfolioSummary
	! !


!PortfolioSummaryTest methodsFor: 'tests' stamp: 'IC&VW 6/1/2023 15:52:44'!
test01PortfolioSummaryofEmptyPortfolioReturnsNameAndBalance

	| portfolioSummary |
	
	portfolioSummary := PortfolioSummary for: (Portfolio named: 'Portfolio de la familia').
	
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: '    Balance = 0') equals: portfolioSummary summary! !

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'IC&VW 6/1/2023 15:52:22'!
test02PortfolioSummaryOfPortfolioWithAccountsReturnsTreeTransactionsAndBalances

	| johnsAccount familyPortfolio miaAccount sonsPortfolio portfolioSummary |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	sonsPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	miaAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: miaAccount with: sonsPortfolio.
	
		
	Deposit register: 100 on: miaAccount.
	Withdraw register: 50 on: miaAccount.
	Transfer register: 20 from: miaAccount to: johnsAccount.
	Deposit register: 15 on: johnsAccount.
	
	
	portfolioSummary := PortfolioSummary for: familyPortfolio.
	
	
	self assert: self portfolioSummaryWithAccountsAndAllPossibleTransactions
	     equals: portfolioSummary summary! !


!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreeFormatTest category: 'Portfolio'!
TestCase subclass: #PortfolioTreeFormatTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTreeFormatTest methodsFor: 'tests' stamp: 'ic&vw 5/31/2023 16:57:01'!
test01PrintPortfolioNameInEmptyPortfolio

	| childrenPortfolio treeFormat |
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	treeFormat := PortfolioTreeFormat for: childrenPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de hijos') equals: (treeFormat summary).! !

!PortfolioTreeFormatTest methodsFor: 'tests' stamp: 'ic&vw 6/1/2023 15:13:06'!
test02PrintPortfolioNameAndAccountWithOneIndentation

	| childrenPortfolio johnsAccount treeFormat |
	
	johnsAccount  := ReceptiveAccount named: 'Cuenta de Juan'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	treeFormat := PortfolioTreeFormat for: childrenPortfolio.
	
	
	self assert: (OrderedCollection with: 'Portfolio de hijos' 
							     with: ('    Cuenta de Juan'	)
			   ) equals: treeFormat summary! !

!PortfolioTreeFormatTest methodsFor: 'tests' stamp: 'ic&vw 6/1/2023 15:13:24'!
test03PrintPortfolioNameAndMoreThanOneAccountWithOneIndentation

	| childrenPortfolio johnsAccount angiesAccount treeFormat |
	
	johnsAccount  := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount  := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	treeFormat := PortfolioTreeFormat for: childrenPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de hijos' 
	  					             with: ('    Cuenta de Juan'	) 
							     with: ('    Cuenta de Angeles'	)
			   ) equals: treeFormat summary ! !

!PortfolioTreeFormatTest methodsFor: 'tests' stamp: 'ic&vw 6/1/2023 15:13:38'!
test04PrintPortfolioWithAccountInPortfolioWithTheRightIndentation

	| childrenPortfolio johnsAccount familyPortfolio treeFormat |
	
	johnsAccount  := ReceptiveAccount named: 'Cuenta de Juan'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.
	treeFormat := PortfolioTreeFormat for: familyPortfolio.

	
	self assert: (OrderedCollection with: 'Portfolio de la familia' 
							     with: ('    Portfolio de hijos'	) 
							     with: ('        Cuenta de Juan'	)
			   ) equals: treeFormat summary! !

!PortfolioTreeFormatTest methodsFor: 'tests' stamp: 'ic&vw 6/1/2023 15:13:59'!
test05PrintPortfolioWithIndentationGoingUpAndDown

	| childrenPortfolio familyPortfolio treeFormat dadAccount momAccount sonAccount |
	
	sonAccount  := ReceptiveAccount named: 'Cuenta del hijo'.
	dadAccount  := ReceptiveAccount named: 'Cuenta del padre'.
	momAccount := ReceptiveAccount named: 'Cuenta de la madre'.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: sonAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: dadAccount with: childrenPortfolio with: momAccount.
	treeFormat := PortfolioTreeFormat for: familyPortfolio.

	
	self assert: (OrderedCollection with: 'Portfolio de la familia' 
							     with: ('    Cuenta del padre'	)
							     with: ('    Portfolio de hijos'	)
							     with: ('        Cuenta del hijo'	)
							     with: ('    Cuenta de la madre'	)
			   ) 
	
	equals: treeFormat summary! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test01TransferNetForNewAccountReturnsZero

	| transferNet |
	
	transferNet := TransferNet for: ReceptiveAccount new.
	
	self assert: 0 equals: transferNet summary.
	
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test02TransferNetIsAffectedByAccountWithTransferDeposit

	| transferNet account |
	
	account := ReceptiveAccount new.
	Transfer register: 10 from: ReceptiveAccount new to: account. 
	
	transferNet := TransferNet for: account.
	
	self assert: 10 equals: transferNet summary.
	
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test03TransferNetIsNotAffectedByAccountWithDeposit

	| transferNet account |
	
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	
	transferNet := TransferNet for: account.
	
	self assert: 0 equals: transferNet summary.
	
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test04TransferNetIsNotAffectedByAccountWithWithdraw

	| transferNet account |
	
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account. 
	
	transferNet := TransferNet for: account.
	
	self assert: 0 equals: transferNet summary.
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test05TransferNetIsAffectedByAccountWithTransferWithdraw

	| transferNet account |
	
	account := ReceptiveAccount new.
	Transfer register: 10 from: account to: ReceptiveAccount new. 
	
	transferNet := TransferNet for: account.
	
	self assert: -10 equals: transferNet summary.
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 21:11:19'!
test06TransferNetAffectForPortfolioWithTwoTransferAccountsIsCancelled

	| senderAccount receiverAccount portfolio transferNet |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	portfolio := Portfolio with: senderAccount with: receiverAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	transferNet := TransferNet for: portfolio.
	
	self assert: 0 equals: transferNet summary.
	! !


!classDefinition: #TransferTest category: 'Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTest methodsFor: 'creations' stamp: 'ic&vw 5/26/2023 13:04:49'!
createTransferBetweenTwoAccounts

	| receiverAccount senderAccount |
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	^Transfer register: 50 from: senderAccount  to: receiverAccount.! !


!TransferTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 20:40:58'!
test01TransferAffectsBalanceOfBothAccounts

	| receiverAccount senderAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer register: 50 from: senderAccount  to: receiverAccount.

	self assert: -50 equals: senderAccount balance .
	self assert: 50 equals: receiverAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'ic&vw 5/26/2023 13:53:10'!
test02TransferIsRegisteredInBothAccounts

	| receiverAccount senderAccount transfer |
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := 	Transfer register: 50 from: senderAccount  to: receiverAccount.

	self assert: (senderAccount hasRegistered: transfer withdrawLeg).
	self assert: (receiverAccount hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 20:41:27'!
test03TransferLegsHaveTheSameTransfer

	| transfer depositLegTransfer withdrawLegTransfer |

	transfer := 	self createTransferBetweenTwoAccounts.
	
	depositLegTransfer := transfer depositLeg transfer.
	withdrawLegTransfer := transfer withdrawLeg transfer.
	
	self assert: depositLegTransfer equals: withdrawLegTransfer! !

!TransferTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 20:42:57'!
test04TransferWithdrawCanAccessTransferDeposit

	| transfer |

	transfer := 	self createTransferBetweenTwoAccounts.
		
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'ic&vw 5/29/2023 20:42:52'!
test05TransferDepositCanAccessTransferWithdraw

	| transfer |

	transfer := 	self createTransferBetweenTwoAccounts.
		
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg.! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'register' stamp: 'ic&vw 5/29/2023 21:02:39'!
registerInTree: aPortfolioTreeFormat

	self subclassResponsibility ! !

!Account methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:13'!
registerTransactionsInSummary: aSummary

	self subclassResponsibility ! !

!Account methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:22'!
registerTransactionsInTransferNet: aTransferNet 

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'ic&vw 5/27/2023 14:35:22'!
name

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:06:19'!
initializeWithName: aName 

	name := aName.
	self initialize.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'name' stamp: 'ic&vw 5/27/2023 14:35:09'!
name

	^name! !


!Portfolio methodsFor: 'register' stamp: 'ic&vw 5/29/2023 21:02:47'!
registerAccountsInTree: aPortfolioTreeFormat

	accounts do: [:anAccount |  anAccount registerInTree: aPortfolioTreeFormat].

	
	! !

!Portfolio methodsFor: 'register' stamp: 'ic&vw 5/29/2023 21:04:06'!
registerInTree: aPortfolioTreeFormat

	aPortfolioTreeFormat registerPortfolio: self.
	
	! !

!Portfolio methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:14'!
registerTransactionsInSummary: anAccountSummary 
	
	accounts do: [ :anAccount | anAccount registerTransactionsInSummary: anAccountSummary ]! !

!Portfolio methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:23'!
registerTransactionsInTransferNet: aTransferNet 
	
	accounts do: [:account | account registerTransactionsInTransferNet: aTransferNet]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error-message' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:08:35'!
named: aName 
	
	^self new initializeWithName: aName! !

!Portfolio class methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:17:05'!
named: aName with: anAccount 

	^(self named: aName) add: anAccount; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:31:07'!
named: aName with: anAccount with: anotherAccount 
	
	^(self named: aName with: anAccount) add: anotherAccount; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 14:17:06'!
named: aName with: anAccount with: anotherAccount with: aThirdAccount
	
	^(self named: aName with: anAccount with: anotherAccount) add: aThirdAccount; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'initialization' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:13:41'!
initializeWithName: aName 

	name := aName.
	self initialize.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'name' stamp: 'ic&vw 5/27/2023 14:34:50'!
name

	^name! !


!ReceptiveAccount methodsFor: 'register' stamp: 'ic&vw 5/29/2023 21:04:15'!
registerInTree: aPortfolioTreeFormat

	aPortfolioTreeFormat registerReceptiveAccount: self
	
	! !

!ReceptiveAccount methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:14'!
registerTransactionsInSummary: aSummary

	transactions do: [:aTransaction | aTransaction registerInAccountSummary: aSummary	]! !

!ReceptiveAccount methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:52:23'!
registerTransactionsInTransferNet: aTransferNet 
	
	transactions do: [:aTransaction | aTransaction registerInTransferNet: aTransferNet	]
		
		
		
		
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'initialization' stamp: 'ic&vw 5/27/2023 13:13:05'!
named: aName 
	
	^self new initializeWithName: aName! !


!classDefinition: #AccountReport category: 'Portfolio'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountReport methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 22:26:21'!
initializeFor: anAccount 
	
	account := anAccount.
! !


!AccountReport methodsFor: 'accessing' stamp: 'ic&vw 5/29/2023 21:11:37'!
summary

	self subclassResponsibility.! !


!AccountReport methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:24'!
registerDepositFor: anAmount 

	self subclassResponsibility! !

!AccountReport methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:34'!
registerTransferDepositFor: anAmount 
	
	self subclassResponsibility
! !

!AccountReport methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:52'!
registerTransferWithdrawFor: anAmount 
	
	self subclassResponsibility! !

!AccountReport methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:43'!
registerWithdrawFor: anAmount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 22:26:43'!
for: anAccount 
	
	^self new initializeFor: anAccount! !


!classDefinition: #AccountSummary category: 'Portfolio'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummary methodsFor: 'register' stamp: 'ic&vw 5/31/2023 16:41:32'!
registerDepositFor: anAmount 
	
	summary add: ( 'Depósito por ', anAmount asString)
! !

!AccountSummary methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:56:49'!
registerTransferDepositFor: anAmount 
	
	summary add: ( 'Entrada por transferencia de ', anAmount asString)
! !

!AccountSummary methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:57:12'!
registerTransferWithdrawFor: anAmount 
	
	summary add: ( 'Salida por transferencia de ', anAmount asString)
! !

!AccountSummary methodsFor: 'register' stamp: 'ic&vw 5/31/2023 16:41:40'!
registerWithdrawFor: anAmount

	summary add: ( 'Extracción por ', anAmount asString)! !


!AccountSummary methodsFor: 'accessing' stamp: 'ic&vw 5/29/2023 20:52:14'!
summary
	
	summary := OrderedCollection new.
	
	account registerTransactionsInSummary: self.
		
	summary add: (self balanceMessage).
	
	^summary! !


!AccountSummary methodsFor: 'messages' stamp: 'ic&vw 5/31/2023 15:31:05'!
balanceMessage

	^ 'Balance = ', account balance asString! !


!classDefinition: #TransferNet category: 'Portfolio'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferNet methodsFor: 'accessing' stamp: 'ic&vw 5/29/2023 21:11:19'!
summary

	transferNet := 0.
	
	account registerTransactionsInTransferNet: self.
			
	^transferNet! !


!TransferNet methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:24'!
registerDepositFor: anAmount
	
	! !

!TransferNet methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:35'!
registerTransferDepositFor: anAmount
	
	transferNet := transferNet + anAmount.! !

!TransferNet methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:52'!
registerTransferWithdrawFor: anAmount 
	
	transferNet := transferNet - anAmount! !

!TransferNet methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:47:43'!
registerWithdrawFor: anAmount 
	! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 13:36:58'!
initializeFor: anAmount 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:39'!
registerInAccountSummary: aSummary

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:39'!
registerInTransferNet: aTransferNet 

	self subclassResponsibility! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:40'!
registerInAccountSummary: aSummary

	aSummary registerDepositFor: value! !

!Deposit methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:40'!
registerInTransferNet: aTransferNet 
	
	aTransferNet registerDepositFor: value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'ic&vw 5/26/2023 13:37:48'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferTransaction category: 'Portfolio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTransaction methodsFor: 'accessing' stamp: 'ic&vw 5/26/2023 13:44:17'!
transfer

	^transfer! !

!TransferTransaction methodsFor: 'accessing' stamp: 'ic&vw 5/26/2023 13:44:13'!
value

	^transfer value! !


!TransferTransaction methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 13:39:13'!
affectBalance: aBalance

	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 13:43:53'!
initializeFor: aTransfer

	transfer := aTransfer! !


!TransferTransaction methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:40'!
registerInAccountSummary: aSummary

	self subclassResponsibility! !

!TransferTransaction methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:40'!
registerInTransferNet: aTransferNet 

	self subclassResponsibility! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 20:29:14'!
registerOn: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferDeposit category: 'Portfolio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferDeposit methodsFor: 'balance' stamp: 'ic&vw 5/26/2023 13:15:15'!
affectBalance: aBalance

	^aBalance + self value ! !


!TransferDeposit methodsFor: 'legs' stamp: 'ic&vw 5/26/2023 13:56:22'!
withdrawLeg
	^transfer withdrawLeg! !


!TransferDeposit methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:40'!
registerInAccountSummary: aSummary

	aSummary registerTransferDepositFor: self value! !

!TransferDeposit methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:40'!
registerInTransferNet: aTransferNet 
	
	aTransferNet registerTransferDepositFor: self value.! !


!classDefinition: #TransferWithdraw category: 'Portfolio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferWithdraw methodsFor: 'balance' stamp: 'ic&vw 5/26/2023 13:15:24'!
affectBalance: aBalance

	^aBalance - self value ! !


!TransferWithdraw methodsFor: 'legs' stamp: 'ic&vw 5/26/2023 13:53:54'!
depositLeg

	^transfer depositLeg! !


!TransferWithdraw methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:40'!
registerInAccountSummary: aSummary

	aSummary registerTransferWithdrawFor: self value! !

!TransferWithdraw methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:40'!
registerInTransferNet: aTransferNet 
	
	aTransferNet registerTransferWithdrawFor: self value! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:49:40'!
registerInAccountSummary: aSummary

	aSummary registerWithdrawFor: value! !

!Withdraw methodsFor: 'register' stamp: 'ic&vw 5/29/2023 20:48:40'!
registerInTransferNet: aTransferNet 
	
	aTransferNet registerWithdrawFor: value ! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'ic&vw 5/26/2023 13:37:52'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 13:35:16'!
initializeFor: anAmount

	depositLeg := TransferDeposit registerOn: self.
	withdrawLeg := TransferWithdraw registerOn: self.
	
	value := 	anAmount.
! !


!Transfer methodsFor: 'accessing' stamp: 'ic&vw 5/26/2023 13:52:23'!
depositLeg
	
	^depositLeg ! !

!Transfer methodsFor: 'accessing' stamp: 'ic&vw 5/26/2023 13:12:15'!
value

	^value! !

!Transfer methodsFor: 'accessing' stamp: 'ic&vw 5/26/2023 13:52:18'!
withdrawLeg
	
	^withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'ic&vw 5/26/2023 13:52:48'!
register: anAmount from: senderAccount to: receiverAccount 
	
	| transfer |
	
	transfer := self new initializeFor: anAmount.

	senderAccount register: transfer withdrawLeg.
	receiverAccount register: transfer depositLeg.
	
	^transfer.
! !
