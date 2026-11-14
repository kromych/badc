/* <arm_neon.h> vcage, vcagt, vcale and vcalt with their scalar forms, vaddhn,
 * vraddhn, vsubhn and vrsubhn with their _high forms, vuqadd and vsqadd
 * with their scalar forms, vrbit, the float vmla and vmls, and vcopy_lane,
 * over seeded lanes with NaNs and the saturating extremes: the result bits
 * hash to what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x02febdd1cf967372ull
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
static int8x16_t i8(void) { int8x16_t v; for (int i = 0; i < 16; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? -128 : (r & 7) == 1 ? 127 : (int8_t)(r >> 8); } return v; }
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int16_t)0x8000 : (r & 7) == 1 ? 0x7fff : (int16_t)(r >> 8); } return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int32_t)0x80000000u : (r & 7) == 1 ? 0x7fffffff : (int32_t)(r >> 16); } return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int64_t)0x8000000000000000ull : (r & 7) == 1 ? 0x7fffffffffffffffll : (int64_t)rnd(); } return v; }
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        float32x4_t a = f4(), b = f4(); float32x2_t c = f2(), d = f2(); float64x2_t e = d2(), f = d2(); float64x1_t g = d1(), k = d1();
        uint32x4_t r1 = vcageq_f32(a, b), r2 = vcaltq_f32(a, b); uint32x2_t r3 = vcagt_f32(c, d), r4 = vcale_f32(c, d);
        uint64x2_t r5 = vcagtq_f64(e, f), r6 = vcaleq_f64(e, f); uint64x1_t r7 = vcage_f64(g, k), r8 = vcalt_f64(g, k);
        uint32_t r9 = vcages_f32(a[0], b[0]); uint64_t r10 = vcaltd_f64(e[1], f[1]);
        MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(r5); MIX(r6); MIX(r7); MIX(r8); MIX(r9); MIX(r10);
        int16x8_t x16 = i16(), y16 = i16(); int32x4_t x32 = i32(), y32 = i32(); int64x2_t x64 = i64(), y64 = i64(); int8x16_t x8 = i8(), y8 = i8();
        int8x8_t h1 = vaddhn_s16(x16, y16), h2 = vrsubhn_s16(x16, y16); uint16x4_t h3 = vraddhn_u32(vreinterpretq_u32_s32(x32), vreinterpretq_u32_s32(y32));
        int32x2_t h4 = vsubhn_s64(x64, y64); int8x16_t h5 = vraddhn_high_s16(h1, x16, y16); uint32x4_t h6 = vrsubhn_high_u64(vreinterpret_u32_s32(h4), vreinterpretq_u64_s64(x64), vreinterpretq_u64_s64(y64));
        MIX(h1); MIX(h2); MIX(h3); MIX(h4); MIX(h5); MIX(h6);
        int8x16_t q1 = vuqaddq_s8(x8, vreinterpretq_u8_s8(y8)); uint16x4_t q2 = vsqadd_u16(vreinterpret_u16_s16(vget_low_s16(x16)), vget_low_s16(y16));
        int32x4_t q3 = vuqaddq_s32(x32, vreinterpretq_u32_s32(y32)); uint64x2_t q4 = vsqaddq_u64(vreinterpretq_u64_s64(x64), y64);
        int64_t q5 = vuqaddd_s64(x64[0], (uint64_t)y64[1]); uint8_t q6 = vsqaddb_u8((uint8_t)x8[3], y8[4]); int16_t q7 = vuqaddh_s16(x16[2], (uint16_t)y16[5]);
        MIX(q1); MIX(q2); MIX(q3); MIX(q4); MIX(q5); MIX(q6); MIX(q7);
        uint8x16_t b1 = vrbitq_u8(vreinterpretq_u8_s8(x8)); int8x8_t b2 = vrbit_s8(vget_low_s8(y8));
        float32x4_t m1 = vmlaq_f32(a, b, a); float64x1_t m2 = vmls_f64(g, k, g); float32x2_t m3 = vmls_f32(c, d, c);
        int16x8_t c1 = vcopyq_laneq_s16(x16, 3, y16, 6); float32x2_t c2 = vcopy_laneq_f32(c, 1, a, 2); uint64x2_t c3 = vcopyq_lane_u64(vreinterpretq_u64_s64(x64), 0, vreinterpret_u64_s64(vget_high_s64(y64)), 0);
        MIX(b1); MIX(b2); MIX(m1); MIX(m2); MIX(m3); MIX(c1); MIX(c2); MIX(c3);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
