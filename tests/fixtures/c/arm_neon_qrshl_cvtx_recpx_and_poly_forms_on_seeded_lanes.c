/* <arm_neon.h> vqrshl on every integer type, vcvtx and vrecpx with the flags
 * they raise, vcls on the unsigned types, the polynomial vadd and vtst,
 * and vcreate, over seeded lanes: the result bits hash to what AArch64
 * hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x4d14c97ed1edc6afull
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
static int8x16_t i8(void) { int8x16_t v; for (int i = 0; i < 16; i++) { uint64_t r = rnd(); v[i] = (r & 3) == 0 ? (int8_t)((r >> 8) % 20 - 10) : (int8_t)(r >> 8); } return v; }
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) { uint64_t r = rnd(); v[i] = (r & 3) == 0 ? (int16_t)((r >> 8) % 40 - 20) : (int16_t)(r >> 8); } return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) { uint64_t r = rnd(); v[i] = (r & 3) == 0 ? (int32_t)((r >> 8) % 80 - 40) : (int32_t)(r >> 16); } return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) { uint64_t r = rnd(); v[i] = (r & 3) == 0 ? (int64_t)((r >> 8) % 160 - 80) : (int64_t)rnd(); } return v; }
/* The raised flags in one encoding on every target: the FE_ values are the
 * FPSR's bits on Linux and macOS and the UCRT's own on Windows. */
static int raised(void) {
    return !!fetestexcept(FE_INVALID) | !!fetestexcept(FE_DIVBYZERO) << 1
        | !!fetestexcept(FE_OVERFLOW) << 2 | !!fetestexcept(FE_UNDERFLOW) << 3
        | !!fetestexcept(FE_INEXACT) << 4;
}
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        int8x16_t a8 = i8(), b8 = i8(); int16x8_t a16 = i16(), b16 = i16(); int32x4_t a32 = i32(), b32 = i32(); int64x2_t a64 = i64(), b64 = i64();
        int8x16_t r1 = vqrshlq_s8(a8, b8); uint8x8_t r2 = vqrshl_u8(vreinterpret_u8_s8(vget_low_s8(a8)), vget_high_s8(b8));
        int16x4_t r3 = vqrshl_s16(vget_low_s16(a16), vget_low_s16(b16)); uint16x8_t r4 = vqrshlq_u16(vreinterpretq_u16_s16(a16), b16);
        int32x4_t r5 = vqrshlq_s32(a32, b32); uint32x2_t r6 = vqrshl_u32(vreinterpret_u32_s32(vget_low_s32(a32)), vget_low_s32(b32));
        int64x1_t r7 = vqrshl_s64(vget_low_s64(a64), vget_low_s64(b64)); uint64x2_t r8 = vqrshlq_u64(vreinterpretq_u64_s64(a64), b64);
        MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(r5); MIX(r6); MIX(r7); MIX(r8);
        float64x2_t d = d2(); float32x4_t f = f4(); float64x1_t g = d1();
        if (i & 1) d = vmulq_f64(d, (float64x2_t){0x1p-900, 0x1p+900});
        feclearexcept(FE_ALL_EXCEPT);
        float32x2_t x1 = vcvtx_f32_f64(d); float32x4_t x2 = vcvtx_high_f32_f64(vget_low_f32(f), d); float32_t x3 = vcvtxd_f32_f64(g[0]);
        float32_t x4 = vrecpxs_f32(f[1]); float64_t x5 = vrecpxd_f64(d[0]);
        int fl = raised();
        MIX(x1); MIX(x2); MIX(x3); MIX(x4); MIX(x5); MIX(fl);
        uint8x16_t u8 = vreinterpretq_u8_s8(a8);
        int8x16_t c1 = vclsq_u8(u8); int16x4_t c2 = vcls_u16(vreinterpret_u16_s16(vget_low_s16(a16))); int32x4_t c3 = vclsq_u32(vreinterpretq_u32_s32(a32));
        poly8x16_t p1 = vaddq_p8(vreinterpretq_p8_s8(a8), vreinterpretq_p8_s8(b8)); poly64x1_t p2 = vadd_p64(vreinterpret_p64_s64(vget_low_s64(a64)), vreinterpret_p64_s64(vget_high_s64(b64)));
        poly16x4_t p3 = vadd_p16(vreinterpret_p16_s16(vget_low_s16(a16)), vreinterpret_p16_s16(vget_high_s16(b16)));
        uint16x8_t t1 = vtstq_p16(vreinterpretq_p16_s16(a16), vreinterpretq_p16_s16(b16)); uint64x2_t t2 = vtstq_p64(vreinterpretq_p64_s64(a64), vreinterpretq_p64_s64(b64));
        float32x2_t k1 = vcreate_f32((uint64_t)a64[0]); uint16x4_t k2 = vcreate_u16((uint64_t)b64[1]); int8x8_t k3 = vcreate_s8((uint64_t)a64[1]);
        MIX(c1); MIX(c2); MIX(c3); MIX(p1); MIX(p2); MIX(p3); MIX(t1); MIX(t2); MIX(k1); MIX(k2); MIX(k3);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
