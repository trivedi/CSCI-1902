import std.stdio, std.conv, std.math;


void main(string[] args) {

    auto n = to!long(args[1]);

    double[] list = new double[50]; 
   
	if (n < 2) writeln(n, " is not a prime");
    // Populates array from 2 to inclusive n
    int pos = 0;
    foreach(x; 2 .. n+1) {  
        if (pos >= list.length) list.length *= 2;
        list[pos] =  x;          
        ++pos;
    }   
    list.length = pos;
  
    
   // Sieve of Eratosthenes
    foreach (p; 0 .. list.length) {
		if (list[p] < sqrt(cast(float)n)) {  // Continue sieving as long as our current number < sqrt(n)
        	if (list[p] != 0) {             
            	double value = list[p];
            	double count = 1;
           	 	while ( p+count*value <= list.length - 1) {
               	 	list[to!int(p+count*value)] = 0;
                	++count;
            }
        }
    }
}    

  	// Remove zeros from our array of prime
    double[] primes = new double[list.length];
    int primes_pos = 0;
    foreach (num; list) {
        if (primes_pos >= primes.length) primes.length *= 2;
        if (num != 0) {
            primes[primes_pos] = num;
            ++primes_pos;
        }
    }
    primes.length = primes_pos;

	
	// Divide each n by each prime
    foreach(prime; primes) {
        if (n % prime == 0 && n != prime) {
            writefln("%s is not a prime", n);
            break;
        }
        else if (prime == primes[primes.length - 1]) {  // We traversed the entire array--would be faster if you break out of loop if n == prime, but I interpreted the problem as wanting to divide by each of the primes 
            writefln("%s is a prime", n);
        }
    }
}
