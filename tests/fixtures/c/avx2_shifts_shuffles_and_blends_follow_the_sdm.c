// AVX2's shifts by an immediate, a vector count and a count per lane, the
// in-lane shuffles and byte alignment, the blends, the sign and zero
// extensions, VMPSADBW and the broadcasts into 128 and 256 bits, each
// checked against the result the SDM defines for its instruction: a model
// over the bytes of the operands on random lanes mixed with the edge
// values, with shift counts at, past and far past the lane width. The exit
// code has bit N set when group N fails; elsewhere than x86-64 the unit is
// empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <immintrin.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

static u64 next(void) {
    seed ^= seed >> 12;
    seed ^= seed << 25;
    seed ^= seed >> 27;
    return seed * 0x2545F4914F6CDD1DULL;
}

// Random bytes, about a quarter of them replaced by 00, 7F, 80 or FF.
static void rnd(unsigned char *b, int n) {
    static const unsigned char edge[4] = {0x00, 0x7F, 0x80, 0xFF};
    for (int k = 0; k < n; k++) {
        u64 r = next();
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

static int same128(__m128i v, const unsigned char *want) {
    unsigned char got[16];
    memcpy(got, &v, 16);
    return memcmp(got, want, 16) == 0;
}

// A left (0), logical right (1) or arithmetic right (2) shift of each lane
// by the unsigned count `n`: past the width the lane clears or takes its
// sign.
static u64 shift(long long x, int w, int kind, u64 n) {
    int bits = 8 * w;
    u64 u = (u64)x & (w == 8 ? ~0ULL : (1ULL << bits) - 1);
    if (kind == 0)
        return n >= (u64)bits ? 0 : u << n;
    if (kind == 1)
        return n >= (u64)bits ? 0 : u >> n;
    return (u64)(x >> (n >= (u64)bits ? bits - 1 : (int)n));
}

static void model_shift(const unsigned char *a, int bytes, int w, int kind, u64 n,
                        unsigned char *out) {
    for (int i = 0; i < bytes / w; i++)
        set_lane(out, w, i, shift(lane(a, w, i, kind == 2), w, kind, n));
}

static int check_immediate_shifts(const unsigned char *a) {
    static const int counts[] = {0, 1, 7, 15, 16, 17, 31, 32, 33, 63, 64};
    unsigned char want[32];
    __m256i x = vec(a);
    int fail = 0;
    for (unsigned k = 0; k < sizeof counts / sizeof counts[0]; k++) {
        int n = counts[k];
        model_shift(a, 32, 2, 0, (u64)n, want);
        fail |= !same(_mm256_slli_epi16(x, n), want);
        model_shift(a, 32, 2, 1, (u64)n, want);
        fail |= !same(_mm256_srli_epi16(x, n), want);
        model_shift(a, 32, 2, 2, (u64)n, want);
        fail |= !same(_mm256_srai_epi16(x, n), want);
        model_shift(a, 32, 4, 2, (u64)n, want);
        fail |= !same(_mm256_srai_epi32(x, n), want);
    }
    return fail ? 1 : 0;
}

static int check_count_shifts(const unsigned char *a, const unsigned char *junk) {
    static const u64 counts[] = {0, 1, 9, 15, 16, 31, 32, 63, 64, 65, 0x100000001ULL, 1ULL << 63};
    unsigned char want[32];
    __m256i x = vec(a);
    int fail = 0;
    for (unsigned k = 0; k < sizeof counts / sizeof counts[0]; k++) {
        u64 hi;
        memcpy(&hi, junk, 8);
        __m128i c = _mm_set_epi64x((long long)hi, (long long)counts[k]);
        __m256i got[8] = {_mm256_sll_epi16(x, c), _mm256_sll_epi32(x, c), _mm256_sll_epi64(x, c),
                          _mm256_srl_epi16(x, c), _mm256_srl_epi32(x, c), _mm256_srl_epi64(x, c),
                          _mm256_sra_epi16(x, c), _mm256_sra_epi32(x, c)};
        static const int shape[8][2] = {{2, 0}, {4, 0}, {8, 0}, {2, 1},
                                        {4, 1}, {8, 1}, {2, 2}, {4, 2}};
        for (int s = 0; s < 8; s++) {
            model_shift(a, 32, shape[s][0], shape[s][1], counts[k], want);
            fail |= !same(got[s], want);
        }
    }
    return fail ? 2 : 0;
}

// VPSLLV, VPSRLV and VPSRAV: each lane by the unsigned count in the same
// lane of the second operand, mostly below 70, sometimes far past it.
static u64 count(int bits) {
    u64 r = next();
    u64 n = r >> 61 == 0 ? r >> 8 : (r >> 8) % 70;
    return bits == 32 ? (u64)(unsigned)n : n;
}

static int check_variable_shifts(const unsigned char *a) {
    unsigned char c32[32], c64[32], want[32];
    for (int i = 0; i < 8; i++)
        set_lane(c32, 4, i, count(32));
    for (int i = 0; i < 4; i++)
        set_lane(c64, 8, i, count(64));
    int fail = 0;
#define VAR(w, kind, got, k, bytes)                                                   \
    do {                                                                              \
        for (int i = 0; i < (bytes) / (w); i++)                                       \
            set_lane(want, w, i, shift(lane(a, w, i, (kind) == 2), w, kind,           \
                                       (u64)lane(k, w, i, 0)));                       \
        if (memcmp(&(got), want, bytes) != 0)                                         \
            fail = 4;                                                                 \
    } while (0)
    __m256i x = vec(a), n32 = vec(c32), n64 = vec(c64), r;
    __m128i x1, m32, m64, r1;
    memcpy(&x1, a, 16);
    memcpy(&m32, c32, 16);
    memcpy(&m64, c64, 16);
    r = _mm256_sllv_epi32(x, n32);
    VAR(4, 0, r, c32, 32);
    r = _mm256_srlv_epi32(x, n32);
    VAR(4, 1, r, c32, 32);
    r = _mm256_srav_epi32(x, n32);
    VAR(4, 2, r, c32, 32);
    r = _mm256_sllv_epi64(x, n64);
    VAR(8, 0, r, c64, 32);
    r = _mm256_srlv_epi64(x, n64);
    VAR(8, 1, r, c64, 32);
    r1 = _mm_sllv_epi32(x1, m32);
    VAR(4, 0, r1, c32, 16);
    r1 = _mm_srlv_epi32(x1, m32);
    VAR(4, 1, r1, c32, 16);
    r1 = _mm_srav_epi32(x1, m32);
    VAR(4, 2, r1, c32, 16);
    r1 = _mm_sllv_epi64(x1, m64);
    VAR(8, 0, r1, c64, 16);
    r1 = _mm_srlv_epi64(x1, m64);
    VAR(8, 1, r1, c64, 16);
    return fail;
}

// VPSHUFD, VPSHUFHW and VPSHUFLW pick within each 128-bit lane by one
// imm8; VPALIGNR shifts each lane pair right by bytes; the b-spelled byte
// shifts are VPSLLDQ and VPSRLDQ.
static int check_shuffles(const unsigned char *a, const unsigned char *b) {
    unsigned char want[32];
    __m256i x = vec(a), y = vec(b);
    int fail = 0;
#define SHUF(M)                                                                       \
    do {                                                                              \
        for (int i = 0; i < 8; i++)                                                   \
            set_lane(want, 4, i, (u64)lane(a, 4, (i & 4) + ((M) >> 2 * (i & 3) & 3), 0)); \
        fail |= !same(_mm256_shuffle_epi32(x, M), want);                              \
        for (int i = 0; i < 16; i++) {                                                \
            int base = i & 8, k = i & 7;                                              \
            int src = k < 4 ? i : base + 4 + ((M) >> 2 * (k - 4) & 3);               \
            set_lane(want, 2, i, (u64)lane(a, 2, src, 0));                            \
        }                                                                             \
        fail |= !same(_mm256_shufflehi_epi16(x, M), want);                            \
        for (int i = 0; i < 16; i++) {                                                \
            int base = i & 8, k = i & 7;                                              \
            int src = k >= 4 ? i : base + ((M) >> 2 * k & 3);                         \
            set_lane(want, 2, i, (u64)lane(a, 2, src, 0));                            \
        }                                                                             \
        fail |= !same(_mm256_shufflelo_epi16(x, M), want);                            \
    } while (0)
    SHUF(0x1B);
    SHUF(0x00);
    SHUF(0xE4);
    SHUF(0x93);
    SHUF(0x4E);
#define ALIGNR(N)                                                                     \
    do {                                                                              \
        for (int h = 0; h < 32; h += 16)                                              \
            for (int i = 0; i < 16; i++) {                                            \
                int k = i + (N);                                                      \
                want[h + i] = k < 16 ? b[h + k] : k < 32 ? a[h + k - 16] : 0;         \
            }                                                                         \
        fail |= !same(_mm256_alignr_epi8(x, y, N), want);                             \
    } while (0)
    ALIGNR(0);
    ALIGNR(1);
    ALIGNR(7);
    ALIGNR(15);
    ALIGNR(16);
    ALIGNR(17);
    ALIGNR(31);
    ALIGNR(32);
#define BYTESHIFT(N)                                                                  \
    do {                                                                              \
        for (int h = 0; h < 32; h += 16)                                              \
            for (int i = 0; i < 16; i++)                                              \
                want[h + i] = i >= (N) ? a[h + i - (N)] : 0;                          \
        fail |= !same(_mm256_bslli_epi128(x, N), want);                               \
        for (int h = 0; h < 32; h += 16)                                              \
            for (int i = 0; i < 16; i++)                                              \
                want[h + i] = i + (N) < 16 ? a[h + i + (N)] : 0;                      \
        fail |= !same(_mm256_bsrli_epi128(x, N), want);                               \
    } while (0)
    BYTESHIFT(0);
    BYTESHIFT(3);
    BYTESHIFT(15);
    BYTESHIFT(16);
    return fail ? 8 : 0;
}

// VPBLENDW repeats its imm8 over each lane; VPBLENDD takes a bit per
// doubleword; VPBLENDVB the byte where the mask byte's sign bit is set.
static int check_blends(const unsigned char *a, const unsigned char *b, const unsigned char *m) {
    unsigned char want[32];
    __m256i x = vec(a), y = vec(b);
    __m128i x1, y1;
    memcpy(&x1, a, 16);
    memcpy(&y1, b, 16);
    int fail = 0;
#define BLEND(M)                                                                      \
    do {                                                                              \
        for (int i = 0; i < 16; i++)                                                  \
            set_lane(want, 2, i, (u64)lane((M) >> (i & 7) & 1 ? b : a, 2, i, 0));     \
        fail |= !same(_mm256_blend_epi16(x, y, M), want);                             \
        for (int i = 0; i < 8; i++)                                                   \
            set_lane(want, 4, i, (u64)lane((M) >> i & 1 ? b : a, 4, i, 0));           \
        fail |= !same(_mm256_blend_epi32(x, y, M), want);                             \
        fail |= !same128(_mm_blend_epi32(x1, y1, (M) & 15), want);                    \
    } while (0)
    BLEND(0x00);
    BLEND(0xFF);
    BLEND(0xA5);
    BLEND(0x5A);
    BLEND(0x81);
    BLEND(0x0F);
    for (int i = 0; i < 32; i++)
        want[i] = m[i] & 0x80 ? b[i] : a[i];
    fail |= !same(_mm256_blendv_epi8(x, y, vec(m)), want);
    return fail ? 16 : 0;
}

// VPMOVSX / VPMOVZX widen the low lanes of a 128-bit operand.
static int check_extensions(const unsigned char *a) {
    static const int shape[6][2] = {{1, 2}, {1, 4}, {1, 8}, {2, 4}, {2, 8}, {4, 8}};
    __m128i x;
    memcpy(&x, a, 16);
    __m256i got[12] = {
        _mm256_cvtepi8_epi16(x),  _mm256_cvtepi8_epi32(x),  _mm256_cvtepi8_epi64(x),
        _mm256_cvtepi16_epi32(x), _mm256_cvtepi16_epi64(x), _mm256_cvtepi32_epi64(x),
        _mm256_cvtepu8_epi16(x),  _mm256_cvtepu8_epi32(x),  _mm256_cvtepu8_epi64(x),
        _mm256_cvtepu16_epi32(x), _mm256_cvtepu16_epi64(x), _mm256_cvtepu32_epi64(x)};
    for (int s = 0; s < 12; s++) {
        int from = shape[s % 6][0], to = shape[s % 6][1];
        unsigned char want[32];
        for (int i = 0; i < 32 / to; i++)
            set_lane(want, to, i, (u64)lane(a, from, i, s < 6));
        if (!same(got[s], want))
            return 32;
    }
    return 0;
}

// VMPSADBW: each 128-bit lane as MPSADBW does, the low by imm8[2:0] and the
// high by imm8[5:3].
static int check_mpsadbw(const unsigned char *a, const unsigned char *b) {
    unsigned char want[32];
    __m256i x = vec(a), y = vec(b);
    int fail = 0;
#define MPSADBW(M)                                                                    \
    do {                                                                              \
        for (int h = 0; h < 2; h++) {                                                 \
            int c = (M) >> (3 * h), ao = 16 * h + 4 * (c >> 2 & 1), bo = 16 * h + 4 * (c & 3); \
            for (int i = 0; i < 8; i++) {                                             \
                int s = 0;                                                            \
                for (int k = 0; k < 4; k++) {                                         \
                    int d = a[ao + i + k] - b[bo + k];                                \
                    s += d < 0 ? -d : d;                                              \
                }                                                                     \
                set_lane(want, 2, 8 * h + i, (u64)s);                                 \
            }                                                                         \
        }                                                                             \
        fail |= !same(_mm256_mpsadbw_epu8(x, y, M), want);                            \
    } while (0)
    MPSADBW(0x00);
    MPSADBW(0x05);
    MPSADBW(0x2D);
    MPSADBW(0x3F);
    MPSADBW(0x12);
    MPSADBW(0x38);
    return fail ? 64 : 0;
}

// The broadcasts copy the low lane of a 128-bit operand to every lane.
static int check_broadcasts(const unsigned char *a) {
    unsigned char want[32];
    __m128i x;
    memcpy(&x, a, 16);
    int fail = 0;
    for (int s = 0; s < 4; s++) {
        int w = 1 << s;
        for (int i = 0; i < 16 / w; i++)
            set_lane(want, w, i, (u64)lane(a, w, 0, 0));
        __m128i got = s == 0 ? _mm_broadcastb_epi8(x)
                      : s == 1 ? _mm_broadcastw_epi16(x)
                      : s == 2 ? _mm_broadcastd_epi32(x)
                               : _mm_broadcastq_epi64(x);
        fail |= !same128(got, want);
    }
    for (int i = 0; i < 8; i++)
        set_lane(want, 4, i, (u64)lane(a, 4, 0, 0));
    __m128 f;
    memcpy(&f, a, 16);
    __m128 bf = _mm_broadcastss_ps(f);
    __m256 bf8 = _mm256_broadcastss_ps(f);
    fail |= memcmp(&bf, want, 16) != 0 || memcmp(&bf8, want, 32) != 0;
    for (int i = 0; i < 4; i++)
        set_lane(want, 8, i, (u64)lane(a, 8, 0, 0));
    __m128d d;
    memcpy(&d, a, 16);
    __m128d bd = _mm_broadcastsd_pd(d);
    __m256d bd4 = _mm256_broadcastsd_pd(d);
    fail |= memcmp(&bd, want, 16) != 0 || memcmp(&bd4, want, 32) != 0;
    memcpy(want, a, 16);
    memcpy(want + 16, a, 16);
    fail |= !same(_mm_broadcastsi128_si256(x), want);
    return fail ? 128 : 0;
}

int main(void) {
    int fail = 0;
    for (int round = 0; round < 200; round++) {
        unsigned char a[32], b[32], m[32];
        rnd(a, 32);
        rnd(b, 32);
        rnd(m, 32);
        fail |= check_immediate_shifts(a);
        fail |= check_count_shifts(a, b);
        fail |= check_variable_shifts(a);
        fail |= check_shuffles(a, b);
        fail |= check_blends(a, b, m);
        fail |= check_extensions(a);
        fail |= check_mpsadbw(a, b);
        fail |= check_broadcasts(a);
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
