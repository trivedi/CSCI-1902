import std.stdio;

void main() {
	int[] a = [4, 7, 2, 7, 5, 9, 2, 5, 10, 14, 3, 18];
	writeln(quicksort(a));
}


T[] quicksort(T)(T[] array) {
	if (array.length <= 1) return array; // already sorted
	T[] less, more;
	foreach (x; array[1 .. $]) {
		(x < array[0] ? less : more) ~= x;
	}
	return quicksort(less) ~ array[0] ~ quicksort(more);
}

