import std.stdio, std.conv;


void main(string[] args) {
    long count = 1l
    auto num = to!long(args[1]);
    writeln(collatz(num, count));
}



// Collatz function

long collatz(long n, long counter) {
    while (n > 1) {            
        counter += 1;                                   // Keep incrementing the count because we haven't reached n = 1
        if (n % 2 == 0) return collatz(n / 2, counter);
        else return collatz((n * 3) + 1, counter);    
    }

    return counter;
}
