// C99 6.7.4: a function declared with the `inline` keyword is a
// hint to the optimiser that calls should be inlined. badc honours
// the hint under -O by bypassing `--inline-cap=N`'s body-size
// gate; the candidate's other shape constraints (single block, no
// internal calls, no LocalAddr, etc.) still apply.
//
// `widen` exceeds the default cap=64 with 80+ SSA insts but is
// flat single-block straight-line arithmetic. Without `inline`
// the inliner would reject it for size; with `inline` it folds
// into main at every call.

static inline long widen(long x) {
    long a = x + 1;
    long b = a + 2;
    long c = b + 3;
    long d = c + 4;
    long e = d + 5;
    long f = e + 6;
    long g = f + 7;
    long h = g + 8;
    long i = h + 9;
    long j = i + 10;
    long k = j + 11;
    long l = k + 12;
    long m = l + 13;
    long n = m + 14;
    long o = n + 15;
    long p = o + 16;
    return p;
}

int main(void) {
    long s = widen(0) + widen(100);
    // widen(0) = 0 + (1+2+3+4+5+6+7+8+9+10+11+12+13+14+15+16)
    //          = 136
    // widen(100) = 100 + 136 = 236
    // sum = 372
    return s == 372 ? 0 : 1;
}
