{-Maintest.hs by Tejas Menon, CS320, last edited 11/17. This file contains some unit tests
  to confirm correct functionality of symboltable append, find, prettyprint and execution of 
  some "While" programs
-}
module Maintest where

import Main
import Test.HUnit

test1(x) = sa (Var "r") (Val 2) (x)
test2(x) = sa (Var "r") (Val 5) (test1 x)
test3(x) = sa (Var "a") (Val 20) (test2(test1(x)))
test4(x) = sa (Var "a") (Val 4) ((test3(test2(test1(x)))))
test5(x) = sa (Var "b") (Val 10) ((test4(test3(test2(test1(x))))))
test6(x) = sa (Var "a") (Val 7) ((test5(test4(test3(test2(test1(x)))))))
test7(x) = sf (Var "b") ((test6(test5(test4(test3(test2(test1(x))))))))
test8 = exec(Compound([
		Assign(Var "a")(Val 4),
		Assign(Var "b")(Val 10),
		While(Lessthan(Var "a")(Var "b"))(
			If(Lessthan(Var "a")(Sub(Var "b")(Val 4)))(Compound([
				Assign(Var "l")(Var "a"),
				Assign(Var "a")(Mult(Val 2)(Var "a")),
				Assign(Var "b")(Sub(Var "b")(Var "l"))]))
			(Compound([
				Assign(Var "a")(Val 5),
				Assign(Var "b")(Val 4)])
			)
		)
	])) []

test9 = TestCase (assertEqual ("First-time-append") (show([(Var "r",Val 2)])) (show(test1 [])))
test10 = TestCase (assertEqual ("Change-first-val") (show([(Var "r",Val 5)])) (show(test2 [])))
test11 = TestCase (assertEqual ("Append-to-end") (show([(Var "r",Val 5),(Var "a",Val 20)])) (show(test3 [])))
test12 = TestCase (assertEqual ("Change-arbitrary-val") (show([(Var "r",Val 5),(Var "a",Val 4)])) (show(test4 [])))
test13 = TestCase (assertEqual ("Append-another") (show([(Var "r",Val 5),(Var "a",Val 4),(Var "b",Val 10)])) (show(test5 [])))
test14 = TestCase (assertEqual ("Change-middl-val") (show([(Var "r",Val 5),(Var "a",Val 7),(Var "b",Val 10)])) (show(test6 [])))
test15 = TestCase (assertEqual ("Find-middl-val") (10) (test7 []))
test16 = TestCase (assertEqual ("Complex-program-execution") (show([(Var "a",Val 8),(Var "b",Val 6),(Var "l",Val 4)])) (show test8))

tests = runTestTT(TestList [TestLabel "test1" test9, TestLabel "test2" test10, TestLabel "test3" test11, TestLabel "test4" test12, TestLabel "test5" test13,
	TestLabel "test6" test14, TestLabel "test7" test15, TestLabel "test8" test16])

--Check the prettyprint results of some simple programs
test1PP = pp "" (While(Lessthan(Var "b")(Var "a"))(Compound([Assign(Var "a")(Val 2),Assign(Var "b")(Val 2),Compound([Assign(Var "a")(Val 3),Assign(Var "b")(Div(Var "b")(Val 4))])])))
test2PP = pp "" (While(Lessthan(Var "a")(Var "b"))(Compound([Assign(Var "a")(Val 2),Assign(Var "b")(Val 2)])))
test3PP = pp "" (While(Lessthan(Var "a")(Var "b"))(If(Morethan(Var "a")(Val 2))(Compound([Assign(Var "a")(Val 2),Assign(Var "b")(Val 2)]))(Assign(Var "a")(Val 5))))
test4PP = pp "" (Compound([Assign(Var "a")(Mult(Div (Val 2) (Sum(Val 3)(Var "a")))(Val 3)),Output(Var "a")]))
