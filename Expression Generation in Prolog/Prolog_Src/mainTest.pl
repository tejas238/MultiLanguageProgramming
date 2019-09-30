/*Test module by Tejas Menon, CS320, last edited 10/16.
  This file contains useful tests on 'uncommented' problem1 */


:- consult(problem1).
:- begin_tests(problem1).

test(exp) :- exp(5,5*(1+10)/11). %check a general expression
test(exp2,[fail]) :- exp2(false,false). %decimal expression
test(exp3):- exp3(0,16/4*0). %check for multiply by zero
test(exp4):- exp4(0,0/12). %check for 0/something
test(exp5,[fail]):- exp5(false,false). %check for divide by zero

:- end_tests(problem1).
:- run_tests.