// SSE4.1's integer operations and SSE4.2's PCMPGTQ -- the minimums and
// maximums, PMULLD, PMULDQ, PACKUSDW, the sign and zero extensions, the
// blends, the element accesses, PTEST, PHMINPOSUW, MPSADBW and MOVNTDQA --
// each checked against the result the SDM defines for its instruction: a
// model over the bytes of the operands, on random lanes mixed with the
// edge values. The exit code has bit N set when group N fails; elsewhere
// than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <smmintrin.h>
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

static int check_extremes(const unsigned char *a, const unsigned char *b) {
    static const int shape[4][2] = {{1, 1}, {2, 0}, {4, 1}, {4, 0}};
    __m128i x = vec(a), y = vec(b);
    __m128i got[8] = {_mm_min_epi8(x, y),  _mm_max_epi8(x, y),  _mm_min_epu16(x, y),
                      _mm_max_epu16(x, y), _mm_min_epi32(x, y), _mm_max_epi32(x, y),
                      _mm_min_epu32(x, y), _mm_max_epu32(x, y)};
    for (int s = 0; s < 8; s++) {
        int w = shape[s / 2][0], sg = shape[s / 2][1], is_max = s & 1;
        unsigned char want[16];
        for (int i = 0; i < 16 / w; i++) {
            long long l = lane(a, w, i, sg), m = lane(b, w, i, sg);
            int less = sg ? l < m : (u64)l < (u64)m;
            int pick_a = is_max ? !less && l != m : less;
            set_lane(want, w, i, (u64)(pick_a ? l : m));
        }
        if (!same(got[s], want))
            return 1;
    }
    return 0;
}

// PMULLD keeps the low doubleword of each product; PMULDQ multiplies the
// even doublewords signed into quadwords; PACKUSDW saturates signed
// doublewords into unsigned words; PCMPGTQ compares quadwords signed.
static int check_products_packs(const unsigned char *a, const unsigned char *b) {
    unsigned char lo[16], dq[16], pk[16], gt[16];
    for (int i = 0; i < 4; i++)
        set_lane(lo, 4, i, (u64)lane(a, 4, i, 0) * (u64)lane(b, 4, i, 0));
    for (int i = 0; i < 2; i++) {
        set_lane(dq, 8, i, (u64)(lane(a, 4, 2 * i, 1) * lane(b, 4, 2 * i, 1)));
        set_lane(gt, 8, i, lane(a, 8, i, 1) > lane(b, 8, i, 1) ? ~0ULL : 0);
    }
    for (int i = 0; i < 8; i++) {
        long long v = lane(i < 4 ? a : b, 4, i % 4, 1);
        set_lane(pk, 2, i, (u64)(v < 0 ? 0 : v > 0xFFFF ? 0xFFFF : v));
    }
    __m128i x = vec(a), y = vec(b);
    return same(_mm_mullo_epi32(x, y), lo) && same(_mm_mul_epi32(x, y), dq) &&
                   same(_mm_packus_epi32(x, y), pk) && same(_mm_cmpgt_epi64(x, y), gt)
               ? 0
               : 2;
}

// PMOVSX / PMOVZX widen the low lanes of the source.
static int check_extensions(const unsigned char *a) {
    static const int shape[6][2] = {{1, 2}, {1, 4}, {1, 8}, {2, 4}, {2, 8}, {4, 8}};
    __m128i x = vec(a);
    __m128i got[12] = {_mm_cvtepi8_epi16(x),  _mm_cvtepi8_epi32(x),  _mm_cvtepi8_epi64(x),
                       _mm_cvtepi16_epi32(x), _mm_cvtepi16_epi64(x), _mm_cvtepi32_epi64(x),
                       _mm_cvtepu8_epi16(x),  _mm_cvtepu8_epi32(x),  _mm_cvtepu8_epi64(x),
                       _mm_cvtepu16_epi32(x), _mm_cvtepu16_epi64(x), _mm_cvtepu32_epi64(x)};
    for (int s = 0; s < 12; s++) {
        int from = shape[s % 6][0], to = shape[s % 6][1], sg = s < 6;
        unsigned char want[16];
        for (int i = 0; i < 16 / to; i++)
            set_lane(want, to, i, (u64)lane(a, from, i, sg));
        if (!same(got[s], want))
            return 4;
    }
    return 0;
}

// PBLENDW takes word i of the second operand where imm8 bit i is set;
// PBLENDVB takes byte i where the mask byte's sign bit is.
static int check_blends(const unsigned char *a, const unsigned char *b, const unsigned char *m) {
    unsigned char want[16];
    int fail = 0;
#define BLENDW(M)                                                     \
    do {                                                              \
        for (int i = 0; i < 8; i++)                                   \
            set_lane(want, 2, i, (u64)lane((M) >> i & 1 ? b : a, 2, i, 0)); \
        if (!same(_mm_blend_epi16(vec(a), vec(b), M), want))          \
            fail = 8;                                                 \
    } while (0)
    BLENDW(0x00);
    BLENDW(0xFF);
    BLENDW(0xA5);
    BLENDW(0x3C);
    BLENDW(0x81);
    for (int i = 0; i < 16; i++)
        want[i] = m[i] & 0x80 ? b[i] : a[i];
    if (!same(_mm_blendv_epi8(vec(a), vec(b), vec(m)), want))
        fail = 8;
    return fail;
}

// PEXTRB zero-extends its byte; the inserts replace one lane.
static int check_elements(const unsigned char *a, const unsigned char *b) {
    int s = (int)lane(b, 4, 0, 1);
    long long q = lane(b, 8, 1, 1);
    unsigned char want[16];
    int fail = 0;
    if (_mm_extract_epi8(vec(a), 0) != a[0] || _mm_extract_epi8(vec(a), 9) != a[9] ||
        _mm_extract_epi8(vec(a), 15) != a[15])
        fail = 16;
    if (_mm_extract_epi32(vec(a), 3) != (int)lane(a, 4, 3, 1) ||
        _mm_extract_epi64(vec(a), 0) != lane(a, 8, 0, 1) ||
        _mm_extract_epi64(vec(a), 1) != lane(a, 8, 1, 1))
        fail = 16;
    memcpy(want, a, 16);
    want[11] = (unsigned char)s;
    if (!same(_mm_insert_epi8(vec(a), s, 11), want))
        fail = 16;
    memcpy(want, a, 16);
    set_lane(want, 4, 2, (u64)s);
    if (!same(_mm_insert_epi32(vec(a), s, 2), want))
        fail = 16;
    memcpy(want, a, 16);
    set_lane(want, 8, 1, (u64)q);
    if (!same(_mm_insert_epi64(vec(a), q, 1), want))
        fail = 16;
    return fail;
}

// PTEST: ZF when the AND is zero, CF when the AND with the first operand
// complemented is.
static int check_ptest(const unsigned char *a, const unsigned char *b) {
    unsigned char sparse[16];
    for (int i = 0; i < 16; i++)
        sparse[i] = a[i] & b[i] & 0x11;
    int fail = 0;
    const unsigned char *ops[3] = {a, b, sparse};
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++) {
            int z = 1, c = 1;
            for (int k = 0; k < 16; k++) {
                z &= (ops[i][k] & ops[j][k]) == 0;
                c &= (~ops[i][k] & ops[j][k] & 0xFF) == 0;
            }
            __m128i x = vec(ops[i]), y = vec(ops[j]);
            if (_mm_testz_si128(x, y) != z || _mm_testc_si128(x, y) != c ||
                _mm_testnzc_si128(x, y) != (!z && !c) || _mm_test_all_zeros(x, y) != z ||
                _mm_test_mix_ones_zeros(x, y) != (!z && !c))
                fail = 32;
        }
    int ones = 1;
    for (int k = 0; k < 16; k++)
        ones &= a[k] == 0xFF;
    if (_mm_test_all_ones(vec(a)) != ones || !_mm_test_all_ones(_mm_set1_epi32(-1)))
        fail = 32;
    return fail;
}

// PHMINPOSUW: the least unsigned word and the index of its first
// occurrence.
static int check_minpos(const unsigned char *a) {
    unsigned char want[16] = {0};
    int k = 0;
    for (int i = 1; i < 8; i++)
        if ((u64)lane(a, 2, i, 0) < (u64)lane(a, 2, k, 0))
            k = i;
    set_lane(want, 2, 0, (u64)lane(a, 2, k, 0));
    set_lane(want, 2, 1, (u64)k);
    return same(_mm_minpos_epu16(vec(a)), want) ? 0 : 64;
}

// MPSADBW: for each of eight windows of the first operand starting at
// 4 * imm8[2], the sum of absolute differences with the four bytes of the
// second at 4 * imm8[1:0]. MOVNTDQA loads as an ordinary load does.
static int check_mpsadbw(const unsigned char *a, const unsigned char *b) {
    unsigned char want[16];
    int fail = 0;
#define MPSADBW(M)                                                            \
    do {                                                                      \
        for (int i = 0; i < 8; i++) {                                         \
            int s = 0;                                                        \
            for (int k = 0; k < 4; k++) {                                     \
                int d = a[4 * ((M) >> 2 & 1) + i + k] - b[4 * ((M) & 3) + k]; \
                s += d < 0 ? -d : d;                                          \
            }                                                                 \
            set_lane(want, 2, i, (u64)s);                                     \
        }                                                                     \
        if (!same(_mm_mpsadbw_epu8(vec(a), vec(b), M), want))                 \
            fail = 128;                                                       \
    } while (0)
    MPSADBW(0);
    MPSADBW(1);
    MPSADBW(2);
    MPSADBW(3);
    MPSADBW(4);
    MPSADBW(5);
    MPSADBW(6);
    MPSADBW(7);
    static __m128i slot;
    memcpy(&slot, a, 16);
    if (!same(_mm_stream_load_si128(&slot), a))
        fail = 128;
    return fail;
}

int main(void) {
    int fail = 0;
    for (int round = 0; round < 300; round++) {
        unsigned char a[16], b[16], m[16];
        rnd(a, 16);
        rnd(b, 16);
        rnd(m, 16);
        if (round % 7 == 0)
            memcpy(b, a, 16);
        fail |= check_extremes(a, b);
        fail |= check_products_packs(a, b);
        fail |= check_extensions(a);
        fail |= check_blends(a, b, m);
        fail |= check_elements(a, b);
        fail |= check_ptest(a, b);
        fail |= check_minpos(a);
        fail |= check_mpsadbw(a, b);
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
