// GNU local labels: `__label__ name, ...;` at the start of a block
// declares label names scoped to that block instead of to the whole
// function. Two sibling blocks may declare the same name, and each
// `goto` binds to the instance declared by its enclosing block. A
// nested declaration shadows an outer one. Ordinary labels and the
// label-address operator keep working alongside them.

// Sibling blocks reusing one name: each `l` is a distinct label.
static int siblings(int n) {
    int r = 0;
    {
        __label__ l;
        if (n) goto l;
        r += 100;
    l:
        r += 1;
    }
    {
        __label__ l;
        if (n) goto l;
        r += 200;
    l:
        r += 2;
    }
    return r;
}

// A nested declaration shadows the outer one; after the inner block
// ends, the name refers to the outer label again.
static int shadowing(int n) {
    __label__ l;
    int r = 0;
    {
        __label__ l;
        if (n) goto l;
        r += 100;
    l:
        r += 1;
    }
    if (!n) goto l;
    r += 1000;
l:
    return r;
}

// One declaration may list several names.
static int multiple(int n) {
    __label__ a, b;
    if (n) goto a;
    goto b;
a:
    return 1;
b:
    return 2;
}

// A local label is visible to a `goto` in a nested block.
static int from_nested(int n) {
    __label__ l;
    {
        {
            if (n) goto l;
        }
    }
    return 5;
l:
    return 6;
}

// The label-address operator takes the address of a local label.
static int label_address(int n) {
    __label__ l;
    void *p = &&l;
    if (n) goto *p;
    return 7;
l:
    return 8;
}

// The motivating case: a macro whose body is a statement expression
// defines a label, and two expansions land in one function. Without the
// local declaration the second expansion would redefine the label.
#define FIRST_SET(a, b) \
    ({ __label__ found; int v = 0; if (a) { v = 1; goto found; } if (b) { v = 2; goto found; } found: ; v; })

static int macro_expansions(int a, int b) {
    int x = FIRST_SET(a, b);
    int y = FIRST_SET(b, a);
    return x * 10 + y;
}

int main(void) {
    if (siblings(1) != 3) return 1;
    if (siblings(0) != 303) return 2;

    if (shadowing(1) != 1001) return 3;
    if (shadowing(0) != 101) return 4;

    if (multiple(1) != 1) return 5;
    if (multiple(0) != 2) return 6;

    if (from_nested(1) != 6) return 7;
    if (from_nested(0) != 5) return 8;

    if (label_address(1) != 8) return 9;
    if (label_address(0) != 7) return 10;

    if (macro_expansions(1, 0) != 12) return 11;
    if (macro_expansions(0, 1) != 21) return 12;
    if (macro_expansions(0, 0) != 0) return 13;

    return 0;
}
