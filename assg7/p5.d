import std.stdio, std.conv, std.exception;


class Node(T) {
	T value;
	Node!T left;
	Node!T right;

	this(T item) {
		value = item;
	}
}


struct Pair(T,U) {
    T key;
    U value;

    alias key this; //see below

    this( T k, U val) {
        key = k;
        value = val;
    }

    string toString() {
    	return "(" ~ to!string(key) ~ " : " ~ to!string(value) ~ ")";
    }
}


struct BST(T) {
	int size = 0; // Number of nodes
	Node!T root = null;


// Is item a member of BST?
	bool member(T item) {
		if (size == 0) return false;	// There's nothing in the tree yet
		if (item == root.value) return true;
		
		// Simplest cases have not been found, must traverse tree
		else {
			auto node = root;
			while (1) {
				if (node.value == item) return true;
				else {
					if (item < node.value && node.left !is null) node = node.left;
					else if (item > node.value && node.right !is null) node = node.right;
					else return false;		// if item is not <= or >=, this item doesn't exist
				}
			}
			return false;
		}
	}


void insert(T item) {
	auto leaf = new Node!T(item);
	auto node = root;
	bool loop = true;
	if (size == 0) {
		++size;
		root = new Node!T(item);
	}
	else {
		if (this.member(item)) return;
		while (loop) {
			if (item < node.value && node.left !is null) node = node.left;
			else if (item > node.value && node.right !is null) node = node.right;
			else loop = false;
		}
		if (item < node.value) node.left = leaf;
		else node.right = leaf;
		++size;
	}
}


	
	// Returns the node containing item. Returns null if item does not exist.
	Node!T find (T item) {
		Node!T null_node;

		if (size == 0) return null_node;
		if (item == root.value) return root;

		// Item not found in the simplest cases--have to traverse tree
		auto node = root;

		// Go to left child
		while (1) {
			if (node.value == item) return node;
			else {
				if (item < node.value && node.left !is null) node = node.left;
				else if (item > node.value && node.right !is null) node = node.right;
				else return null_node;
			}
		}	
		return null_node;
	}

}



struct Map(T, U) {
		
		BST!(Pair!(T, U)) tree;
		int size = 0;


		// Is key k in Map?
		bool opBinaryRight(string op)(T k) if (op == "in") {
			U v;
			auto node = Pair!(T, U)(k, v);
			return tree.member(node);
		}


		// Insert key-value pair into Map; if key already exists, modify it's corresponding value
		void opIndexAssign(U val, T k) {
			auto pair = Pair!(T, U)(k, val);
			if (k in this) {
				auto node = tree.find(pair);
				node.value.value = val;		// Modify the key's value if key is already present
			}
			else tree.insert(pair);
		}

		//Returns the value associated with key k if present
		U opIndex(T k) {
			U v;
			auto key = Pair!(T, U)(k, v);
			auto node = tree.find(key);
			enforce(node !is null, "Error: Cannot get value, key is not present");
			return node.value.value;   // value inside Pair
		}


	
}


