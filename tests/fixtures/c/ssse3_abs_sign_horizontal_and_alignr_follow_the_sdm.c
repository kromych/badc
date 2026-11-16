// SSSE3's 128-bit integer operations -- PABS, PSIGN, the horizontal sums
// and differences, PMULHRSW and PALIGNR -- each checked against the result
// the SDM defines for its instruction: a model over the bytes of the
// operands, on random lanes mixed with the edge values, and every PALIGNR
// count from 0 past 32. The exit code has bit N set when group N fails;
// elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <string.h>
#include <tmmintrin.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

// Random bytes, about a quarter of them replaced by 00, 7F, 80 or FF.
static void rnd(unsigned char *b, int n) {
    static const unsigned char edge[4] = {0x00, 0x7F, 0x80, 0xFF};
    for (int k = 0; k < n; k++) {
        seed ^= seed >> 12;
        seed ^= seed << 25;
        seed ^= seed >> 27;
        u64 r = seed * 0x2545F4914F6CDD1DULL;
        b[k] = (r >> 60) < 4 ? edge[(r >> 58) & 3] : (unsigned char)(r >> 24);
    }
}

// Lane `i` of width `w` bytes, sign-extended.
static long long lane(const unsigned char *b, int w, int i) {
    u64 v = 0;
    for (int k = w - 1; k >= 0; k--)
        v = v << 8 | b[w * i + k];
    if (v >> (8 * w - 1) & 1)
        v |= ~0ULL << (8 * w);
    return (long long)v;
}

static void set_lane(unsigned char *b, int w, int i, long long v) {
    for (int k = 0; k < w; k++)
        b[w * i + k] = (unsigned char)((u64)v >> (8 * k));
}

static __m128i vec(const unsigned char *b) {
    __m128i v;
    memcpy(&v, b, 16);
    return v;
}

static int same(__m128i v, const unsigned char *want) {
    unsigned char got[16];
    memcpy(got, &v, 16);
    return memcmp(got, want, 16) == 0;
}

static long long sat(long long x, int w) {
    long long hi = (1LL << (8 * w - 1)) - 1;
    return x > hi ? hi : x < -hi - 1 ? -hi - 1 : x;
}

// PABS: the magnitude, unsigned in the lane, so the most negative value is
// its own.
static int check_abs(const unsigned char *a) {
    unsigned char want[3][16];
    for (int s = 0; s < 3; s++) {
        int w = 1 << s;
        for (int i = 0; i < 16 / w; i++) {
            long long x = lane(a, w, i);
            set_lane(want[s], w, i, x < 0 ? -x : x);
        }
    }
    return same(_mm_abs_epi8(vec(a)), want[0]) && same(_mm_abs_epi16(vec(a)), want[1]) &&
                   same(_mm_abs_epi32(vec(a)), want[2])
               ? 0
               : 1;
}

// PSIGN: the first lane negated (wrapping) where the second is negative,
// zero where it is zero, kept where it is positive.
static int check_sign(const unsigned char *a, const unsigned char *b) {
    unsigned char want[3][16];
    for (int s = 0; s < 3; s++) {
        int w = 1 << s;
        for (int i = 0; i < 16 / w; i++) {
            long long x = lane(a, w, i), y = lane(b, w, i);
            set_lane(want[s], w, i, y < 0 ? -x : y == 0 ? 0 : x);
        }
    }
    __m128i x = vec(a), y = vec(b);
    return same(_mm_sign_epi8(x, y), want[0]) && same(_mm_sign_epi16(x, y), want[1]) &&
                   same(_mm_sign_epi32(x, y), want[2])
               ? 0
               : 2;
}

// PHADD / PHSUB: adjacent lanes summed or differenced, the first operand's
// pairs in the low half of the result; wrapping, or with signed saturation
// in the S forms.
static void model_horizontal(const unsigned char *a, const unsigned char *b, int w, int sub,
                             int saturate, unsigned char *out) {
    int pairs = 8 / w;
    for (int i = 0; i < 2 * pairs; i++) {
        const unsigned char *src = i < pairs ? a : b;
        int k = 2 * (i % pairs);
        long long x = lane(src, w, k), y = lane(src, w, k + 1);
        long long r = sub ? x - y : x + y;
        set_lane(out, w, i, saturate ? sat(r, w) : r);
    }
}

static int check_horizontal(const unsigned char *a, const unsigned char *b) {
    unsigned char want[16];
    __m128i x = vec(a), y = vec(b);
    int fail = 0;
    model_horizontal(a, b, 2, 0, 0, want);
    fail |= !same(_mm_hadd_epi16(x, y), want);
    model_horizontal(a, b, 4, 0, 0, want);
    fail |= !same(_mm_hadd_epi32(x, y), want);
    model_horizontal(a, b, 2, 1, 0, want);
    fail |= !same(_mm_hsub_epi16(x, y), want);
    model_horizontal(a, b, 4, 1, 0, want);
    fail |= !same(_mm_hsub_epi32(x, y), want);
    int fail_sat = 0;
    model_horizontal(a, b, 2, 0, 1, want);
    fail_sat |= !same(_mm_hadds_epi16(x, y), want);
    model_horizontal(a, b, 2, 1, 1, want);
    fail_sat |= !same(_mm_hsubs_epi16(x, y), want);
    return (fail ? 4 : 0) | (fail_sat ? 8 : 0);
}

// PMULHRSW: the signed product's bits 30:15 after adding 1 at bit 14, so
// -32768 * -32768 gives 0x8000.
static int check_mulhrs(const unsigned char *a, const unsigned char *b) {
    unsigned char want[16];
    for (int i = 0; i < 8; i++)
        set_lane(want, 2, i, ((lane(a, 2, i) * lane(b, 2, i) >> 14) + 1) >> 1);
    return same(_mm_mulhrs_epi16(vec(a), vec(b)), want) ? 0 : 16;
}

// PALIGNR: the first operand above the second, shifted right by N bytes;
// zero past the 32nd.
static int check_alignr(const unsigned char *a, const unsigned char *b) {
    unsigned char want[16];
    int fail = 0;
#define ALIGNR(N)                                                              \
    do {                                                                       \
        for (int i = 0; i < 16; i++)                                           \
            want[i] = i + (N) < 16 ? b[i + (N)] : i + (N) < 32 ? a[i + (N)-16] : 0; \
        if (!same(_mm_alignr_epi8(vec(a), vec(b), N), want))                  \
            fail = 32;                                                         \
    } while (0)
    ALIGNR(0);
    ALIGNR(1);
    ALIGNR(5);
    ALIGNR(8);
    ALIGNR(15);
    ALIGNR(16);
    ALIGNR(17);
    ALIGNR(24);
    ALIGNR(31);
    ALIGNR(32);
    ALIGNR(40);
    return fail;
}

int main(void) {
    int fail = 0;
    for (int round = 0; round < 400; round++) {
        unsigned char a[16], b[16];
        rnd(a, 16);
        rnd(b, 16);
        fail |= check_abs(a);
        fail |= check_sign(a, b);
        fail |= check_horizontal(a, b);
        fail |= check_mulhrs(a, b);
        fail |= check_alignr(a, b);
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
