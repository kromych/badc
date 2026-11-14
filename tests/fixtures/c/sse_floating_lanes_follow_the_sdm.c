// The SSE and SSE2 floating-point operations of <xmmintrin.h> and
// <emmintrin.h>: each one's results and the exception flags it raises, over
// random operands mixed with zeros, infinities, quiet NaNs, subnormals and
// halfway values, in each rounding direction, are hashed and compared with
// the hashes the instructions themselves give, recorded from a gcc -O0
// build of this unit on an x86-64 machine (-DPRINT prints the table). RCPPS
// and RSQRTPS are held to their error bound. The exit code is the row of the
// first mismatch; elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <emmintrin.h>
#include <fenv.h>
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

static float rnd_f(void) {
    static const unsigned edge[] = {0x00000000, 0x80000000, 0x3F800000, 0xBF800000,
                                    0x7F800000, 0xFF800000, 0x7FC00000, 0x00000001,
                                    0x00800000, 0x40200000, 0x4F000000, 0xCF000001};
    u64 r = next();
    unsigned bits = (r >> 60) < 5 ? edge[(r >> 32) % 12] : (unsigned)(r >> 16);
    if ((bits & 0x7F800000) == 0x7F800000 && (bits & 0x7FFFFF))
        bits |= 0x400000;
    float f;
    memcpy(&f, &bits, 4);
    return f;
}

static double rnd_d(void) {
    static const u64 edge[] = {0x0, 0x8000000000000000ULL, 0x3FF0000000000000ULL,
                               0x7FF0000000000000ULL, 0xFFF0000000000000ULL,
                               0x7FF8000000000000ULL, 0x1ULL, 0x0010000000000000ULL,
                               0x4004000000000000ULL, 0x41E0000000000000ULL,
                               0xC1E0000000200000ULL};
    u64 r = next();
    u64 bits = (r >> 60) < 5 ? edge[(r >> 32) % 11] : next();
    if ((bits & 0x7FF0000000000000ULL) == 0x7FF0000000000000ULL && (bits & 0xFFFFFFFFFFFFFULL))
        bits |= 0x8000000000000ULL;
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

#define ROWS 12
static u64 h[ROWS];

#define MIX(row, v)                                \
    do {                                           \
        __typeof__(v) v_ = (v);                    \
        h[row] = fnv(h[row], &v_, (int)sizeof v_); \
    } while (0)
// The raised flags in one order on every C library.
static int raised(void) {
    int t = fetestexcept(FE_ALL_EXCEPT);
    return !!(t & FE_INVALID) | !!(t & FE_DIVBYZERO) << 1 | !!(t & FE_OVERFLOW) << 2 |
           !!(t & FE_UNDERFLOW) << 3 | !!(t & FE_INEXACT) << 4;
}
#define FLAGS(row) MIX(row, raised())

static void singles(__m128 a, __m128 b) {
    float o[4];
    feclearexcept(FE_ALL_EXCEPT);
    MIX(0, _mm_add_ps(a, b));
    MIX(0, _mm_sub_ps(a, b));
    MIX(0, _mm_mul_ps(a, b));
    MIX(0, _mm_div_ps(a, b));
    MIX(0, _mm_add_ss(a, b));
    MIX(0, _mm_sub_ss(a, b));
    MIX(0, _mm_mul_ss(a, b));
    MIX(0, _mm_div_ss(a, b));
    MIX(0, _mm_sqrt_ps(a));
    MIX(0, _mm_sqrt_ss(a));
    FLAGS(0);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(1, _mm_min_ps(a, b));
    MIX(1, _mm_max_ps(a, b));
    MIX(1, _mm_min_ss(a, b));
    MIX(1, _mm_max_ss(a, b));
    FLAGS(1);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(2, _mm_cmpeq_ps(a, b));
    MIX(2, _mm_cmplt_ps(a, b));
    MIX(2, _mm_cmple_ps(a, b));
    MIX(2, _mm_cmpgt_ps(a, b));
    MIX(2, _mm_cmpge_ps(a, b));
    MIX(2, _mm_cmpneq_ps(a, b));
    MIX(2, _mm_cmpnlt_ps(a, b));
    MIX(2, _mm_cmpnle_ps(a, b));
    MIX(2, _mm_cmpngt_ps(a, b));
    MIX(2, _mm_cmpnge_ps(a, b));
    MIX(2, _mm_cmpord_ps(a, b));
    MIX(2, _mm_cmpunord_ps(a, b));
    MIX(2, _mm_cmpeq_ss(a, b));
    MIX(2, _mm_cmplt_ss(a, b));
    MIX(2, _mm_cmpgt_ss(a, b));
    MIX(2, _mm_cmpnge_ss(a, b));
    MIX(2, _mm_cmpunord_ss(a, b));
    FLAGS(2);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(3, _mm_comieq_ss(a, b));
    MIX(3, _mm_comilt_ss(a, b));
    MIX(3, _mm_comile_ss(a, b));
    MIX(3, _mm_comigt_ss(a, b));
    MIX(3, _mm_comige_ss(a, b));
    MIX(3, _mm_comineq_ss(a, b));
    FLAGS(3);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(3, _mm_ucomieq_ss(a, b));
    MIX(3, _mm_ucomilt_ss(a, b));
    MIX(3, _mm_ucomile_ss(a, b));
    MIX(3, _mm_ucomigt_ss(a, b));
    MIX(3, _mm_ucomige_ss(a, b));
    MIX(3, _mm_ucomineq_ss(a, b));
    FLAGS(3);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(4, _mm_cvtss_si32(a));
    MIX(4, _mm_cvttss_si32(a));
    MIX(4, _mm_cvtss_si64(a));
    MIX(4, _mm_cvttss_si64(a));
    MIX(4, _mm_cvtsi32_ss(a, (int)next()));
    MIX(4, _mm_cvtsi64_ss(a, (long long)next()));
    MIX(4, _mm_cvtps_epi32(a));
    MIX(4, _mm_cvttps_epi32(a));
    MIX(4, _mm_cvtepi32_ps(_mm_castps_si128(a)));
    MIX(4, _mm_cvtps_pd(a));
    FLAGS(4);
    MIX(5, _mm_shuffle_ps(a, b, _MM_SHUFFLE(1, 3, 0, 2)));
    MIX(5, _mm_unpacklo_ps(a, b));
    MIX(5, _mm_unpackhi_ps(a, b));
    MIX(5, _mm_movehl_ps(a, b));
    MIX(5, _mm_movelh_ps(a, b));
    MIX(5, _mm_move_ss(a, b));
    MIX(5, _mm_movemask_ps(a));
    _mm_storer_ps(o, a);
    MIX(5, _mm_loadu_ps(o));
    MIX(5, _mm_load_ss(o + 1));
    MIX(5, _mm_load1_ps(o + 2));
    _mm_store_ss(o, b);
    MIX(5, _mm_loadr_ps(o));
    MIX(5, _mm_cvtss_f32(b));
}

static void doubles(__m128d a, __m128d b, __m128 s) {
    double o[2];
    feclearexcept(FE_ALL_EXCEPT);
    MIX(6, _mm_add_pd(a, b));
    MIX(6, _mm_sub_pd(a, b));
    MIX(6, _mm_mul_pd(a, b));
    MIX(6, _mm_div_pd(a, b));
    MIX(6, _mm_add_sd(a, b));
    MIX(6, _mm_sub_sd(a, b));
    MIX(6, _mm_mul_sd(a, b));
    MIX(6, _mm_div_sd(a, b));
    MIX(6, _mm_sqrt_pd(a));
    MIX(6, _mm_sqrt_sd(a, b));
    FLAGS(6);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(7, _mm_min_pd(a, b));
    MIX(7, _mm_max_pd(a, b));
    MIX(7, _mm_min_sd(a, b));
    MIX(7, _mm_max_sd(a, b));
    FLAGS(7);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(8, _mm_cmpeq_pd(a, b));
    MIX(8, _mm_cmplt_pd(a, b));
    MIX(8, _mm_cmple_pd(a, b));
    MIX(8, _mm_cmpgt_pd(a, b));
    MIX(8, _mm_cmpge_pd(a, b));
    MIX(8, _mm_cmpneq_pd(a, b));
    MIX(8, _mm_cmpnlt_pd(a, b));
    MIX(8, _mm_cmpnle_pd(a, b));
    MIX(8, _mm_cmpngt_pd(a, b));
    MIX(8, _mm_cmpnge_pd(a, b));
    MIX(8, _mm_cmpord_pd(a, b));
    MIX(8, _mm_cmpunord_pd(a, b));
    MIX(8, _mm_cmpeq_sd(a, b));
    MIX(8, _mm_cmple_sd(a, b));
    MIX(8, _mm_cmpge_sd(a, b));
    MIX(8, _mm_cmpngt_sd(a, b));
    MIX(8, _mm_cmpord_sd(a, b));
    FLAGS(8);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(9, _mm_comieq_sd(a, b));
    MIX(9, _mm_comilt_sd(a, b));
    MIX(9, _mm_comige_sd(a, b));
    MIX(9, _mm_comineq_sd(a, b));
    FLAGS(9);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(9, _mm_ucomieq_sd(a, b));
    MIX(9, _mm_ucomile_sd(a, b));
    MIX(9, _mm_ucomigt_sd(a, b));
    MIX(9, _mm_ucomineq_sd(a, b));
    FLAGS(9);
    feclearexcept(FE_ALL_EXCEPT);
    MIX(10, _mm_cvtsd_si32(a));
    MIX(10, _mm_cvttsd_si32(a));
    MIX(10, _mm_cvtsd_si64(a));
    MIX(10, _mm_cvttsd_si64(a));
    MIX(10, _mm_cvtsi32_sd(a, (int)next()));
    MIX(10, _mm_cvtsi64_sd(a, (long long)next()));
    MIX(10, _mm_cvtpd_epi32(a));
    MIX(10, _mm_cvttpd_epi32(a));
    MIX(10, _mm_cvtepi32_pd(_mm_castpd_si128(b)));
    MIX(10, _mm_cvtpd_ps(a));
    MIX(10, _mm_cvtsd_ss(s, a));
    MIX(10, _mm_cvtss_sd(a, s));
    FLAGS(10);
    MIX(11, _mm_unpacklo_pd(a, b));
    MIX(11, _mm_unpackhi_pd(a, b));
    MIX(11, _mm_move_sd(a, b));
    MIX(11, _mm_movemask_pd(a));
    _mm_storer_pd(o, a);
    MIX(11, _mm_loadu_pd(o));
    MIX(11, _mm_loadh_pd(b, o));
    MIX(11, _mm_loadl_pd(b, o + 1));
    _mm_storeh_pd(o, b);
    MIX(11, _mm_load_sd(o));
    MIX(11, _mm_load1_pd(o));
    MIX(11, _mm_mul_epu32(_mm_castpd_si128(a), _mm_castpd_si128(b)));
}

// RCPPS and RSQRTPS: within a relative 1.5 * 2^-12 of the exact value on a
// positive normal lane.
static int approximations(void) {
    for (int k = 0; k < 200; k++) {
        float x = 1.0f + (float)(next() >> 41) / 1048576.0f;
        float r[4], q[4];
        _mm_storeu_ps(r, _mm_rcp_ps(_mm_set1_ps(x)));
        _mm_storeu_ps(q, _mm_rsqrt_ps(_mm_set1_ps(x)));
        double er = r[0] * (double)x - 1, eq = q[0] * q[0] * (double)x - 1;
        if (er > 0x1.8p-12 || er < -0x1.8p-12 || eq > 0x1.8p-11 || eq < -0x1.8p-11)
            return 1;
    }
    return 0;
}

static const u64 want[ROWS] = {
    0x1D353ECCE4BB2C4CULL,
    0x5F321771CC41BDBEULL,
    0x11856F6FFB76E2B5ULL,
    0x522E63C0D8741325ULL,
    0x99FADE8481D65B9DULL,
    0xB8927E1638651CE4ULL,
    0x2592E395939D25FBULL,
    0x592DD2B653FEAAFDULL,
    0xD3C8174E98AEF9DFULL,
    0xFD514170F557EFC5ULL,
    0x4D66A832B7BC62CBULL,
    0x0A3DAD741C2E2D3FULL,
};

int main(void) {
    static const int modes[] = {FE_TONEAREST, FE_UPWARD, FE_DOWNWARD, FE_TOWARDZERO};
    for (int r = 0; r < ROWS; r++)
        h[r] = 0xCBF29CE484222325ULL;
    for (int m = 0; m < 4; m++) {
        fesetround(modes[m]);
        for (int k = 0; k < 300; k++) {
            float fa[4], fb[4];
            double da[2], db[2];
            for (int i = 0; i < 4; i++) {
                fa[i] = rnd_f();
                fb[i] = rnd_f();
            }
            for (int i = 0; i < 2; i++) {
                da[i] = rnd_d();
                db[i] = rnd_d();
            }
            singles(_mm_loadu_ps(fa), _mm_loadu_ps(fb));
            doubles(_mm_loadu_pd(da), _mm_loadu_pd(db), _mm_loadu_ps(fb));
        }
    }
    fesetround(FE_TONEAREST);
#ifdef PRINT
    for (int r = 0; r < ROWS; r++)
        printf("    0x%016llXULL,\n", h[r]);
    return approximations();
#else
    for (int r = 0; r < ROWS; r++)
        if (h[r] != want[r])
            return r + 1;
    return approximations() ? ROWS + 1 : 0;
#endif
}
#else
int main(void) {
    return 0;
}
#endif
