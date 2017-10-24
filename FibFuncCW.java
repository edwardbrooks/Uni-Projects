package rcw;

import java.util.Scanner;
import java.util.function.IntSupplier;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class FibFuncCW {
    public static void main(String args[]) {
    	
    	/**
    	 * Scanner Code
    	 * 
    	 * Following code implements the Scanner/User input of two numbers that set the range for the 
    	 * un-filtered stream of fibonacci numbers
    	 * 
    	 * An 'if' statement is in the code to check whether the user input is valid, i.e. if the user input is an int. If not, the
    	 * program will exit and print a message explaining what went wrong.
    	 * 
    	 * The user can either enter the values in one go in one line (e.g. "32 400", or one by one)
    	 * 
    	 */
    	final int max = 2; //Only two numbers to be entered (a min and a max)
		IntSupplier getNums = new IntSupplier() {
			 int next = 1;
			 Scanner inp = new Scanner(System.in);
		 	 @Override
		 	 public int getAsInt() {
		 		 System.out.printf("Enter a number (%d/%d)", next, max); //Prints as "Enter a number (1/2)"
		 		 next++;
		 		 if(inp.hasNextInt()){
		 			 //All Ok!, User input was a valid 'int'
		 		 } else {
		 			 System.out.println("Sorry, your input wasn't recognised as an \"int\" value, please try again! (Please remove any non-digit/space characters!)"); //Code to check user input, if it is not a valid 'int' the program will terminate
		 			 System.exit(0);
		 		 }
		 		return inp.nextInt();
		 	 }
		 };
		
		final int[] vals = IntStream.generate(getNums).limit(max).sorted().toArray(); //Runs the code above to prompt the user and 'generate' the two numbers, sorting them and then storing them in an array. The sorting means that the user
																					  //can enter the min/max number in any order, and the program will take the correct values for each.
		 
		 
		/**
		 * TEST CODE
		 * Echo's back the numbers entered by the user, these two lines of code were originally used to test/debug the application.
		 */
		 //System.out.println("The two numbers are: ");
		 //IntStream.of(vals).forEach(n ->System.out.print(n + " " + '\n'));
		 
		 /**
		  * Fibonacci Sequence Code
		  * 
		  * The following line generates an un-filtered, uncapped stream of numbers that make up the Fibonacci sequence starting from 1.
		  * Starting with an array of the first two values in the sequence (1 and 1), the stream then iterates infinitely by creating a new int value from the previous two (sum of both)
		  */
		 IntStream fibo = Stream.iterate(new int[] {1, 1}, fib -> new int[] {fib[1], fib[0] + fib[1]}).mapToInt(fib -> fib[0]);
		 
		 /**
		  * The last line of code takes the IntStream created above of the fibonacci sequence and then limits and filters it using the user given numbers.
		  * The limit being 47 is due to the 47th number in the fibonacci sequence being a number greater than the upper limit of an valid int value (i.e. INTEGER.MAX)
		  * By limiting this to 47, it means that all possible int values are calculated and available to be filtered, as after this the fibonacci sequence numbers would not be correct.
		  * 
		  * The filter then takes every number in the stream and checks that its is both less than the max user number and greater than the minimum user limit. Finally, the program prints 
		  * the now filtered stream of ints to the console.
		  */
		 fibo.limit(47).filter(n -> n >= vals[0] && n <= vals[1]).forEach(n ->System.out.print(n + " "));
		 
	}
}

