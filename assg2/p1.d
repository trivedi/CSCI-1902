// Program computes average of all numbers inputted

import std.stdio;


void main() {
    double[] input = new double[10];
    int pos = 0;
    long sum = 0;
    while (!stdin.eof) {
        if (pos >= input.length) {
            input.length *= 2;      // Double the size of array if there's no room left
        }
        readf(" %s ", &input[pos]);
        ++pos;
    }

    
    input.length = pos; // Trims trailing zeros inside array
    
    foreach (x; input) {
        sum += x;       // Keeps running sum
    }
    writeln(sum / pos);
}
