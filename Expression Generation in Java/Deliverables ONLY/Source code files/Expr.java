//Expr.java implementation by Tejas Menon, CS320, last edited 10/9. The abstract class Expr contains functions to
//retrieve the value and expression string generated upon creation of the concrete classes.
package com.hw1;

abstract public class Expr {
    protected int i;
    protected String exp;
    protected boolean error;
    Expr() {
        this.error = false;
        this.i = 0;
    }
    public String val() {
        if (this.error) return("Error Value");
        else return(Integer.toString(i));
    }
    public String exp() {
        return(this.exp);
    }
}

