import std.stdio, p1;

void main() {
    Rat a = Rat(6, 12); // .5
    Rat b = Rat(3, 12); //  .25
	Rat c = Rat(-7, 8);
	writeln(a);
    writeln(a + b);
    writeln(a * b);
	writeln(a / b);
	writeln(a - b);
	writeln(a > b);
	writeln(a < b);
	writeln(a >= b);
	writeln(a <= b);
	writeln(a == b);
	writeln(a != b);
	writeln(-a);
	writeln(-c);
}
