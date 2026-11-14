/* <arm_neon.h> vcvt, vcvtn, vcvtm, vcvtp and vcvta to every integer type
 * from every float vector and scalar, and vcvt_n to and from fixed point at
 * several fraction counts, over seeded lanes with NaNs, infinities,
 * out-of-range and fractional values, with the flags each raises: the
 * result bits hash to what AArch64 hardware gives. Elsewhere the unit is
 * empty. */
#if defined(__aarch64__)
#define EXPECTED 0xba11caee51640df7ull
#include <arm_neon.h>
#include <stdint.h>
#include <string.h>
static uint64_t st = 0x9e3779b97f4a7c15ull;
static uint64_t rnd(void) {
    st ^= st << 13; st ^= st >> 7; st ^= st << 17;
    return st;
}
/* Special values mixed into the random lanes. */
static const uint32_t SP32[] = {0, 0x80000000u, 0x7f800000u, 0xff800000u, 0x7fc00001u, 0x7f800002u,
    0xff800003u, 0x00000001u, 0x001fffffu, 0x00200000u, 0x00400000u, 0x00800000u, 0x7f7fffffu,
    0x3f800000u, 0xbf800000u, 0x40000000u, 0x40400000u, 0x3f000000u, 0x80000001u, 0x803fffffu,
    0x4f000000u, 0xcf000000u, 0x5f000000u, 0x4f800000u};
static const uint64_t SP64[] = {0, 0x8000000000000000ull, 0x7ff0000000000000ull, 0xfff0000000000000ull,
    0x7ff8000000000001ull, 0x7ff0000000000002ull, 0xfff0000000000003ull, 1, 0x0003ffffffffffffull,
    0x0004000000000000ull, 0x0008000000000000ull, 0x0010000000000000ull, 0x7fefffffffffffffull,
    0x3ff0000000000000ull, 0xbff0000000000000ull, 0x4000000000000000ull, 0x4008000000000000ull,
    0x43e0000000000000ull, 0xc3e0000000000000ull, 0x43f0000000000000ull, 0x41e0000000000000ull};
static uint32_t r32(void) {
    uint64_t x = rnd();
    if ((x & 7) == 0) return SP32[(x >> 8) % (sizeof SP32 / 4)];
    if ((x & 7) == 1) return (uint32_t)(x >> 32) & 0x80ffffffu; /* small exponents */
    if ((x & 7) == 2) return 0x3f000000u + ((uint32_t)(x >> 20) & 0x01ffffffu); /* near one */
    return (uint32_t)(x >> 16);
}
static uint64_t r64(void) {
    uint64_t x = rnd();
    if ((x & 7) == 0) return SP64[(x >> 8) % (sizeof SP64 / 8)];
    if ((x & 7) == 1) return rnd() & 0x800fffffffffffffull;
    if ((x & 7) == 2) return 0x3fe0000000000000ull + (rnd() >> 11);
    return rnd();
}
static uint64_t h = 1469598103934665603ull;
static void mix(const void *p, size_t n) {
    const unsigned char *b = p;
    for (size_t i = 0; i < n; i++) { h ^= b[i]; h *= 1099511628211ull; }
}
#define MIX(v) mix(&(v), sizeof (v))
static float32x4_t f4(void) { uint32_t u[4]; for (int i = 0; i < 4; i++) u[i] = r32(); float32x4_t v; memcpy(&v, u, 16); return v; }
static float32x2_t f2(void) { uint32_t u[2]; for (int i = 0; i < 2; i++) u[i] = r32(); float32x2_t v; memcpy(&v, u, 8); return v; }
static float64x2_t d2(void) { uint64_t u[2]; for (int i = 0; i < 2; i++) u[i] = r64(); float64x2_t v; memcpy(&v, u, 16); return v; }
static float64x1_t d1(void) { uint64_t u = r64(); float64x1_t v; memcpy(&v, &u, 8); return v; }
static uint32x4_t u4(void) { uint32x4_t v; for (int i = 0; i < 4; i++) v[i] = (uint32_t)rnd(); return v; }
static uint32x2_t u2(void) { uint32x2_t v; for (int i = 0; i < 2; i++) v[i] = (uint32_t)rnd(); return v; }
#include <fenv.h>
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) v[i] = (rnd() & 1) ? (int32_t)rnd() : (int32_t)(rnd() % 1000) - 500; return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) v[i] = (rnd() & 1) ? (int64_t)rnd() : (int64_t)(rnd() % 100000) - 50000; return v; }
#define TOI(c) do { \
    int32x2_t a1 = c##_s32_f32(c2); int32x4_t a2 = c##q_s32_f32(a); uint32x2_t a3 = c##_u32_f32(c2); uint32x4_t a4 = c##q_u32_f32(a); \
    int64x2_t a5 = c##q_s64_f64(e); uint64x2_t a6 = c##q_u64_f64(e); int64x1_t a7 = c##_s64_f64(g); uint64x1_t a8 = c##_u64_f64(g); \
    int32_t a9 = c##s_s32_f32(a[1]); uint32_t a10 = c##s_u32_f32(a[2]); int64_t a11 = c##d_s64_f64(e[1]); uint64_t a12 = c##d_u64_f64(e[0]); \
    MIX(a1); MIX(a2); MIX(a3); MIX(a4); MIX(a5); MIX(a6); MIX(a7); MIX(a8); MIX(a9); MIX(a10); MIX(a11); MIX(a12); } while (0)
#define FIX(N) do { \
    float32x4_t b1 = vcvtq_n_f32_s32(x, 1 + (N) % 32); float32x2_t b2 = vcvt_n_f32_u32(vreinterpret_u32_s32(vget_low_s32(x)), 1 + (N) % 32); \
    float64x2_t b3 = vcvtq_n_f64_s64(y, 1 + (N)); float64x1_t b4 = vcvt_n_f64_u64(vreinterpret_u64_s64(vget_high_s64(y)), 1 + (N)); \
    int32x4_t b5 = vcvtq_n_s32_f32(a, 1 + (N) % 32); uint32x2_t b6 = vcvt_n_u32_f32(c2, 1 + (N) % 32); \
    int64x2_t b7 = vcvtq_n_s64_f64(e, 1 + (N)); uint64x1_t b8 = vcvt_n_u64_f64(g, 1 + (N)); \
    float32_t b9 = vcvts_n_f32_s32(x[0], 1 + (N) % 32); int64_t b10 = vcvtd_n_s64_f64(e[0], 1 + (N)); \
    MIX(b1); MIX(b2); MIX(b3); MIX(b4); MIX(b5); MIX(b6); MIX(b7); MIX(b8); MIX(b9); MIX(b10); } while (0)
/* The raised flags in one encoding on every target: the FE_ values are the
 * FPSR's bits on Linux and macOS and the UCRT's own on Windows. */
static int raised(void) {
    return !!fetestexcept(FE_INVALID) | !!fetestexcept(FE_DIVBYZERO) << 1
        | !!fetestexcept(FE_OVERFLOW) << 2 | !!fetestexcept(FE_UNDERFLOW) << 3
        | !!fetestexcept(FE_INEXACT) << 4;
}
int main(void) {
    int n = 500;
    for (int i = 0; i < n; i++) {
        float32x4_t a = f4(); float32x2_t c2 = f2(); float64x2_t e = d2(); float64x1_t g = d1();
        int32x4_t x = i32(); int64x2_t y = i64();
        if (i & 1) {
            a = vmulq_f32(a, (float32x4_t){0x1p-100f, 0x1p-110f, 0x1p-120f, 0x1p-90f});
            c2 = vmul_f32(c2, (float32x2_t){0x1p-105f, 0x1p-95f});
            e = vmulq_f64(e, (float64x2_t){0x1p-1000, 0x1p-990});
            g = vmul_f64(g, (float64x1_t){0x1p-1010});
        }
        feclearexcept(FE_ALL_EXCEPT);
        TOI(vcvt); TOI(vcvtn); TOI(vcvtm); TOI(vcvtp); TOI(vcvta);
        FIX(0); FIX(7); FIX(15); FIX(31); FIX(63);
        float32x4_t f1 = vcvtq_f32_s32(x); float64x1_t f3 = vcvt_f64_s64(vget_low_s64(y));
        float32_t f4_ = vcvts_f32_u32((uint32_t)x[1]); float64_t f5 = vcvtd_f64_u64((uint64_t)y[1]);
        MIX(f1); MIX(f3); MIX(f4_); MIX(f5);
        int fl = raised(); MIX(fl);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
