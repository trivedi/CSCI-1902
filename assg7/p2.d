import std.stdio, std.conv, std.exception;


class Node(T, U) {
	T key;
	U value;
	Node!(T, U) next;

	this(T k, U v) {
		key = k;
		value = v;
	}
}


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
		enforce((k in this), "Error: Cannot get value, key is not present in Map");
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
		string map = "[";
		auto node = head;
		while (node.next !is null) {
			map ~= to!string(node.key) ~ " : " ~ to!string(node.value) ~ ", ";
			node = node.next;
		}
		map ~= to!string(node.key) ~ " : " ~ to!string(node.value) ~ "]";
		return map;
	}

}