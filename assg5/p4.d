import std.stdio, std.conv, std.exception;


// Our Nodes, or Links inside the linked List
class Node(T) {
    
	T val;			// data stored in this node
	Node!T prev;	// reference to the previous node
    Node!T next;	// reference to the next node
	
	
	
	// Node constructor
	this(T data) {
		val = data;
	}
	
	void display() {
		writeln("Value: ", val);
	} 	
}


struct PriorityQueue(T) {

	//private
	private Node!T head;
	private int length;
	
	
	// Initialize first node to be null
//	this() {
//	}
	
	// Postblit constructor
	
	
	
	// Returns true if stack is empty
	bool empty() {
		return length == 0;
	}
	
		
	void insert(T data) {
		Node!T node = new Node!T(data);
		Node!T previousNode = null;
		Node!T current = head;
		
		while (current !is null && node.val > current.val) {
			previousNode = current;
			current = current.next;
		}
		if (previousNode is null) {
			head = node;
		}
		else {
			previousNode.next = node;
		}
		
		node.next = current;
		++length;
	}
	
	
	T extractMax() {
		Node!T node1 = head;
		Node!T node2 = head;
		
		enforce(length > 0, "Error: Cannot apply extractMax()--priority queue is empty");
		
		// only one node--it's the max
		if (length == 1) {
			auto temp = node1.val;
			head = null;
			--length;
			return temp;
		}
		
		// Get second to last node
		if (length != 1) {
			while (node2.next.next !is null) {
				node2 = node2.next;
			}
		}
		
		// Get the last node
		while (node1.next !is null) {
			node1 = node1.next;
		}
		
		// now temp is the max node
		auto temp = node1.val;
		// save to temp, and get rid of reference
		node2.next = null;
		
		--length;
		return temp;
	}
	

       string toString() {
		Node!T node = head;
		string result = "";
		if (length == 0) return "Empty priority queue";
		while(node !is null) {
			if (node.next is null) result = to!string(node.val) ~ result;
			else result = "\n" ~ to!string(node.val) ~ result;
			node = node.next;
		}
		return result;
	}	
	
	
	

}
	
	
