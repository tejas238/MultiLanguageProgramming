/*maintest.pl by Tejas Menon, CS320, last edited 11/13. This file contains an implementation of 
  the unit tests for HW6 and tests primary functions of the while language.
*/

:- consult(main).
:- begin_tests(main).

%Pretty print simple programs
test1PP :- pp([""],while(lessthan(b,a),compound([assign(a,2),assign(b,2),compound([assign(a,3),assign(b,div(b,4))])]))), nl.
test2PP :- pp([""],while(lessthan(a,b),compound([assign(a,2),assign(b,2)]))), nl.
test3PP :- pp([""],while(lessthan(a,b),if(morethan(a,2),compound([assign(a,2),assign(b,2)]),compound([assign(a,3),assign(b,4),output(b)])))), nl.

test4PP :- pp([""],while(lessthan(a,b),if(lessthan(a,2),compound([assign(a,mult(a,5)),assign(b,add(b,mult(2,3)))]),compound([assign(a,3),assign(b,4)])))), nl.

%Check symbol table addition 
test5SA(S) :- sa(a,5,TL,TO), sa(a,3,TO,T1), sa(b,4,T1,T2), sa(c,2,T2,T3), sa(b,24,T3,S).
%Check symbol table searching
test6SF(Var) :- test5SA(S1), sf(b,Var,S1).

%Check a simple program execution
test7EX(S) :- ex(compound([
		assign(a,4),
		assign(b,10),
		while(lessthan(a,b),
			if(lessthan(a,sub(b,4)), compound([
				assign(l,a),
				assign(a,mult(2,a)),
	      			assign(b,sub(b,l))]),
			compound([
				assign(a,5),assign(b,4)]))
		)]),[],S).

test(test5SA) :- test5SA([[a,3],[b,24],[c,2]]). %end result of symbol table
test(test6SF) :- test6SF(4). %b must be 4
test(test7EX) :- test7EX([[a,8],[b,6],[l,4]]). %symbol table should wind up to this upon execution

testpprun :- test1PP,test2PP,test3PP,test4PP. %pretty print to check output

:- end_tests(main).
:- run_tests.
