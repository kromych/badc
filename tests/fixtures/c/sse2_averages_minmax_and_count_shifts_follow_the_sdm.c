// SSE2's unsigned high product, averages, minimums and maximums, the
// shifts by a vector count, the byte shifts' b-spelled names, MOVQ, the
// non-temporal stores, MASKMOVDQU and CLFLUSH, each checked against the
// result the SDM defines for its instruction: a model over the bytes of the
// operands, on random lanes mixed with the edge values and on shift counts
// at, past and far past the lane width. The exit code has bit N set when
// group N fails; elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <emmintrin.h>
#include <string.h>

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

// Lane `i` of width `w` bytes, zero- or sign-extended.
static long long lane(const unsigned char *b, int w, int i, int is_signed) {
    u64 v = 0;
    for (int k = w - 1; k >= 0; k--)
        v = v << 8 | b[w * i + k];
    if (is_signed && w < 8 && (v >> (8 * w - 1) & 1))
        v |= ~0ULL << (8 * w);
    return (long long)v;
}

static void set_lane(unsigned char *b, int w, int i, u64 v) {
    for (int k = 0; k < w; k++)
        b[w * i + k] = (unsigned char)(v >> (8 * k));
}

static int same(__m128i v, const unsigned char *want) {
    unsigned char got[16];
    memcpy(got, &v, 16);
    return memcmp(got, want, 16) == 0;
}

static __m128i vec(const unsigned char *b) {
    __m128i v;
    memcpy(&v, b, 16);
    return v;
}

static int check_products_and_averages(const unsigned char *a, const unsigned char *b) {
    unsigned char hi[16], avg8[16], avg16[16];
    for (int i = 0; i < 8; i++) {
        u64 x = (u64)lane(a, 2, i, 0), y = (u64)lane(b, 2, i, 0);
        set_lane(hi, 2, i, x * y >> 16);
        set_lane(avg16, 2, i, (x + y + 1) >> 1);
    }
    for (int i = 0; i < 16; i++)
        avg8[i] = (unsigned char)((a[i] + b[i] + 1) >> 1);
    int fail = 0;
    if (!same(_mm_mulhi_epu16(vec(a), vec(b)), hi))
        fail |= 1;
    if (!same(_mm_avg_epu8(vec(a), vec(b)), avg8) || !same(_mm_avg_epu16(vec(a), vec(b)), avg16))
        fail |= 2;
    return fail;
}

static int check_extremes(const unsigned char *a, const unsigned char *b) {
    unsigned char mins[16], maxs[16], minu[16], maxu[16];
    for (int i = 0; i < 8; i++) {
        long long x = lane(a, 2, i, 1), y = lane(b, 2, i, 1);
        set_lane(mins, 2, i, (u64)(x < y ? x : y));
        set_lane(maxs, 2, i, (u64)(x > y ? x : y));
    }
    for (int i = 0; i < 16; i++) {
        minu[i] = a[i] < b[i] ? a[i] : b[i];
        maxu[i] = a[i] > b[i] ? a[i] : b[i];
    }
    __m128i x = vec(a), y = vec(b);
    return same(_mm_min_epi16(x, y), mins) && same(_mm_max_epi16(x, y), maxs) &&
                   same(_mm_min_epu8(x, y), minu) && same(_mm_max_epu8(x, y), maxu)
               ? 0
               : 4;
}

// PSLL, PSRL and PSRA by the count in the low quadword of a vector, read
// as an unsigned 64-bit value: a count past the lane width clears the lane,
// or fills it with the sign for PSRA. The count's high quadword is ignored.
static void model_shift(const unsigned char *a, int w, int kind, u64 n, unsigned char *out) {
    for (int i = 0; i < 16 / w; i++) {
        u64 x = (u64)lane(a, w, i, kind == 2), r;
        int bits = 8 * w;
        if (kind == 0)
            r = n >= (u64)bits ? 0 : x << n;
        else if (kind == 1)
            r = n >= (u64)bits ? 0 : x >> n;
        else
            r = (u64)(lane(a, w, i, 1) >> (n >= (u64)bits ? bits - 1 : (int)n));
        set_lane(out, w, i, r);
    }
}

static int check_count_shifts(const unsigned char *a, const unsigned char *junk) {
    static const u64 counts[] = {0,  1,  3,  7,  8,  15, 16, 17, 31,
                                 32, 33, 63, 64, 65, 255, 256, 0x100000001ULL, 1ULL << 63};
    int fail = 0;
    for (unsigned k = 0; k < sizeof counts / sizeof counts[0]; k++) {
        u64 hi;
        memcpy(&hi, junk, 8);
        __m128i c = _mm_set_epi64x((long long)hi, (long long)counts[k]);
        __m128i x = vec(a);
        unsigned char want[16];
        __m128i got[8] = {_mm_sll_epi16(x, c), _mm_sll_epi32(x, c), _mm_sll_epi64(x, c),
                          _mm_srl_epi16(x, c), _mm_srl_epi32(x, c), _mm_srl_epi64(x, c),
                          _mm_sra_epi16(x, c), _mm_sra_epi32(x, c)};
        static const int shape[8][2] = {{2, 0}, {4, 0}, {8, 0}, {2, 1},
                                        {4, 1}, {8, 1}, {2, 2}, {4, 2}};
        for (int s = 0; s < 8; s++) {
            model_shift(a, shape[s][0], shape[s][1], counts[k], want);
            if (!same(got[s], want))
                fail = 8;
        }
    }
    return fail;
}

static int check_byte_shifts(const unsigned char *a) {
    unsigned char want[16];
    int fail = 0;
#define BYTE_SHIFT(N)                                         \
    do {                                                      \
        for (int i = 0; i < 16; i++)                          \
            want[i] = i >= (N) ? a[i - (N)] : 0;              \
        if (!same(_mm_bslli_si128(vec(a), N), want))          \
            fail = 16;                                        \
        for (int i = 0; i < 16; i++)                          \
            want[i] = i + (N) < 16 ? a[i + (N)] : 0;          \
        if (!same(_mm_bsrli_si128(vec(a), N), want))          \
            fail = 16;                                        \
    } while (0)
    BYTE_SHIFT(0);
    BYTE_SHIFT(1);
    BYTE_SHIFT(9);
    BYTE_SHIFT(15);
    BYTE_SHIFT(16);
    return fail;
}

// The non-temporal stores write what an ordinary store does; MASKMOVDQU
// writes the bytes whose mask byte has its top bit set and leaves the rest;
// CLFLUSH changes no data.
static int check_stores(const unsigned char *a, const unsigned char *m) {
    static unsigned char line[64];
    unsigned char before[32], want[32];
    int fail = 0;
    rnd(before, 32);
    memcpy(line, before, 32);
    _mm_maskmoveu_si128(vec(a), vec(m), (char *)line + 3);
    memcpy(want, before, 32);
    for (int i = 0; i < 16; i++)
        if (m[i] & 0x80)
            want[3 + i] = a[i];
    if (memcmp(line, want, 32) != 0)
        fail = 32;
    _mm_clflush(line);
    _mm_clflush(line + 63);
    if (memcmp(line, want, 32) != 0)
        fail = 32;
    __m128i slot[2];
    _mm_stream_si128(&slot[1], vec(a));
    int i32 = 0;
    long long i64 = 0;
    _mm_stream_si32(&i32, (int)lane(m, 4, 1, 1));
    _mm_stream_si64(&i64, lane(m, 8, 1, 1));
    if (!same(slot[1], a) || i32 != (int)lane(m, 4, 1, 1) || i64 != lane(m, 8, 1, 1))
        fail = 32;
    return fail;
}

// MOVQ keeps the low quadword and zeroes the high one; the x-suffixed
// 64-bit transfers, which gcc and MSVC name and clang does not, are the
// unsuffixed ones.
#ifdef __clang__
#define _mm_cvtsi64x_si128 _mm_cvtsi64_si128
#define _mm_cvtsi128_si64x _mm_cvtsi128_si64
#define _mm_cvtss_si64x _mm_cvtss_si64
#define _mm_cvttss_si64x _mm_cvttss_si64
#define _mm_cvtsi64x_ss _mm_cvtsi64_ss
#endif
static int check_moves(const unsigned char *a) {
    unsigned char want[16] = {0};
    memcpy(want, a, 8);
    long long q = lane(a, 8, 1, 1);
    __m128i u = _mm_undefined_si128();
    __m128d d = _mm_undefined_pd();
    __m128 f = _mm_undefined_ps();
    (void)u;
    (void)d;
    (void)f;
    unsigned char lo[16] = {0};
    memcpy(lo, a + 8, 8);
    float g = (float)q;
    return same(_mm_move_epi64(vec(a)), want) && same(_mm_cvtsi64x_si128(q), lo) &&
                   _mm_cvtsi128_si64x(vec(a)) == lane(a, 8, 0, 1) &&
                   _mm_cvtss_si64x(_mm_set_ss(-2.5f)) == -2 &&
                   _mm_cvttss_si64x(_mm_set_ss(-2.75f)) == -2 &&
                   _mm_cvtss_f32(_mm_cvtsi64x_ss(_mm_setzero_ps(), q)) == g
               ? 0
               : 64;
}

int main(void) {
    int fail = 0;
    for (int round = 0; round < 300; round++) {
        unsigned char a[16], b[16];
        rnd(a, 16);
        rnd(b, 16);
        fail |= check_products_and_averages(a, b);
        fail |= check_extremes(a, b);
        fail |= check_count_shifts(a, b);
        fail |= check_byte_shifts(a);
        fail |= check_stores(a, b);
        fail |= check_moves(a);
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
