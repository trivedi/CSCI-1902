// Program sorts the numbers inputted

import std.stdio;


void main() {
    double[] input = new double[10];
    int pos = 0;
    while (!stdin.eof) {
        if (pos >= input.length) {
            input.length *= 2;          // Double array size if there's no room left for storage
        }
        readf(" %s ", &input[pos]);
        ++pos;
    }

    input.length = pos;
    foreach(x; input.sort) {        // Outputs a number per line in increasing order
        writeln(x);
    }

}
