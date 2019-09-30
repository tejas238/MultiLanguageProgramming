//If.java by Tejas Menon, CS32O, last edited 11/4. The If class provides functions for variable flow of control
//in the while language. Depending on the binary value of its expression operand, it executes either statement b or c.
//Note that it ecpects a MoreThan or LessThan expression operand as only they output binary values
package com.hw1;

public class If extends Statement{
    protected Expr a;
    protected Statement b;
    protected Statement c;

    public If(Expr a, Statement b, Statement c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public void pp(String indent) {
        System.out.print(indent + "if " + this.a.exp() + " then\n");
        this.b.pp(indent + "    ");
        System.out.print(indent + "else\n");
        this.c.pp(indent + "    ");
    }

    public void exec() {
        this.a.exec();
        if (this.a.val().equals("True")) this.b.exec();
        else this.c.exec();
    }
}
