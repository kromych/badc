// struct initializers, both designated and positional. The
// fixture covers a vtable-style shape: a const struct with
// integer, string, and function-pointer fields, populated via a
// brace-list at file scope.
//
// Calling through a struct field directly (`v.add(...)`) still
// requires copying the field to a local first; that's a c5
// expression-chain limitation, not a struct-initializer one.

typedef int (*Op)(int, int);

struct Vtable {
    int version;
    Op add;
    Op sub;
    char *name;
};

static int do_add(int a, int b) { return a + b; }
static int do_sub(int a, int b) { return a - b; }

// Designated initializer.
static struct Vtable v_designated = {
    .version = 1,
    .add = do_add,
    .sub = do_sub,
    .name = "demo",
};

// Positional initializer.
static struct Vtable v_positional = {
    2,
    do_add,
    do_sub,
    "alt",
};

// Mixed: positional first two, designated rest. C allows this;
// after a designator, positional resumes from the named field's
// successor, but the fixture sticks to a clean order.
static struct Vtable v_mixed = {
    3,
    do_add,
    .sub = do_sub,
    .name = "mix",
};

// Plain struct globals (no function pointers) -- pure data init.
struct Point {
    int x;
    int y;
};
static struct Point origin = { .x = 10, .y = 20 };
static struct Point unit = { 1, 2 };

int main() {
    Op fn;

    // Designated.
    if (v_designated.version != 1) return 1;
    fn = v_designated.add;
    if (fn(2, 3) != 5) return 2;
    fn = v_designated.sub;
    if (fn(10, 4) != 6) return 3;
    if (v_designated.name[0] != 'd') return 4;

    // Positional.
    if (v_positional.version != 2) return 5;
    fn = v_positional.add;
    if (fn(7, 8) != 15) return 6;
    if (v_positional.name[0] != 'a') return 7;

    // Mixed.
    if (v_mixed.version != 3) return 8;
    fn = v_mixed.add;
    if (fn(1, 1) != 2) return 9;
    fn = v_mixed.sub;
    if (fn(5, 1) != 4) return 10;

    // Plain data structs.
    if (origin.x != 10) return 11;
    if (origin.y != 20) return 12;
    if (unit.x != 1) return 13;
    if (unit.y != 2) return 14;

    return 0;
}
