import std.stdio, std.conv, std.exception;


// A class for creating and operating on rectangles
class Rect {

    private double left, right, top, bottom;

	
	// Initializes the coordinates of rectangle
    this(double x_left, double x_right, double y_top, double y_bottom) {
        enforce(x_left <= x_right && y_top >= y_bottom, "Error: A valid rectangle was not entered");
        left = x_left;
        right = x_right;
        top = y_top;
        bottom = y_bottom;
    }

    
    override string toString() {
       auto left = to!string(left);
       auto right = to!string(right);
       auto top = to!string(top);
       auto bottom = to!string(bottom);
       return "[" ~ left ~ ", " ~ right ~ ", " ~ top ~ ", " ~ bottom ~ "]"; // [left, right, top, bottom]
    }

	// Takes in x-coordinate and y-coordinate. Returns true if coordinate inside this instance of Rect.
    bool inside(double x, double y) {
        if ((bottom < y && top > y ) && (left < x && right > x)) return true;
        else return false;
    }


	// Takes in a Rect object and returns true if overlap exists between current instance of Rect and passed in Rect
    bool overlap(Rect r) {
		// Any one of these conditions guarantees an overlap doesn't exist
		if (r.left > right || r.right < left || r.top < bottom || r.bottom > top) return false; 
		else return true;
		
    }
	
    // Takes in a Rect object and return a new Rect object that comprises this instance of Rect and Rect r.
	Rect sum(Rect r) {
		double sum_left = 0;
		double sum_right = 0;
		double sum_top = 0;
		double sum_bottom = 0;
	
		if (left <= r.left) sum_left = left;
			else sum_left = r.left;
		if (right >= r.right) sum_right = right;
			else sum_right = r.right;
		if (top >= r.top) sum_top = top;
			else sum_top = r.top;
		if (bottom <= r.bottom) sum_bottom = bottom;
			else sum_bottom = r.bottom;

		return new Rect(sum_left, sum_right, sum_top, sum_bottom);
	}
	
	 
	
	// Takes in a Rect object and returns a new Rect object that us the largest rectangle inside this Rect instance and other Rect r
	Rect intersect(Rect r) {
		enforce(overlap(r), "Error: Rectangles do not overlap--cannot make type Rect out of intersection");
		
		double sum_left = 0;
		double sum_right = 0;
		double sum_top = 0;
		double sum_bottom = 0;
	
		if (left <= r.left) sum_left = r.left;
			else sum_left = left;
		if (right >= r.right) sum_right = r.right;
			else sum_right = right;
		if (top >= r.top) sum_top = r.top;
			else sum_top = top;
		if (bottom <= r.bottom) sum_bottom = r.bottom;
			else sum_bottom = bottom;
			
		return new Rect(sum_left, sum_right, sum_top, sum_bottom);
		
	}
}
