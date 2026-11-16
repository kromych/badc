/* <arm_neon.h>'s halfword lanes and 64-bit integer vectors: the doubleword
 * load, the halfword broadcast and equality, the exclusive or, the
 * narrowing shift, the integer lane reads, the lane broadcast and the
 * reinterpretations, each checked against its scalar value. The halfword
 * equality narrowed by four bits leaves one byte per lane, the mask a
 * wide-character search scans. Native-only on AArch64; elsewhere the unit
 * checks nothing. */

#if defined(__aarch64__)
#include <arm_neon.h>
#endif

int main(void) {
#if defined(__aarch64__)
    unsigned short w[8] = {1, 2, 3, 0x4141, 5, 0x4141, 7, 8};
    unsigned short x[4] = {1, 2, 0x8003, 0x4141};
    unsigned char b[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    uint16x8_t v = vreinterpretq_u16_u8(vld1q_u8((const unsigned char *)w));
    uint16x8_t eq = vceqq_u16(v, vdupq_n_u16(0x4141));
    unsigned long long mask = vget_lane_u64(vreinterpret_u64_u8(vshrn_n_u16(eq, 4)), 0);
    if (mask != 0x0000ff00ff000000ull)
        return 1;
    uint16x4_t lo = vreinterpret_u16_u8(vld1_u8((const unsigned char *)w));
    uint16x4_t other = vreinterpret_u16_u8(vld1_u8((const unsigned char *)x));
    unsigned long long diff = vget_lane_u64(vreinterpret_u64_u16(veor_u16(lo, other)), 0);
    if (diff != 0x00008000ull << 32)
        return 2;
    if (vget_lane_u32(vreinterpret_u32_u8(vld1_u8(b)), 1) != 0x08070605u)
        return 3;
    uint64x2_t both = vdupq_lane_u64(vmov_n_u64(0x0004000300020001ull), 0);
    uint16x8_t halves = vreinterpretq_u16_u64(both);
    if (halves[0] != 1 || halves[3] != 4 || halves[4] != 1 || halves[7] != 4)
        return 4;
#endif
    return 42;
}
