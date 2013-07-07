// Program takes in command-line argument and uses the Sieve of Eratosthenes to find all primes less than inputted value

import std.stdio, std.conv;


void main(string[] args) {

    auto n = to!int(args[1]);
    int[] list = new int[50];
    
    
    // Populates array from 2 to n
    int pos = 0;
    foreach(x; 2 .. n) {  
        if (pos >= list.length) list.length *= 2;
        list[pos] = x;         
        ++pos;
    }   

    list.length = pos;


    // Sieve of Eratosthenes
    foreach (p; 0 .. list.length) {
        if (list[p] != 0) {        // zeros are ruled out be primes, so no need to sieve
            int value = list[p];
            int count = 1;
            while ( p+count*value <= list.length - 1) {
                list[p+count*value] = 0;        // Overwrite all multiples of current number to 0
                ++count;
            }
        }
    }


    // Display only primes
    foreach (prime; list) {
        if (prime != 0) writeln(prime);
    }

}
