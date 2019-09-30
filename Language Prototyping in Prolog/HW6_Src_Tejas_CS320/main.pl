indent([]) :- true.
indent([H|T]) :- write(H), indent(T). 

pp(N,assign(A,B)) :- indent(N), pp(A), write(" := "), pp(B), nl.
pp(N,while(A,B)) :- indent(N), write("while "), pp(A), write(" do"), nl,
			       append(N,["    "],C), pp(C,B).

pp(N,compound(T)) :- indent(N), append(N,["    "],C), write("begin"), nl, pp(C,compound1(T)),
		     indent(N), write("end"), nl.

pp(_,compound1([])) :- true.
pp(N,compound1([H|T])) :- pp(N,H), pp(N,compound1(T)).

pp(N,if(A,S,S2)) :- indent(N), append(N,["    "],C), write("if "), pp(A), write(" then"), nl,
		    pp(C,S), indent(N), write("else"), nl, pp(C,S2).

pp(N,output(A)) :- indent(N), write("output "), pp(A), nl.  

pp(add(A,B)) :- write("("), pp(A), write("+"), pp(B), write(")").
pp(sub(A,B)) :- write("("), pp(A), write("-"), pp(B), write(")").
pp(mult(A,B)) :- write("("), pp(A), write("*"), pp(B), write(")").
pp(div(A,B)) :- write("("), pp(A), write("/"), pp(B), write(")").
pp(lessthan(A,B)) :- write("("), pp(A), write("<"), pp(B), write(")").
pp(morethan(A,B)) :- write("("), pp(A), write(">"), pp(B), write(")").
pp(A) :- write(A).

sa(Var,Val,[],TO) :- TO = [[Var,Val]].
sa(Var,Val,[[Var1,_]|T1],[[Var2,Val2]|T2]) :- Var = Var1, Var2 = Var, Val2 is Val, sac(T1,T2).
sa(Var,Val,[[Var1,Val1]|T1],[[Var2,Val2]|T2]) :- Var2 = Var1, Val2 = Val1, sa(Var,Val,T1,T2).

sac([],[]) :- true.
sac([[Var1,Val1]|T1],[[Var2,Val2]|T2]) :- Var2 = Var1, Val2 = Val1, sac(T1,T2).

sf(_,_,[]) :- true.
sf(Var,Val,[[Var1,Val1]|_]) :- Var = Var1, Val = Val1.
sf(Var,Val,[_|T]) :- sf(Var,Val,T).

ex(assign(A,B),S,SO) :- ex(B,Z,S), sa(A,Z,S,SO).

ex(if(A,B,_),S,SO) :- ex(A,Z,S), Z = 1, ex(B,S,SO).
ex(if(_,_,C),S,SO) :- ex(C,S,SO).

ex(compound([]),S,SO) :- SO = S.
ex(compound([H|T]),S,SO) :- ex(H,S,S1), ex(compound(T),S1,SO).

ex(while(A,B),S,SO) :- ex(A,Z,S), Z = 1, ex(B,S,S1), ex(while(A,B),S1,SO).
ex(while(_,_),S,SO) :- SO = S.

ex(output(A),S,SO) :- pp(A), write(" = "), ex(A,Z,S), pp(Z), SO = S, nl.

ex(add(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), Z is C+D.
ex(sub(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), Z is C-D.
ex(mult(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), Z is C*D.
ex(div(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), Z is C/D.
ex(lessthan(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), C<D, Z is 1.
ex(lessthan(_,_),Z,_) :- Z is 0.
ex(morethan(A,B),Z,S) :- ex(A,C,S), ex(B,D,S), C>D, Z is 1.
ex(morethan(_,_),Z,_) :- Z is 0.
ex(A,C,_) :- integer(A), C is A.
ex(A,C,S) :- sf(A,C,S).

test1 :- pp([""],while(lessthan(a,b),if(lessthan(a,2),compound([assign(a,mult(a,5)),assign(b,add(b,mult(2,3)))]),compound([assign(a,3),assign(b,4)])))).	    
test2 :- pp([""],while(lessthan(b,a),compound([assign(a,2),assign(b,2),compound([assign(a,3),assign(b,div(b,4))])]))).
test3 :- pp([""],while(lessthan(a,b),compound([assign(a,2),assign(b,2)]))).
test4 :- pp([""],while(lessthan(a,b),if(morethan(a,2),compound([assign(a,2),assign(b,2)]),compound([assign(a,3),assign(b,4),output(b)])))).

test5 :- sa(a,5,TL,TO), write(TO), nl, sa(a,3,TO,T1), write(T1), nl, sa(a,4,T1,T2), write(T2), nl, sa(b,2,T2,T3), write(T3), nl, sa(a,24,T3,T4), write(T4),
	 nl,sf(a,Val,T4), write(Val), nl.

test6 :- ex(compound([assign(n,5),assign(r,1),
	 while(morethan(n,0),compound([assign(r,mult(r,n)),assign(n,sub(n,1))])),
	 output(r)]),S,SO).

