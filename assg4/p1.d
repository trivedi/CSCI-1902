import std.stdio, std.conv, std.string, std.exception;


// A class for creating and operating on rational numbers
struct Rat {

    private long n, d; // Numerator and Denominator

    this(long numerator, long denominator) {
		enforce(denominator != 0, "Error: Denominator cannot be zero");
       
	   // Keep the invariant == 1 by using Euclid's GCD algorithm
       while (gcd(numerator, denominator) != 1) {
           auto gcd = gcd(numerator, denominator);
           numerator /= gcd;
           denominator /= gcd;
       }
	   
		if (denominator < 0) {
			numerator = -1 * numerator;
			denominator = -1 * denominator;
		}
		
        n = numerator;
        d = denominator;
    }

	string toString() {
       auto n = to!string(n);
       auto d = to!string(d);
	   if (d == "1") return n;
	   else if (n == "0") return n;
       else return n ~ "/" ~ d;
    }
	

	// Comparison Operators
	auto opCmp(Rat r) {
		double n = to!double(n);
		double d = to!double(d);
		
		if (n/d > r.n/r.d) return 1;	// this > other
		else if (n/d < r.n/r.d) return -1;  // this < other
		else return 0;    // >=, <=, ==
	}
	
	
	
	// Unary operator '-' by operator overloading
	Rat opUnary(string op)() if (op == "-") {
		long num = -n;
		return Rat(num, d);
	}

	// Takes in a Rat object and returns the sum
    auto opBinary(string op)(Rat r) if (op == "+") {
        auto num = n*r.d + d*r.n;
        auto denom = d * r.d;
        while(gcd(num, denom) != 1) {
            auto gcd = gcd(num, denom);
            num /= gcd;
            denom /= gcd;
        }
		if (num == 0) return format("%s", num);
		else if (denom == 1) return format("%s", num);
        else return format("%s/%s",num, denom);	
    }


	// Takes in a Rat object and returns the difference
    auto opBinary(string op)(Rat r) if (op == "-") {
        auto num = (n*r.d) - (d*r.n);
        auto denom = d * r.d;
        while(gcd(num, denom) != 1) {
            auto gcd = gcd(num, denom);
            num /= gcd;
            denom /= gcd;
        }
		if (num == 0) return format("%s", num);
		else if (denom == 1) return format("%s", num);
        else return format("%s/%s",num, denom);
    } 


	// Takes in a Rat object and returns the product
    auto opBinary(string op)(Rat r) if (op == "*") {
        auto num = n * r.n;
        auto denom = d * r.d;
        while(gcd(num, denom) != 1) {
            auto gcd = gcd(num, denom);
            num /= gcd;
            denom /= gcd;
        }
		if (num == 0) return format("%s", num);
		else if (denom == 1) return format("%s", num);
        else return format("%s/%s",num, denom);
    }


	// Takes in a Rat object and returns the quotient
    auto opBinary(string op)(Rat r) if (op == "/") {
        enforce(r.n != 0, "Error: Attempted to divide by zero");
        auto num = n * r.d;
        auto denom = d * r.n;
        while(gcd(num, denom) != 1) {
            auto gcd = gcd(num, denom);
            num /= gcd;
            denom /= gcd;
        }
		if (num == 0) return format("%s", num);
		else if (denom == 1) return format("%s", num);
        else return format("%s/%s",num, denom);
    }

}



// Recursive implementation of Euclid's GCD algorithm
long gcd(long a, long b) { 

    if (b == 0) return a;
    else return gcd(b, a % b);
}

