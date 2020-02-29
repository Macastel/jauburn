"
I am the value that results from evaluating a function.  My i-vars

	parameters -- collection holding names of my parameters 
	environment -- a JbEnvironment instance holding the environment in effect when I was created (closures!)
	body -- an AST node for the body of this function
"
Class {
	#name : #JbFunction,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters',
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbFunction >> body [
	^ body
]

{ #category : #accessing }
JbFunction >> body: anObject [
	body := anObject
]

{ #category : #api }
JbFunction >> call: arguments in: callEnvironment [
	"You need to implement this method!  arguments will contain the arguments to pass to this function and callEnvironment will contain the environment in place when this function was called."
	| proc newEnv params p oldP|

	
	params := self parameters collect: [ :f | f identifier  ].
	oldP := self parameters.
	self parameters: params.
	
	newEnv := self setEnvironmentalParamatersFor: (arguments collect: [ :e | e evaluateIn: callEnvironment]) in: environment.
	
	self parameters: oldP.
	proc := body.
	
	"^proc first executeIn: newEnv."
	^(proc do: [ :x | x isJbReturnStatementNode ifTrue: [ ^x executeIn: newEnv ] ifFalse: [p := (x executeIn: newEnv).
		 p notNil ifTrue: [p notNode ifTrue: [^p]]]])  
	


	
	

]

{ #category : #accessing }
JbFunction >> environment [
	^ environment
]

{ #category : #accessing }
JbFunction >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
JbFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunction >> parameters: anObject [
	parameters := anObject
]

{ #category : #initialization }
JbFunction >> setEnvironmentalParamatersFor: values in: outerEnvironment [
	| applicationEnvironment |
	
	applicationEnvironment := JbEnvironment newFromKeys: self parameters  andValues: values.
	applicationEnvironment outerEnvironment: outerEnvironment. 
	^ applicationEnvironment
]
