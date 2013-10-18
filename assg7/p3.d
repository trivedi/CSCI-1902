import std.stdio, std.conv, std.exception, std.traits;


// Contains key and value to be stored inside Map as linked list
class Node(T, U) {
	T key;
	U value;
	Node!(T, U) next;

	this(T k, U v) {
		key = k;
		value = v;
	}
}


// Hash function used for Hashmap to compute an array index
size_t hash(T)( T key, size_t m) {
  static if( isIntegral!T) {
    double x = cast(double)key;
    return typeid(x).getHash(&x) % m;
  } else {
    return typeid(key).getHash(&key) % m;
  }
}



struct HashMap(T, U) {
	int size = 0; 	// number of keys
	Map!(T, U)[] A;		// an array containing Maps	


	// Checks if key k is in HashMap
	bool opBinaryRight(string op)(T k) if (op == "in") {
		auto i = hash(k, A.length);  // computes index
		return (k in A[i]);
	}

	// Removes key k from HashMap if present, otherwise returns false
	bool remove(T k) {
		auto i = hash(k, A.length);
		--size;
		return A[i].remove(k);
	}

	// Returns the value of key K in Hashmap if present
	U opIndex(T k) {
		auto i = hash(k, A.length);
		return A[i][k];
	}

	// Inserts key-value pair into HashMap if key is not present, otherwise modifies existing key with new value
	void opIndexAssign(U val, T k) {
		if (size == 0) A.length = 10; 	// Start out the array with a length of 10

		auto i = hash(k, A.length);  // computes the index where we will store the Map implemented as a linked list

		A[i][k] = val;	// Store key-value pair (abstracted as a Map which is a linked list) into the slot at A[i]
						// if this slot already has a Map, the new pair will just be linked on to the existing Map
		++size;

			// Increase the length if array is not larger than twice the total number of keys
			if (A.length < size * 2) {
				Map!(T, U)[] temp;	
				temp.length = size * 2 + 2;
				foreach(map; A) {
					if (map.head !is null) {				
						auto new_index = hash(map.head.key, temp.length);	// Rehash since we have a new array length
						temp[new_index] = map;			// Put items into new indices
					}
				}
				A = temp;
			}
			
		
	}


	string toString() {
		string result = "[";
		foreach (map; A) {
			if (map.head !is null) {
				result ~= to!string(map);
			}
		}
		return result ~= "]";
	}
}

// From p2
struct Map(T, U) {
	Node!(T, U) head;


	// Is k a key in the Map?
	bool opBinaryRight(string op)(T k) if (op == "in") {
		auto node = head;
		while (node !is null) {
			if (node.key == k) return true;
			node = node.next;
		}
		return false;
	}

	// Removes the pair with key k if present, else returns false
	bool remove(T k) {
		if (k in this) { // k is in map, let's find the node
			if (head.next is null) {
				head = null; // there's only node in Map, so just change head's reference
				return true;
			}
			auto node = head;
			while (node !is null) {
				if (node.next.key == k) { // the next node contains the key
					node.next = node.next.next;
					return true;
				}
				node = node.next;
			}
		}
		return false;
	}

	// Returns the value associated with key k if present
	U opIndex(T k) {
		enforce((k in this), "Error: Cannot get value, key is not present in HashMap");
		auto node = head;
		while (node !is null) {
			if (node.key == k) return node.value;
			node = node.next;
		}
		return head.value;
	}

	// Adds a key-value pair to Map. Modifies the value if key k is already present.
	void opIndexAssign(U val, T k) {
		if (k in this) {
			auto node1 = head;
			while (node1 !is null) {
				if (node1.key == k) {
					node1.value = val;
				}
				node1 = node1.next;
			}
		}
		else {
			auto node = new Node!(T, U)(k, val);
			node.next = head;
			head = node;
		}
	}

	// Prints out Map
	string toString() {
		if (head is null) return "Empty Map"; // Map is empty
		string map = "";
		auto node = head;
		while (node.next !is null) {
			map ~= to!string(node.key) ~ " : " ~ to!string(node.value) ~ ", ";
			node = node.next;
		}
		map ~= to!string(node.key) ~ " : " ~ to!string(node.value) ~ ", ";
		return map;
	}

}