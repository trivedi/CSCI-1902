import std.stdio, std.conv;


void main(string[] args) {
    long n1 = to!long(args[1]); // Starting value
    long n2 = to!long(args[2]); // Ending value
    long[] collatz_seq = [];

    if (n1 < n2) {			
        foreach (num; n1 .. n2) {
            collatz_seq ~= collatz(num, 1);	    // Append each Collatz sequence into array
        }

        long max = collatz_seq[0];

        foreach(i; 1 .. collatz_seq.length) {	// Go through entire array to find max value
            if (collatz_seq[i] > max) {
                max = collatz_seq[i];
            }
        }
        writeln(max);
    }
}


// Collatz function

long collatz(long n, int counter) {
    while (n > 1) {            
        counter += 1;                   
        if ((n % 2) == 0) return collatz((n / 2), counter);
        else return collatz(((n * 3) + 1), counter);
    }
        return counter; 
}
