--Problem1.hs by Tejas Menon, CS320, last edited 10/21. This file contains expression generator functions
--that allow creation of expressions satisfying integer output and non-invalid evaluations

module Problem1
where

data Expr =  Errorval |Val Float| Exp String deriving Show --The Expr type includes all these definitions

add :: Expr -> Expr -> Expr
add (Val x) (Val y) = Val (x+y)
add Errorval (_) = Errorval
add (_) Errorval = Errorval

--'p' affixed functions to create string output
addp :: Expr -> Expr -> Expr
addp (Exp x) (Exp y) = Exp ("(" ++ x ++ " + " ++ y ++ ")") 

sub :: Expr -> Expr -> Expr
sub (Val x) (Val y) = Val (x-y)
sub Errorval (_) = Errorval
sub (_) Errorval = Errorval

subp :: Expr -> Expr -> Expr
subp (Exp x) (Exp y) = Exp ("(" ++ x ++ " - " ++ y ++ ")")

mult :: Expr -> Expr -> Expr
mult (Val x) (Val y) = Val (x*y)
mult Errorval (_) = Errorval
mult (_) Errorval = Errorval

multp :: Expr -> Expr -> Expr
multp (Exp x) (Exp y) = Exp ("(" ++ x ++ " * " ++ y ++ ")")

--'div' name is already taken
divi :: Expr -> Expr -> Expr
isInt x = x == fromInteger (round x) --fromInteger converts an integer to any type
divi (Val x) (Val y) = if y==0 then Errorval else if isInt (x/y) then Val (x/y) else Errorval
divi Errorval (_) = Errorval
divi (_) Errorval = Errorval

divip :: Expr -> Expr -> Expr
divip (Exp x) (Exp y) = Exp ("(" ++ x ++ " / " ++ y ++ ")")

--transfer a tuple (Exp,Val) to readable string output
transfer :: (Expr,Expr) -> String
transfer (Exp a, Val b) = a ++ " = " ++ show (b)
transfer (Exp a, Errorval) = a ++ " = " ++ "Errorval"

printoneperline (x:y) = do putStrLn (transfer x) 
			   printoneperline y
printoneperline [] = return ()

--Example expressions
main = printoneperline [(addp (subp (Exp "5") (Exp "3")) (Exp "50"), add (sub (Val 5) (Val 3)) (Val 50)), (multp (Exp "6") (Exp "2"), mult (Val 6) (Val 2)), (divip (Exp "3")(Exp "2"), divi (Val 3) (Val 2))]

