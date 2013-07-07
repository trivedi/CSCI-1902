import std.stdio, std.conv, std.string, std.exception;


// A class for creating and operating on rational numbers
class Rat {

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

    override string toString() {
       auto n = to!string(n);
       auto d = to!string(d);
	   if (d == "1") return n;
	   else if (n == "0") return n;
       else return n ~ "/" ~ d;
    }


	// Takes in a Rat object and returns the sum
    auto plus(Rat r) {
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
    auto minus(Rat r) {
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
    auto times(Rat r) {
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
    auto divide(Rat r) {
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

