/* <arm_neon.h> shifts by an immediate the shift-only rows did not cover:
 * the saturating left shifts (vqshl_n), the rounding right shifts
 * (vrshr_n), the right shifts that narrow (vshrn_n, vrshrn_n), the right
 * shifts that accumulate (vsra_n, vrsra_n) and the inserting shifts
 * (vsli_n, vsri_n), at the ends of their count ranges and on lanes that
 * saturate, round up or wrap: each
 * result checked against the operation computed lane by lane in C. The
 * exit code has a bit per failing group; elsewhere than AArch64 the unit
 * is empty. */
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>
static const unsigned char A[16] = {0x80, 0x7f, 0xff, 0x01, 0x00, 0x55, 0xaa, 0x12, 0x34, 0xfe, 0x81, 0x7e, 0x02, 0xfd, 0x40, 0xc0};
static long long sat(long long x, long long lo, long long hi) { return x < lo ? lo : x > hi ? hi : x; }
int main(void) {
    int bad = 0;
    int8_t s8[16]; uint8_t u8[16]; int16_t s16[8]; uint16_t u16[8]; uint32_t u32[4]; int64_t s64[2];
    memcpy(s8, A, 16); memcpy(u8, A, 16); memcpy(s16, A, 16); memcpy(u16, A, 16); memcpy(u32, A, 16); memcpy(s64, A, 16);
    int8x16_t vs8; uint8x16_t vu8; int16x8_t vs16; uint16x8_t vu16; uint32x4_t vu32; int64x2_t vs64;
    memcpy(&vs8, A, 16); memcpy(&vu8, A, 16); memcpy(&vs16, A, 16); memcpy(&vu16, A, 16); memcpy(&vu32, A, 16); memcpy(&vs64, A, 16);
    int8x16_t a = vqshlq_n_s8(vs8, 3); uint8x16_t b = vqshlq_n_u8(vu8, 2);
    int8x16_t c = vrshrq_n_s8(vs8, 3); uint16x8_t d = vrshrq_n_u16(vu16, 16);
    for (int i = 0; i < 16; i++) {
        bad |= a[i] != (int8_t)sat((long long)s8[i] * 8, -128, 127);
        bad |= (b[i] != (uint8_t)sat((long long)u8[i] * 4, 0, 255)) << 1;
        bad |= (c[i] != (int8_t)((s8[i] + 4) >> 3)) << 2;
        if (i < 8) bad |= (d[i] != (uint16_t)(((uint32_t)u16[i] + 0x8000) >> 16)) << 3;
    }
    int8x8_t e = vshrn_n_s16(vs16, 3); uint16x4_t f = vrshrn_n_u32(vu32, 16);
    for (int i = 0; i < 8; i++) bad |= (e[i] != (int8_t)(s16[i] >> 3)) << 4;
    for (int i = 0; i < 4; i++) bad |= (f[i] != (uint16_t)(((uint64_t)u32[i] + 0x8000) >> 16)) << 5;
    int64x2_t g = vqshlq_n_s64(vs64, 1);
    for (int i = 0; i < 2; i++) bad |= (g[i] != (s64[i] > 0x3fffffffffffffffLL ? 0x7fffffffffffffffLL : s64[i] < -0x4000000000000000LL ? (long long)0x8000000000000000ULL : s64[i] * 2)) << 6;
    /* The accumulating and inserting forms take a second operand: A's
     * bytes reversed. */
    unsigned char R[16];
    for (int i = 0; i < 16; i++) R[i] = A[15 - i];
    int8_t rs8[16]; uint8_t ru8[16]; uint16_t ru16[8]; uint32_t ru32[4]; int64_t rs64[2]; uint64_t u64[2], ru64[2];
    memcpy(rs8, R, 16); memcpy(ru8, R, 16); memcpy(ru16, R, 16); memcpy(ru32, R, 16); memcpy(rs64, R, 16);
    memcpy(u64, A, 16); memcpy(ru64, R, 16);
    int8x16_t ws8; uint8x16_t wu8; uint16x8_t wu16; uint32x4_t wu32; uint64x2_t vu64, wu64;
    memcpy(&ws8, R, 16); memcpy(&wu8, R, 16); memcpy(&wu16, R, 16); memcpy(&wu32, R, 16);
    memcpy(&vu64, A, 16); memcpy(&wu64, R, 16);
    int64x1_t xs64, ys64; uint8x8_t xu8, yu8;
    memcpy(&xs64, A, 8); memcpy(&ys64, R, 8); memcpy(&xu8, A, 8); memcpy(&yu8, R, 8);
    int8x16_t h = vsraq_n_s8(vs8, ws8, 3); uint16x8_t k = vrsraq_n_u16(vu16, wu16, 16);
    int64x1_t l = vsra_n_s64(xs64, ys64, 64); uint64x2_t m = vrsraq_n_u64(vu64, wu64, 1);
    for (int i = 0; i < 16; i++) {
        bad |= (h[i] != (int8_t)(s8[i] + (rs8[i] >> 3))) << 7;
        if (i < 8) bad |= (k[i] != (uint16_t)(u16[i] + (((uint32_t)ru16[i] + 0x8000) >> 16))) << 8;
        if (i < 2) bad |= (m[i] != u64[i] + (ru64[i] >> 1) + (ru64[i] & 1)) << 9;
    }
    bad |= (l[0] != s64[0] + (rs64[0] < 0 ? -1 : 0)) << 9;
    uint8x16_t n = vsliq_n_u8(vu8, wu8, 3); uint8x8_t p = vsri_n_u8(xu8, yu8, 3);
    uint32x4_t q = vsriq_n_u32(vu32, wu32, 32); uint64x2_t r = vsliq_n_u64(vu64, wu64, 0);
    for (int i = 0; i < 16; i++) {
        bad |= (n[i] != (uint8_t)(ru8[i] << 3 | (u8[i] & 7))) << 10;
        if (i < 8) bad |= (p[i] != (uint8_t)(ru8[i] >> 3 | (u8[i] & 0xe0))) << 10;
        if (i < 4) bad |= (q[i] != u32[i]) << 11;
        if (i < 2) bad |= (r[i] != ru64[i]) << 11;
    }
    return bad;
}
#else
int main(void) { return 0; }
#endif
