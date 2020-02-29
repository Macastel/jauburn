Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#classInstVars : [
		'nterpreter',
		'interpreter'
	],
	#category : #'Jauburn-Interpreter-Interpreter Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #'as yet unclassified' }
JbInterpreterTest >> interpret: code thenAssert: variable equals: answer [


self interpret: code.
^self assert: (interpreter environment at: variable) equals: answer.
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> test2OperationNodeArithmeticFunctions [

	self interpret: 'var x = 12 - 2 * 3;'.
	self assert: (interpreter environment at: 'x') equals: 6.	
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 8; var y = 12 - x;'.
	self assert: (interpreter environment at: 'y') equals: 4.
	
	self interpret: 'var x = 12 - 6 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 9.

	self interpret: 'var x = (4 + 5) / 3 + 2;'.
	self assert: (interpreter environment at: 'x') equals: 5.	
	
	
	self interpret: 'var t = 9; var j = (t / 3);'.
	self assert: (interpreter environment at: 'j') equals: 3.
]

{ #category : #tests }
JbInterpreterTest >> test2OperationNodeFunctions [

   self interpret: 'var x = 19 != 5;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var y = 5 != 5;'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var y = 5 != -5;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
   self interpret: 'var x = 19 == 5;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var y = 5 == 5;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var y = 5 == -5;'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var y = 5 < 5;'.
	self assert: (interpreter environment at: 'y') equals: false.

	self interpret: 'var y = 4 < 5;'.
	self assert: (interpreter environment at: 'y') equals: true.	

	self interpret: 'var y = 5 < 3;'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var y = 5 <= 5;'.
	self assert: (interpreter environment at: 'y') equals: true.

	self interpret: 'var y = 4 <= 5;'.
	self assert: (interpreter environment at: 'y') equals: true.	

	self interpret: 'var y = 5 <= 3;'.
	self assert: (interpreter environment at: 'y') equals: false.	

	self interpret: 'var y = 5 > 5;'.
	self assert: (interpreter environment at: 'y') equals: false.

	self interpret: 'var y = 4 > 5;'.
	self assert: (interpreter environment at: 'y') equals: false.	

	self interpret: 'var y = 5 > 3;'.
	self assert: (interpreter environment at: 'y') equals: true.	

	self interpret: 'var y = 5 >= 5;'.
	self assert: (interpreter environment at: 'y') equals: true.

	self interpret: 'var y = 4 >= 5;'.
	self assert: (interpreter environment at: 'y') equals: false.	

	self interpret: 'var y = 5 >= 3;'.
	self assert: (interpreter environment at: 'y') equals: true.	
			
	"Gets 5
	self interpret: 'var y = 5; var z = 9;'.
	self interpret: 'var k = y == z'.
	self assert: (interpreter environment at: 'y') equals: true."
]

{ #category : #tests }
JbInterpreterTest >> testClosure [ 

self interpret: 
'var x = 7;
var f = function (a) {  
	return a + x; };
var g = function () {  
	var x = 42;  
	return f(3);
};	
var x = 17;'.
	self assert: (interpreter environment includesKey: 'f').
	self assert: (interpreter environment includesKey: 'g').
	self assert: (interpreter environment includesKey: 'x'). 	 	 
	self interpret: 'var y = g();' thenAssert: 'y' equals: 20.
	
	self interpret: 'var x = 4;.'.
	self interpret: 'var y = g();' thenAssert: 'y' equals: 7.		
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testGCD [

	self interpret: 'var gcd = function (a , b) {
		
		if (a == 0) { 
			return b;
		 }	
		var t = mod(b, a);
		return gcd(t, a);	
	
	};'.

	self assert: (interpreter environment includesKey: 'gcd'). 
	self interpret: 'var y = gcd(10, 15);' thenAssert: 'y' equals: 5.			
	self interpret: 'var y = gcd(30, 20);' thenAssert: 'y' equals: 10.
	self interpret: 'var y = gcd(4, 3);' thenAssert: 'y' equals: 1.							


]

{ #category : #tests }
JbInterpreterTest >> testJBElseNodeFunctions [

	
	self interpret: 'var y = false;'.
   self interpret: 'if (y) { var x = 5; } else { var x = 9;}'.
	self assert: (interpreter environment at: 'x') equals: 9.
	
	self interpret: 'if ("hello" == "goodbye") { var x = 2; } else { var y = 3; }'.
	self assert: (interpreter environment at: 'y') equals: 3.

	self interpret: 'var y = true;'.
   self interpret: 'if (y) { var y = 5;} else { var y = 9;}'.
	self assert: (interpreter environment at: 'y') equals: 5.
	
	self interpret: 'var x = 1;'.
	self interpret: 'if (x == 2) {var v = 10; } else {var v = -1;}'.
	self assert: (interpreter environment at: 'v') equals: -1


]

{ #category : #tests }
JbInterpreterTest >> testJBFunctionCall [

	self interpret: 'var y = function (j, l) { var x = j * l; return x;};'.
	self assert: (interpreter environment includesKey: 'y'). 
	self interpret: 'var z = y(12, 33);' thenAssert: 'z' equals: 396.	
		
	self interpret: 'var q = function () { var x = 6; var p = 10; if (x == 7) {return 5;} return 11;};'.
	self assert: (interpreter environment includesKey: 'q'). 
	self interpret: 'var n = q();' thenAssert: 'n' equals: 11.

	self interpret: 'var q = function () { var x = 6; var p = 10; if (x == 6) {return 5;} return 11;};'.
	self assert: (interpreter environment includesKey: 'q'). 
	self interpret: 'var n = q();' thenAssert: 'n' equals: 5.	
	
	
	self interpret: 'var y = function (p, q) { return p + q;};'.
	self assert: (interpreter environment includesKey: 'y'). 
	self interpret: 'var z = y(8, 10);' thenAssert: 'z' equals: 18.
	
	self interpret: 'var y = function () { var x = 6; var p = 10; return p - x;};'.
	self assert: (interpreter environment includesKey: 'y'). 
	self interpret: 'var z = y();' thenAssert: 'z' equals: 4.	
		
					
	self interpret: 'var y = function (p, q) { return p / q;};'.
	self assert: (interpreter environment includesKey: 'y'). 
	self interpret: 'var z = y(9, 5);' thenAssert: 'z' equals: 1.8.

	self interpret: 'var y = function (p, q) { return p / q;};'.
	self assert: (interpreter environment includesKey: 'y'). 
	self interpret: 'var z = y(9, 3);' thenAssert: 'z' equals: 3.	

]

{ #category : #tests }
JbInterpreterTest >> testJBIfNodeFunctions [

	self interpret: 'var y = true;'.
   self interpret: 'if (y) { var y = 5;}'.
	self assert: (interpreter environment at: 'y') equals: 5.

	self interpret: 'var y = 10;'.
   self interpret: 'if (y == 10) { var z = 5 + 2; }'.
	self assert: (interpreter environment at: 'z') equals: 7.
	
	self interpret: 'var y = 10;'.
	self interpret: 'var z = 6;'.
   self interpret: 'if (y == 5) { var z = 5; }'.
	self assert: (interpreter environment at: 'z') equals: 6.
	
	self interpret: 'var z = 11;'.
   self interpret: 'if (11 == 10) { var z = 5 + 2; }'.
	self assert: (interpreter environment at: 'z') equals: 11.
]

{ #category : #tests }
JbInterpreterTest >> testJBPrimitives [
	| jbmt jbui |
	jbmt := JbMockTranscript new.
	jbui := JbMockUIManager new.
	interpreter transcript: jbmt.
	interpreter uimanager: jbui.
	
	
	self interpret: 'var x = asNumber("4");' thenAssert: 'x' equals: 4.	
			
	self interpret: 'print(42);'.
	self assert: jbmt contents equals: '42'.
	
	self interpret: 'println(42);'.
	self assert: jbmt contents equals: '42', (String with: Character cr).
		
	self interpret: 'print(true);'.
	self assert: jbmt contents equals: 'true'.
	"Test Printing Strings"
	
	self interpret: 'input(42);'.
	self assert: jbui contents equals: 42.
	
	self interpret: 'var x = length("Hello");' thenAssert: 'x' equals: 5.
	self interpret: 'var x = concat("abc", "def");' thenAssert: 'x' equals: 'abcdef'.
	self interpret: 'var x = not(true);' thenAssert: 'x' equals: false.	
	self interpret: 'var x = abs(120);' thenAssert: 'x' equals: 120.	
	self interpret: 'var x = abs(-120);' thenAssert: 'x' equals: 120.
	self interpret: 'var x = mod(10, 3);' thenAssert: 'x' equals: 1.	
	self interpret: 'var x = mod(18, 4);' thenAssert: 'x' equals: 2.			
			

	
]

{ #category : #tests }
JbInterpreterTest >> testJbWhileNodeFunctions [

	
	self interpret: 'var x = 1; var y = 0; while (x < 11){var y = y + x; var x = x + 1;}'.
	self assert: (interpreter environment at: 'y') equals: 55.
	
	self interpret: 'var x = 1; var y = 0; while (x < 11){var y = 10 + x; var x = x + 1; }'.
	self assert: (interpreter environment at: 'y') equals: 20.	

	self interpret: 'var x = 1; var y = 0; while (x < 11){var y = 10; var x = x + 1; }'.
	self assert: (interpreter environment at: 'y') equals: 10.	
		
	self interpret: 'var x = 1; var y = 0; while (x < 11){ var x = x + 1; }'.
	self assert: (interpreter environment at: 'x') equals: 11.			

	
]

{ #category : #tests }
JbInterpreterTest >> testSqrt [
	
	| jbmt jbui |
	jbmt := JbMockTranscript new.
	jbui := JbMockUIManager new.
	interpreter transcript: jbmt.
	
	self interpret: 
	'var sqrt = function(n) {
	
		var tollerance = 1 / 10000;
		var val = n;
		var x = true;
		while (x) { 
			var last = val;
			
			var t = n / val;
			var t = t + val;
			var t = t / 2;
			var diff = abs(t - last);
			var val = t;
			println(val);
	
			
			if (diff < tollerance) {  
				var x = false;
			}

		 }
		
		return val;
	};'.
	self assert: (interpreter environment includesKey: 'sqrt'). 
	self interpret: 'var y = sqrt(4);'.
	self assert: (interpreter environment at: 'y') closeTo: 2.		
			
			
	self interpret: 'var y = sqrt(16);'.
	self assert: (interpreter environment at: 'y') closeTo: 4.				


 
]

{ #category : #tests }
JbInterpreterTest >> testUnaryOperatorFunctions [


	self interpret: 'var x = -99;'.
	self assert: (interpreter environment at: 'x') equals: -99.
	
	self interpret: 'var y = -0;'.
	self assert: (interpreter environment at: 'y') equals: 0.
	
	self interpret: 'var z = -1;'.
	self assert: (interpreter environment at: 'z') equals: -1.
	
	self interpret: 'var k = 6; var l = -k;'.
	self assert: (interpreter environment at: 'l') equals: -6.
]
