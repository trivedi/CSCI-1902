import std.stdio, std.conv, std.exception;

/********************************
*
*	(1) Explanation:
*
*	I believe we can make sure the keys are comparable by using is() and typeof()
*	For example:
*		
*		is(typeof(a < b)) will only evaluate to 'true' if a CAN be compared to b
*		This is similar to the way opCmp is implemented
*
*	
*	(2) Found at line 130
*
**********************************/

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


	Node!T find (T item) {
		Node!T null_node;

		if (size == 0) return null_node;
		if (item == root.value) return root;

		// Item not found in the simplest cases--have to traverse tree
		auto node = root;

		// Go to left child
		while (item <= node.value) {
			if (node.value == item) return node;
			else if (node.left is null) return null_node;
			else node = node.left;
		}
		// Go to right child
		while (item >= node.value) {
			if (node.value == item) return node;
			else if (node.right is null) return null_node;
			else node = node.right;
		}
		return null_node;
	}


}

struct Map(T, U) {
		
		BST!(Pair!(T, U)) tree;
		int size = 0;



	/************
		opApply implementation
	

	I'm not sure how others implemented the foreach, but my was pretty hackish and hopefully satisfiable. Here's what I did:
	Looking at the example of opApply on the D Lang website (http://dlang.org/statement.html), the opCall explanation was illustrated by going through an array inside a class
	This wasn't terribly useful as I was using a tree :(. However, with a stroke of ingenuity, I remembered the Map struct in p4 has a sort() method which returns an array of items in sorted order.
	So, why not just use that to fill the array with keys instead of node values? With minimal fiddling arround with sort(), I was able to return an array sorted by key.
	Now, I literally had to copy the example on the website and change the array's name to mine.
	The downside is that you must call object.sort() before you iterate over the object. It seems obvious that you should just call object.sort() everytime an assignment is made, but
	it kept on giving me an out of range error during runtime and at that point I was just barely satisfied with my working somewhat solution. Also, calling sort() each time an assignment is made seems inefficient unless you want a sorted array at all times.

	So, now you can do chill stuff like this inside main():

	void main() {
		auto dict = Map!(double, double)();

		dict[1] = 10;
		dict[2] = 20;
		dict[3] = 30;
		dict[4] = 40;

		dict.sort()	// You have to do this unfortunately

		// iterate over Map and perform reassignment
		foreach(key; dict) {
			dict[key] = key * 2;
		}

		// Print out values
		foreach(key; dict) {
			write(t[key], " ") // 2 4 6 8     
		}
	}


	In the words of Professor Sturtivant: "This is a hack."
	**************/

		


		size_t index = 0; // Used for indexing through array
		T[] sorted;   // Our sorted array


		// Helper function for sort()
		void sorttree(Node!(Pair!(T, U)) node) {
			if (node is null) return;
			if (sorted.length != size) sorted.length += 1;
			sorttree(node.left);
			sorted[index++] = node.value;
			sorttree(node.right);
		}

		// Returns an array containing keys from Map sorted in order
		T[] sort() {
			sorttree(tree.root);
			return sorted;
		}

		
		int opApply(int delegate(ref T) dg) {
			int result = 0;
			for (int i = 0; i < sorted.length; i++) {
				result = dg(sorted[i]);
				if (result) break;
			}
			return result;
		}


// END OF OPAPPLY IMPLEMENTATION
//****************************************************************************

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
			else {
				++size;
				tree.insert(pair);
			}
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


