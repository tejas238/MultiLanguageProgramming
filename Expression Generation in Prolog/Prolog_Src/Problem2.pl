/*Problem 2 by Tejas Menon, CS320, last edited 10/16.
  This file uses code from the commented problem1 file to generate all expressions 'of interest'
  that evaluate to integers between 0-9 inclusive. Expressions of interest include all expressions with 4 tens.
  RUN THE main(A1) PREDICATE TO EVALUATE ALL EXPRESSIONS*/


:- consult(problem1_commented).

%tens predicates are used to recursively create expressions by appending a 10 with an operator at various positions. 
tens(A,4) :- I is A, integer(I), I >= 0, I =< 9,   %acceptable integer value
			 write(A), write(" = "), write(I), nl.
tens(A,4) :- true. %In all other cases

%The main function that recursively calls itself until the expression size is 4.
tens(A,N) :- add(A,10,S),
			 B is N+1, tens(S,B),
			 add(10,A,T), tens(T,B),
			 sub(A,10,U), tens(U,B),
			 sub(10,A,V), tens(V,B),
			 mult(A,10,W), tens(W,B),
			 mult(10,A,X), tens(X,B),
			 div(A,10,Y), tens(Y,B),
    		 ifzero(10,A,B). 

ifzero(10,A,B) :- A =\= 0, div(10,A,Z), tens(Z,B). %predicate only reached for divisions where the divisor isn't zero
ifzero(10,A,B) :- true.

ifzero2(D,E) :- E =\= 0, div(D,E,I), tens(I,4). %second ifzero predicate for expressions created by tensrest.
ifzero2(D,E) :- true.

%main calls the 'tens' predicate with all operations to avoid duplicate '10+10' evaluation with its commuted '10+10' version
main(A1) :- add(10,10,A), sub(10,10,B), mult(10,10,C), div(10,10,D),
             tens(A,2), tens(B,2), tens(C,2), tens(D,2),
			 tensrest(1,1). %tensrest called for all other expressions.

%The tenrest predicate is used for expressions of the type (x(oper)Y) where X and Y is any of (10(oper)10).
tensrest(A,B) :- B =< 4, elem(A,D), elem(B,E), 
    			 add(D,E,F), tens(F,4), sub(D,E,G), tens(G,4),
    			 mult(D,E,H), tens(H,4), ifzero2(D,E), tensrest(A,B+1).
tensrest(A,B) :- A < 4, C is B-4, D is A+1, tensrest(D,C). %Calls the above tensrest function when B reaches 4. 
tensrest(A,B) :- true. %When (A,B) reach (4,5), this predicate is called
    
elem(A,B) :- A =:= 1, add(10,10,B). %elem provides the elementary expressions organized by a numeral from 1 to 4.
elem(A,B) :- A =:= 2, sub(10,10,B).
elem(A,B) :- A =:= 3, mult(10,10,B).
elem(A,B) :- A =:= 4, div(10,10,B).