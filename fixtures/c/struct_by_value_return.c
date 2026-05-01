// Struct returned by value. The c5 ABI for c5-to-c5 struct
// returns uses a hidden out-pointer prepended to the argument
// list: the caller allocates a temp for the result and pushes
// its address as arg 0; the callee's `return s` writes to that
// address via Mcpy and then leaves. The visible return value is
// the same out-pointer (the caller already has it; convenient
// when the result feeds straight into another call).

struct Pair { int a; int b; };

struct Pair make_pair(int a, int b) {
    struct Pair r;
    r.a = a;
    r.b = b;
    return r;
}

// Aggressively clobber the stack region a returned struct would
// have lived in. The point is to catch the failure mode where
// the callee returns a pointer to its own local, the local gets
// reused after Lev pops the frame, and the caller reads stale
// bytes.
int clobber(int n) {
    int a;
    int b;
    int c;
    int d;
    a = 0xdead;
    b = 0xbeef;
    c = 0xcafe;
    d = 0xfacef;
    return a + b + c + d + n;
}

struct Pair sum_pair_pair(struct Pair x, struct Pair y) {
    struct Pair r;
    r.a = x.a + y.a;
    r.b = x.b + y.b;
    return r;
}

int main() {
    struct Pair p;
    int junk;
    p = make_pair(11, 22);
    // Run a clobber call BETWEEN the return and the
    // value-checks. A naive implementation that returns the
    // callee's local-frame address would lose the data here --
    // clobber()'s frame reuses the same slots make_pair()'s did.
    junk = clobber(7);
    if (junk == 0) return 99;       // satisfy "use" of `junk`
    if (p.a != 11) return 1;
    if (p.b != 22) return 2;

    // Chained calls: the result of one struct-returning function
    // feeds straight into the next as a struct-by-value arg.
    {
        struct Pair q;
        q = make_pair(3, 4);
        if (q.a != 3) return 3;
        if (q.b != 4) return 4;
    }

    // Stress test: stash the result, then make a *second* call
    // before reading the first. Without a hidden out-pointer the
    // returned struct's storage gets reused by the second call's
    // frame and the original values disappear. With the
    // out-pointer the result lives in the caller's temp and
    // survives any number of subsequent calls.
    {
        struct Pair r;
        struct Pair s;
        r = make_pair(100, 200);
        s = make_pair(300, 400);
        if (r.a != 100) return 5;
        if (r.b != 200) return 6;
        if (s.a != 300) return 7;
        if (s.b != 400) return 8;
    }

    // Chained calls: pass a fresh struct return as an argument
    // to another struct-returning call. The callee's local r
    // must outlive the next make_pair (for the arg eval) AND
    // the assignment to t. This shape stresses the temp-slot
    // staging the worst.
    {
        struct Pair t;
        t = sum_pair_pair(make_pair(1, 2), make_pair(3, 4));
        // sum_pair_pair returns a struct whose .a is sum of the
        // two .a's and .b is sum of the two .b's.
        if (t.a != 4) return 9;     // 1 + 3
        if (t.b != 6) return 10;    // 2 + 4
    }

    return 0;
}
