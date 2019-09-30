/*Problem 1 by Tejas Menon, CS320, last edited 10/16.
  This file simply comments out the integer check from the
  problem 1 code for avoiding errors in problem 2 */

%The exp predicates put the expression value into D and the expression into L
exp(D,L):- add(1,10,A), mult(5,A,R), div(R,11,L), D is L.
exp2(D,L):- sub(3,10,A), mult(A,-5,R), div(R,2,L), D is L.
exp3(D,L):- div(16,4,A), mult(A,0,L), D is L. 
exp4(D,L):- div(0,12,L), D is L.
exp5(D,L):- div(12,0,L), D is L.

add(A,B,C):- C =A+B.
mult(A,B,C):- C =A*B. 
div(A,B,C):- B =\= 0, C = A/B. /* I is C, integer(I)*/
sub(A,B,C):- C = A-B.