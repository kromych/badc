// A struct returned by value through a function pointer in the
// out-pointer class: the caller allocates the result and passes its
// address as a hidden first argument; the callee writes the struct
// through it. System V AMD64 uses this for aggregates over 16 bytes and
// Win64 for aggregates outside {1,2,4,8} bytes (so a 16-byte aggregate
// is out-pointer on Win64 but register-returned elsewhere). AAPCS64
// returns the larger aggregate through x8. The result is read inline so
// the result temp must be sized to the whole struct.

typedef struct {
    long a, b, c, d, e;
} Big; // 40 bytes

typedef struct {
    long lo, hi;
} Pair; // 16 bytes

static Big make_big(int x) {
    Big b = {x, x + 1, x + 2, x + 3, x + 4};
    return b;
}

static Pair make_pair(int x) {
    Pair p = {x, x * 2};
    return p;
}

int main(void) {
    Big (*fb)(int) = make_big;
    Pair (*fp)(int) = make_pair;

    Big b = fb(10);
    if (b.a != 10 || b.c != 12 || b.e != 14) return 1;

    Pair p = fp(7);
    if (p.lo != 7 || p.hi != 14) return 2;

    // Result fed straight into an expression.
    if (fb(3).e != 7) return 3;
    if (fp(5).lo + fp(5).hi != 15) return 4;
    return 0;
}
