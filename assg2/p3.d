// Program takes in a stream of integers from stdin and outputs whether each are prime or not

import std.stdio;


void main(string[] args) {
    
    int[] input = new int[10];

    int[] primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41,  // All primes < 100
                    43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97];

    int pos = 0;
    while (!stdin.eof) {
        if (pos >= input.length) {
            input.length *= 2;
        }
        readf(" %s ", &input[pos]);
        ++pos;
    }

    input.length = pos;

    foreach(num; input) {
        foreach (prime; primes) {
            if (num < 2 || num % prime == 0 && num != prime) {    // If the number is less than 2 or the remainder between itself and a prime is 0 and they're not identical, 
                writefln("%s is not a prime", num);                // than this number is not a prime             
                break;
            }
            else if (prime == primes[primes.length - 1]) {   // If this number is in our array of known primes or we've gone
                writefln("%s is a prime", num);                              // through all the numbers, than this number must be a prime
                break;
            }
        }
    }
}

