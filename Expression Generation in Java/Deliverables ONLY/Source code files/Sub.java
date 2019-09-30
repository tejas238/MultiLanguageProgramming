//Sub.java file by Tejas Menon, CS320, last edited 10/9. The Mult class performs subtraction
//on the expression values of its operands and stores its result in i. Then, it concatenates the string
//expression in a to b and stores this in exp.

package com.hw1;

public class Sub extends Expr {
    Sub(Expr a, Expr b) {
        this.error = a.error || b.error; //if either operand has an error, then inherit it
        float check = (float) a.i - (float) b.i; //val() not used as it returns a string (for error value)
        if (check != (int) check) this.error = true; //decimal and undefined values (+-inf) sets error to true
        this.i = (int) check;
        this.exp = ("(" + a.exp + "-" + b.exp + ")");
    }
}
