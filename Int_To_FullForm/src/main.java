public class main {
    public static void main(String[] args) {
        make_num();
        System.out.println(numparse(10050));
    }

    static public String arr[];

    static public void make_num() {
        arr = new String[31];
        arr[0] = "zero";
        arr[1] = "one";
        arr[2] = "two";
        arr[3] = "three";
        arr[4] = "four";
        arr[5] = "five";
        arr[6] = "six";
        arr[7] = "seven";
        arr[8] = "eight";
        arr[9] = "nine";
        arr[10] = "ten";
        arr[11] = "eleven";
        arr[12] = "twelve";
        arr[13] = "thirteen";
        arr[14] = "fourteen";
        arr[15] = "fifteen";
        arr[16] = "sixteen";
        arr[17] = "seventeen";
        arr[18] = "eighteen";
        arr[19] = "nineteen";
        arr[20] = "twenty";
    }

    static public String lookup(int number) {
        if (number == 30) return "thirty";
        if (number == 40) return "forty";
        if (number == 50) return "fifty";
        if (number == 60) return "sixty";
        if (number == 70) return "seventy";
        if (number == 80) return "eighty";
        if (number == 90) return "ninety";
        if (number == 100) return "hundred";
        if (number == 1000) return "thousand";
        if (number == 1000000) return "million";

        else if(number < 21) return arr[number];
        return "";
    }

    static public String numparse(int number) {
        if (number == 0) return lookup(0);
        int modded, count = 1;
        int rest = number;
        String output = "";
        do {
            modded = rest%1000;
            rest = (rest-modded)/1000;
            if (count == 1) output = hundreds(modded);
            else if (modded == 0) output = hundreds(modded) + " " + output;
            else output = hundreds(modded) + " " + lookup(count) + " " + output;
            count *= 1000;
        }
        while(rest != 0);
        return output;
    }


    static public String tens(int number) {
        if (number==0) return "";
        int modded = number%10;
        int diff = number-modded;
        String output;
        if ((number > 10) && (number < 20)) return lookup(number);
        else if (modded == 0) output = lookup(diff);
        else if (diff == 0) output = lookup(modded);
        else output = lookup(diff) + " " + lookup(modded);
        return output;
    }

    static public String hundreds(int number) {
       int modded = number%100;
       int diff = (number-modded)/100;
       if (number==0 || diff==0) return tens(modded);
       else return (lookup(diff) + " hundred " + tens(modded));
    }

}
