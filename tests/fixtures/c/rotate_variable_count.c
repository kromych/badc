// Runtime-count 64-bit rotate `(x >> c) | (x << (64 - c))` folds to a
// single hardware rotate (rorv / ror %cl); the constant-count form
// keeps folding to the immediate rotate. `volatile` keeps the count a
// runtime value. Returns 0 when every case matches a bit-walk
// reference for c in 1..63.

typedef unsigned long u64;

static u64 rotr_var(u64 x, int c) { return (x >> c) | (x << (64 - c)); }

static u64 ref_ror(u64 x, int c) {
    u64 r = 0;
    for (int i = 0; i < 64; i++) {
        if (x & (1UL << i)) {
            int j = (i - c) & 63;
            r |= (1UL << j);
        }
    }
    return r;
}

int main(void) {
    u64 xs[] = {0UL, 1UL, 0x8000000000000000UL, 0x0123456789abcdefUL,
                0xffffffffffffffffUL, 0xdeadbeefcafef00dUL};
    for (unsigned k = 0; k < sizeof xs / sizeof *xs; k++) {
        volatile int c;
        for (c = 1; c < 64; c++) {
            if (rotr_var(xs[k], c) != ref_ror(xs[k], (int)c)) return 1;
        }
    }
    // Constant-count rotate.
    volatile u64 v = 0x0123456789abcdefUL;
    if (((v >> 7) | (v << 57)) != ref_ror(0x0123456789abcdefUL, 7)) return 2;
    return 0;
}
