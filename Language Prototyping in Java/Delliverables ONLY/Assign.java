//Assign.java implementation by Tejas Menon, CS320, last edited 11/4. The class Assign takes the value of
//its second operand and assigns it to the variable on the left, modifying the symbol table in the process.
//In the case of needing to assign one variable to another, this class also reads the symbol table always expecting
//the corresponding symbol to be present in the table
package com.hw1;

public class Assign extends Statement{
    protected Var x;
    protected Expr y;

    public Assign(Var x, Expr y) {
        this.x = x;
        this.y = y;
    }

    public void pp(String indent) {
       System.out.println(indent + this.x.exp() + " := " + this.y.exp());
    }

    public void exec() {
        this.y.exec();
        String var;
        if (this.y.var) var = Expr.map.get(this.y.exp());
        else var = this.y.val();
        Expr.map.put(this.x.exp(),var);
    }
}
