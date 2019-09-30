//Var.java by Tejas Menon, CS320, last edited 11/4. The Var class initializes all variables in the While language
//storing its identifying string within it.
package com.hw1;

public class Var extends Expr {
    Var(String i) {
       this.exp = i;
       this.var = true;
       this.isrel = false; //not a relational expression
    }
    public void exec() {}
}

