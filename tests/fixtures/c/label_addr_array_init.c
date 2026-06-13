// A `&&label` element (GCC labels as values) in an array initializer is a
// runtime value: the block address is not known until the function is
// emitted, so the element is filled by a runtime store rather than a
// constant. A label-address array indexed by a computed goto is the
// dispatch-table form. Covers automatic and static storage (deferred and
// known size, including the `const` dispatch-table shape). Asserted by
// return code.

static int run_auto(int n) {
    void *tbl[] = { &&L0, &&L1, &&L2 };
    int acc = 0;
    goto *tbl[n];
L0:
    acc = 10;
    goto done;
L1:
    acc = 20;
    goto done;
L2:
    acc = 30;
    goto done;
done:
    return acc;
}

static int run_static(int n) {
    static void *tbl[] = { &&A, &&B, &&C };
    int acc = 0;
    goto *tbl[n];
A:
    acc = 1;
    goto d;
B:
    acc = 2;
    goto d;
C:
    acc = 3;
    goto d;
d:
    return acc;
}

static int run_static_const(int n) {
    static const void *const tbl[3] = { &&X, &&Y, &&Z };
    int acc = 0;
    goto *(void *)tbl[n];
X:
    acc = 100;
    goto e;
Y:
    acc = 200;
    goto e;
Z:
    acc = 300;
    goto e;
e:
    return acc;
}

int main(void) {
    if (run_auto(0) != 10) return 1;
    if (run_auto(1) != 20) return 2;
    if (run_auto(2) != 30) return 3;
    if (run_static(0) != 1) return 4;
    if (run_static(1) != 2) return 5;
    if (run_static(2) != 3) return 6;
    // Re-entry: the static table persists across calls.
    if (run_static(2) != 3) return 7;
    if (run_static_const(0) != 100) return 8;
    if (run_static_const(1) != 200) return 9;
    if (run_static_const(2) != 300) return 10;
    return 0;
}
