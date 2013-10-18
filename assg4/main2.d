import std.stdio, p2;

void main() {
    
    Rect a = Rect(0, 10, 0, -10);
    Rect b = Rect(-4, 6, -4, -16);
	Rect c = Rect(10, 20, 10, 0);
	Rect d1 = Rect(0,2, 2, 0);
	Rect d2 = Rect(0, 3, 3, 0);

	writeln(d1 == d2);
	writeln(a != c);

    writeln(a);
    writeln(b);

    //sum
    writeln(a | b);
    writeln(a & b);
   writeln(a == b);
  writeln(a != b);
   writeln(a > b); // false
  writeln(a < b); // false
   writeln(a >= b);  // ASK ABOUT THESE
   writeln(a <= b);   // ASK ABOUT THESE
   overlap(a, b);
   overlap(b, a);
   writeln(d1 >= d2);
   writeln(d1 <= d2);
	writeln(a == c);
	writeln(a != c);
}
