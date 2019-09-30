--Maintest.hs by Tejas Menon, CS320, last edited 10/21. This file contains a test modeule that evaluates basic to complex expressions for problem 1
--RUN THE 'tests' FUNCTION FOR OUTPUT OR SEE TYPESCRIPT

module Maintest where

import Problem1
import Test.HUnit

test1 = TestCase (assertEqual ("Simple Addition") ("(5 + 6) = 11.0") (transfer (addp (Exp "5") (Exp "6"), add (Val 5) (Val 6))))
test2 = TestCase (assertEqual ("Non-integer result") ("(6 / 5) = Errorval") (transfer (divip (Exp "6") (Exp "5"), divi (Val 6) (Val 5))))
test3 = TestCase (assertEqual ("Complex Expression") ("(((6 / 2) + 23) - 9) = 17.0") (transfer (subp (addp (divip (Exp "6") (Exp "2")) (Exp "23")) (Exp "9"), sub (add (divi (Val 6)(Val 2)) (Val 23)) (Val 9))))
test4 = TestCase (assertEqual ("Complex Expression w/ error") ("(((6 / 0) + 23) - 9) = Errorval") (transfer (subp (addp (divip (Exp "6") (Exp "0")) (Exp "23")) (Exp "9"), sub (add (divi (Val 6)(Val 0)) (Val 23)) (Val 9))))
test5 = TestCase (assertEqual ("Complex Expression non-integer") ("(((6 / 5) + 23) - 9) = Errorval") (transfer (subp (addp (divip (Exp "6") (Exp "5")) (Exp "23")) (Exp "9"), sub (add (divi (Val 6)(Val 5)) (Val 23)) (Val 9))))


tests = runTestTT (TestList [TestLabel "test1" test1, TestLabel "test2" test2, TestLabel "test3" test3, TestLabel "test4" test4, TestLabel "test5" test5])

