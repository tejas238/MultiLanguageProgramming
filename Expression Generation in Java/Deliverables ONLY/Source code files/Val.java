//Val.java implementation by Tejas Menon, CS320, last edited on 10/9. The Val subclass of Expr
//configures all integers added into this expression system to be modified by other subclasses of Expr.
package com.hw1;

public class Val extends Expr {
    Val(int i) {
       this.i = i;
       this.exp = Integer.toString(i); //Used in printing expression
    }
}
