// Locks C99 6.7.8 -- an aggregate or union initializer is a
// brace-enclosed list, and any member that is itself an
// aggregate may be initialised with its own brace-enclosed
// list. The fixture exercises array-of-struct fields nested
// inside an outer struct initializer.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

struct Pair {
    int a;
    int b;
};

struct Container {
    int header;
    struct Pair data[3];
    int trailer;
};

static struct Container c = {
    100,
    { {1, 2}, {3, 4}, {5, 6} },
    200,
};

// Same shape with the array as the only field, to catch a fix
// that accidentally only handles arrays sandwiched between
// scalars.
struct WrapOnly {
    struct Pair data[2];
};

static struct WrapOnly w = {
    { {10, 20}, {30, 40} },
};

// Array of small structs followed by a flat int array, to keep
// the per-field offset bookkeeping honest across element-size
// transitions.
struct Mixed {
    struct Pair head[2];
    int  tail[3];
};

static struct Mixed m = {
    { {7, 8}, {9, 11} },
    { 13, 17, 19 },
};

int main(void) {
    if (c.header  != 100) return 11;
    if (c.data[0].a != 1) return 12;
    if (c.data[0].b != 2) return 13;
    if (c.data[1].a != 3) return 14;
    if (c.data[1].b != 4) return 15;
    if (c.data[2].a != 5) return 16;
    if (c.data[2].b != 6) return 17;
    if (c.trailer != 200) return 18;

    if (w.data[0].a != 10) return 21;
    if (w.data[0].b != 20) return 22;
    if (w.data[1].a != 30) return 23;
    if (w.data[1].b != 40) return 24;

    if (m.head[0].a != 7)  return 31;
    if (m.head[0].b != 8)  return 32;
    if (m.head[1].a != 9)  return 33;
    if (m.head[1].b != 11) return 34;
    if (m.tail[0] != 13)   return 35;
    if (m.tail[1] != 17)   return 36;
    if (m.tail[2] != 19)   return 37;
    return 0;
}
