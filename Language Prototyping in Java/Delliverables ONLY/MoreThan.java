//MoreThan.java implementation by Tejas Menon, CS320, last edited 11/4. The class MoreThan compares the
//value of two expressions and stores within it the result. It inherits any errors from its operands and
//accesses the symbol table to find variable bindings if executed
package com.hw1;

public class MoreThan extends Expr{
    protected Expr a;
    protected Expr b;

    MoreThan(Expr a, Expr b) {
        this.a = a;
        this.b = b;
        this.isrel = true; //a relational class
        this.var = false; //not a variable
        this.exp = ("(" + a.exp + ">" + b.exp + ")"); //creates its expression upon initialization
    }

    public void exec() {
        a.exec(); //executes its operands before using it
        b.exec();

        //variable operand cases
        if (a.var) a.error = map.get(((Var) a).exp).equals("Error Value");
        if (b.var) b.error = map.get(((Var) b).exp).equals("Error Value");
        if (a.var && !a.error) a.i = Integer.parseInt(map.get(((Var) a).exp));
        if (b.var && !b.error) b.i = Integer.parseInt(map.get(((Var) b).exp));

        this.error = a.error || b.error; //if either operand has an error, then inherit it
        this.relval = a.i > b.i;
    }
}
