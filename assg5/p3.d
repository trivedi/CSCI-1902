import std.stdio, std.conv, std.exception;



// must be a struct
struct PriorityQueue(T) {

	T[] queue;
		

	// Default constructor to make empty queue
	// ?
	
	// Postblit constructor
	this(this) {
		queue = queue.dup;
	}

	
	// Checks if PQ is empty
	bool empty() {
		return queue.length == 0;
	}
	
	
	// Inserts item of type T into PQ
	void insert(T item) {
		queue ~= item;
		queue.sort;
	}
	
	
	// doesn't work!!
	// Removes and returns the max value from PQ
	T extractMax() {
		enforce(queue.length > 0, "Error: Cannot extract max--no items in Priority Queue");
		T[] old_queue = queue;
		queue = queue[0..$-1];
		return old_queue[$-1];
	}
	
	string toString() {
		string q = "";
		if (this.empty()) return "Empty priority queue";
		else {
		foreach(value; queue.reverse) {
			if (value != queue[queue.length-1]) q = q ~ to!string(value) ~ "\n";
			else q ~= to!string(value);
		}
		return q;
	}
	}


}