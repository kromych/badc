/* <arm_neon.h> vceqz, vcgez, vcgtz, vclez and vcltz on every element type
 * they are defined on, vector and scalar, over seeded lanes with zeros,
 * infinities, NaNs and subnormals: the result bits hash to what AArch64
 * hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x3789142cb24220e2ull
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
static int8x16_t i8(void) { int8x16_t v; for (int i = 0; i < 16; i++) v[i] = (rnd() & 3) ? (int8_t)rnd() : 0; return v; }
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) v[i] = (rnd() & 3) ? (int16_t)rnd() : 0; return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) v[i] = (rnd() & 3) ? (int32_t)rnd() : 0; return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) v[i] = (rnd() & 3) ? (int64_t)rnd() : 0; return v; }
#define ALL(op) do { \
    int8x16_t a = i8(); int16x8_t b = i16(); int32x4_t c = i32(); int64x2_t d = i64(); \
    float32x4_t e = f4(); float64x2_t f = d2(); \
    uint8x8_t r1 = op##_s8(vget_low_s8(a)); uint8x16_t r2 = op##q_s8(a); \
    uint16x4_t r3 = op##_s16(vget_low_s16(b)); uint16x8_t r4 = op##q_s16(b); \
    uint32x2_t r5 = op##_s32(vget_low_s32(c)); uint32x4_t r6 = op##q_s32(c); \
    uint64x1_t r7 = op##_s64(vget_low_s64(d)); uint64x2_t r8 = op##q_s64(d); \
    uint32x2_t r9 = op##_f32(vget_low_f32(e)); uint32x4_t r10 = op##q_f32(e); \
    uint64x1_t r11 = op##_f64(vget_low_f64(f)); uint64x2_t r12 = op##q_f64(f); \
    uint64_t r13 = op##d_s64(d[1]); uint32_t r14 = op##s_f32(e[2]); uint64_t r15 = op##d_f64(f[1]); \
    MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(r5); MIX(r6); MIX(r7); MIX(r8); \
    MIX(r9); MIX(r10); MIX(r11); MIX(r12); MIX(r13); MIX(r14); MIX(r15); \
} while (0)
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        ALL(vceqz); ALL(vcgez); ALL(vcgtz); ALL(vclez); ALL(vcltz);
        uint8x16_t u = vceqzq_u8(vreinterpretq_u8_s8(i8()));
        uint16x4_t v = vceqz_u16(vreinterpret_u16_s16(vget_low_s16(i16())));
        uint32x4_t w = vceqzq_u32(vreinterpretq_u32_s32(i32()));
        uint64x2_t x = vceqzq_u64(vreinterpretq_u64_s64(i64()));
        uint8x8_t y = vceqz_p8(vreinterpret_p8_s8(vget_low_s8(i8())));
        uint64x1_t z = vceqz_p64(vreinterpret_p64_s64(vget_low_s64(i64())));
        uint64_t q = vceqzd_u64((uint64_t)i64()[0]);
        MIX(u); MIX(v); MIX(w); MIX(x); MIX(y); MIX(z); MIX(q);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
