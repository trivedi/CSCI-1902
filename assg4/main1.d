import std.stdio, p1;

void main() {
    Rat a = Rat(6, 12); // .5
    Rat b = Rat(1, 2); //  .25
	Rat c = Rat(-1, 2);
	Rat d = Rat(1, -2);
	writeln(a);
    writeln(d + b);
    writeln(d - c);
	writeln(c / b);
	writeln(b / d);
	writeln(c / d);
	writeln(a < b);
	writeln(a >= b);
	writeln(a <= b);
	writeln(a == b);
	writeln(a != b);
	writeln(-a);
	writeln(-c);
	writeln(a == Rat(10, 20));
}
