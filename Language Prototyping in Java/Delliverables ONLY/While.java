//While.java by Tejas Menon, CS32O, last edited 11/4. The While class executes its statement body for as long
//as the expression is true. It assumes that the expression operand provided to it is relational and will give
//undesirable results if other expression types are inputted to it
package com.hw1;

public class While extends Statement{
    protected Expr a;
    protected Statement b;

    public While(Expr a, Statement b) {
        this.a = a;
        this.b = b;
    }

    public void pp(String indent) {
        System.out.print(indent + "While " + a.exp() + " do\n");
        b.pp(indent + "    "); //execute pretty print with the current plus 'tab' indentation provided to it
    }

    public void exec() {
        this.a.exec();
        while(this.a.val().equals("True")) {
            this.b.exec();
            this.a.exec(); //update expression result upon statement execution
        }
    }
}
