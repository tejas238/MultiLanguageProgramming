{-Main.hs by Tejas Menon, last edited 11/17. This file contains the complete implementation of the 
  "while" language and provides two example programs- the factorial of 5 and the 22nd fibonacci number-
  both of which are pretty-printed in a readable format and executed upon calling of the respective functions
-}

module Main 
where

--Not separated into expressions and statements as function names would need to be different
data Expr = Val Int | Var String | Sum Expr Expr | Mult Expr Expr | Sub Expr Expr | Div Expr Expr | Lessthan Expr Expr | Morethan Expr Expr
	   | If Expr Expr Expr | Compound [Expr] | While Expr Expr | Output Expr | Assign Expr Expr deriving Show 

ex::Expr -> [(Expr,Expr)] -> Int
ex(Val x) (_) = x
ex(Var x) (s) = sf(Var x) (s)
ex(Sum x y) (s) = ex(x)(s) + ex(y)(s)
ex(Sub x y) (s) = ex(x)(s) - ex(y)(s)
ex(Mult x y) (s) = ex(x)(s) * ex(y)(s)
ex(Div x y) (s) = ex(x)(s) `div` ex(y)(s)
ex(Lessthan x y) (s) = if (ex(x)(s) < ex(y)(s)) then 1 else 0
ex(Morethan x y) (s) = if (ex(x)(s) > ex(y)(s)) then 1 else 0

--exec functions used for executing "while" program statements
exec::Expr -> [(Expr,Expr)] -> [(Expr,Expr)]
exec(Assign (Var x) y)(s) = sa(Var x) (Val (ex y s)) s

exec(Compound []) s = s
exec(Compound (x:xs)) s = exec(Compound xs)(exec x s)

exec(While x y) s = if (ex x s == 1) then exec(While x y)(exec y s) else s

exec(If x y z) s = if (ex x s == 1) then exec y s else exec z s

--prettyprints all expressions
pp(n) (Val x) = putStr(n ++ show(x))

pp(n) (Var x) = putStr(n ++ x)

pp(n) (Sum x y) = do putStr(n ++ "(") 
		     pp ("") (x)
		     putStr("+")
		     pp ("") (y)
		     putStr(")")

pp(n) (Sub x y) = do putStr(n ++ "(") 
		     pp("")(x)
		     putStr("-")
		     pp("")(y)
		     putStr(")")

pp(n) (Mult x y) = do putStr(n ++ "(") 
		      pp("")(x)
		      putStr("*")
		      pp("")(y)
		      putStr(")")

pp(n) (Div x y) = do putStr(n ++ "(") 
		     pp("")(x)
		     putStr("/")
		     pp("")(y)
		     putStr(")")

pp(n) (Lessthan x y) = do putStr(n ++ "(") 
		          pp("")(x)
		          putStr("<")
		          pp("")(y)
		          putStr(")") 

pp(n) (Morethan x y) = do putStr(n ++ "(") 
		          pp("")(x)
		          putStr(">")
		          pp("")(y)
		          putStr(")")

pp(n) (If x y z) = do putStr(n ++ "if ")
		      pp("")(x)
		      putStrLn(" then")
		      pp(n ++ "    ") (y)
		      putStrLn(n ++ "else")
		      pp(n ++ "    ") (z)

pp(n) (While x y) = do putStr(n ++ "while ")
		       pp("")(x)
		       putStrLn(" do")
		       pp(n ++ "    ")(y)

pp(n) (Compound x) = do putStrLn(n ++ "begin")
		        compound(n ++ "    ")(x)
		    	putStrLn(n ++ "end")

pp(n) (Assign x y) = do putStr(n)
			pp("")(x)
			putStr(" :- ")
			pp("")(y)
			putStr("\n")

pp(n) (Output x) = do putStr(n ++ "output ")
		      pp("")(x)
		      putStr("\n")

compound (_) ([]) = return ()
compound (n) (x:xs) = do pp(n)(x)
		         compound (n)(xs)

--symboltable append
sa::Expr -> Expr -> [(Expr,Expr)] -> [(Expr,Expr)]
sa(Var x) (Val y) ([]) = [(Var x, Val y)]
sa(Var x) (Val y) ((Var z,Val a):xs) = if (x == z) then (Var x,Val y):xs else (Var z,Val a):sa(Var x)(Val y)(xs)

--symboltable find
sf::Expr -> [(Expr,Expr)] -> Int
sf(_) ([]) = 0
sf(Var x) ((Var y,Val z):xs) = if (x == y) then z else sf(Var x)(xs)

--Pretty print the factorial program
factpp = pp "" (Compound([Assign (Var "n") (Val 5), Assign (Var "r") (Val 1), While(Morethan (Var "n") (Val 0)) (Compound([Assign (Var "r") (Mult (Var "r") (Var "n")), 
       Assign (Var "n") (Sub (Var "n") (Val 1))])), Output (Var "r")]))

--Execute to find the factorial of 5 (Symbol table produces a correct result with r being 120)
factex = exec (Compound([Assign (Var "n") (Val 5), Assign (Var "r") (Val 1), While(Morethan (Var "n") (Val 0)) (Compound([Assign (Var "r") (Mult (Var "r") (Var "n")), 
	Assign (Var "n") (Sub (Var "n") (Val 1))]))])) []

--Pretty print the fibonacci program
fibpp = pp "" (Compound([Assign(Var "i")(Val 1),Assign(Var "j")(Val 1),Assign(Var "k")(Val 20),
	While(Morethan(Var "k")(Val 0))(Compound([Assign(Var "l")(Sum(Var "i")(Var "j")),Assign(Var "i")(Var "j"),Assign(Var "j")(Var "l"),Assign(Var "k")(Sub(Var "k")(Val 1))])),
	Output(Var "j")]))

--Execute to find the 22nd fibonacci number (Symbol table produces a correct result with j being 17711)
fibex = exec (Compound([Assign(Var "i")(Val 1),Assign(Var "j")(Val 1),Assign(Var "k")(Val 20),
	While(Morethan(Var "k")(Val 0))(Compound([Assign(Var "l")(Sum(Var "i")(Var "j")),Assign(Var "i")(Var "j"),Assign(Var "j")(Var "l"),Assign(Var "k")(Sub(Var "k")(Val 1))]))])) []


