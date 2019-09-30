//Compound.java by Tejas Menon, CS32O, last edited 11/4. The Compound class allows storage of an unlimited number of statements,
//executing them in order of storage within the array

package com.hw1;

public class Compound extends Statement {
   protected Statement array[];

   public Compound(Statement array[]) {
       this.array = array;
   }

   public void pp(String indent) {
       System.out.print(indent + "begin\n");
       for(int i = 0; i<array.length; ++i) {
           array[i].pp(indent + "   ");
       }
       System.out.print(indent + "end\n");
   }

   public void exec() {
       for(int i = 0; i<array.length; ++i) {
           array[i].exec();
       }
   }
}
