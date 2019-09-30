//Expr.java implementation by Tejas Menon, CS320, last edited 11/4. The abstract class Expr contains functions to
//retrieve the value and expression string generated upon creation of the concrete classes.
package com.hw1;

import java.util.Map;

abstract public class Expr {
    protected int i;
    protected String exp;
    protected boolean error;
    protected boolean var;
    protected boolean isrel;
    protected boolean relval;
    static protected Map <String,String> map;

    Expr() {
        this.error = false;
        this.i = 0;
    }

    abstract public void exec();

    public String val() {
        if (this.error) return("Error Value");
        if (this.isrel && this.relval) return("True");
        if (this.isrel && !this.relval) return("False");
        else return(Integer.toString(i));
    }
    public String exp() {
        return(this.exp);
    }
}

