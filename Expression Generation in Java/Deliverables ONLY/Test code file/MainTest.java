//MainTest.java file by Tejas Menon, CS320, last edited on 10/9. This file contains interesting test cases
//to check for the accuracy of the abstraction for problem 1. This file uses junit4 library.

package com.hw1;

import org.junit.Test;

import static org.junit.Assert.*;

public class MainTest {
    @Test
    public void CheckDivError() {
        Add exp = new Add(new Val(2), new Mult(new Val(4), new Div(new Val(2), new Val(3))));
        assertEquals("Error Value", exp.val());
        assertEquals("(2+(4*(2/3)))", exp.exp());
    }
    @Test
    public void CheckAdditionNested() {
        Add exp1 = new Add(new Add(new Val(4), new Val(3)), new Add(new Val(2), new Val(3)));
        assertEquals("12", exp1.val());
        assertEquals("((4+3)+(2+3))", exp1.exp());
    }
    @Test
    public void CheckDivRegular() {
        Div exp2 = new Div(new Add(new Val(5), new Val(5)), new Add(new Val(3), new Val(2)));
        assertEquals("2", exp2.val());
        assertEquals("((5+5)/(3+2))", exp2.exp());
    }
    @Test
    public void CheckMultSimple() {
        Mult exp3 = new Mult(new Val(2), new Val(3));
        assertEquals("6", exp3.val());
        assertEquals("(2*3)", exp3.exp());
    }
    @Test
    public void CheckDivByZero() {
        Div exp4 = new Div(new Val(2), new Val(0));
        assertEquals("Error Value", exp4.val());
        assertEquals("(2/0)", exp4.exp());
    }
    @Test
    public void CheckComplexExpressionWithSubtraction() {
        Div exp5 = new Div(new Mult(new Val(5),new Sub(new Add(new Val(3),new Val(9)),new Val(2))),new Val(5));
        assertEquals("10",exp5.val());
        assertEquals("((5*((3+9)-2))/5)",exp5.exp());
    }
}