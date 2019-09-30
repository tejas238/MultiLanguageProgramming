--Problem2.hs by Tejas Menon, CS320, last edited 10/21. This file contains functions to generate all expressions of interest (expressions with four 10s evaluating to an integer
--between 0 and 9 inclusive). 
--CALL 'mainMain' TO SEE FINAL OUTPUT OF PROBLEM2 OR SEE THE FILE 'TYPESCRIPT'

module Problem2 where
import Problem1

--Adds/subs/divides/multiplies an (expression, value) tuple together and outputs a tuple
addt :: (Expr,Expr) -> (Expr,Expr) -> (Expr,Expr)
addt (a,b) (c,d) = (addp (a)(c), add (b)(d))

subt :: (Expr,Expr) -> (Expr,Expr) -> (Expr,Expr)
subt (a,b) (c,d) = (subp (a)(c), sub (b)(d))

divit :: (Expr,Expr) -> (Expr,Expr) -> (Expr,Expr)
divit (a,b) (c,d) = (divip (a)(c), divi (b)(d))

multt :: (Expr,Expr) -> (Expr,Expr) -> (Expr,Expr)
multt (a,b) (c,d) = (multp (a)(c), mult (b)(d))

--Appends the list in arg 1 to the front of the list in arg 2
merge :: [(Expr,Expr)] -> [(Expr,Expr)] -> [(Expr,Expr)]
merge [] xs = xs
merge xs [] = xs
merge (x:xs) (ys) = x: merge(xs)(ys)

--Takes the cartesian product of arg 1 X arg 2 for the four different expressions and
--outputs the resulting list
build :: [(Expr,Expr)] -> [(Expr,Expr)] -> [(Expr,Expr)]
build [] (_) = []
build (x:y) (zs) = do let one = map (addt x) zs
		      let two = merge (one) (map (subt x) zs)
		      let three = merge (two) (map (multt x) zs)
		      let four = merge (three) (map (divit x) zs)
		      merge (four) (build y zs)

--Uses split, build and merge to iterate across a list with Val 10s and outputs all their possible combinations in a list
split :: [Expr] -> Int -> Int -> [(Expr,Expr)]
split [Val 10] (_) (_) = [(Exp "10", Val 10)] --base case where you reach a list with one element
split x y z = if z==y then [] else do let (a,b) = splitAt y x -- y==z means that every split possibility has been evaluated
		                      merge (build (split (a) (1) (y)) (split(b)(1)(z-y))) (split (x) (y+1) (z)) 

--helper function that returns a boolean value to use in 'filter' below
help (a, Val b) = if ((b > -1) && (b < 10)) then True else False
help (a, Errorval) = False

--CALL THIS FUNCTION TO SEE FINAL OUTPUT OR SEE TYPESCRIPT
mainMain = printoneperline (filter (\x -> (help x)) (split ([Val 10, Val 10, Val 10, Val 10]) (1) (4)))
