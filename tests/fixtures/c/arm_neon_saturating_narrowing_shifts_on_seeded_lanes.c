/* <arm_neon.h> vqshrn_n, vqrshrn_n, vqshrun_n and vqrshrun_n on every
 * element type, and the _high forms of the narrowing shifts, over seeded
 * lanes at counts from 1 to the narrow width: the result bits hash to
 * what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x87a684e447c04dcaull
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
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) v[i] = (rnd() & 3) ? (int16_t)rnd() : (int16_t)((int8_t)rnd() * 3); return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) v[i] = (rnd() & 3) ? (int32_t)rnd() : (int32_t)((int16_t)rnd() * 5); return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) v[i] = (rnd() & 3) ? (int64_t)rnd() : (int64_t)((int32_t)rnd() * 7LL); return v; }
#define S(N) do { \
    int8x8_t a1 = vqshrn_n_s16(x16, 1 + (N) % 8), a2 = vqrshrn_n_s16(x16, 1 + (N) % 8); \
    uint8x8_t a3 = vqshrn_n_u16(u16, 1 + (N) % 8), a4 = vqrshrn_n_u16(u16, 1 + (N) % 8); \
    uint8x8_t a5 = vqshrun_n_s16(x16, 1 + (N) % 8), a6 = vqrshrun_n_s16(x16, 1 + (N) % 8); \
    int16x4_t b1 = vqshrn_n_s32(x32, 1 + (N) % 16), b2 = vqrshrn_n_s32(x32, 1 + (N) % 16); \
    uint16x4_t b3 = vqshrn_n_u32(u32, 1 + (N) % 16), b4 = vqrshrn_n_u32(u32, 1 + (N) % 16); \
    uint16x4_t b5 = vqshrun_n_s32(x32, 1 + (N) % 16), b6 = vqrshrun_n_s32(x32, 1 + (N) % 16); \
    int32x2_t c1 = vqshrn_n_s64(x64, 1 + (N)), c2 = vqrshrn_n_s64(x64, 1 + (N)); \
    uint32x2_t c3 = vqshrn_n_u64(u64, 1 + (N)), c4 = vqrshrn_n_u64(u64, 1 + (N)); \
    uint32x2_t c5 = vqshrun_n_s64(x64, 1 + (N)), c6 = vqrshrun_n_s64(x64, 1 + (N)); \
    int8x16_t h1 = vqshrn_high_n_s16(a1, x16, 1 + (N) % 8); uint8x16_t h2 = vqrshrun_high_n_s16(a5, x16, 1 + (N) % 8); \
    uint16x8_t h3 = vrshrn_high_n_u32(b3, u32, 1 + (N) % 16); int32x4_t h4 = vshrn_high_n_s64(c1, x64, 1 + (N)); \
    uint32x4_t h5 = vqrshrn_high_n_u64(c3, u64, 1 + (N)); int16x8_t h6 = vqrshrn_high_n_s32(b1, x32, 1 + (N) % 16); \
    MIX(a1); MIX(a2); MIX(a3); MIX(a4); MIX(a5); MIX(a6); MIX(b1); MIX(b2); MIX(b3); MIX(b4); MIX(b5); MIX(b6); \
    MIX(c1); MIX(c2); MIX(c3); MIX(c4); MIX(c5); MIX(c6); MIX(h1); MIX(h2); MIX(h3); MIX(h4); MIX(h5); MIX(h6); } while (0)
int main(void) {
    int n = 300;
    for (int i = 0; i < n; i++) {
        int16x8_t x16 = i16(); int32x4_t x32 = i32(); int64x2_t x64 = i64();
        uint16x8_t u16 = vreinterpretq_u16_s16(i16()); uint32x4_t u32 = vreinterpretq_u32_s32(i32());
        uint64x2_t u64 = vreinterpretq_u64_s64(i64());
        S(0); S(2); S(6); S(7); S(14); S(15); S(30); S(31);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
