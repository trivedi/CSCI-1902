import std.stdio, std.conv;


class Set(T) {

	T[T] set;

	// Constructor
	this(T...)(T x) {
		foreach (element; x) {
			insert(element);	// Uses insert method to add initial elements
		}
	}
	
	
	
	// Checks if x is in set
	bool member(T x) {
		if (x in set) return true;
		else return false;
	}
	
	// Adds x to set
	void insert(T x) {
		set[x] = x;
	}
	
	
	// Removes x from set
	void remove(T x) {
		if (member(x)) set.remove(x);
		else writefln("Error: Cannot remove element '%s'--not present in set", x);
	}
	
	// Returns the intersection of this set and other set
	// (s1 & s2)
	Set!T opBinary(string op)(Set!T other) if (op == "&") {
		Set!T intersection = new Set!T;
		
		foreach (elem; other.set) {
			if (member(elem)) intersection.insert(elem);  
		}
		
		return intersection;
	}
	
	// Returns the union of this set and other set
	Set!T opBinary(string op)(Set!T other) if (op == "|") {
		Set!T u = new Set!T;
		
		foreach (elem; set) {
			u.insert(elem);
		}
		foreach(elem; other.set) {
			u.insert(elem);
		}
		
		return u;
	}
	
	// Complement
	// s1 - s2
	Set!T opBinary(string op)(Set!T other) if (op == "-") {
		Set!T c = new Set!T;
		
		foreach (elem; set) {
			if (!other.member(elem)) c.insert(elem);
		}
		
		return c;
	}
	
	

	
	// Returns in the format {elem1, elem2, elem3, ... } in sorted order
	override string toString() {
		
		auto setLength = set.length;
		auto setString = "{";
		foreach(value; set.values.sort) {
			if (value == set.values.sort[setLength-1]) setString = setString ~ to!string(value) ~ "}";  // append "}" if at the end of dictionary
			else setString = setString ~ to!string(value) ~ ", ";
		}
		
		if (setLength == 0) return "{}";
		return setString;
	}		
	
	
	
	/**
		if opCmp returns positive value
		a < b False
		a > b True
		a >= b True
		a <= b False
		
		
		neg value
		a < b True
		a > b False
		a >= b False
		a <= b True>
		
		0 value
		a < b False
		a > b False
		a >= b True
		a <= b True
		
	**/
		
	// Subset
	// s1 is a subset of s2: s1 <= s2
	// s1 is a proper subset of s2: s1 < s2
	
	
	override int opCmp(Object o) {
		Set!T other = cast(Set!T)o;
		bool subset = true;
		
		foreach(elem; set) if (!other.member(elem)) subset = false;
		
		if (subset && (set.length != other.set.length)) return -1; // subset
		else if (subset && (set.length == other.set.length)) return 0; // proper subset
		return 1;
	
	/*			
		// Check if subset
		if (set.length == 0 && other.set.length == 0) return 0; // the empty set is always a subset, but never a proper subset
		else {
			foreach(elem; set) {
				if (!(other.member(elem))) return 1;  // if element in this set is not in other set, this is not a subset, nor a proper subset
			}
			
			// if we've made it this far, it's a subset
			// now check if proper
				foreach(elem; other.set) {
					if (!(this.member(elem))) return -1;	// element in other, not in this-- proper subset
				}
			
			return 0;
		}
		*/
	}
		
	
	
	// Set equality 
	// s1 == s2
	override bool opEquals(Object o) {
		Set!T other = cast(Set!T)o;
		
		foreach(elem; other.set) {
			if (!(this.member(elem))) return false;	// check if all elements in other set are members of this set
		}
		foreach(elem; set) {
			if (!(other.member(elem))) return false;  // check if all elements of this set are members of this set
		}
		return true;
	}
	
	
	

	
}

