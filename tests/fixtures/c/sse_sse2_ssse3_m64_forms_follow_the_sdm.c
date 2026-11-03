// The __m64 forms of <xmmintrin.h>, <emmintrin.h> and <tmmintrin.h>, each
// checked against the result the SDM defines for its instruction: a model
// over the lanes of a 64-bit integer, on random lanes mixed with the edge
// values, and fixed cases for the conversions, whose CVT*2SI lanes round
// by MXCSR and give 0x80000000 for a NaN or a value out of range. The
// exit code is the line of the first mismatch; elsewhere than x86-64 the
// unit is empty. gcc 16 -mssse3 agrees.

#ifdef __x86_64__
#include <tmmintrin.h>

typedef unsigned long long u64;

#define Q(m) ((u64)_mm_cvtm64_si64(m))
#define M(q) _mm_cvtsi64_m64((long long)(q))
#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static u64 seed = 0x9E3779B97F4A7C15ULL;

// Random lanes, about a quarter of the bytes replaced by 00, 7F, 80 or FF.
static u64 rnd(void) {
    static const unsigned char edge[4] = {0x00, 0x7F, 0x80, 0xFF};
    u64 r[2];
    for (int k = 0; k < 2; k++) {
        seed ^= seed >> 12;
        seed ^= seed << 25;
        seed ^= seed >> 27;
        r[k] = seed * 0x2545F4914F6CDD1DULL;
    }
    for (int b = 0; b < 8; b++)
        if (((r[1] >> (8 * b)) & 3) == 0) {
            r[0] &= ~(0xFFULL << (8 * b));
            r[0] |= (u64)edge[(r[1] >> (8 * b + 2)) & 3] << (8 * b);
        }
    return r[0];
}

static u64 field(u64 x, int bits, int i) {
    return bits == 64 ? x : (x >> (bits * i)) & ((1ULL << bits) - 1);
}

static long long sfield(u64 x, int bits, int i) {
    u64 v = field(x, bits, i);
    return bits < 64 && (v >> (bits - 1)) ? (long long)(v - (1ULL << bits)) : (long long)v;
}

static u64 place(u64 r, int bits, int i, long long v) {
    u64 m = (1ULL << bits) - 1;
    return r | (((u64)v & m) << (bits * i));
}

static long long sat(long long v, int bits) {
    long long hi = (1LL << (bits - 1)) - 1;
    return v > hi ? hi : v < -hi - 1 ? -hi - 1 : v;
}

static u64 ref_shuffle_pi16(u64 a, int n) {
    u64 r = 0;
    for (int i = 0; i < 4; i++)
        r = place(r, 16, i, (long long)field(a, 16, (n >> (2 * i)) & 3));
    return r;
}

static u64 ref_alignr(u64 a, u64 b, int n) {
    u64 r = 0;
    for (int i = 0; i < 8; i++) {
        int k = n + i;
        r = place(r, 8, i, k < 8 ? (long long)field(b, 8, k) : k < 16 ? (long long)field(a, 8, k - 8) : 0);
    }
    return r;
}

// SSE: the integer forms over random lanes.
static int sse_lanes(void) {
    for (int t = 0; t < 2000; t++) {
        u64 a = rnd(), b = rnd(), r;
        __m64 ma = M(a), mb = M(b);
        r = 0;
        for (int i = 0; i < 8; i++)
            r = place(r, 8, i, (long long)((field(a, 8, i) + field(b, 8, i) + 1) >> 1));
        CHECK(Q(_mm_avg_pu8(ma, mb)) == r && Q(_m_pavgb(ma, mb)) == r);
        r = 0;
        for (int i = 0; i < 4; i++)
            r = place(r, 16, i, (long long)((field(a, 16, i) + field(b, 16, i) + 1) >> 1));
        CHECK(Q(_mm_avg_pu16(ma, mb)) == r && Q(_m_pavgw(ma, mb)) == r);
        u64 mx = 0, mn = 0;
        for (int i = 0; i < 4; i++) {
            long long x = sfield(a, 16, i), y = sfield(b, 16, i);
            mx = place(mx, 16, i, x > y ? x : y);
            mn = place(mn, 16, i, x < y ? x : y);
        }
        CHECK(Q(_mm_max_pi16(ma, mb)) == mx && Q(_m_pmaxsw(ma, mb)) == mx);
        CHECK(Q(_mm_min_pi16(ma, mb)) == mn && Q(_m_pminsw(ma, mb)) == mn);
        mx = mn = 0;
        for (int i = 0; i < 8; i++) {
            u64 x = field(a, 8, i), y = field(b, 8, i);
            mx = place(mx, 8, i, (long long)(x > y ? x : y));
            mn = place(mn, 8, i, (long long)(x < y ? x : y));
        }
        CHECK(Q(_mm_max_pu8(ma, mb)) == mx && Q(_m_pmaxub(ma, mb)) == mx);
        CHECK(Q(_mm_min_pu8(ma, mb)) == mn && Q(_m_pminub(ma, mb)) == mn);
        int mask = 0;
        for (int i = 0; i < 8; i++)
            mask |= (int)(field(a, 8, i) >> 7) << i;
        CHECK(_mm_movemask_pi8(ma) == mask && _m_pmovmskb(ma) == mask);
        r = 0;
        for (int i = 0; i < 4; i++)
            r = place(r, 16, i, (long long)((field(a, 16, i) * field(b, 16, i)) >> 16));
        CHECK(Q(_mm_mulhi_pu16(ma, mb)) == r && Q(_m_pmulhuw(ma, mb)) == r);
        u64 sad = 0;
        for (int i = 0; i < 8; i++) {
            long long d = (long long)field(a, 8, i) - (long long)field(b, 8, i);
            sad += (u64)(d < 0 ? -d : d);
        }
        CHECK(Q(_mm_sad_pu8(ma, mb)) == sad && Q(_m_psadbw(ma, mb)) == sad);
#define SHUF(n) CHECK(Q(_mm_shuffle_pi16(ma, n)) == ref_shuffle_pi16(a, n) && \
                      Q(_m_pshufw(ma, n)) == ref_shuffle_pi16(a, n))
        SHUF(0x00);
        SHUF(0x1B);
        SHUF(0x4E);
        SHUF(0x93);
        SHUF(0xE4);
        SHUF(0xFF);
#define LANE(n)                                                                     \
    CHECK(_mm_extract_pi16(ma, n) == (int)field(a, 16, n) &&                       \
          _m_pextrw(ma, n) == (int)field(a, 16, n));                               \
    CHECK(Q(_mm_insert_pi16(ma, (int)b, n)) ==                                      \
          ((a & ~(0xFFFFULL << (16 * n))) | ((b & 0xFFFF) << (16 * n))) &&          \
          Q(_m_pinsrw(ma, (int)b, n)) == Q(_mm_insert_pi16(ma, (int)b, n)))
        LANE(0);
        LANE(1);
        LANE(2);
        LANE(3);
        unsigned char buf[10], want[10];
        for (int i = 0; i < 10; i++)
            buf[i] = want[i] = (unsigned char)(0xA0 + i);
        for (int i = 0; i < 8; i++)
            if (field(b, 8, i) & 0x80)
                want[i + 1] = (unsigned char)field(a, 8, i);
        _mm_maskmove_si64(ma, mb, (char *)buf + 1);
        for (int i = 0; i < 10; i++)
            CHECK(buf[i] == want[i]);
        _m_maskmovq(mb, ma, (char *)buf + 1);
    }
    __m64 s;
    _mm_stream_pi(&s, M(0x0123456789ABCDEFULL));
    _mm_sfence();
    CHECK(Q(s) == 0x0123456789ABCDEFULL);
    return 0;
}

static void round_mode(unsigned mode) {
    _mm_setcsr((_mm_getcsr() & ~0x6000u) | mode);
}

// The operands of a conversion through volatile objects: a compiler that
// folds a constant one rounds to nearest, whatever MXCSR holds.
static __m128 ps(float a, float b, float c, float d) {
    volatile float t[4] = {a, b, c, d};
    return (__m128){t[0], t[1], t[2], t[3]};
}

static __m128d pd(double a, double b) {
    volatile double t[2] = {a, b};
    return (__m128d){t[0], t[1]};
}

// SSE: the conversions, under round-to-nearest-even and the other modes.
static int sse_conversions(void) {
    const float nan = __builtin_nanf("");
    __m128 v = ps(2.5f, -3.5f, 1e10f, nan);
    CHECK(Q(_mm_cvtps_pi32(v)) == 0xFFFFFFFC00000002ULL);
    CHECK(Q(_mm_cvt_ps2pi(v)) == 0xFFFFFFFC00000002ULL);
    CHECK(Q(_mm_cvtps_pi32(ps(1e10f, nan, 0, 0))) == 0x8000000080000000ULL);
    CHECK(Q(_mm_cvttps_pi32(ps(-2.7f, 2.7f, 0, 0))) == 0x00000002FFFFFFFEULL);
    CHECK(Q(_mm_cvtt_ps2pi(ps(-2147483648.0f, 2147483648.0f, 0, 0))) == 0x8000000080000000ULL);
    round_mode(0x2000);
    CHECK(Q(_mm_cvtps_pi32(ps(2.5f, -2.5f, 0, 0))) == 0xFFFFFFFD00000002ULL);
    round_mode(0x4000);
    CHECK(Q(_mm_cvtps_pi32(ps(2.5f, -2.5f, 0, 0))) == 0xFFFFFFFE00000003ULL);
    CHECK(Q(_mm_cvtps_pi16(ps(1.2f, -1.2f, 40000.f, -40000.f))) == 0x80007FFFFFFF0002ULL);
    round_mode(0x6000);
    CHECK(Q(_mm_cvtps_pi32(ps(2.5f, -2.5f, 0, 0))) == 0xFFFFFFFE00000002ULL);
    CHECK(Q(_mm_cvttps_pi32(ps(2.5f, -2.5f, 0, 0))) == 0xFFFFFFFE00000002ULL);
    round_mode(0);
    CHECK(Q(_mm_cvtps_pi16(ps(1.5f, -1.5f, 40000.f, nan))) == 0x80007FFFFFFE0002ULL);
    CHECK(Q(_mm_cvtps_pi8(ps(300.f, -300.f, 0.5f, -7.f))) == 0x00000000F900807FULL);
    __m128 f = _mm_cvtpi32_ps((__m128){9, 9, 9, 9}, _mm_set_pi32(-5, 16777217));
    CHECK(f[0] == 16777216.f && f[1] == -5.f && f[2] == 9.f && f[3] == 9.f);
    f = _mm_cvt_pi2ps((__m128){1, 2, 3, 4}, _mm_set_pi32(7, 6));
    CHECK(f[0] == 6.f && f[1] == 7.f && f[2] == 3.f && f[3] == 4.f);
    f = _mm_cvtpi16_ps(_mm_setr_pi16(-32768, 32767, -1, 0));
    CHECK(f[0] == -32768.f && f[1] == 32767.f && f[2] == -1.f && f[3] == 0.f);
    f = _mm_cvtpu16_ps(_mm_setr_pi16(-32768, 32767, -1, 0));
    CHECK(f[0] == 32768.f && f[1] == 32767.f && f[2] == 65535.f && f[3] == 0.f);
    f = _mm_cvtpi8_ps(_mm_setr_pi8(-128, 127, -1, 5, 9, 9, 9, 9));
    CHECK(f[0] == -128.f && f[1] == 127.f && f[2] == -1.f && f[3] == 5.f);
    f = _mm_cvtpu8_ps(_mm_setr_pi8(-128, 127, -1, 5, 9, 9, 9, 9));
    CHECK(f[0] == 128.f && f[1] == 127.f && f[2] == 255.f && f[3] == 5.f);
    f = _mm_cvtpi32x2_ps(_mm_set_pi32(2, 1), _mm_set_pi32(-4, 3));
    CHECK(f[0] == 1.f && f[1] == 2.f && f[2] == 3.f && f[3] == -4.f);
    unsigned char raw[17];
    float lo[2] = {1.25f, -2.5f};
    __builtin_memcpy(raw + 1, lo, 8);
    f = _mm_loadh_pi((__m128){1, 2, 3, 4}, (const __m64 *)(raw + 1));
    CHECK(f[0] == 1.f && f[1] == 2.f && f[2] == 1.25f && f[3] == -2.5f);
    f = _mm_loadl_pi((__m128){1, 2, 3, 4}, (const __m64 *)(raw + 1));
    CHECK(f[0] == 1.25f && f[1] == -2.5f && f[2] == 3.f && f[3] == 4.f);
    _mm_storeh_pi((__m64 *)(raw + 1), (__m128){1, 2, 3, 4});
    _mm_storel_pi((__m64 *)(raw + 9), (__m128){5, 6, 7, 8});
    float out[4];
    __builtin_memcpy(out, raw + 1, 16);
    CHECK(out[0] == 3.f && out[1] == 4.f && out[2] == 5.f && out[3] == 6.f);
    return 0;
}

// SSE2: the transfers, the unsigned doubleword product and the conversions.
static int sse2(void) {
    const double nan = __builtin_nan("");
    __m128i x = _mm_set_epi64x(0x1111222233334444LL, 0x5555666677778888LL);
    CHECK(Q(_mm_movepi64_pi64(x)) == 0x5555666677778888ULL);
    __m128i y = _mm_movpi64_epi64(M(0xFEDCBA9876543210ULL));
    CHECK((u64)y[0] == 0xFEDCBA9876543210ULL && y[1] == 0);
    y = _mm_set_epi64(M(1), M(2));
    CHECK(y[0] == 2 && y[1] == 1);
    y = _mm_setr_epi64(M(1), M(2));
    CHECK(y[0] == 1 && y[1] == 2);
    y = _mm_set1_epi64(M(7));
    CHECK(y[0] == 7 && y[1] == 7);
    for (int t = 0; t < 2000; t++) {
        u64 a = rnd(), b = rnd();
        CHECK(Q(_mm_mul_su32(M(a), M(b))) == (a & 0xFFFFFFFFULL) * (b & 0xFFFFFFFFULL));
        CHECK(Q(_mm_add_si64(M(a), M(b))) == a + b && Q(_mm_sub_si64(M(a), M(b))) == a - b);
    }
    CHECK(Q(_mm_cvtpd_pi32(pd(2.5, -3.5))) == 0xFFFFFFFC00000002ULL);
    CHECK(Q(_mm_cvtpd_pi32(pd(2147483647.4, -2147483648.0))) == 0x800000007FFFFFFFULL);
    CHECK(Q(_mm_cvtpd_pi32(pd(3e9, nan))) == 0x8000000080000000ULL);
    round_mode(0x2000);
    CHECK(Q(_mm_cvtpd_pi32(pd(2.5, -2.5))) == 0xFFFFFFFD00000002ULL);
    round_mode(0);
    CHECK(Q(_mm_cvttpd_pi32(pd(-2.7, 2147483647.9))) == 0x7FFFFFFFFFFFFFFEULL);
    CHECK(Q(_mm_cvttpd_pi32(pd(-2147483649.0, nan))) == 0x8000000080000000ULL);
    __m128d d = _mm_cvtpi32_pd(_mm_set_pi32(-2147483647 - 1, 2147483647));
    CHECK(d[0] == 2147483647.0 && d[1] == -2147483648.0);
    return 0;
}

// SSSE3 over random lanes.
static int ssse3(void) {
    for (int t = 0; t < 2000; t++) {
        u64 a = rnd(), b = rnd(), r;
        __m64 ma = M(a), mb = M(b);
        static const int bits[3] = {8, 16, 32};
        for (int w = 0; w < 3; w++) {
            int n = bits[w], lanes = 64 / n;
            u64 abs = 0, sign = 0;
            for (int i = 0; i < lanes; i++) {
                long long x = sfield(a, n, i), y = sfield(b, n, i);
                abs = place(abs, n, i, x < 0 ? -x : x);
                sign = place(sign, n, i, y < 0 ? -x : y ? x : 0);
            }
            u64 got_abs = n == 8 ? Q(_mm_abs_pi8(ma)) : n == 16 ? Q(_mm_abs_pi16(ma)) : Q(_mm_abs_pi32(ma));
            u64 got_sign = n == 8    ? Q(_mm_sign_pi8(ma, mb))
                           : n == 16 ? Q(_mm_sign_pi16(ma, mb))
                                     : Q(_mm_sign_pi32(ma, mb));
            CHECK(got_abs == abs && got_sign == sign);
        }
        u64 add = 0, adds = 0, sub = 0, subs = 0;
        for (int i = 0; i < 2; i++) {
            long long a0 = sfield(a, 16, 2 * i), a1 = sfield(a, 16, 2 * i + 1);
            long long b0 = sfield(b, 16, 2 * i), b1 = sfield(b, 16, 2 * i + 1);
            add = place(place(add, 16, i, a0 + a1), 16, i + 2, b0 + b1);
            adds = place(place(adds, 16, i, sat(a0 + a1, 16)), 16, i + 2, sat(b0 + b1, 16));
            sub = place(place(sub, 16, i, a0 - a1), 16, i + 2, b0 - b1);
            subs = place(place(subs, 16, i, sat(a0 - a1, 16)), 16, i + 2, sat(b0 - b1, 16));
        }
        CHECK(Q(_mm_hadd_pi16(ma, mb)) == add && Q(_mm_hadds_pi16(ma, mb)) == adds);
        CHECK(Q(_mm_hsub_pi16(ma, mb)) == sub && Q(_mm_hsubs_pi16(ma, mb)) == subs);
        r = place(place(0, 32, 0, sfield(a, 32, 0) + sfield(a, 32, 1)), 32, 1,
                  sfield(b, 32, 0) + sfield(b, 32, 1));
        CHECK(Q(_mm_hadd_pi32(ma, mb)) == r);
        r = place(place(0, 32, 0, sfield(a, 32, 0) - sfield(a, 32, 1)), 32, 1,
                  sfield(b, 32, 0) - sfield(b, 32, 1));
        CHECK(Q(_mm_hsub_pi32(ma, mb)) == r);
        r = 0;
        for (int i = 0; i < 4; i++)
            r = place(r, 16, i,
                      sat((long long)field(a, 8, 2 * i) * sfield(b, 8, 2 * i) +
                              (long long)field(a, 8, 2 * i + 1) * sfield(b, 8, 2 * i + 1),
                          16));
        CHECK(Q(_mm_maddubs_pi16(ma, mb)) == r);
        r = 0;
        for (int i = 0; i < 4; i++)
            r = place(r, 16, i, (((sfield(a, 16, i) * sfield(b, 16, i)) >> 14) + 1) >> 1);
        CHECK(Q(_mm_mulhrs_pi16(ma, mb)) == r);
        r = 0;
        for (int i = 0; i < 8; i++)
            r = place(r, 8, i,
                      field(b, 8, i) & 0x80 ? 0 : (long long)field(a, 8, field(b, 8, i) & 7));
        CHECK(Q(_mm_shuffle_pi8(ma, mb)) == r);
#define ALIGNR(n) CHECK(Q(_mm_alignr_pi8(ma, mb, n)) == ref_alignr(a, b, n))
        ALIGNR(0);
        ALIGNR(1);
        ALIGNR(5);
        ALIGNR(8);
        ALIGNR(9);
        ALIGNR(15);
        ALIGNR(16);
        ALIGNR(20);
    }
    return 0;
}

int main(void) {
    int line = sse_lanes();
    if (!line)
        line = sse_conversions();
    if (!line)
        line = sse2();
    if (!line)
        line = ssse3();
    return line;
}
#else
int main(void) {
    return 0;
}
#endif
