"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'as yet unclassified' }
JbSamplePrograms >> gcd [

^'

var p = input("Enter a Number");
var p = asNumber(p);
var q = input("Enter another Number");
var q = asNumber(q);	


var gcd = function (a , b) {
		
		if (a == 0) { 
			return b;
		 }	
		var t = mod(b, a);
		return gcd(t, a);	
	
	};
var z = gcd(p, q);
println(z);	
	
'
]

{ #category : #'as yet unclassified' }
JbSamplePrograms >> squareRoot [

^	'
var p = input("Enter a Number");
var p = asNumber(p);
	var sqrt = function(n) {
	
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
	};	

var z = sqrt(p);
println(z);

'
]
