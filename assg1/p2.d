import std.stdio, std.conv;


void main(string[] args) {

    long[] fib_seq = [0, 1];              // Array fib_seq will contain the Fibonacci sequence
    long n = to!long(args[1]);

    foreach(i; 2 .. n+1) {
        fib_seq ~= fib_seq[i - 1] + fib_seq[i - 2];   // Add the next Fibonacci number to the array
    }

    writeln(fib_seq[n]);
}
