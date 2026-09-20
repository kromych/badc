// A divisor that is a constant only after the optimizer has worked: the
// argument of an inlined helper, and the parameter of an out-of-line one
// whose every call passes the same value. Each group compares the helper
// with the same operation through a `volatile` divisor of the same type,
// which takes the hardware divide, over boundary and pseudorandom
// numerators. The operation's signedness and width come from the helper's
// types, not from the constant: -3 passed as `unsigned` divides by
// 4294967293, and `long` is 32 bits wide on LLP64.
// Returns 0 when every case matches; otherwise the group index, plus 100
// when it was the modulo that disagreed.

#define NN 24

static long long nums[NN];
static int step;

static void fill(void) {
    unsigned long long s = 0x9E3779B97F4A7C15ULL;
    int i;
    nums[0] = 0;
    nums[1] = 1;
    nums[2] = -1;
    nums[3] = 2;
    nums[4] = -2;
    nums[5] = 2147483647LL;
    nums[6] = -2147483647LL - 1;
    nums[7] = 9223372036854775807LL;
    nums[8] = -9223372036854775807LL - 1;
    nums[9] = 4294967295LL;
    nums[10] = 2147483648LL;
    nums[11] = 127;
    nums[12] = -128;
    nums[13] = 255;
    nums[14] = -32768;
    nums[15] = 65535;
    for (i = 16; i < NN; i++) {
        s = s * 6364136223846793005ULL + 1442695040888963407ULL;
        nums[i] = (long long)s;
    }
}

// RTY is the type the operation runs at after the conversions.
#define OPS(NAME, TY, DTY, RTY)                                                                    \
    static inline RTY NAME##_div(TY a, DTY d) { return a / d; }                                    \
    static inline RTY NAME##_mod(TY a, DTY d) { return a % d; }

OPS(si, int, int, int)
OPS(ui, unsigned, unsigned, unsigned)
OPS(sl, long, long, long)
OPS(ul, unsigned long, unsigned long, unsigned long)
OPS(sll, long long, long long, long long)
OPS(ull, unsigned long long, unsigned long long, unsigned long long)
OPS(sc, signed char, signed char, int)
OPS(uc, unsigned char, unsigned char, int)
OPS(sh, short, short, int)
OPS(mix, int, unsigned, unsigned)
OPS(wide, int, long long, long long)
OPS(uwide, unsigned, long long, long long)

// A numerator equal to SKIP is left out: the most negative value of the
// operation's type under a divisor of -1 (C99 6.5.5p6 leaves it undefined).
#define CK(NAME, TY, DTY, D, SKIP)                                                                 \
    do {                                                                                           \
        int i;                                                                                     \
        step++;                                                                                    \
        for (i = 0; i < NN; i++) {                                                                 \
            volatile DTY vd = (D);                                                                 \
            TY n = (TY)nums[i];                                                                    \
            if ((long long)n == (long long)(SKIP)) continue;                                       \
            if (NAME##_div(n, (D)) != n / vd) return step;                                         \
            if (NAME##_mod(n, (D)) != n % vd) return step + 100;                                   \
        }                                                                                          \
    } while (0)

#define NONE 0x5555555555555555LL
#define IMIN (-2147483647 - 1)
#define LLMIN (-9223372036854775807LL - 1)

static int ints(void) {
    CK(si, int, int, 10, NONE);
    CK(si, int, int, 7, NONE);
    CK(si, int, int, -7, NONE);
    CK(si, int, int, 1, NONE);
    CK(si, int, int, -1, IMIN);
    CK(si, int, int, 2, NONE);
    CK(si, int, int, -2, NONE);
    CK(si, int, int, 1024, NONE);
    CK(si, int, int, 2147483647, NONE);
    CK(si, int, int, IMIN, NONE);
    CK(si, int, int, IMIN + 1, NONE);
    CK(ui, unsigned, unsigned, 10u, NONE);
    CK(ui, unsigned, unsigned, 7u, NONE);
    CK(ui, unsigned, unsigned, 1u, NONE);
    CK(ui, unsigned, unsigned, 64u, NONE);
    CK(ui, unsigned, unsigned, 0x80000000u, NONE);
    CK(ui, unsigned, unsigned, 0x80000001u, NONE);
    CK(ui, unsigned, unsigned, 0xfffffffeu, NONE);
    CK(ui, unsigned, unsigned, 0xffffffffu, NONE);
    // The constant is negative and the operation unsigned.
    CK(ui, unsigned, unsigned, -3, NONE);
    CK(ui, unsigned, unsigned, -1, NONE);
    return 0;
}

static int wides(void) {
    CK(sll, long long, long long, 10LL, NONE);
    CK(sll, long long, long long, -1000LL, NONE);
    CK(sll, long long, long long, 1LL, NONE);
    CK(sll, long long, long long, -1LL, LLMIN);
    CK(sll, long long, long long, 4096LL, NONE);
    CK(sll, long long, long long, 0x100000001LL, NONE);
    CK(sll, long long, long long, 9223372036854775807LL, NONE);
    CK(sll, long long, long long, LLMIN, NONE);
    CK(ull, unsigned long long, unsigned long long, 10ULL, NONE);
    CK(ull, unsigned long long, unsigned long long, 7ULL, NONE);
    CK(ull, unsigned long long, unsigned long long, 0x100000000ULL, NONE);
    CK(ull, unsigned long long, unsigned long long, 0x8000000000000000ULL, NONE);
    CK(ull, unsigned long long, unsigned long long, 0x8000000000000001ULL, NONE);
    CK(ull, unsigned long long, unsigned long long, 0xffffffffffffffffULL, NONE);
    CK(ull, unsigned long long, unsigned long long, -3, NONE);
    // `long`: 64 bits on LP64, 32 on LLP64, so the numerator a divisor of
    // -1 leaves out is the most negative value of whichever it is.
    CK(sl, long, long, 10L, NONE);
    CK(sl, long, long, -7L, NONE);
    CK(sl, long, long, 1L << 30, NONE);
    CK(sl, long, long, -1L, sizeof(long) == 4 ? (long long)IMIN : LLMIN);
    CK(ul, unsigned long, unsigned long, 10UL, NONE);
    CK(ul, unsigned long, unsigned long, 0x80000001UL, NONE);
    CK(ul, unsigned long, unsigned long, -3, NONE);
    return 0;
}

static int converted(void) {
    CK(sc, signed char, signed char, 3, NONE);
    CK(sc, signed char, signed char, -128, NONE);
    CK(sc, signed char, signed char, -1, NONE);
    CK(uc, unsigned char, unsigned char, 3, NONE);
    CK(uc, unsigned char, unsigned char, 255, NONE);
    CK(sh, short, short, 10, NONE);
    CK(sh, short, short, -32768, NONE);
    // An `int` numerator divided as unsigned, and as `long long`.
    CK(mix, int, unsigned, 3u, NONE);
    CK(mix, int, unsigned, 0x80000000u, NONE);
    CK(mix, int, unsigned, -3, NONE);
    CK(wide, int, long long, 3LL, NONE);
    CK(wide, int, long long, -1LL, NONE);
    CK(wide, int, long long, 0x100000000LL, NONE);
    CK(wide, int, long long, -0x80000000LL, NONE);
    CK(uwide, unsigned, long long, 7LL, NONE);
    CK(uwide, unsigned, long long, -7LL, NONE);
    CK(uwide, unsigned, long long, 0xffffffffLL, NONE);
    return 0;
}

// Out of line, and every call passes 7 and 1000: the parameters are
// constants of the body without any inlining.
__attribute__((noinline)) static int fixed(int a, int d, unsigned e) {
    return a / d + (int)((unsigned)a % e);
}

// The divisor is zero once inlined. The division is never run; it has to
// compile, and to stay a division.
static inline int by_zero(int a, int d) { return a / d + a % d; }

static int others(void) {
    volatile int never = 0;
    volatile int d = 7;
    volatile unsigned e = 1000;
    int i, sink = 0;
    step++;
    for (i = 0; i < NN; i++) {
        int n = (int)nums[i];
        if (fixed(n, 7, 1000u) != n / d + (int)((unsigned)n % e)) return step;
        if (never) sink += by_zero(n, 0);
    }
    return sink;
}

int main(void) {
    int r;
    fill();
    if ((r = ints()) != 0) return r;
    if ((r = wides()) != 0) return r;
    if ((r = converted()) != 0) return r;
    return others();
}
