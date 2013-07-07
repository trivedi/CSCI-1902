// Program computes prime factorization for each given integer. Worst case complexity is O(n) for each individual input if input is prime.


import std.stdio, std.conv;

void main(string[] args) {
	
	// Goes through all integer input arguments and gives the prime factorization for each integer
	foreach(num; 1 .. args.length) {
			
	int	n = to!int(args[num]);
	
	int[] factors = new int[n];
	int[] exp = new int[n];
	int exp_count = 0;
	int divisor = 2;	// Start dividing as smallest prime
    int div_pos = 0;
    int exp_pos = 0;
    bool inArray = false; // Keeps track of whether current prime is already in array
	

    // If prime factor is already in array, increment exponent count, and divide n by the factor--if not in array, 
	// do the above and store factor in array.
	// This method prevents duplicate factors in the array making factor-exponent tuples easier to index.
	while (n > 1) {
		while (n % divisor == 0) {
            if (!inArray) {
			    factors[div_pos] = divisor;
			    n /= divisor;
			    ++exp_count;
                ++div_pos;
                inArray = true;
            }
            else {
                ++exp_count;
                n /= divisor;
		    }
        }
		exp[exp_pos] = exp_count;
		exp_count = 0;
		++divisor;
        ++exp_pos;
        inArray = false;
		}
    factors.length = div_pos;
    

    // Filter out zeros from exponent array
    int[] new_exp = new int[exp.length];
    exp_pos = 0;
	foreach(exponent; exp) {
		if (exponent != 0) {
            new_exp[exp_pos] = exponent;
            ++exp_pos;
        }
	}
    new_exp.length = exp_pos;


    // This loop formats the display of the factorization
    // Appends 'x', new line, and/or includes exponent based on the position of the current factor inside array
	writef("%s = ", args[num]);
	if (new_exp.length == 0) writeln(factors[0]);
    else
    foreach (exponent; 0 .. new_exp.length) {   
        if (exponent != new_exp.length - 1) {  
            if (new_exp[exponent] != 1) {
                writef("%s^%s x ", factors[exponent], new_exp[exponent]);
            }
            else writef("%s x ", factors[exponent]);
        }
        // Last factor to display
        else if (new_exp[exponent] != 1) { 
            writefln("%s^%s", factors[exponent], new_exp[exponent]);
        }
        else writefln("%s", factors[exponent]);
    }
}

}
