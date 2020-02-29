Extension { #name : #JbIdentifierExpressionNode }

{ #category : #'*Jauburn-Interpreter' }
JbIdentifierExpressionNode >> evaluateIn: environment [ 

	"(environment includesKey: self identifier) ifTrue: [ ^environment at: self identifier ].
	^self identifier."

	^environment at: self identifier
	

]
