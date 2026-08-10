// A `&&label` element (GCC labels as values) in a static initializer is a
// link-time constant: the data image holds a relocation against the
// label's code location, so the table is a genuine read-only constant and
// no stores initialize it at the declaration point. Covers the plain
// dispatch table, the section-attributed spelling (the shape the Linux
// BPF interpreter's jump table takes), a range designator, and re-entry
// across calls. Asserted by return code.

static int dispatch(int n) {
    static const void *const t[2] = {&&a, &&b};
    goto *t[n];
a:
    return 11;
b:
    return 12;
}

static int sectioned(int n) {
    static const void *const t[4] __attribute__((section(".test.jump"))) = {
        &&j0, &&j1, &&j2, &&j3};
    goto *t[n];
j0:
    return 20;
j1:
    return 21;
j2:
    return 22;
j3:
    return 23;
}

// The kernel's dispatch table shape: a range designator fills the holes
// with the default label, named entries override individual slots.
static int ranged(int n) {
    static const void *const t[8] = {[0 ... 7] = &&dflt, [3] = &&three,
                                     [5] = &&five};
    goto *t[n];
three:
    return 3;
five:
    return 5;
dflt:
    return 99;
}

// A file-scope reader proves the table is data, not something the
// declaration's control flow has to reach first.
static int reached_without_declaring(int n) {
    if (n < 0) {
        return -1;
    }
    return sectioned(n);
}

int main(void) {
    if (dispatch(0) != 11) return 1;
    if (dispatch(1) != 12) return 2;
    if (dispatch(0) != 11) return 3;
    if (sectioned(0) != 20) return 4;
    if (sectioned(3) != 23) return 5;
    if (reached_without_declaring(2) != 22) return 6;
    if (ranged(0) != 99) return 7;
    if (ranged(3) != 3) return 8;
    if (ranged(5) != 5) return 9;
    if (ranged(7) != 99) return 10;
    return 0;
}
