// `E1 /= K` and `E1 %= K` reduce a constant divisor as `E1 / K` does (C99
// 6.5.16.2p3). Each group runs the compound operator with the divisor as a
// literal and again through a `volatile` object of the literal's type,
// which takes the hardware divide, over boundary and pseudorandom values
// of the lvalue's type. The lvalues cover the integer types, a mixed
// common type, a volatile object, array elements and bit-fields.
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
    nums[10] = 127;
    nums[11] = -128;
    nums[12] = 255;
    nums[13] = 32767;
    nums[14] = -32768;
    nums[15] = 65535;
    for (i = 16; i < NN; i++) {
        s = s * 6364136223846793005ULL + 1442695040888963407ULL;
        nums[i] = (long long)s;
    }
}

// TY is the lvalue's type and DTY the literal's. A numerator equal to SKIP
// is left out: the most negative value of TY under a divisor of -1, whose
// quotient C99 6.5.5p6 leaves undefined.
#define CK(TY, DTY, D, SKIP)                                                                       \
    do {                                                                                           \
        int i;                                                                                     \
        step++;                                                                                    \
        for (i = 0; i < NN; i++) {                                                                 \
            volatile DTY vd = (D);                                                                 \
            TY q = (TY)nums[i], r = q, vq = q, vr = q;                                             \
            if ((long long)q == (long long)(SKIP)) continue;                                       \
            q /= (D);                                                                              \
            r %= (D);                                                                              \
            vq /= vd;                                                                              \
            vr %= vd;                                                                              \
            if (q != vq) return step;                                                              \
            if (r != vr) return step + 100;                                                        \
        }                                                                                          \
    } while (0)

#define NONE 0x5555555555555555LL

struct bits {
    int s : 11;
    unsigned u : 13;
    long long w : 40;
};

static int plain(void) {
    CK(int, int, 10, NONE);
    CK(int, int, 7, NONE);
    CK(int, int, -7, NONE);
    CK(int, int, 16, NONE);
    CK(int, int, -16, NONE);
    CK(int, int, 1, NONE);
    CK(int, int, -1, -2147483647LL - 1);
    CK(int, int, 2147483647, NONE);
    CK(int, int, -2147483647 - 1, NONE);
    CK(unsigned, unsigned, 10u, NONE);
    CK(unsigned, unsigned, 7u, NONE);
    CK(unsigned, unsigned, 8u, NONE);
    CK(unsigned, unsigned, 1u, NONE);
    CK(unsigned, unsigned, 0x80000001u, NONE);
    CK(unsigned, unsigned, 4000000000u, NONE);
    CK(unsigned, unsigned, 0xffffffffu, NONE);
    CK(long long, long long, 10LL, NONE);
    CK(long long, long long, -1000LL, NONE);
    CK(long long, long long, 4096LL, NONE);
    CK(long long, long long, -1LL, -9223372036854775807LL - 1);
    CK(long long, long long, -9223372036854775807LL - 1, NONE);
    CK(unsigned long long, unsigned long long, 10ULL, NONE);
    CK(unsigned long long, unsigned long long, 7ULL, NONE);
    CK(unsigned long long, unsigned long long, 0x8000000000000001ULL, NONE);
    CK(long, long, 100L, NONE);
    CK(long, long, -3L, NONE);
    CK(unsigned long, unsigned long, 100UL, NONE);
    CK(unsigned long, unsigned long, 7UL, NONE);
    return 0;
}

// The lvalue is narrower than the operation, which runs at the promoted
// or the common type and converts back on the store.
static int converted(void) {
    CK(signed char, int, 3, NONE);
    CK(signed char, int, -5, NONE);
    CK(signed char, int, -1, NONE);
    CK(unsigned char, int, 3, NONE);
    CK(unsigned char, int, 16, NONE);
    CK(unsigned char, int, -7, NONE);
    CK(short, int, 10, NONE);
    CK(short, int, -1, NONE);
    CK(unsigned short, int, 1000, NONE);
    CK(unsigned short, unsigned, 7u, NONE);
    CK(int, unsigned, 3u, NONE);
    CK(int, unsigned, 0x80000000u, NONE);
    CK(int, long long, 3LL, NONE);
    CK(int, long long, 0x100000000LL, NONE);
    CK(int, unsigned long, 7UL, NONE);
    CK(unsigned, long long, 7LL, NONE);
    CK(unsigned, long long, -7LL, NONE);
    CK(unsigned, unsigned long long, 10ULL, NONE);
    CK(short, unsigned long, 9UL, NONE);
    CK(long long, int, -10, NONE);
    CK(unsigned long long, int, 10, NONE);
    return 0;
}

static int places(void) {
    int arr[NN];
    struct bits b, vb;
    int i;

    // A volatile lvalue.
    step++;
    for (i = 0; i < NN; i++) {
        volatile int v = (int)nums[i], w = (int)nums[i];
        volatile int vd = 10;
        v /= 10;
        w /= vd;
        if (v != w) return step;
        v = (int)nums[i];
        w = (int)nums[i];
        v %= 10;
        w %= vd;
        if (v != w) return step + 100;
    }

    // Array elements, and the value of the compound expression.
    step++;
    for (i = 0; i < NN; i++) arr[i] = (int)nums[i];
    for (i = 0; i < NN; i++) {
        volatile int vd = -9;
        int want = (int)nums[i] / vd;
        if ((arr[i] /= -9) != want) return step;
        if (arr[i] != want) return step;
        want %= vd;
        if ((arr[i] %= -9) != want) return step + 100;
    }

    // Bit-fields: signed, unsigned, and wider than `int`.
    step++;
    for (i = 0; i < NN; i++) {
        volatile int vd = 3;
        b.s = vb.s = (int)nums[i];
        b.u = vb.u = (unsigned)nums[i];
        b.w = vb.w = nums[i];
        b.s /= 3;
        vb.s /= vd;
        b.u /= 3;
        vb.u /= vd;
        b.w /= 3;
        vb.w /= vd;
        if (b.s != vb.s || b.u != vb.u || b.w != vb.w) return step;
        b.s = vb.s = (int)nums[i];
        b.u = vb.u = (unsigned)nums[i];
        b.w = vb.w = nums[i];
        b.s %= 3;
        vb.s %= vd;
        b.u %= 3;
        vb.u %= vd;
        b.w %= 3;
        vb.w %= vd;
        if (b.s != vb.s || b.u != vb.u || b.w != vb.w) return step + 100;
    }
    return 0;
}

int main(void) {
    int r;
    fill();
    if ((r = plain()) != 0) return r;
    if ((r = converted()) != 0) return r;
    return places();
}
