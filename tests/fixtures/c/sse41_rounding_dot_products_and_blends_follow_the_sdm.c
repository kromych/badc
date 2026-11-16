// SSE4.1's floating-point lane operations -- ROUNDPS, ROUNDPD, ROUNDSS and
// ROUNDSD in each direction and in MXCSR's, with and without the precision
// exception, the floor and ceiling forms, DPPS, DPPD, INSERTPS, EXTRACTPS
// and the blends -- each checked against the result the SDM defines for its
// instruction, over halfway values, signed zeros, subnormals, values past
// the last fraction bit, infinities and NaNs. The exit code has bit N set
// when group N fails; elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <smmintrin.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

static u64 next(void) {
    seed ^= seed >> 12;
    seed ^= seed << 25;
    seed ^= seed >> 27;
    return seed * 0x2545F4914F6CDD1DULL;
}

static const double specials[] = {0.0,      -0.0,     0.5,       -0.5,     1.5,       -1.5,
                                  2.5,      -2.5,     0.49999,   -0.50001, 3.0,       -7.0,
                                  1e-310,   -1e-310,  1e-40,     -1e-40,   8388607.5, -8388608.5,
                                  16777217, 4.5e15,   -4.5e15,   1e300,    -0.75,     123.456};

// A random value: a quiet or signaling NaN, a special, or a random
// magnitude below 2^24.
static double value(void) {
    static const u64 nans[3] = {0x7FF8000000000123ULL, 0x7FF0000000000456ULL,
                                0xFFF0000000000001ULL};
    u64 r = next();
    if (r >> 59 == 0) {
        double x;
        memcpy(&x, &nans[(r >> 32) % 3], 8);
        return x;
    }
    if (r >> 62 == 0)
        return specials[(r >> 32) % (sizeof specials / sizeof specials[0])];
    double v = (double)(r >> 40) / (double)(1 << ((r >> 8) & 15));
    return r & 1 ? -v : v;
}

static float fvalue(void) {
    static const unsigned nans[3] = {0x7FC00123u, 0x7F800456u, 0xFF800001u};
    u64 r = next();
    if (r >> 59 == 0) {
        float x;
        memcpy(&x, &nans[(r >> 32) % 3], 4);
        return x;
    }
    return (float)value();
}

static u64 bits_d(double x) {
    u64 b;
    memcpy(&b, &x, 8);
    return b;
}

static unsigned bits_f(float x) {
    unsigned b;
    memcpy(&b, &x, 4);
    return b;
}

// The integral value in direction `mode` (0 nearest-even, 1 down, 2 up,
// 3 toward zero), as ROUNDPD defines it: the sign of a zero result is the
// operand's, and an infinity or a NaN passes through, quieted.
static double model_round(double x, int mode) {
    u64 b = bits_d(x);
    if ((b >> 52 & 0x7FF) == 0x7FF) {
        b |= (b & 0xFFFFFFFFFFFFFULL) ? 1ULL << 51 : 0;
        memcpy(&x, &b, 8);
        return x;
    }
    if (x >= 4503599627370496.0 || x <= -4503599627370496.0)
        return x;
    long long t = (long long)x;
    double ft = (double)t, fr = x - ft, r = ft;
    if (mode == 0) {
        if (fr > 0.5 || (fr == 0.5 && (t & 1)))
            r = ft + 1;
        else if (fr < -0.5 || (fr == -0.5 && (t & 1)))
            r = ft - 1;
    } else if (mode == 1 && fr < 0) {
        r = ft - 1;
    } else if (mode == 2 && fr > 0) {
        r = ft + 1;
    }
    if (r == 0)
        r = b >> 63 ? -0.0 : 0.0;
    return r;
}

static float model_round_f(float x, int mode) {
    unsigned b = bits_f(x);
    if ((b >> 23 & 0xFF) == 0xFF) {
        b |= (b & 0x7FFFFF) ? 1u << 22 : 0;
        memcpy(&x, &b, 4);
        return x;
    }
    return (float)model_round(x, mode);
}

static unsigned csr;

// Runs `op` on a volatile copy of the operands with MXCSR's direction
// `rc` and the exception flags clear; `pe` receives the precision flag.
#define RUN(type, out, op, rc, pe)                              \
    do {                                                        \
        volatile type in_a = a, in_b = b;                       \
        _mm_setcsr((csr & ~0x603Fu) | (unsigned)(rc) << 13);    \
        type x_ = in_a, y_ = in_b;                              \
        (void)y_;                                               \
        volatile type r_ = (op);                                \
        pe = _mm_getcsr() >> 5 & 1;                             \
        _mm_setcsr(csr);                                        \
        out = r_;                                               \
    } while (0)

static int check_round_ps(void) {
    __m128 a, b = _mm_setzero_ps(), r;
    float lanes[4];
    for (int i = 0; i < 4; i++)
        lanes[i] = fvalue();
    memcpy(&a, lanes, 16);
    int fail = 0, pe, inexact = 0;
    for (int i = 0; i < 4; i++)
        inexact |= lanes[i] == lanes[i] && model_round_f(lanes[i], 3) != lanes[i];
#define ROUND_PS(M, mode, rc, want_pe)                                         \
    do {                                                                       \
        RUN(__m128, r, _mm_round_ps(x_, M), rc, pe);                           \
        for (int i = 0; i < 4; i++)                                            \
            if (bits_f(r[i]) != bits_f(model_round_f(lanes[i], mode)))         \
                fail = 1;                                                      \
        if (pe != ((want_pe) && inexact))                                      \
            fail = 1;                                                          \
    } while (0)
    ROUND_PS(_MM_FROUND_TO_NEAREST_INT, 0, 1, 1);
    ROUND_PS(_MM_FROUND_TO_NEG_INF, 1, 0, 1);
    ROUND_PS(_MM_FROUND_TO_POS_INF, 2, 3, 1);
    ROUND_PS(_MM_FROUND_TO_ZERO, 3, 2, 1);
    ROUND_PS(_MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC, 0, 2, 0);
    ROUND_PS(_MM_FROUND_TO_NEG_INF | _MM_FROUND_NO_EXC, 1, 3, 0);
    ROUND_PS(_MM_FROUND_TO_POS_INF | _MM_FROUND_NO_EXC, 2, 0, 0);
    ROUND_PS(_MM_FROUND_TO_ZERO | _MM_FROUND_NO_EXC, 3, 1, 0);
    return fail;
}

static int check_round_pd(void) {
    __m128d a, b = _mm_setzero_pd(), r;
    double lanes[2] = {value(), value()};
    memcpy(&a, lanes, 16);
    int fail = 0, pe, inexact = 0;
    for (int i = 0; i < 2; i++)
        inexact |= lanes[i] == lanes[i] && model_round(lanes[i], 3) != lanes[i];
#define ROUND_PD(M, mode, rc, want_pe)                                 \
    do {                                                               \
        RUN(__m128d, r, _mm_round_pd(x_, M), rc, pe);                  \
        for (int i = 0; i < 2; i++)                                    \
            if (bits_d(r[i]) != bits_d(model_round(lanes[i], mode)))   \
                fail = 2;                                              \
        if (pe != ((want_pe) && inexact))                              \
            fail = 2;                                                  \
    } while (0)
    ROUND_PD(_MM_FROUND_TO_NEAREST_INT, 0, 3, 1);
    ROUND_PD(_MM_FROUND_TO_NEG_INF, 1, 2, 1);
    ROUND_PD(_MM_FROUND_TO_POS_INF, 2, 1, 1);
    ROUND_PD(_MM_FROUND_TO_ZERO, 3, 0, 1);
    ROUND_PD(_MM_FROUND_TO_NEG_INF | _MM_FROUND_NO_EXC, 1, 0, 0);
    ROUND_PD(_MM_FROUND_TO_POS_INF | _MM_FROUND_NO_EXC, 2, 0, 0);
    return fail;
}

// The scalar forms round the second operand's low lane and keep the first
// operand's others; floor and ceiling are the downward and upward forms.
static int check_round_scalar(void) {
    float fa[4], fb[4];
    double da[2], db[2];
    for (int i = 0; i < 4; i++) {
        fa[i] = fvalue();
        fb[i] = fvalue();
    }
    for (int i = 0; i < 2; i++) {
        da[i] = value();
        db[i] = value();
    }
    __m128 a, b, r;
    __m128d c, d, s;
    memcpy(&a, fa, 16);
    memcpy(&b, fb, 16);
    memcpy(&c, da, 16);
    memcpy(&d, db, 16);
    int fail = 0;
    r = _mm_round_ss(a, b, _MM_FROUND_TO_ZERO);
    fail |= bits_f(r[0]) != bits_f(model_round_f(fb[0], 3));
    for (int i = 1; i < 4; i++)
        fail |= bits_f(r[i]) != bits_f(fa[i]);
    s = _mm_round_sd(c, d, _MM_FROUND_TO_POS_INF);
    fail |= bits_d(s[0]) != bits_d(model_round(db[0], 2)) || bits_d(s[1]) != bits_d(da[1]);
    r = _mm_floor_ps(b);
    for (int i = 0; i < 4; i++)
        fail |= bits_f(r[i]) != bits_f(model_round_f(fb[i], 1));
    r = _mm_ceil_ps(b);
    for (int i = 0; i < 4; i++)
        fail |= bits_f(r[i]) != bits_f(model_round_f(fb[i], 2));
    s = _mm_floor_pd(d);
    fail |= bits_d(s[0]) != bits_d(model_round(db[0], 1));
    s = _mm_ceil_pd(d);
    fail |= bits_d(s[1]) != bits_d(model_round(db[1], 2));
    r = _mm_floor_ss(a, b);
    fail |= bits_f(r[0]) != bits_f(model_round_f(fb[0], 1)) || bits_f(r[3]) != bits_f(fa[3]);
    r = _mm_ceil_ss(a, b);
    fail |= bits_f(r[0]) != bits_f(model_round_f(fb[0], 2)) || bits_f(r[2]) != bits_f(fa[2]);
    s = _mm_floor_sd(c, d);
    fail |= bits_d(s[0]) != bits_d(model_round(db[0], 1)) || bits_d(s[1]) != bits_d(da[1]);
    s = _mm_ceil_sd(c, d);
    fail |= bits_d(s[0]) != bits_d(model_round(db[0], 2)) || bits_d(s[1]) != bits_d(da[1]);
    return fail ? 4 : 0;
}

// _MM_FROUND_CUR_DIRECTION takes MXCSR's direction; RINT raises the
// precision exception for an inexact result and NEARBYINT does not.
static int check_current_direction(void) {
    __m128 a, b = _mm_setzero_ps(), r;
    __m128d c = {value(), value()}, s;
    float lanes[4];
    for (int i = 0; i < 4; i++)
        lanes[i] = fvalue();
    memcpy(&a, lanes, 16);
    int fail = 0, pe, inexact = 0;
    for (int i = 0; i < 4; i++)
        inexact |= lanes[i] == lanes[i] && model_round_f(lanes[i], 3) != lanes[i];
    for (int rc = 0; rc < 4; rc++) {
        RUN(__m128, r, _mm_round_ps(x_, _MM_FROUND_CUR_DIRECTION), rc, pe);
        for (int i = 0; i < 4; i++)
            fail |= bits_f(r[i]) != bits_f(model_round_f(lanes[i], rc));
        fail |= pe != inexact;
        RUN(__m128, r, _mm_round_ps(x_, _MM_FROUND_RINT), rc, pe);
        fail |= bits_f(r[1]) != bits_f(model_round_f(lanes[1], rc)) || pe != inexact;
        RUN(__m128, r, _mm_round_ps(x_, _MM_FROUND_NEARBYINT), rc, pe);
        fail |= bits_f(r[2]) != bits_f(model_round_f(lanes[2], rc)) || pe != 0;
        {
            __m128d a = c, b = c;
            RUN(__m128d, s, _mm_round_pd(x_, _MM_FROUND_NEARBYINT), rc, pe);
            fail |= bits_d(s[0]) != bits_d(model_round(c[0], rc)) || pe != 0;
            fail |= bits_d(s[1]) != bits_d(model_round(c[1], rc));
        }
    }
    return fail ? 8 : 0;
}

// DPPS / DPPD: the products imm8[7:4] selects, +0.0 for the others,
// summed in pairs and the pair sums added; the sum in the lanes imm8[3:0]
// selects and +0.0 in the others.
static float small(void) {
    static const float v[8] = {-0.0f, 0.0f, 1.0f, -1.5f, 0.1f, 3e38f, -3e38f, 7.0f};
    u64 r = next();
    return r >> 61 == 0 ? v[(r >> 40) & 7] : (float)((long long)(r >> 44) - (1 << 19)) / 256;
}

static int check_dot_products(void) {
    float x[4], y[4];
    for (int i = 0; i < 4; i++) {
        x[i] = small();
        y[i] = small();
    }
    __m128 a, b;
    memcpy(&a, x, 16);
    memcpy(&b, y, 16);
    int fail = 0;
#define DPPS(M)                                                                   \
    do {                                                                          \
        volatile float p[4];                                                      \
        float want[4];                                                            \
        for (int i = 0; i < 4; i++)                                               \
            p[i] = (M) >> (4 + i) & 1 ? x[i] * y[i] : 0.0f;                       \
        float sum = (p[0] + p[1]) + (p[2] + p[3]);                                \
        for (int i = 0; i < 4; i++)                                               \
            want[i] = (M) >> i & 1 ? sum : 0.0f;                                  \
        __m128 r = _mm_dp_ps(a, b, M);                                            \
        for (int i = 0; i < 4; i++)                                               \
            if (bits_f(r[i]) != bits_f(want[i]))                                  \
                fail = 16;                                                        \
    } while (0)
    DPPS(0xFF);
    DPPS(0xF1);
    DPPS(0x7F);
    DPPS(0x3C);
    DPPS(0xA5);
    DPPS(0x0F);
    DPPS(0xF0);
    DPPS(0x82);
    double u[2] = {x[0], x[1] * 1e-3}, v[2] = {y[2], y[3]};
    __m128d c, d;
    memcpy(&c, u, 16);
    memcpy(&d, v, 16);
#define DPPD(M)                                                                    \
    do {                                                                           \
        volatile double p0 = (M) & 0x10 ? u[0] * v[0] : 0.0;                       \
        volatile double p1 = (M) & 0x20 ? u[1] * v[1] : 0.0;                       \
        double sum = p0 + p1;                                                      \
        __m128d r = _mm_dp_pd(c, d, M);                                            \
        if (bits_d(r[0]) != bits_d((M) & 1 ? sum : 0.0) ||                         \
            bits_d(r[1]) != bits_d((M) & 2 ? sum : 0.0))                           \
            fail = 16;                                                             \
    } while (0)
    DPPD(0x33);
    DPPD(0x31);
    DPPD(0x12);
    DPPD(0x23);
    DPPD(0x03);
    DPPD(0xF0);
    return fail;
}

// INSERTPS: lane imm8[7:6] of the second operand into lane imm8[5:4] of
// the first, then the lanes imm8[3:0] names zeroed. EXTRACTPS: a lane's
// bits as an int.
static int check_insert_extract(void) {
    unsigned x[4], y[4];
    for (int i = 0; i < 4; i++) {
        x[i] = (unsigned)next();
        y[i] = (unsigned)(next() >> 7);
    }
    __m128 a, b;
    memcpy(&a, x, 16);
    memcpy(&b, y, 16);
    int fail = 0;
#define INSERTPS(M)                                     \
    do {                                                \
        unsigned want[4], got[4];                       \
        memcpy(want, x, 16);                            \
        want[(M) >> 4 & 3] = y[(M) >> 6 & 3];           \
        for (int i = 0; i < 4; i++)                     \
            if ((M) >> i & 1)                           \
                want[i] = 0;                            \
        __m128 r = _mm_insert_ps(a, b, M);              \
        memcpy(got, &r, 16);                            \
        if (memcmp(got, want, 16) != 0)                 \
            fail = 32;                                  \
    } while (0)
    INSERTPS(0x00);
    INSERTPS(0x10);
    INSERTPS(0x6C);
    INSERTPS(0xB1);
    INSERTPS(0xF0);
    INSERTPS(0xCF);
    INSERTPS(0x3A);
    INSERTPS(0x96);
    if (_mm_extract_ps(a, 0) != (int)x[0] || _mm_extract_ps(a, 1) != (int)x[1] ||
        _mm_extract_ps(a, 2) != (int)x[2] || _mm_extract_ps(a, 3) != (int)x[3])
        fail = 32;
    return fail;
}

// BLENDPS / BLENDPD take lane i of the second operand where imm8 bit i is
// set; BLENDVPS / BLENDVPD where the mask lane's sign bit is.
static int check_blends(void) {
    unsigned x[4], y[4], m[4];
    for (int i = 0; i < 4; i++) {
        x[i] = (unsigned)next();
        y[i] = (unsigned)(next() >> 3);
        m[i] = (unsigned)(next() >> 17);
    }
    __m128 a, b, k;
    memcpy(&a, x, 16);
    memcpy(&b, y, 16);
    memcpy(&k, m, 16);
    int fail = 0;
    unsigned want[4], got[4];
#define BLENDPS(M)                                      \
    do {                                                \
        for (int i = 0; i < 4; i++)                     \
            want[i] = (M) >> i & 1 ? y[i] : x[i];       \
        __m128 r = _mm_blend_ps(a, b, M);               \
        memcpy(got, &r, 16);                            \
        if (memcmp(got, want, 16) != 0)                 \
            fail = 64;                                  \
    } while (0)
    BLENDPS(0);
    BLENDPS(5);
    BLENDPS(10);
    BLENDPS(15);
    BLENDPS(9);
    for (int i = 0; i < 4; i++)
        want[i] = m[i] >> 31 ? y[i] : x[i];
    __m128 r = _mm_blendv_ps(a, b, k);
    memcpy(got, &r, 16);
    if (memcmp(got, want, 16) != 0)
        fail = 64;
    __m128d c = _mm_castps_pd(a), d = _mm_castps_pd(b), n = _mm_castps_pd(k);
    __m128d s = _mm_blend_pd(c, d, 2);
    memcpy(got, &s, 16);
    if (got[0] != x[0] || got[1] != x[1] || got[2] != y[2] || got[3] != y[3])
        fail = 64;
    s = _mm_blendv_pd(c, d, n);
    memcpy(got, &s, 16);
    for (int i = 0; i < 4; i++)
        if (got[i] != (m[i | 1] >> 31 ? y[i] : x[i]))
            fail = 64;
    return fail;
}

int main(void) {
    csr = _mm_getcsr();
    int fail = 0;
    for (int round = 0; round < 300; round++) {
        fail |= check_round_ps();
        fail |= check_round_pd();
        fail |= check_round_scalar();
        fail |= check_current_direction();
        fail |= check_dot_products();
        fail |= check_insert_extract();
        fail |= check_blends();
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
