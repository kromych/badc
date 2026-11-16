// AVX2's 256-bit saturating arithmetic, averages, products, minimums and
// maximums, PABS and PSIGN, the horizontal sums and differences, the byte
// and word compares, the packs and the byte and word interleaves, each
// checked against the result the SDM defines for its instruction: a model
// over the bytes of the operands, each 128-bit lane on its own where the
// instruction works by lane, on random lanes mixed with the edge values.
// The exit code has bit N set when group N fails; elsewhere than x86-64
// the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <immintrin.h>
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

static __m256i vec(const unsigned char *b) {
    __m256i v;
    memcpy(&v, b, 32);
    return v;
}

static int same(__m256i v, const unsigned char *want) {
    unsigned char got[32];
    memcpy(got, &v, 32);
    return memcmp(got, want, 32) == 0;
}

static long long clamp(long long x, int w, int is_signed) {
    long long lo = is_signed ? -(1LL << (8 * w - 1)) : 0;
    long long hi = is_signed ? (1LL << (8 * w - 1)) - 1 : (1LL << 8 * w) - 1;
    return x < lo ? lo : x > hi ? hi : x;
}

static int check_saturating(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[8] = {_mm256_adds_epi8(x, y),  _mm256_adds_epi16(x, y), _mm256_adds_epu8(x, y),
                      _mm256_adds_epu16(x, y), _mm256_subs_epi8(x, y),  _mm256_subs_epi16(x, y),
                      _mm256_subs_epu8(x, y),  _mm256_subs_epu16(x, y)};
    for (int op = 0; op < 8; op++) {
        int w = op & 1 ? 2 : 1, sg = !(op & 2), sub = op >= 4;
        unsigned char want[32];
        for (int i = 0; i < 32 / w; i++) {
            long long l = lane(a, w, i, sg), m = lane(b, w, i, sg);
            set_lane(want, w, i, (u64)clamp(sub ? l - m : l + m, w, sg));
        }
        if (!same(got[op], want))
            return 1;
    }
    return 0;
}

// PAVG rounds the unsigned mean up; PMULHW, PMULHUW and PMULLW keep a half
// of the word product; PMULHRSW rounds it at bit 14; PMULDQ multiplies the
// even doublewords signed.
static int check_products(const unsigned char *a, const unsigned char *b) {
    unsigned char avg8[32], avg16[32], hs[32], hu[32], hrs[32], lo[32], dq[32];
    for (int i = 0; i < 32; i++)
        avg8[i] = (unsigned char)((a[i] + b[i] + 1) >> 1);
    for (int i = 0; i < 16; i++) {
        long long s = lane(a, 2, i, 1) * lane(b, 2, i, 1);
        u64 u = (u64)lane(a, 2, i, 0) * (u64)lane(b, 2, i, 0);
        set_lane(avg16, 2, i, ((u64)lane(a, 2, i, 0) + (u64)lane(b, 2, i, 0) + 1) >> 1);
        set_lane(hs, 2, i, (u64)(s >> 16));
        set_lane(hu, 2, i, u >> 16);
        set_lane(hrs, 2, i, (u64)(((s >> 14) + 1) >> 1));
        set_lane(lo, 2, i, (u64)s);
    }
    for (int i = 0; i < 4; i++)
        set_lane(dq, 8, i, (u64)(lane(a, 4, 2 * i, 1) * lane(b, 4, 2 * i, 1)));
    __m256i x = vec(a), y = vec(b);
    return same(_mm256_avg_epu8(x, y), avg8) && same(_mm256_avg_epu16(x, y), avg16) &&
                   same(_mm256_mulhi_epi16(x, y), hs) && same(_mm256_mulhi_epu16(x, y), hu) &&
                   same(_mm256_mulhrs_epi16(x, y), hrs) && same(_mm256_mullo_epi16(x, y), lo) &&
                   same(_mm256_mul_epi32(x, y), dq)
               ? 0
               : 2;
}

static int check_extremes(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[12] = {_mm256_min_epi8(x, y),  _mm256_max_epi8(x, y),  _mm256_min_epi16(x, y),
                       _mm256_max_epi16(x, y), _mm256_min_epi32(x, y), _mm256_max_epi32(x, y),
                       _mm256_min_epu8(x, y),  _mm256_max_epu8(x, y),  _mm256_min_epu16(x, y),
                       _mm256_max_epu16(x, y), _mm256_min_epu32(x, y), _mm256_max_epu32(x, y)};
    for (int s = 0; s < 12; s++) {
        int w = 1 << (s / 2 % 3), sg = s < 6, is_max = s & 1;
        unsigned char want[32];
        for (int i = 0; i < 32 / w; i++) {
            long long l = lane(a, w, i, sg), m = lane(b, w, i, sg);
            int less = sg ? l < m : (u64)l < (u64)m;
            set_lane(want, w, i, (u64)((is_max ? !less : less) ? l : m));
        }
        if (!same(got[s], want))
            return 4;
    }
    return 0;
}

// PABS gives the most negative lane back; PSIGN negates (wrapping), keeps
// or zeroes by the sign of the second operand's lane.
static int check_abs_sign(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i abs[3] = {_mm256_abs_epi8(x), _mm256_abs_epi16(x), _mm256_abs_epi32(x)};
    __m256i sign[3] = {_mm256_sign_epi8(x, y), _mm256_sign_epi16(x, y), _mm256_sign_epi32(x, y)};
    for (int s = 0; s < 3; s++) {
        int w = 1 << s;
        unsigned char wa[32], ws[32];
        for (int i = 0; i < 32 / w; i++) {
            long long l = lane(a, w, i, 1), m = lane(b, w, i, 1);
            set_lane(wa, w, i, (u64)(l < 0 ? -l : l));
            set_lane(ws, w, i, (u64)(m < 0 ? -l : m == 0 ? 0 : l));
        }
        if (!same(abs[s], wa) || !same(sign[s], ws))
            return 8;
    }
    return 0;
}

// The horizontal forms pair adjacent lanes within each 128-bit lane: its
// low half from the first operand's pairs, its high half from the second's.
static void model_horizontal(const unsigned char *a, const unsigned char *b, int w, int sub,
                             int saturate, unsigned char *out) {
    int pairs = 8 / w;
    for (int h = 0; h < 2; h++)
        for (int i = 0; i < 2 * pairs; i++) {
            const unsigned char *src = (i < pairs ? a : b) + 16 * h;
            int k = 2 * (i % pairs);
            long long x = lane(src, w, k, 1), y = lane(src, w, k + 1, 1);
            long long r = sub ? x - y : x + y;
            set_lane(out + 16 * h, w, i, (u64)(saturate ? clamp(r, w, 1) : r));
        }
}

static int check_horizontal(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[6] = {_mm256_hadd_epi16(x, y),  _mm256_hadd_epi32(x, y),
                      _mm256_hsub_epi16(x, y),  _mm256_hsub_epi32(x, y),
                      _mm256_hadds_epi16(x, y), _mm256_hsubs_epi16(x, y)};
    static const int shape[6][3] = {{2, 0, 0}, {4, 0, 0}, {2, 1, 0},
                                    {4, 1, 0}, {2, 0, 1}, {2, 1, 1}};
    for (int s = 0; s < 6; s++) {
        unsigned char want[32];
        model_horizontal(a, b, shape[s][0], shape[s][1], shape[s][2], want);
        if (!same(got[s], want))
            return 16;
    }
    return 0;
}

static int check_compares(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[4] = {_mm256_cmpgt_epi8(x, y), _mm256_cmpgt_epi16(x, y), _mm256_cmpgt_epi32(x, y),
                      _mm256_cmpgt_epi64(x, y)};
    for (int s = 0; s < 4; s++) {
        int w = 1 << s;
        unsigned char want[32];
        for (int i = 0; i < 32 / w; i++)
            set_lane(want, w, i, lane(a, w, i, 1) > lane(b, w, i, 1) ? ~0ULL : 0);
        if (!same(got[s], want))
            return 32;
    }
    return 0;
}

// The packs saturate each 128-bit lane of the first operand into the low
// half of that lane of the result and the second's into the high half.
static int check_packs(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[4] = {_mm256_packs_epi16(x, y), _mm256_packs_epi32(x, y),
                      _mm256_packus_epi16(x, y), _mm256_packus_epi32(x, y)};
    for (int s = 0; s < 4; s++) {
        int w = s & 1 ? 4 : 2, sg = s < 2, n = 16 / w;
        unsigned char want[32];
        for (int h = 0; h < 2; h++)
            for (int i = 0; i < 2 * n; i++) {
                long long v = lane((i < n ? a : b) + 16 * h, w, i % n, 1);
                set_lane(want + 16 * h, w / 2, i, (u64)clamp(v, w / 2, sg));
            }
        if (!same(got[s], want))
            return 64;
    }
    return 0;
}

// The interleaves alternate the lanes of the low or high half of each
// 128-bit lane, the first operand's first.
static int check_unpacks(const unsigned char *a, const unsigned char *b) {
    __m256i x = vec(a), y = vec(b);
    __m256i got[4] = {_mm256_unpacklo_epi8(x, y), _mm256_unpacklo_epi16(x, y),
                      _mm256_unpackhi_epi8(x, y), _mm256_unpackhi_epi16(x, y)};
    for (int s = 0; s < 4; s++) {
        int w = s & 1 ? 2 : 1, n = 16 / w, base = s >= 2 ? n / 2 : 0;
        unsigned char want[32];
        for (int h = 0; h < 2; h++)
            for (int i = 0; i < n / 2; i++) {
                set_lane(want + 16 * h, w, 2 * i, (u64)lane(a + 16 * h, w, base + i, 0));
                set_lane(want + 16 * h, w, 2 * i + 1, (u64)lane(b + 16 * h, w, base + i, 0));
            }
        if (!same(got[s], want))
            return 128;
    }
    return 0;
}

int main(void) {
    int fail = 0;
    for (int round = 0; round < 300; round++) {
        unsigned char a[32], b[32];
        rnd(a, 32);
        rnd(b, 32);
        if (round % 5 == 0)
            memcpy(b + 8, a + 8, 8);
        fail |= check_saturating(a, b);
        fail |= check_products(a, b);
        fail |= check_extremes(a, b);
        fail |= check_abs_sign(a, b);
        fail |= check_horizontal(a, b);
        fail |= check_compares(a, b);
        fail |= check_packs(a, b);
        fail |= check_unpacks(a, b);
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
