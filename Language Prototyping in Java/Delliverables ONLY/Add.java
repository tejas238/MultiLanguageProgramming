//Add.java file by Tejas Menon, CS320, last edited 11/4. The Add class performs addition
//on the expression values of its operands and stores its result in i. Then, it concatenates the string
//expression in a to b and stores this in exp. It also accesses the symbol table if one or more of its
//operands is a variable, and stores within it the result of the operation.

package com.hw1;

public class Add extends Expr {

    protected Expr a;
    protected Expr b;

    Add(Expr a, Expr b) {
        this.a = a;
        this.b = b;
        this.isrel = false;
        this.var = false;
        this.exp = ("(" + a.exp + "+" + b.exp + ")");
    }

    public void exec() {
        a.exec();
        b.exec();

        if (a.var) a.error = map.get(((Var) a).exp).equals("Error Value");
        if (b.var) b.error = map.get(((Var) b).exp).equals("Error Value");
        if (a.var && !a.error) a.i = Integer.parseInt(map.get(((Var) a).exp));
        if (b.var && !b.error) b.i = Integer.parseInt(map.get(((Var) b).exp));

        this.error = a.error || b.error; //if either operand has an error, then inherit it
        float check = (float) a.i + (float) b.i; //val() not used as it returns a string (for error value)
        if (check != (int) check) this.error = true; //decimal and undefined values (+-inf) sets error to true
        this.i = (int) check;
    }
}
