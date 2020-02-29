"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'primitives',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
 ^ #abs -> [ :x | x abs ]
]

{ #category : #primitives }
JbInterpreter >> asNumberBinding [

^#asNumber -> [ :x | x asNumber ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [

^#concat -> [ :s1 :s2 | s1, s2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [
	super initialize.
	environment := JbEnvironment new.
	primitives := Set new.
	self initializeBindings.
]

{ #category : #initialization }
JbInterpreter >> initializeBindings [

(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding |
				binding := self perform: s.
				primitives add: binding key.			 
				environment at: binding key put: (JbPrimitive new block: (binding value)) ]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [

	^#input -> [ :x |
		uimanager request: x.
		]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
 ^#length -> [ :x | 
					| ans |
					ans := -1.
					(x isString or: x isSymbol)
						ifTrue: [ ans := x size ].
					x isCollection
						ifTrue: [ ans := x size ].
					ans = -1
						ifTrue: [ ans := #undefined ].
					ans ].
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^#mod -> [ :x :y | x \\ y  ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [ :x | x not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
 ^#print -> [ :value | transcript show: value printString ].
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [

	^#println -> [ :value | transcript show: value printString, (String with: Character cr)].
		
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [
	^ transcript
]

{ #category : #accessing }
JbInterpreter >> transcript: anObject [
	transcript := anObject
]

{ #category : #accessing }
JbInterpreter >> uimanager [
	^ uimanager
]

{ #category : #accessing }
JbInterpreter >> uimanager: anObject [
	uimanager := anObject
]
