/* <arm_neon.h> vqshlu_n, vshll_n with its _high forms (a shift by the lane
 * width included) and vpadal on every element type they are defined on,
 * over seeded lanes at several counts: the result bits hash to what
 * AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x7495d56f987d93d4ull
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
static int8x16_t i8(void) { int8x16_t v; for (int i = 0; i < 16; i++) v[i] = (int8_t)rnd(); return v; }
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) v[i] = (rnd() & 3) ? (int16_t)rnd() : (int16_t)(rnd() & 0xff); return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) v[i] = (rnd() & 3) ? (int32_t)rnd() : (int32_t)(rnd() & 0xffff); return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) v[i] = (rnd() & 3) ? (int64_t)rnd() : (int64_t)(rnd() & 0xffffffff); return v; }
#define QSHLU(N) do { \
    uint8x8_t a = vqshlu_n_s8(vget_low_s8(x8), (N) % 8); uint8x16_t b = vqshluq_n_s8(x8, (N) % 8); \
    uint16x4_t c = vqshlu_n_s16(vget_low_s16(x16), (N) % 16); uint16x8_t d = vqshluq_n_s16(x16, (N) % 16); \
    uint32x2_t e = vqshlu_n_s32(vget_low_s32(x32), (N)); uint32x4_t f = vqshluq_n_s32(x32, (N)); \
    uint64x1_t g = vqshlu_n_s64(vget_low_s64(x64), 2 * (N)); uint64x2_t k = vqshluq_n_s64(x64, 2 * (N)); \
    MIX(a); MIX(b); MIX(c); MIX(d); MIX(e); MIX(f); MIX(g); MIX(k); } while (0)
#define SHLL(N) do { \
    int16x8_t a = vshll_n_s8(vget_low_s8(x8), (N) % 9); uint16x8_t b = vshll_n_u8(vreinterpret_u8_s8(vget_high_s8(x8)), (N) % 9); \
    int32x4_t c = vshll_n_s16(vget_low_s16(x16), (N) % 17); uint32x4_t d = vshll_high_n_u16(vreinterpretq_u16_s16(x16), (N) % 17); \
    int64x2_t e = vshll_high_n_s32(x32, (N)); uint64x2_t f = vshll_n_u32(vreinterpret_u32_s32(vget_low_s32(x32)), (N)); \
    int16x8_t g = vshll_high_n_s8(x8, (N) % 9); uint16x8_t k = vshll_high_n_u8(vreinterpretq_u8_s8(x8), (N) % 9); \
    int32x4_t m = vshll_high_n_s16(x16, (N) % 17); uint32x4_t p = vshll_n_u16(vreinterpret_u16_s16(vget_low_s16(x16)), (N) % 17); \
    int64x2_t q = vshll_n_s32(vget_low_s32(x32), (N)); uint64x2_t r = vshll_high_n_u32(vreinterpretq_u32_s32(x32), (N)); \
    MIX(a); MIX(b); MIX(c); MIX(d); MIX(e); MIX(f); MIX(g); MIX(k); MIX(m); MIX(p); MIX(q); MIX(r); } while (0)
int main(void) {
    int n = 300;
    for (int i = 0; i < n; i++) {
        int8x16_t x8 = i8(); int16x8_t x16 = i16(); int32x4_t x32 = i32(); int64x2_t x64 = i64();
        QSHLU(0); QSHLU(1); QSHLU(3); QSHLU(7); QSHLU(12); QSHLU(31);
        SHLL(0); SHLL(1); SHLL(5); SHLL(8); SHLL(16); SHLL(32);
        int16x4_t pa = vpadal_s8(vget_low_s16(x16), vget_low_s8(x8)); int16x8_t pb = vpadalq_s8(x16, x8);
        uint16x4_t pc = vpadal_u8(vreinterpret_u16_s16(vget_high_s16(x16)), vreinterpret_u8_s8(vget_high_s8(x8)));
        uint16x8_t pd = vpadalq_u8(vreinterpretq_u16_s16(x16), vreinterpretq_u8_s8(x8));
        int32x2_t pe = vpadal_s16(vget_low_s32(x32), vget_low_s16(x16)); int32x4_t pf = vpadalq_s16(x32, x16);
        uint32x4_t pg = vpadalq_u16(vreinterpretq_u32_s32(x32), vreinterpretq_u16_s16(x16));
        uint32x2_t ph = vpadal_u16(vreinterpret_u32_s32(vget_high_s32(x32)), vreinterpret_u16_s16(vget_low_s16(x16)));
        int64x1_t pk = vpadal_s32(vget_low_s64(x64), vget_low_s32(x32)); int64x2_t pm = vpadalq_s32(x64, x32);
        uint64x1_t pn = vpadal_u32(vreinterpret_u64_s64(vget_high_s64(x64)), vreinterpret_u32_s32(vget_high_s32(x32)));
        uint64x2_t pp = vpadalq_u32(vreinterpretq_u64_s64(x64), vreinterpretq_u32_s32(x32));
        MIX(pa); MIX(pb); MIX(pc); MIX(pd); MIX(pe); MIX(pf); MIX(pg); MIX(ph); MIX(pk); MIX(pm); MIX(pn); MIX(pp);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
