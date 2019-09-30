//Problem2.java implementation file by Tejas Menon, CS320, last edited 10/9. This file implements Problem2
//by creating an exp array that is gradually filled up with expressions of 'interest'. First we start with
//the basic operations with two ten's (4 ways) which is then permuted with another to create three ten's (32 ways) and finally
//with a fourth ten to create 256 expressions of interest. Then, we consider the last case that can create expressions
//of size 4 by permuting all ways the expressions with 2 ten's can combine with each other to create a total of 64 possibilities.
//In total, 256+64 = 320.

package com.hw1;

public class Problem2 {
    private Expr listof356[]; //4+32+256+64

    public Problem2() {
        listof356 = new Expr[356];

        //The 4 basic two ten operations
        listof356[0] = new Add(new Val(10), new Val(10));
        listof356[1] = new Sub(new Val(10), new Val(10));
        listof356[2] = new Mult(new Val(10), new Val(10));
        listof356[3] = new Div(new Val(10), new Val(10));

        this.compound(0, 4); //compounds listof356 with another ten
        this.compound(4, 36); //another 10
        this.compound2(292); //compounds differently for the 64 cases
        this.printfrom(36); //prints from 36 which is where all expressions of interest began
    }

    public void compound(int from, int to) {
        int addfrom = to;
        for (int i = from; i < to; ++i) {
            listof356[addfrom] = new Add(new Val(10), listof356[i]);
            ++addfrom;
            listof356[addfrom] = new Add(listof356[i], new Val(10));
            ++addfrom;
            listof356[addfrom] = new Sub(new Val(10), listof356[i]);
            ++addfrom;
            listof356[addfrom] = new Sub(listof356[i], new Val(10));
            ++addfrom;
            listof356[addfrom] = new Mult(new Val(10), listof356[i]);
            ++addfrom;
            listof356[addfrom] = new Mult(listof356[i], new Val(10));
            ++addfrom;
            listof356[addfrom] = new Div(new Val(10), listof356[i]);
            ++addfrom;
            listof356[addfrom] = new Div(listof356[i], new Val(10));
            ++addfrom;
        }

    }

    public void compound2(int from) {
        int addfrom = from;
        for (int i = 0; i < 4; ++i) {
            for (int j = 0; j < 4; ++j) {
                listof356[addfrom] = new Add(listof356[i], listof356[j]);
                ++addfrom;
                listof356[addfrom] = new Sub(listof356[i], listof356[j]);
                ++addfrom;
                listof356[addfrom] = new Mult(listof356[i], listof356[j]);
                ++addfrom;
                listof356[addfrom] = new Div(listof356[i], listof356[j]);
                ++addfrom;
            }
        }
    }

    public void printfrom(int from) {
        for (int i = from; i < 356; ++i) {
            String value = listof356[i].val();
            if(value != "Error Value" && Integer.parseInt(value) <= 9 && Integer.parseInt(value) >= 0) System.out.println(listof356[i].exp() + " = " + value + " ");
        }
    }
}

