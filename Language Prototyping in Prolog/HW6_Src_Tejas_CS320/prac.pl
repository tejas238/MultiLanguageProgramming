:- op(500,yfx,plus).
:- arithmetic_function(plus/2).
plus(X,Y,Z) :- Z is X+Y, write(X), write(Y).

hey(A) :- A is 3 plus 4, write(A).
