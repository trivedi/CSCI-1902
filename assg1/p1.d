import std.stdio, std.conv;


void main(string[] args) {
    auto num = to!long(args[1]);
    writeln(fib(num));
}


// Recursive algorithm to find Fibonacci number
long fib(long n) {
    if (n == 0 || n == 1) {
        return n;
    }
    else {
        return fib(n - 1) + fib(n - 2);   // Recursive formula to find next Fibonacci number
    }
}
