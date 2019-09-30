//Main.java file for HW5 by Tejas Menon, CS320, last edited 11/4. This file contains the program iayout of two potential
//"while language" programs, one finding the factorial of 5 and the other calculating the 22nd fibonacci number.

package com.hw1;
import java.util.HashMap; //for the symbol table

public class Main {

    public static void main(String[] args) {
        new Main().exec_factorial();
        new Main().exec_fibonacci();
    }

    public void exec_factorial() {
        Expr.map = new HashMap<String, String>();
        Assign one = new Assign(new Var("n"),new Val(5));
        Assign two = new Assign(new Var("r"), new Val(1));
        MoreThan three = new MoreThan(new Var("n"), new Val(0));
        Assign four = new Assign(new Var("r"), new Mult(new Var("r"), new Var("n")));
        Assign five = new Assign(new Var("n"), new Sub(new Var("n"), new Val(1)));
        Statement six [] = {four,five};
        While seven = new While(three,new Compound(six));
        Output eight = new Output(new Var("r"));
        Statement nine [] = {one,two,seven,eight};
        Compound factorial = new Compound(nine);

        System.out.println("Factorial Pretty Print:\n");
        factorial.pp(""); //begin with no indentation
        System.out.println("\nFactorial Execution:\n");
        factorial.exec();
    }

    public void exec_fibonacci() {
        Expr.map = new HashMap<String,String>();
        Assign one = new Assign(new Var("i"), new Val(1));
        Assign two = new Assign(new Var("j"), new Val(1));
        Assign three = new Assign(new Var("k"), new Val(20));
        MoreThan four = new MoreThan(new Var("k"), new Val(0));
        Assign five = new Assign(new Var("l"), new Add(new Var("i"),new Var("j")));
        Assign six = new Assign(new Var("i"), new Var("j"));
        Assign seven = new Assign(new Var("j"), new Var("l"));
        Assign eight = new Assign(new Var("k"), new Sub(new Var("k"), new Val(1)));
        Statement nine [] = {five,six,seven,eight};
        Statement ten [] = {one,two,three,new While(four,new Compound(nine)),new Output(new Var("j"))};
        Compound fibonacci_22nd = new Compound(ten);

        System.out.println("\n22nd Fibonacci Pretty Print\n");
        fibonacci_22nd.pp("");
        System.out.println("\n22nd Fibonacci Execution\n");
        fibonacci_22nd.exec();
    }
}


