import std.stdio, std.conv;


void main(string[] args) {
    auto num = to!long(args[1]);
    writeln(collatz(num));
}


// Collatz function
long collatz(long n) {
    while (n > 1) {                 // Keep displaying n and apply operations while n > 1
        writeln(n);     
        if (n % 2 == 0) return collatz(n / 2);
        else return collatz((n * 3) + 1);
    }
    return n;                       // We're finished, n == 1
}
