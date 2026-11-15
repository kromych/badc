/* The ACLE SVE bit counts and conversions, each checked against scalar C:
 * svcnt over every element type, svclz over the integer ones and svcls
 * over the signed ones, each giving the unsigned type of its width; svcvt
 * from the 32- and 64-bit integers to the float of their width, rounding
 * to nearest, and back toward zero, saturating, a NaN to zero; in the
 * merging, zeroing and don't-care forms. The exit status is the vector
 * length in 128-bit granules. */
#include <arm_sve.h>

#define N 41

static int8_t s8[N];
static uint8_t c8[N];
static uint16_t u16[N], c16[N];
static int32_t s32[N], i32[N];
static uint32_t u32[N], c32[N], m32[N], k32[N];
static uint64_t u64[N], c64[N], m64[N], k64[N];
static int64_t s64[N], i64[N];
static float f32[N], g32[N];
static double f64[N], g64[N];

static void fill(void) {
    static const float fs[] = {0.5f, -0.5f, 1.5f, -2.75f, 3e9f, -3e9f, 5e9f, 16777216.0f, -1.0f};
    static const double ds[] = {0.75, -0.25, 1e19, -1e19, 2e19, 9007199254740993.0, -4.5, 3.0};
    for (int i = 0; i < N; i++) {
        uint32_t h = (uint32_t)i * 2654435761u;
        s8[i] = (int8_t)(h >> 13);
        u16[i] = (uint16_t)(h >> 7);
        s32[i] = (int32_t)h >> (i % 31);
        u32[i] = h >> (i % 32);
        m32[i] = (uint32_t)(i % 4 != 2);
        u64[i] = ((uint64_t)h << 32 | h) >> (i % 64);
        s64[i] = (int64_t)u64[i] >> (i % 3);
        m64[i] = (uint64_t)(i % 3 != 0);
        f32[i] = fs[i % 9] * (float)(1 + i / 9);
        f64[i] = ds[i % 8];
    }
    s8[1] = -1;
    s8[2] = 0;
    u16[3] = 0;
    s32[4] = 16777217;
    s32[5] = -2147483647 - 1;
    u32[6] = 0xFFFFFFFFu;
    u32[7] = 0;
    s64[8] = 9007199254740993;
    u64[9] = 0xFFFFFFFFFFFFFFFFull;
    s64[10] = -1;
    union { uint32_t u; float f; } nan32 = {0x7FC00000u};
    union { uint64_t u; double f; } nan64 = {0x7FF8000000000000ull};
    f32[11] = nan32.f;
    f64[12] = nan64.f;
}

static unsigned ones(uint64_t x) {
    unsigned n = 0;
    for (; x; x &= x - 1)
        n++;
    return n;
}

static unsigned leading(uint64_t x, unsigned bits) {
    unsigned n = 0;
    while (n < bits && !(x >> (bits - 1 - n) & 1))
        n++;
    return n;
}

static uint32_t bits32(float x) {
    union { float f; uint32_t u; } v = {x};
    return v.u;
}

static int counts(void) {
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svint8_t a = svld1(pg, &s8[i]);
        svst1(pg, &c8[i], svadd_x(pg, svcnt_s8_x(pg, a), svcls_x(pg, a)));
    }
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16(i, N);
        svuint16_t a = svld1(pg, &u16[i]);
        svst1(pg, &c16[i], svclz_u16_z(pg, a));
    }
    for (int op = 0; op < 4; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &s32[i]);
            svfloat32_t f = svld1(pg, &f32[i]);
            svuint32_t u = svld1(pg, &u32[i]);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svuint32_t r;
            switch (op) {
            case 0: r = svcnt_m(u, on, a); break;
            case 1: r = svclz_s32_z(on, a); break;
            case 2: r = svcls_s32_m(u, on, a); break;
            default: r = svcnt_f32_z(on, f); break;
            }
            svst1(pg, &c32[i], r);
        }
        for (int i = 0; i < N; i++) {
            uint32_t a = (uint32_t)s32[i], u = u32[i], want;
            int on = m32[i] != 0;
            uint32_t sign = a >> 31 ? ~a : a;
            switch (op) {
            case 0: want = on ? ones(a) : u; break;
            case 1: want = on ? leading(a, 32) : 0; break;
            case 2: want = on ? leading(sign, 32) - 1 : u; break;
            default: want = on ? ones(bits32(f32[i])) : 0; break;
            }
            if (c32[i] != want)
                return 10 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svuint64_t a = svld1(pg, &u64[i]);
        svint64_t s = svld1(pg, &s64[i]);
        svbool_t on = svcmpne_n_u64(pg, svld1(pg, &m64[i]), 0);
        svst1(pg, &c64[i], svadd_x(pg, svclz_m(a, on, a), svcls_x(pg, s)));
    }
    for (int i = 0; i < N; i++) {
        int a = s8[i];
        uint8_t b = (uint8_t)a;
        unsigned want = ones(b) + leading(a < 0 ? (uint8_t)~b : b, 8) - 1;
        if (c8[i] != (uint8_t)want)
            return 20;
        if (c16[i] != leading(u16[i], 16))
            return 21;
        uint64_t x = u64[i], s = (uint64_t)s64[i];
        uint64_t clz = m64[i] ? leading(x, 64) : x;
        if (c64[i] != clz + leading(s >> 63 ? ~s : s, 64) - 1)
            return 22;
    }
    return 0;
}

static int32_t to_s32(float x) {
    if (x != x)
        return 0;
    if (x >= 2147483648.0f)
        return 2147483647;
    if (x < -2147483648.0f)
        return -2147483647 - 1;
    return (int32_t)x;
}

static uint32_t to_u32(float x) {
    if (x != x || x <= -1.0f)
        return 0;
    if (x >= 4294967296.0f)
        return 0xFFFFFFFFu;
    return (uint32_t)x;
}

static int64_t to_s64(double x) {
    if (x != x)
        return 0;
    if (x >= 9223372036854775808.0)
        return 0x7FFFFFFFFFFFFFFFll;
    if (x < -9223372036854775808.0)
        return -0x7FFFFFFFFFFFFFFFll - 1;
    return (int64_t)x;
}

static uint64_t to_u64(double x) {
    if (x != x || x <= -1.0)
        return 0;
    if (x >= 18446744073709551616.0)
        return 0xFFFFFFFFFFFFFFFFull;
    return (uint64_t)x;
}

static int conversions(void) {
    for (int op = 0; op < 4; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svint32_t a = svld1(pg, &s32[i]);
            svuint32_t u = svld1(pg, &u32[i]);
            svfloat32_t f = svld1(pg, &f32[i]);
            switch (op) {
            case 0:
                svst1(pg, &g32[i], svcvt_f32_s32_m(f, on, a));
                svst1(pg, &i32[i], svcvt_s32_f32_x(pg, f));
                break;
            case 1:
                svst1(pg, &g32[i], svcvt_f32_z(on, u));
                svst1(pg, &k32[i], svcvt_u32_m(u, on, f));
                break;
            case 2:
                svst1(pg, &g32[i], svcvt_f32_x(pg, a));
                svst1(pg, &i32[i], svcvt_s32_z(on, f));
                break;
            default:
                svst1(pg, &g32[i], svcvt_f32_u32_m(f, on, u));
                svst1(pg, &k32[i], svcvt_u32_f32_x(pg, f));
                break;
            }
        }
        for (int i = 0; i < N; i++) {
            int on = m32[i] != 0;
            float f = f32[i], want;
            switch (op) {
            case 0: want = on ? (float)s32[i] : f; break;
            case 1: want = on ? (float)u32[i] : 0.0f; break;
            case 2: want = (float)s32[i]; break;
            default: want = on ? (float)u32[i] : f; break;
            }
            if (bits32(g32[i]) != bits32(want))
                return 30 + op;
            if (op % 2 == 0 && i32[i] != (op == 0 || on ? to_s32(f) : 0))
                return 40 + op;
            if (op % 2 == 1 && k32[i] != (op == 3 || on ? to_u32(f) : u32[i]))
                return 40 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svbool_t on = svcmpne_n_u64(pg, svld1(pg, &m64[i]), 0);
        svint64_t s = svld1(pg, &s64[i]);
        svuint64_t u = svld1(pg, &u64[i]);
        svfloat64_t f = svld1(pg, &f64[i]);
        svst1(pg, &g64[i], svadd_x(pg, svcvt_f64_x(pg, s), svcvt_f64_u64_z(on, u)));
        svst1(pg, &i64[i], svcvt_s64_m(s, on, f));
        svst1(pg, &k64[i], svcvt_u64_f64_x(pg, f));
    }
    for (int i = 0; i < N; i++) {
        double want = (double)s64[i] + (m64[i] ? (double)u64[i] : 0.0);
        if (g64[i] != want)
            return 50;
        if (i64[i] != (m64[i] ? to_s64(f64[i]) : s64[i]))
            return 51;
        if (k64[i] != to_u64(f64[i]))
            return 52;
    }
    return 0;
}

int main(void) {
    fill();
    int r = counts();
    if (!r)
        r = conversions();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
