//Output.java by Tejas Menon, CS320, last edited 11/4. The Output class prints either its description of its use or the value of
//the variable it contains as interpreted by the symbol table. It assumes that the variable it looks for within the table is present
package com.hw1;

public class Output extends Statement {
    protected Var a;

    public Output(Var a) {
        this.a = a;
    }

    public void pp(String indent) {
       System.out.println(indent + "Output " + this.a.exp());
    }

    public void exec() {
        System.out.println(this.a.exp() + " = " + Expr.map.get(this.a.exp()));
    }
}
