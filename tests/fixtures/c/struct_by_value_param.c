// Struct passed by value to a function. The c5 calling convention
// pushes the struct's *address* to the c5 stack at the call site;
// the callee's prologue copies the struct out of the caller's
// temp into a stack-allocated local of its own, so writes the
// callee makes don't leak back to the caller's copy.

struct Pair { int a; int b; };

int sum_pair(struct Pair p) {
    // Mutate the local copy -- this should NOT be visible to the
    // caller. Verifying that requires comparing the caller's
    // pre/post values; this fixture just reads to make sure the
    // parameter arrived intact.
    int total;
    total = p.a + p.b;
    p.a = -1;
    p.b = -1;
    if (p.a != -1) return -1;
    if (p.b != -1) return -2;
    return total;
}

int main() {
    struct Pair x;
    int t;

    x.a = 3;
    x.b = 7;
    t = sum_pair(x);
    if (t != 10) return 1;
    // The callee mutated its local copy; the caller's `x` is
    // untouched.
    if (x.a != 3) return 2;
    if (x.b != 7) return 3;
    return 0;
}
