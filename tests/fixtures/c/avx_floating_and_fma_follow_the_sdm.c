// AVX's 256-bit floating-point operations, its compares by each of the 32
// predicates, and the FMA3 forms of <immintrin.h>: each one's results and
// the exception flags it raises, over random operands mixed with zeros,
// infinities, quiet NaNs (the FMA operands excepted), subnormals and halfway
// values, in each rounding direction, are hashed and compared with the
// hashes the instructions themselves give, recorded from a gcc -O0 -mavx2
// -mfma build of this unit on an x86-64 machine (-DPRINT prints the table).
// The exit code is the row of the first mismatch; elsewhere than x86-64 the
// unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <fenv.h>
#include <immintrin.h>
#include <stdio.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x2545F4914F6CDD1DULL;

static u64 next(void) {
    seed ^= seed >> 12;
    seed ^= seed << 25;
    seed ^= seed >> 27;
    return seed * 0x9E3779B97F4A7C15ULL;
}

static float rnd_f(int nan) {
    static const unsigned edge[] = {0x00000000, 0x80000000, 0x3F800000, 0xBF800000,
                                    0x7F800000, 0xFF800000, 0x00000001, 0x00800000,
                                    0x40200000, 0x4F000000, 0xCF000001, 0x7FC00000};
    u64 r = next();
    unsigned bits = (r >> 60) < 5 ? edge[(r >> 32) % (nan ? 12 : 11)] : (unsigned)(r >> 16);
    if ((bits & 0x7F800000) == 0x7F800000 && (bits & 0x7FFFFF))
        bits = nan ? bits | 0x400000 : 0x3F800000;
    float f;
    memcpy(&f, &bits, 4);
    return f;
}

static double rnd_d(int nan) {
    static const u64 edge[] = {0x0, 0x8000000000000000ULL, 0x3FF0000000000000ULL,
                               0x7FF0000000000000ULL, 0xFFF0000000000000ULL, 0x1ULL,
                               0x0010000000000000ULL, 0x4004000000000000ULL,
                               0x41E0000000000000ULL, 0xC1E0000000200000ULL,
                               0x7FF8000000000000ULL};
    u64 r = next();
    u64 bits = (r >> 60) < 5 ? edge[(r >> 32) % (nan ? 11 : 10)] : next();
    if ((bits & 0x7FF0000000000000ULL) == 0x7FF0000000000000ULL && (bits & 0xFFFFFFFFFFFFFULL))
        bits = nan ? bits | 0x8000000000000ULL : 0x3FF0000000000000ULL;
    double d;
    memcpy(&d, &bits, 8);
    return d;
}

static u64 fnv(u64 h, const void *p, int n) {
    const unsigned char *b = p;
    for (int k = 0; k < n; k++)
        h = (h ^ b[k]) * 0x100000001B3ULL;
    return h;
}

#define ROWS 8
static u64 h[ROWS];

#define MIX(row, v)                                \
    do {                                           \
        __typeof__(v) v_ = (v);                    \
        h[row] = fnv(h[row], &v_, (int)sizeof v_); \
    } while (0)

static int raised(void) {
    int t = fetestexcept(FE_ALL_EXCEPT);
    return !!(t & FE_INVALID) | !!(t & FE_DIVBYZERO) << 1 | !!(t & FE_OVERFLOW) << 2 |
           !!(t & FE_UNDERFLOW) << 3 | !!(t & FE_INEXACT) << 4;
}
#define FLAGS(row) MIX(row, raised())

#define CMP8(p)                                       \
    do {                                              \
        MIX(2, _mm256_cmp_ps(a, b, p));               \
        MIX(2, _mm256_cmp_pd(c, d, p));               \
        MIX(2, _mm_cmp_ss(_mm256_castps256_ps128(a), _mm256_castps256_ps128(b), p)); \
        MIX(2, _mm_cmp_sd(_mm256_castpd256_pd128(c), _mm256_castpd256_pd128(d), p)); \
        FLAGS(2);                                     \
        feclearexcept(FE_ALL_EXCEPT);                 \
    } while (0)

static void arith(__m256 a, __m256 b, __m256d c, __m256d d) {
    float of[8];
    feclearexcept(FE_ALL_EXCEPT);
    MIX(0, _mm256_add_ps(a, b));
    MIX(0, _mm256_sub_ps(a, b));
    MIX(0, _mm256_mul_ps(a, b));
    MIX(0, _mm256_div_ps(a, b));
    MIX(0, _mm256_min_ps(a, b));
    MIX(0, _mm256_max_ps(a, b));
    MIX(0, _mm256_sqrt_ps(a));
    MIX(0, _mm256_addsub_ps(a, b));
    MIX(0, _mm256_hadd_ps(a, b));
    MIX(0, _mm256_hsub_ps(a, b));
    FLAGS(0);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(1, _mm256_add_pd(c, d));
    MIX(1, _mm256_sub_pd(c, d));
    MIX(1, _mm256_mul_pd(c, d));
    MIX(1, _mm256_div_pd(c, d));
    MIX(1, _mm256_min_pd(c, d));
    MIX(1, _mm256_max_pd(c, d));
    MIX(1, _mm256_sqrt_pd(c));
    MIX(1, _mm256_addsub_pd(c, d));
    MIX(1, _mm256_hadd_pd(c, d));
    MIX(1, _mm256_hsub_pd(c, d));
    FLAGS(1);
    feclearexcept(FE_ALL_EXCEPT);
    CMP8(0); CMP8(1); CMP8(2); CMP8(3); CMP8(4); CMP8(5); CMP8(6); CMP8(7);
    CMP8(8); CMP8(9); CMP8(10); CMP8(11); CMP8(12); CMP8(13); CMP8(14); CMP8(15);
    CMP8(16); CMP8(17); CMP8(18); CMP8(19); CMP8(20); CMP8(21); CMP8(22); CMP8(23);
    CMP8(24); CMP8(25); CMP8(26); CMP8(27); CMP8(28); CMP8(29); CMP8(30); CMP8(31);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(3, _mm256_cvtps_epi32(a));
    MIX(3, _mm256_cvttps_epi32(a));
    MIX(3, _mm256_cvtepi32_ps(_mm256_castps_si256(b)));
    MIX(3, _mm256_cvtpd_ps(c));
    MIX(3, _mm256_cvtps_pd(_mm256_castps256_ps128(a)));
    MIX(3, _mm256_cvtpd_epi32(c));
    MIX(3, _mm256_cvttpd_epi32(c));
    MIX(3, _mm256_cvtepi32_pd(_mm256_castsi256_si128(_mm256_castpd_si256(d))));
    FLAGS(3);
    MIX(4, _mm256_and_ps(a, b));
    MIX(4, _mm256_andnot_pd(c, d));
    MIX(4, _mm256_or_ps(a, b));
    MIX(4, _mm256_xor_pd(c, d));
    MIX(4, _mm256_unpacklo_ps(a, b));
    MIX(4, _mm256_unpackhi_pd(c, d));
    MIX(4, _mm256_shuffle_ps(a, b, 0x9C));
    MIX(4, _mm256_shuffle_pd(c, d, 0x6));
    MIX(4, _mm256_permute_ps(a, 0x1B));
    MIX(4, _mm256_permute_pd(c, 0x5));
    MIX(4, _mm256_permute2f128_ps(a, b, 0x21));
    MIX(4, _mm256_permute2f128_pd(c, d, 0x30));
    MIX(4, _mm256_blend_ps(a, b, 0xA5));
    MIX(4, _mm256_blend_pd(c, d, 0x9));
    MIX(4, _mm256_blendv_ps(a, b, _mm256_castpd_ps(c)));
    MIX(4, _mm256_blendv_pd(c, d, _mm256_castps_pd(a)));
    MIX(4, _mm256_movemask_ps(a));
    MIX(4, _mm256_movemask_pd(c));
    MIX(4, _mm256_movehdup_ps(a));
    MIX(4, _mm256_moveldup_ps(b));
    MIX(4, _mm256_movedup_pd(c));
    MIX(4, _mm256_extractf128_ps(a, 1));
    MIX(4, _mm256_insertf128_pd(c, _mm256_castpd256_pd128(d), 1));
    _mm256_storeu_ps(of, a);
    MIX(4, _mm256_broadcast_ss(of + 3));
    MIX(4, _mm256_loadu_ps(of));
    MIX(4, _mm256_cvtss_f32(b));
}

static void fused(__m256 a, __m256 b, __m256 e, __m256d c, __m256d d, __m256d f) {
    __m128 a4 = _mm256_castps256_ps128(a), b4 = _mm256_castps256_ps128(b),
           e4 = _mm256_castps256_ps128(e);
    __m128d c2 = _mm256_castpd256_pd128(c), d2 = _mm256_castpd256_pd128(d),
            f2 = _mm256_castpd256_pd128(f);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(5, _mm256_fmadd_ps(a, b, e));
    MIX(5, _mm256_fmsub_ps(a, b, e));
    MIX(5, _mm256_fnmadd_ps(a, b, e));
    MIX(5, _mm256_fnmsub_ps(a, b, e));
    MIX(5, _mm256_fmaddsub_ps(a, b, e));
    MIX(5, _mm256_fmsubadd_ps(a, b, e));
    MIX(5, _mm_fmadd_ps(a4, b4, e4));
    MIX(5, _mm_fnmsub_ps(a4, b4, e4));
    MIX(5, _mm_fmadd_ss(a4, b4, e4));
    MIX(5, _mm_fmsub_ss(a4, b4, e4));
    FLAGS(5);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(6, _mm256_fmadd_pd(c, d, f));
    MIX(6, _mm256_fmsub_pd(c, d, f));
    MIX(6, _mm256_fnmadd_pd(c, d, f));
    MIX(6, _mm256_fnmsub_pd(c, d, f));
    MIX(6, _mm256_fmaddsub_pd(c, d, f));
    MIX(6, _mm256_fmsubadd_pd(c, d, f));
    MIX(6, _mm_fmadd_pd(c2, d2, f2));
    MIX(6, _mm_fnmadd_pd(c2, d2, f2));
    MIX(6, _mm_fnmadd_sd(c2, d2, f2));
    MIX(6, _mm_fnmsub_sd(c2, d2, f2));
    FLAGS(6);
    MIX(7, _mm256_setr_ps(1, 2, 3, 4, 5, 6, 7, 8));
    MIX(7, _mm256_set_pd(1, 2, 3, 4));
    MIX(7, _mm256_set1_pd(0.5));
    MIX(7, _mm256_set_m128(b4, a4));
    MIX(7, _mm256_setr_m128d(c2, d2));
}

static const u64 want[ROWS] = {
    0xD20C8AB447C633C0ULL,
    0x74CCBD3F6DC406F9ULL,
    0x01109575788509C5ULL,
    0x22E32B377FE2C5F9ULL,
    0x643FF85C67BFE70EULL,
    0x1399BA70A23F6F3FULL,
    0xA60312D90E39B83DULL,
    0x9A11A6EA03F41D8FULL,
};

int main(void) {
    static const int modes[] = {FE_TONEAREST, FE_UPWARD, FE_DOWNWARD, FE_TOWARDZERO};
    for (int r = 0; r < ROWS; r++)
        h[r] = 0xCBF29CE484222325ULL;
    for (int m = 0; m < 4; m++) {
        fesetround(modes[m]);
        for (int k = 0; k < 150; k++) {
            float fa[8], fb[8], fe[8];
            double da[4], db[4], df[4];
            for (int i = 0; i < 8; i++) {
                fa[i] = rnd_f(1);
                fb[i] = rnd_f(1);
            }
            for (int i = 0; i < 4; i++) {
                da[i] = rnd_d(1);
                db[i] = rnd_d(1);
            }
            arith(_mm256_loadu_ps(fa), _mm256_loadu_ps(fb), _mm256_loadu_pd(da),
                  _mm256_loadu_pd(db));
            for (int i = 0; i < 8; i++) {
                fa[i] = rnd_f(0);
                fb[i] = rnd_f(0);
                fe[i] = rnd_f(0);
            }
            for (int i = 0; i < 4; i++) {
                da[i] = rnd_d(0);
                db[i] = rnd_d(0);
                df[i] = rnd_d(0);
            }
            fused(_mm256_loadu_ps(fa), _mm256_loadu_ps(fb), _mm256_loadu_ps(fe),
                  _mm256_loadu_pd(da), _mm256_loadu_pd(db), _mm256_loadu_pd(df));
        }
    }
    fesetround(FE_TONEAREST);
#ifdef PRINT
    for (int r = 0; r < ROWS; r++)
        printf("    0x%016llXULL,\n", h[r]);
    return 0;
#else
    for (int r = 0; r < ROWS; r++)
        if (h[r] != want[r])
            return r + 1;
    return 0;
#endif
}
#else
int main(void) {
    return 0;
}
#endif
