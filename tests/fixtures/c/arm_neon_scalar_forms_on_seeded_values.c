/* <arm_neon.h> the scalar forms -- the saturating arithmetic, shifts and
 * narrowings, the 64-bit arithmetic, compares and shifts, the lane reads
 * and the lane-indexed multiplies -- over seeded values with the
 * saturating extremes and NaNs: the result bits hash to what AArch64
 * hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x92d495923f453d83ull
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
static unsigned char vb[16];
static unsigned char fb[16];
static uint64_t ri(void) { uint64_t r = rnd(); switch (r & 7) { case 0: return 0x8000000000000000ull >> (r >> 8) % 64; case 1: return ~0ull >> (r >> 8) % 64; case 2: return (r >> 8) % 7; default: return rnd(); } }
static int sh(int n) { uint64_t r = rnd(); return (int)(r % (2 * n + 6)) - n - 3; }
static float rf(void) { float32x2_t v = f2(); return v[0]; }
static double rd(void) { float64x1_t v = d1(); return v[0]; }
int main(void) {
    int n = 300;
    for (int it = 0; it < n; it++) {
        for (int i = 0; i < 16; i++) vb[i] = (unsigned char)rnd();
        { float32x4_t f = f4(); memcpy(fb, &f, 16); }
        { __typeof__(vqabsb_s8((int8_t)ri())) r = vqabsb_s8((int8_t)ri()); MIX(r); }
        { __typeof__(vqnegb_s8((int8_t)ri())) r = vqnegb_s8((int8_t)ri()); MIX(r); }
        { __typeof__(vqaddb_s8((int8_t)ri(), (int8_t)ri())) r = vqaddb_s8((int8_t)ri(), (int8_t)ri()); MIX(r); }
        { __typeof__(vqaddb_u8((uint8_t)ri(), (uint8_t)ri())) r = vqaddb_u8((uint8_t)ri(), (uint8_t)ri()); MIX(r); }
        { __typeof__(vqsubb_s8((int8_t)ri(), (int8_t)ri())) r = vqsubb_s8((int8_t)ri(), (int8_t)ri()); MIX(r); }
        { __typeof__(vqsubb_u8((uint8_t)ri(), (uint8_t)ri())) r = vqsubb_u8((uint8_t)ri(), (uint8_t)ri()); MIX(r); }
        { __typeof__(vqshlb_s8((int8_t)ri(), (int8_t)sh(8))) r = vqshlb_s8((int8_t)ri(), (int8_t)sh(8)); MIX(r); }
        { __typeof__(vqshlb_u8((uint8_t)ri(), (int8_t)sh(8))) r = vqshlb_u8((uint8_t)ri(), (int8_t)sh(8)); MIX(r); }
        { __typeof__(vqrshlb_s8((int8_t)ri(), (int8_t)sh(8))) r = vqrshlb_s8((int8_t)ri(), (int8_t)sh(8)); MIX(r); }
        { __typeof__(vqrshlb_u8((uint8_t)ri(), (int8_t)sh(8))) r = vqrshlb_u8((uint8_t)ri(), (int8_t)sh(8)); MIX(r); }
        { __typeof__(vqshlb_n_s8((int8_t)ri(), 0)) r = vqshlb_n_s8((int8_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlb_n_s8((int8_t)ri(), 4)) r = vqshlb_n_s8((int8_t)ri(), 4); MIX(r); }
        { __typeof__(vqshlb_n_s8((int8_t)ri(), 7)) r = vqshlb_n_s8((int8_t)ri(), 7); MIX(r); }
        { __typeof__(vqshlb_n_u8((uint8_t)ri(), 0)) r = vqshlb_n_u8((uint8_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlb_n_u8((uint8_t)ri(), 4)) r = vqshlb_n_u8((uint8_t)ri(), 4); MIX(r); }
        { __typeof__(vqshlb_n_u8((uint8_t)ri(), 7)) r = vqshlb_n_u8((uint8_t)ri(), 7); MIX(r); }
        { __typeof__(vqshlub_n_s8((int8_t)ri(), 0)) r = vqshlub_n_s8((int8_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlub_n_s8((int8_t)ri(), 7)) r = vqshlub_n_s8((int8_t)ri(), 7); MIX(r); }
        { __typeof__(vqabsh_s16((int16_t)ri())) r = vqabsh_s16((int16_t)ri()); MIX(r); }
        { __typeof__(vqnegh_s16((int16_t)ri())) r = vqnegh_s16((int16_t)ri()); MIX(r); }
        { __typeof__(vqaddh_s16((int16_t)ri(), (int16_t)ri())) r = vqaddh_s16((int16_t)ri(), (int16_t)ri()); MIX(r); }
        { __typeof__(vqaddh_u16((uint16_t)ri(), (uint16_t)ri())) r = vqaddh_u16((uint16_t)ri(), (uint16_t)ri()); MIX(r); }
        { __typeof__(vqsubh_s16((int16_t)ri(), (int16_t)ri())) r = vqsubh_s16((int16_t)ri(), (int16_t)ri()); MIX(r); }
        { __typeof__(vqsubh_u16((uint16_t)ri(), (uint16_t)ri())) r = vqsubh_u16((uint16_t)ri(), (uint16_t)ri()); MIX(r); }
        { __typeof__(vqshlh_s16((int16_t)ri(), (int16_t)sh(16))) r = vqshlh_s16((int16_t)ri(), (int16_t)sh(16)); MIX(r); }
        { __typeof__(vqshlh_u16((uint16_t)ri(), (int16_t)sh(16))) r = vqshlh_u16((uint16_t)ri(), (int16_t)sh(16)); MIX(r); }
        { __typeof__(vqrshlh_s16((int16_t)ri(), (int16_t)sh(16))) r = vqrshlh_s16((int16_t)ri(), (int16_t)sh(16)); MIX(r); }
        { __typeof__(vqrshlh_u16((uint16_t)ri(), (int16_t)sh(16))) r = vqrshlh_u16((uint16_t)ri(), (int16_t)sh(16)); MIX(r); }
        { __typeof__(vqshlh_n_s16((int16_t)ri(), 0)) r = vqshlh_n_s16((int16_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlh_n_s16((int16_t)ri(), 8)) r = vqshlh_n_s16((int16_t)ri(), 8); MIX(r); }
        { __typeof__(vqshlh_n_s16((int16_t)ri(), 15)) r = vqshlh_n_s16((int16_t)ri(), 15); MIX(r); }
        { __typeof__(vqshlh_n_u16((uint16_t)ri(), 0)) r = vqshlh_n_u16((uint16_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlh_n_u16((uint16_t)ri(), 8)) r = vqshlh_n_u16((uint16_t)ri(), 8); MIX(r); }
        { __typeof__(vqshlh_n_u16((uint16_t)ri(), 15)) r = vqshlh_n_u16((uint16_t)ri(), 15); MIX(r); }
        { __typeof__(vqshluh_n_s16((int16_t)ri(), 0)) r = vqshluh_n_s16((int16_t)ri(), 0); MIX(r); }
        { __typeof__(vqshluh_n_s16((int16_t)ri(), 15)) r = vqshluh_n_s16((int16_t)ri(), 15); MIX(r); }
        { __typeof__(vqabss_s32((int32_t)ri())) r = vqabss_s32((int32_t)ri()); MIX(r); }
        { __typeof__(vqnegs_s32((int32_t)ri())) r = vqnegs_s32((int32_t)ri()); MIX(r); }
        { __typeof__(vqadds_s32((int32_t)ri(), (int32_t)ri())) r = vqadds_s32((int32_t)ri(), (int32_t)ri()); MIX(r); }
        { __typeof__(vqadds_u32((uint32_t)ri(), (uint32_t)ri())) r = vqadds_u32((uint32_t)ri(), (uint32_t)ri()); MIX(r); }
        { __typeof__(vqsubs_s32((int32_t)ri(), (int32_t)ri())) r = vqsubs_s32((int32_t)ri(), (int32_t)ri()); MIX(r); }
        { __typeof__(vqsubs_u32((uint32_t)ri(), (uint32_t)ri())) r = vqsubs_u32((uint32_t)ri(), (uint32_t)ri()); MIX(r); }
        { __typeof__(vqshls_s32((int32_t)ri(), (int32_t)sh(32))) r = vqshls_s32((int32_t)ri(), (int32_t)sh(32)); MIX(r); }
        { __typeof__(vqshls_u32((uint32_t)ri(), (int32_t)sh(32))) r = vqshls_u32((uint32_t)ri(), (int32_t)sh(32)); MIX(r); }
        { __typeof__(vqrshls_s32((int32_t)ri(), (int32_t)sh(32))) r = vqrshls_s32((int32_t)ri(), (int32_t)sh(32)); MIX(r); }
        { __typeof__(vqrshls_u32((uint32_t)ri(), (int32_t)sh(32))) r = vqrshls_u32((uint32_t)ri(), (int32_t)sh(32)); MIX(r); }
        { __typeof__(vqshls_n_s32((int32_t)ri(), 0)) r = vqshls_n_s32((int32_t)ri(), 0); MIX(r); }
        { __typeof__(vqshls_n_s32((int32_t)ri(), 16)) r = vqshls_n_s32((int32_t)ri(), 16); MIX(r); }
        { __typeof__(vqshls_n_s32((int32_t)ri(), 31)) r = vqshls_n_s32((int32_t)ri(), 31); MIX(r); }
        { __typeof__(vqshls_n_u32((uint32_t)ri(), 0)) r = vqshls_n_u32((uint32_t)ri(), 0); MIX(r); }
        { __typeof__(vqshls_n_u32((uint32_t)ri(), 16)) r = vqshls_n_u32((uint32_t)ri(), 16); MIX(r); }
        { __typeof__(vqshls_n_u32((uint32_t)ri(), 31)) r = vqshls_n_u32((uint32_t)ri(), 31); MIX(r); }
        { __typeof__(vqshlus_n_s32((int32_t)ri(), 0)) r = vqshlus_n_s32((int32_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlus_n_s32((int32_t)ri(), 31)) r = vqshlus_n_s32((int32_t)ri(), 31); MIX(r); }
        { __typeof__(vqabsd_s64((int64_t)ri())) r = vqabsd_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vqnegd_s64((int64_t)ri())) r = vqnegd_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vqaddd_s64((int64_t)ri(), (int64_t)ri())) r = vqaddd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vqaddd_u64((uint64_t)ri(), (uint64_t)ri())) r = vqaddd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vqsubd_s64((int64_t)ri(), (int64_t)ri())) r = vqsubd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vqsubd_u64((uint64_t)ri(), (uint64_t)ri())) r = vqsubd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vqshld_s64((int64_t)ri(), (int64_t)sh(64))) r = vqshld_s64((int64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vqshld_u64((uint64_t)ri(), (int64_t)sh(64))) r = vqshld_u64((uint64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vqrshld_s64((int64_t)ri(), (int64_t)sh(64))) r = vqrshld_s64((int64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vqrshld_u64((uint64_t)ri(), (int64_t)sh(64))) r = vqrshld_u64((uint64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vqshld_n_s64((int64_t)ri(), 0)) r = vqshld_n_s64((int64_t)ri(), 0); MIX(r); }
        { __typeof__(vqshld_n_s64((int64_t)ri(), 32)) r = vqshld_n_s64((int64_t)ri(), 32); MIX(r); }
        { __typeof__(vqshld_n_s64((int64_t)ri(), 63)) r = vqshld_n_s64((int64_t)ri(), 63); MIX(r); }
        { __typeof__(vqshld_n_u64((uint64_t)ri(), 0)) r = vqshld_n_u64((uint64_t)ri(), 0); MIX(r); }
        { __typeof__(vqshld_n_u64((uint64_t)ri(), 32)) r = vqshld_n_u64((uint64_t)ri(), 32); MIX(r); }
        { __typeof__(vqshld_n_u64((uint64_t)ri(), 63)) r = vqshld_n_u64((uint64_t)ri(), 63); MIX(r); }
        { __typeof__(vqshlud_n_s64((int64_t)ri(), 0)) r = vqshlud_n_s64((int64_t)ri(), 0); MIX(r); }
        { __typeof__(vqshlud_n_s64((int64_t)ri(), 63)) r = vqshlud_n_s64((int64_t)ri(), 63); MIX(r); }
        { __typeof__(vqmovnh_s16((int16_t)ri())) r = vqmovnh_s16((int16_t)ri()); MIX(r); }
        { __typeof__(vqshrnh_n_s16((int16_t)ri(), 1)) r = vqshrnh_n_s16((int16_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrnh_n_s16((int16_t)ri(), 8)) r = vqshrnh_n_s16((int16_t)ri(), 8); MIX(r); }
        { __typeof__(vqrshrnh_n_s16((int16_t)ri(), 1)) r = vqrshrnh_n_s16((int16_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrnh_n_s16((int16_t)ri(), 8)) r = vqrshrnh_n_s16((int16_t)ri(), 8); MIX(r); }
        { __typeof__(vqmovnh_u16((uint16_t)ri())) r = vqmovnh_u16((uint16_t)ri()); MIX(r); }
        { __typeof__(vqshrnh_n_u16((uint16_t)ri(), 1)) r = vqshrnh_n_u16((uint16_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrnh_n_u16((uint16_t)ri(), 8)) r = vqshrnh_n_u16((uint16_t)ri(), 8); MIX(r); }
        { __typeof__(vqrshrnh_n_u16((uint16_t)ri(), 1)) r = vqrshrnh_n_u16((uint16_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrnh_n_u16((uint16_t)ri(), 8)) r = vqrshrnh_n_u16((uint16_t)ri(), 8); MIX(r); }
        { __typeof__(vqmovunh_s16((int16_t)ri())) r = vqmovunh_s16((int16_t)ri()); MIX(r); }
        { __typeof__(vqshrunh_n_s16((int16_t)ri(), 1)) r = vqshrunh_n_s16((int16_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrunh_n_s16((int16_t)ri(), 8)) r = vqshrunh_n_s16((int16_t)ri(), 8); MIX(r); }
        { __typeof__(vqrshrunh_n_s16((int16_t)ri(), 1)) r = vqrshrunh_n_s16((int16_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrunh_n_s16((int16_t)ri(), 8)) r = vqrshrunh_n_s16((int16_t)ri(), 8); MIX(r); }
        { __typeof__(vqmovns_s32((int32_t)ri())) r = vqmovns_s32((int32_t)ri()); MIX(r); }
        { __typeof__(vqshrns_n_s32((int32_t)ri(), 1)) r = vqshrns_n_s32((int32_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrns_n_s32((int32_t)ri(), 16)) r = vqshrns_n_s32((int32_t)ri(), 16); MIX(r); }
        { __typeof__(vqrshrns_n_s32((int32_t)ri(), 1)) r = vqrshrns_n_s32((int32_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrns_n_s32((int32_t)ri(), 16)) r = vqrshrns_n_s32((int32_t)ri(), 16); MIX(r); }
        { __typeof__(vqmovns_u32((uint32_t)ri())) r = vqmovns_u32((uint32_t)ri()); MIX(r); }
        { __typeof__(vqshrns_n_u32((uint32_t)ri(), 1)) r = vqshrns_n_u32((uint32_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrns_n_u32((uint32_t)ri(), 16)) r = vqshrns_n_u32((uint32_t)ri(), 16); MIX(r); }
        { __typeof__(vqrshrns_n_u32((uint32_t)ri(), 1)) r = vqrshrns_n_u32((uint32_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrns_n_u32((uint32_t)ri(), 16)) r = vqrshrns_n_u32((uint32_t)ri(), 16); MIX(r); }
        { __typeof__(vqmovuns_s32((int32_t)ri())) r = vqmovuns_s32((int32_t)ri()); MIX(r); }
        { __typeof__(vqshruns_n_s32((int32_t)ri(), 1)) r = vqshruns_n_s32((int32_t)ri(), 1); MIX(r); }
        { __typeof__(vqshruns_n_s32((int32_t)ri(), 16)) r = vqshruns_n_s32((int32_t)ri(), 16); MIX(r); }
        { __typeof__(vqrshruns_n_s32((int32_t)ri(), 1)) r = vqrshruns_n_s32((int32_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshruns_n_s32((int32_t)ri(), 16)) r = vqrshruns_n_s32((int32_t)ri(), 16); MIX(r); }
        { __typeof__(vqmovnd_s64((int64_t)ri())) r = vqmovnd_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vqshrnd_n_s64((int64_t)ri(), 1)) r = vqshrnd_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrnd_n_s64((int64_t)ri(), 32)) r = vqshrnd_n_s64((int64_t)ri(), 32); MIX(r); }
        { __typeof__(vqrshrnd_n_s64((int64_t)ri(), 1)) r = vqrshrnd_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrnd_n_s64((int64_t)ri(), 32)) r = vqrshrnd_n_s64((int64_t)ri(), 32); MIX(r); }
        { __typeof__(vqmovnd_u64((uint64_t)ri())) r = vqmovnd_u64((uint64_t)ri()); MIX(r); }
        { __typeof__(vqshrnd_n_u64((uint64_t)ri(), 1)) r = vqshrnd_n_u64((uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrnd_n_u64((uint64_t)ri(), 32)) r = vqshrnd_n_u64((uint64_t)ri(), 32); MIX(r); }
        { __typeof__(vqrshrnd_n_u64((uint64_t)ri(), 1)) r = vqrshrnd_n_u64((uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrnd_n_u64((uint64_t)ri(), 32)) r = vqrshrnd_n_u64((uint64_t)ri(), 32); MIX(r); }
        { __typeof__(vqmovund_s64((int64_t)ri())) r = vqmovund_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vqshrund_n_s64((int64_t)ri(), 1)) r = vqshrund_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vqshrund_n_s64((int64_t)ri(), 32)) r = vqshrund_n_s64((int64_t)ri(), 32); MIX(r); }
        { __typeof__(vqrshrund_n_s64((int64_t)ri(), 1)) r = vqrshrund_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vqrshrund_n_s64((int64_t)ri(), 32)) r = vqrshrund_n_s64((int64_t)ri(), 32); MIX(r); }
        { __typeof__(vabsd_s64((int64_t)ri())) r = vabsd_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vnegd_s64((int64_t)ri())) r = vnegd_s64((int64_t)ri()); MIX(r); }
        { __typeof__(vaddd_s64((int64_t)ri(), (int64_t)ri())) r = vaddd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vsubd_s64((int64_t)ri(), (int64_t)ri())) r = vsubd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vceqd_s64((int64_t)ri(), (int64_t)ri())) r = vceqd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vcged_s64((int64_t)ri(), (int64_t)ri())) r = vcged_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vcgtd_s64((int64_t)ri(), (int64_t)ri())) r = vcgtd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vcled_s64((int64_t)ri(), (int64_t)ri())) r = vcled_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vcltd_s64((int64_t)ri(), (int64_t)ri())) r = vcltd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vtstd_s64((int64_t)ri(), (int64_t)ri())) r = vtstd_s64((int64_t)ri(), (int64_t)ri()); MIX(r); }
        { __typeof__(vpaddd_s64((int64x2_t){(int64_t)ri(), (int64_t)ri()})) r = vpaddd_s64((int64x2_t){(int64_t)ri(), (int64_t)ri()}); MIX(r); }
        { __typeof__(vrshld_s64((int64_t)ri(), (int64_t)sh(64))) r = vrshld_s64((int64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vshld_s64((int64_t)ri(), (int64_t)sh(64))) r = vshld_s64((int64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vshld_n_s64((int64_t)ri(), 0)) r = vshld_n_s64((int64_t)ri(), 0); MIX(r); }
        { __typeof__(vshld_n_s64((int64_t)ri(), 31)) r = vshld_n_s64((int64_t)ri(), 31); MIX(r); }
        { __typeof__(vshld_n_s64((int64_t)ri(), 63)) r = vshld_n_s64((int64_t)ri(), 63); MIX(r); }
        { __typeof__(vshrd_n_s64((int64_t)ri(), 1)) r = vshrd_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vshrd_n_s64((int64_t)ri(), 33)) r = vshrd_n_s64((int64_t)ri(), 33); MIX(r); }
        { __typeof__(vshrd_n_s64((int64_t)ri(), 64)) r = vshrd_n_s64((int64_t)ri(), 64); MIX(r); }
        { __typeof__(vrshrd_n_s64((int64_t)ri(), 1)) r = vrshrd_n_s64((int64_t)ri(), 1); MIX(r); }
        { __typeof__(vrshrd_n_s64((int64_t)ri(), 33)) r = vrshrd_n_s64((int64_t)ri(), 33); MIX(r); }
        { __typeof__(vrshrd_n_s64((int64_t)ri(), 64)) r = vrshrd_n_s64((int64_t)ri(), 64); MIX(r); }
        { __typeof__(vsrad_n_s64((int64_t)ri(), (int64_t)ri(), 1)) r = vsrad_n_s64((int64_t)ri(), (int64_t)ri(), 1); MIX(r); }
        { __typeof__(vsrad_n_s64((int64_t)ri(), (int64_t)ri(), 64)) r = vsrad_n_s64((int64_t)ri(), (int64_t)ri(), 64); MIX(r); }
        { __typeof__(vrsrad_n_s64((int64_t)ri(), (int64_t)ri(), 1)) r = vrsrad_n_s64((int64_t)ri(), (int64_t)ri(), 1); MIX(r); }
        { __typeof__(vrsrad_n_s64((int64_t)ri(), (int64_t)ri(), 64)) r = vrsrad_n_s64((int64_t)ri(), (int64_t)ri(), 64); MIX(r); }
        { __typeof__(vsrid_n_s64((int64_t)ri(), (int64_t)ri(), 1)) r = vsrid_n_s64((int64_t)ri(), (int64_t)ri(), 1); MIX(r); }
        { __typeof__(vsrid_n_s64((int64_t)ri(), (int64_t)ri(), 64)) r = vsrid_n_s64((int64_t)ri(), (int64_t)ri(), 64); MIX(r); }
        { __typeof__(vslid_n_s64((int64_t)ri(), (int64_t)ri(), 0)) r = vslid_n_s64((int64_t)ri(), (int64_t)ri(), 0); MIX(r); }
        { __typeof__(vslid_n_s64((int64_t)ri(), (int64_t)ri(), 63)) r = vslid_n_s64((int64_t)ri(), (int64_t)ri(), 63); MIX(r); }
        { __typeof__(vaddd_u64((uint64_t)ri(), (uint64_t)ri())) r = vaddd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vsubd_u64((uint64_t)ri(), (uint64_t)ri())) r = vsubd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vceqd_u64((uint64_t)ri(), (uint64_t)ri())) r = vceqd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vcged_u64((uint64_t)ri(), (uint64_t)ri())) r = vcged_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vcgtd_u64((uint64_t)ri(), (uint64_t)ri())) r = vcgtd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vcled_u64((uint64_t)ri(), (uint64_t)ri())) r = vcled_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vcltd_u64((uint64_t)ri(), (uint64_t)ri())) r = vcltd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vtstd_u64((uint64_t)ri(), (uint64_t)ri())) r = vtstd_u64((uint64_t)ri(), (uint64_t)ri()); MIX(r); }
        { __typeof__(vpaddd_u64((uint64x2_t){(uint64_t)ri(), (uint64_t)ri()})) r = vpaddd_u64((uint64x2_t){(uint64_t)ri(), (uint64_t)ri()}); MIX(r); }
        { __typeof__(vrshld_u64((uint64_t)ri(), (int64_t)sh(64))) r = vrshld_u64((uint64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vshld_u64((uint64_t)ri(), (int64_t)sh(64))) r = vshld_u64((uint64_t)ri(), (int64_t)sh(64)); MIX(r); }
        { __typeof__(vshld_n_u64((uint64_t)ri(), 0)) r = vshld_n_u64((uint64_t)ri(), 0); MIX(r); }
        { __typeof__(vshld_n_u64((uint64_t)ri(), 31)) r = vshld_n_u64((uint64_t)ri(), 31); MIX(r); }
        { __typeof__(vshld_n_u64((uint64_t)ri(), 63)) r = vshld_n_u64((uint64_t)ri(), 63); MIX(r); }
        { __typeof__(vshrd_n_u64((uint64_t)ri(), 1)) r = vshrd_n_u64((uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vshrd_n_u64((uint64_t)ri(), 33)) r = vshrd_n_u64((uint64_t)ri(), 33); MIX(r); }
        { __typeof__(vshrd_n_u64((uint64_t)ri(), 64)) r = vshrd_n_u64((uint64_t)ri(), 64); MIX(r); }
        { __typeof__(vrshrd_n_u64((uint64_t)ri(), 1)) r = vrshrd_n_u64((uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vrshrd_n_u64((uint64_t)ri(), 33)) r = vrshrd_n_u64((uint64_t)ri(), 33); MIX(r); }
        { __typeof__(vrshrd_n_u64((uint64_t)ri(), 64)) r = vrshrd_n_u64((uint64_t)ri(), 64); MIX(r); }
        { __typeof__(vsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 1)) r = vsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 64)) r = vsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 64); MIX(r); }
        { __typeof__(vrsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 1)) r = vrsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vrsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 64)) r = vrsrad_n_u64((uint64_t)ri(), (uint64_t)ri(), 64); MIX(r); }
        { __typeof__(vsrid_n_u64((uint64_t)ri(), (uint64_t)ri(), 1)) r = vsrid_n_u64((uint64_t)ri(), (uint64_t)ri(), 1); MIX(r); }
        { __typeof__(vsrid_n_u64((uint64_t)ri(), (uint64_t)ri(), 64)) r = vsrid_n_u64((uint64_t)ri(), (uint64_t)ri(), 64); MIX(r); }
        { __typeof__(vslid_n_u64((uint64_t)ri(), (uint64_t)ri(), 0)) r = vslid_n_u64((uint64_t)ri(), (uint64_t)ri(), 0); MIX(r); }
        { __typeof__(vslid_n_u64((uint64_t)ri(), (uint64_t)ri(), 63)) r = vslid_n_u64((uint64_t)ri(), (uint64_t)ri(), 63); MIX(r); }
        { __typeof__(vceqd_f64(rd(), rd())) r = vceqd_f64(rd(), rd()); MIX(r); }
        { __typeof__(vceqs_f32(rf(), rf())) r = vceqs_f32(rf(), rf()); MIX(r); }
        { __typeof__(vcged_f64(rd(), rd())) r = vcged_f64(rd(), rd()); MIX(r); }
        { __typeof__(vcges_f32(rf(), rf())) r = vcges_f32(rf(), rf()); MIX(r); }
        { __typeof__(vcgtd_f64(rd(), rd())) r = vcgtd_f64(rd(), rd()); MIX(r); }
        { __typeof__(vcgts_f32(rf(), rf())) r = vcgts_f32(rf(), rf()); MIX(r); }
        { __typeof__(vcled_f64(rd(), rd())) r = vcled_f64(rd(), rd()); MIX(r); }
        { __typeof__(vcles_f32(rf(), rf())) r = vcles_f32(rf(), rf()); MIX(r); }
        { __typeof__(vcltd_f64(rd(), rd())) r = vcltd_f64(rd(), rd()); MIX(r); }
        { __typeof__(vclts_f32(rf(), rf())) r = vclts_f32(rf(), rf()); MIX(r); }
        { __typeof__(vdupb_lane_s8(*(int8x8_t *)vb, 7)) r = vdupb_lane_s8(*(int8x8_t *)vb, 7); MIX(r); }
        { __typeof__(vdupb_laneq_s8(*(int8x16_t *)vb, 15)) r = vdupb_laneq_s8(*(int8x16_t *)vb, 15); MIX(r); }
        { __typeof__(vdupb_lane_u8(*(uint8x8_t *)vb, 7)) r = vdupb_lane_u8(*(uint8x8_t *)vb, 7); MIX(r); }
        { __typeof__(vdupb_laneq_u8(*(uint8x16_t *)vb, 15)) r = vdupb_laneq_u8(*(uint8x16_t *)vb, 15); MIX(r); }
        { __typeof__(vdupb_lane_p8(*(poly8x8_t *)vb, 7)) r = vdupb_lane_p8(*(poly8x8_t *)vb, 7); MIX(r); }
        { __typeof__(vdupb_laneq_p8(*(poly8x16_t *)vb, 15)) r = vdupb_laneq_p8(*(poly8x16_t *)vb, 15); MIX(r); }
        { __typeof__(vduph_lane_s16(*(int16x4_t *)vb, 3)) r = vduph_lane_s16(*(int16x4_t *)vb, 3); MIX(r); }
        { __typeof__(vduph_laneq_s16(*(int16x8_t *)vb, 7)) r = vduph_laneq_s16(*(int16x8_t *)vb, 7); MIX(r); }
        { __typeof__(vduph_lane_u16(*(uint16x4_t *)vb, 3)) r = vduph_lane_u16(*(uint16x4_t *)vb, 3); MIX(r); }
        { __typeof__(vduph_laneq_u16(*(uint16x8_t *)vb, 7)) r = vduph_laneq_u16(*(uint16x8_t *)vb, 7); MIX(r); }
        { __typeof__(vduph_lane_p16(*(poly16x4_t *)vb, 3)) r = vduph_lane_p16(*(poly16x4_t *)vb, 3); MIX(r); }
        { __typeof__(vduph_laneq_p16(*(poly16x8_t *)vb, 7)) r = vduph_laneq_p16(*(poly16x8_t *)vb, 7); MIX(r); }
        { __typeof__(vdups_lane_s32(*(int32x2_t *)vb, 1)) r = vdups_lane_s32(*(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vdups_laneq_s32(*(int32x4_t *)vb, 3)) r = vdups_laneq_s32(*(int32x4_t *)vb, 3); MIX(r); }
        { __typeof__(vdups_lane_u32(*(uint32x2_t *)vb, 1)) r = vdups_lane_u32(*(uint32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vdups_laneq_u32(*(uint32x4_t *)vb, 3)) r = vdups_laneq_u32(*(uint32x4_t *)vb, 3); MIX(r); }
        { __typeof__(vdups_lane_f32(*(float32x2_t *)vb, 1)) r = vdups_lane_f32(*(float32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vdups_laneq_f32(*(float32x4_t *)vb, 3)) r = vdups_laneq_f32(*(float32x4_t *)vb, 3); MIX(r); }
        { __typeof__(vdupd_lane_s64(*(int64x1_t *)vb, 0)) r = vdupd_lane_s64(*(int64x1_t *)vb, 0); MIX(r); }
        { __typeof__(vdupd_laneq_s64(*(int64x2_t *)vb, 1)) r = vdupd_laneq_s64(*(int64x2_t *)vb, 1); MIX(r); }
        { __typeof__(vdupd_lane_u64(*(uint64x1_t *)vb, 0)) r = vdupd_lane_u64(*(uint64x1_t *)vb, 0); MIX(r); }
        { __typeof__(vdupd_laneq_u64(*(uint64x2_t *)vb, 1)) r = vdupd_laneq_u64(*(uint64x2_t *)vb, 1); MIX(r); }
        { __typeof__(vdupd_lane_f64(*(float64x1_t *)vb, 0)) r = vdupd_lane_f64(*(float64x1_t *)vb, 0); MIX(r); }
        { __typeof__(vdupd_laneq_f64(*(float64x2_t *)vb, 1)) r = vdupd_laneq_f64(*(float64x2_t *)vb, 1); MIX(r); }
        { __typeof__(vfmas_lane_f32(rf(), rf(), *(float32x2_t *)fb, 0)) r = vfmas_lane_f32(rf(), rf(), *(float32x2_t *)fb, 0); MIX(r); }
        { __typeof__(vfmas_laneq_f32(rf(), rf(), *(float32x4_t *)fb, 1)) r = vfmas_laneq_f32(rf(), rf(), *(float32x4_t *)fb, 1); MIX(r); }
        { __typeof__(vfmss_lane_f32(rf(), rf(), *(float32x2_t *)fb, 0)) r = vfmss_lane_f32(rf(), rf(), *(float32x2_t *)fb, 0); MIX(r); }
        { __typeof__(vfmss_laneq_f32(rf(), rf(), *(float32x4_t *)fb, 1)) r = vfmss_laneq_f32(rf(), rf(), *(float32x4_t *)fb, 1); MIX(r); }
        { __typeof__(vmuls_lane_f32(rf(), *(float32x2_t *)fb, 0)) r = vmuls_lane_f32(rf(), *(float32x2_t *)fb, 0); MIX(r); }
        { __typeof__(vmuls_laneq_f32(rf(), *(float32x4_t *)fb, 1)) r = vmuls_laneq_f32(rf(), *(float32x4_t *)fb, 1); MIX(r); }
        { __typeof__(vmulxs_lane_f32(rf(), *(float32x2_t *)fb, 0)) r = vmulxs_lane_f32(rf(), *(float32x2_t *)fb, 0); MIX(r); }
        { __typeof__(vmulxs_laneq_f32(rf(), *(float32x4_t *)fb, 1)) r = vmulxs_laneq_f32(rf(), *(float32x4_t *)fb, 1); MIX(r); }
        { __typeof__(vfmad_lane_f64(rd(), rd(), *(float64x1_t *)fb, 0)) r = vfmad_lane_f64(rd(), rd(), *(float64x1_t *)fb, 0); MIX(r); }
        { __typeof__(vfmad_laneq_f64(rd(), rd(), *(float64x2_t *)fb, 1)) r = vfmad_laneq_f64(rd(), rd(), *(float64x2_t *)fb, 1); MIX(r); }
        { __typeof__(vfmsd_lane_f64(rd(), rd(), *(float64x1_t *)fb, 0)) r = vfmsd_lane_f64(rd(), rd(), *(float64x1_t *)fb, 0); MIX(r); }
        { __typeof__(vfmsd_laneq_f64(rd(), rd(), *(float64x2_t *)fb, 1)) r = vfmsd_laneq_f64(rd(), rd(), *(float64x2_t *)fb, 1); MIX(r); }
        { __typeof__(vmuld_lane_f64(rd(), *(float64x1_t *)fb, 0)) r = vmuld_lane_f64(rd(), *(float64x1_t *)fb, 0); MIX(r); }
        { __typeof__(vmuld_laneq_f64(rd(), *(float64x2_t *)fb, 1)) r = vmuld_laneq_f64(rd(), *(float64x2_t *)fb, 1); MIX(r); }
        { __typeof__(vmulxd_lane_f64(rd(), *(float64x1_t *)fb, 0)) r = vmulxd_lane_f64(rd(), *(float64x1_t *)fb, 0); MIX(r); }
        { __typeof__(vmulxd_laneq_f64(rd(), *(float64x2_t *)fb, 1)) r = vmulxd_laneq_f64(rd(), *(float64x2_t *)fb, 1); MIX(r); }
        { __typeof__(vqdmulhh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1)) r = vqdmulhh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmulhh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2)) r = vqdmulhh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2); MIX(r); }
        { __typeof__(vqrdmulhh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1)) r = vqrdmulhh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1); MIX(r); }
        { __typeof__(vqrdmulhh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2)) r = vqrdmulhh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmullh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1)) r = vqdmullh_lane_s16((int16_t)ri(), *(int16x4_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmullh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2)) r = vqdmullh_laneq_s16((int16_t)ri(), *(int16x8_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmlalh_lane_s16((int32_t)ri(), (int16_t)ri(), *(int16x4_t *)vb, 1)) r = vqdmlalh_lane_s16((int32_t)ri(), (int16_t)ri(), *(int16x4_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmlalh_laneq_s16((int32_t)ri(), (int16_t)ri(), *(int16x8_t *)vb, 2)) r = vqdmlalh_laneq_s16((int32_t)ri(), (int16_t)ri(), *(int16x8_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmlslh_lane_s16((int32_t)ri(), (int16_t)ri(), *(int16x4_t *)vb, 1)) r = vqdmlslh_lane_s16((int32_t)ri(), (int16_t)ri(), *(int16x4_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmlslh_laneq_s16((int32_t)ri(), (int16_t)ri(), *(int16x8_t *)vb, 2)) r = vqdmlslh_laneq_s16((int32_t)ri(), (int16_t)ri(), *(int16x8_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmulhs_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1)) r = vqdmulhs_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmulhs_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2)) r = vqdmulhs_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2); MIX(r); }
        { __typeof__(vqrdmulhs_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1)) r = vqrdmulhs_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vqrdmulhs_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2)) r = vqrdmulhs_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmulls_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1)) r = vqdmulls_lane_s32((int32_t)ri(), *(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmulls_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2)) r = vqdmulls_laneq_s32((int32_t)ri(), *(int32x4_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmlals_lane_s32((int64_t)ri(), (int32_t)ri(), *(int32x2_t *)vb, 1)) r = vqdmlals_lane_s32((int64_t)ri(), (int32_t)ri(), *(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmlals_laneq_s32((int64_t)ri(), (int32_t)ri(), *(int32x4_t *)vb, 2)) r = vqdmlals_laneq_s32((int64_t)ri(), (int32_t)ri(), *(int32x4_t *)vb, 2); MIX(r); }
        { __typeof__(vqdmlsls_lane_s32((int64_t)ri(), (int32_t)ri(), *(int32x2_t *)vb, 1)) r = vqdmlsls_lane_s32((int64_t)ri(), (int32_t)ri(), *(int32x2_t *)vb, 1); MIX(r); }
        { __typeof__(vqdmlsls_laneq_s32((int64_t)ri(), (int32_t)ri(), *(int32x4_t *)vb, 2)) r = vqdmlsls_laneq_s32((int64_t)ri(), (int32_t)ri(), *(int32x4_t *)vb, 2); MIX(r); }
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
