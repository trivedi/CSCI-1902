import std.stdio, std.conv, std.exception;


// Our Nodes inside the linked List
class Node(T) {
    
	private T val;			// data stored in this node
    private Node!T next;	// reference to the next node

	
	// Node constructor
	this(T data) {
		val = data;
	} 	
}



class Stack(T) {

	private Node!T start;
	private int length;
	
	
	// Initialize first node to be null
	this() {
		auto start = null;
		length = 0;
	}
	
	// Returns true if stack is empty
	pure bool empty() {
		return length == 0;
	}
	
	// Inserts a new link at the beginning of the list
	void push(T data) {
	
		Node!T node = new Node!T(data);
		
		node.next = start;
		start = node;
		++length;
	}
		
	
	T pop() {
		enforce(length > 0, "Error: Attempted to pop an empty stack");
		Node!T temp = start;
		start = start.next;
		--length;
		return temp.val;
	}
	
	/*
	 Prints stack in the form:
	 
	 ------
	 item1
	 item2
	 item3
	   .
	   .
	 itemn
	 ------
	*/
	override string toString() {
			if (length == 0) return "Empty stack";
			Node!T node = start;
			string result = "------\n";
			while (node !is null) {
				if (node.next is null) result ~= to!string(node.val);
				else result = result ~ to!string(node.val) ~ "\n";
				node = node.next;
			}
			result ~= "\n------";
			return result;	
	}

}
	
