/* A 16-byte all-integer struct parameter is passed as a single argument
   (the address of the caller's copy) and read by value in the callee.
   The inliner redirects the body's parameter-slot reads to the caller's
   argument, so a small by-value-struct accessor inlines (matching
   gcc/clang -O2). Both eightbytes must read back correctly. */

struct pair {
    long a;
    long b;
};

static long lo(struct pair p) {
    return p.a;
}
static long hi(struct pair p) {
    return p.b;
}
static long combine(struct pair p) {
    return p.a * 1000 + p.b;
}

int main(void) {
    struct pair p = {12, 34};
    if (lo(p) != 12) {
        return 1;
    }
    if (hi(p) != 34) {
        return 2;
    }
    if (combine(p) != 12034) {
        return 3;
    }
    return 0;
}
