import std.stdio, std.conv, std.exception;


class Node(T) {
	T value;
	Node!T left;
	Node!T right;

	this(T item) {
		value = item;
	}

	override string toString() {
		return "(Node type: " ~ T.stringof ~ ", value: " ~ to!string(value) ~ ")" ;
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


	// Helper function for sort()
	void sorttree(Node!T node) {
		if (node is null) return;
		if (sorted.length != size) sorted.length += 1;
		sorttree(node.left);
		sorted[index++] = node.value;
		sorttree(node.right);
	}


	size_t index = 0; // Used for indexing through array
	T[] sorted;   // Our sorted array

	// Returns an array containing items from the BST in order
	T[] sort() {
		sorttree(root);
		return sorted;
	}


}