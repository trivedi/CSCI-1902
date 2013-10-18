import std.stdio, std.conv;


class DisjointSets(T) {
    int n; // Set # - a way to identify a set
    int[T] toInt;  // Maps the node to the set # e.g. [4:1, 10:1, 3:2] means nodes 4 and 10 belong to the same set (set #1) and node 3 belongs to set #2
    T[] fromInt;   // I'm not sure why we actually need this
    int[] p; // holds parent values which are the canonical nodes
    int[] rank;  //pseudo-height

    this() {
        n = 0;
        fromInt = new T[100];
        p = new int[100];
        rank = new int[100];
    }


// toInt uses an assoc array so you know which set something is part of

    void make_set( T item) {
        if( item in toInt) return;
        // Increase array size if array is full
        if (fromInt.length <= item) fromInt.length += item;
        if (rank.length <= item) rank.length += item;
        if (p.length <= item) p.length += item;

        toInt[item] = ++n;
        fromInt[n] = item;
        p[item] = item;
        rank[item] = 0;
    }

    // Unionizes the two items into one set. The parent is determined by the ranks of each item.
    bool set_union( T item1, T item2) {
        auto x = find_set(item1);
        auto y = find_set(item2);
        if (rank[x] > rank[y]) {
            p[y] = x;
            toInt[y] = toInt[x];
        }
        else {
            p[x] = y;
            toInt[x] = toInt[y];
            if (rank[x] == rank[y]) rank[y] = rank[y] + 1;

        }
        return true;
    }

    // Finds the canonical node of the set to which item belongs to
    // Implemented using path compression
    T find_set( T item) {
        auto x = item;
        if (x != p[x]) p[x] = find_set(p[x]);
        return p[x];    // this will return the canonical node -- if you want to find the set # the canonical node belongs to do -- object.toInt[object.find_set(item)]; which in my opinion is pretty useful
    }

    override string toString() {
        string output = "";
        output  = output ~
        "-------------------------------------" ~ "\n" ~
        "Number of calls made of make_set: " ~ to!string(n) ~ "\n" ~
        "toInt: " ~ to!string(toInt) ~ "\n" ~
        "fromInt: " ~ to!string(fromInt) ~ "\n" ~
        "Parent: " ~ to!string(p) ~ "\n" ~ 
        "Rank: " ~ to!string(rank) ~ "\n" ~
        "-------------------------------------";
        return output;
    }
}