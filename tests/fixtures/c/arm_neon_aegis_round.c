/* <arm_neon.h>: the intrinsics and vector-operator mix the kernel's aegis128
 * NEON unit uses -- table lookup with fallback, byte equality, halfword
 * reversal, across-lanes minimum, 64-bit lane composition, and its
 * mix-columns step verbatim -- each checked against a scalar reference.
 * Native-only on AArch64; elsewhere only the trailing return runs. */

#if defined(__aarch64__)
#include <arm_neon.h>

static unsigned char xtime(unsigned char x) {
    return (unsigned char)((x << 1) ^ ((x & 0x80) ? 0x1b : 0));
}
#endif

int main(void) {
    unsigned char vb[16];
    int i;
    for (i = 0; i < 16; i++)
        vb[i] = (unsigned char)(i * 23 + 5);
#if defined(__aarch64__)
    /* vrev32q_u16: the halfwords of each word swap, so byte i reads from
     * the same word at (i + 2) mod 4. */
    {
        unsigned char out[16];
        uint8x16_t r = (uint8x16_t)vrev32q_u16((uint16x8_t)vld1q_u8(vb));
        vst1q_u8(out, r);
        for (i = 0; i < 16; i++)
            if (out[i] != vb[(i & 12) | ((i + 2) & 3)])
                return 1;
    }
    /* vceqq_u8: 0xff where the bytes are equal, 0 where they differ. */
    {
        unsigned char tb[16], out[16];
        for (i = 0; i < 16; i++)
            tb[i] = vb[i];
        tb[5] ^= 0xff;
        vst1q_u8(out, vceqq_u8(vld1q_u8(vb), vld1q_u8(tb)));
        for (i = 0; i < 16; i++)
            if (out[i] != (i == 5 ? 0x00 : 0xff))
                return 2;
    }
    /* vqtbx1q_u8: an in-range index byte selects from the table, an
     * out-of-range one keeps the destination byte. */
    {
        static const unsigned char idx[16] = {0, 17, 2, 35, 4, 21, 6,  7,
                                              8, 9,  50, 11, 12, 13, 14, 255};
        unsigned char tb[16], out[16];
        for (i = 0; i < 16; i++)
            tb[i] = (unsigned char)(200 - 3 * i);
        vst1q_u8(out, vqtbx1q_u8(vld1q_u8(vb), vld1q_u8(tb), vld1q_u8(idx)));
        for (i = 0; i < 16; i++)
            if (out[i] != (idx[i] < 16 ? tb[idx[i]] : vb[i]))
                return 3;
    }
    /* vminvq_s8 against a scalar minimum. */
    {
        static const unsigned char sb[16] = {5,   254, 100, 128, 1,  2,  3,  4,
                                             250, 6,   7,   8,   9,  10, 11, 12};
        signed char min = 127;
        for (i = 0; i < 16; i++)
            if ((signed char)sb[i] < min)
                min = (signed char)sb[i];
        if (vminvq_s8((int8x16_t)vld1q_u8(sb)) != min)
            return 4;
    }
    /* vmov_n_u64 / vcombine_u64: the length block of the final step. */
    {
        uint64x2_t v = vcombine_u64(vmov_n_u64(0x1122334455667788ull),
                                    vmov_n_u64(0x99aabbccddeeff00ull));
        if (vgetq_lane_u64(v, 0) != 0x1122334455667788ull)
            return 5;
        if (vgetq_lane_u64(v, 1) != 0x99aabbccddeeff00ull)
            return 6;
    }
    /* The unit's mix-columns lines, verbatim, against the byte-wise AES
     * MixColumns of each 32-bit word. */
    {
        static const uint8_t ror32by8[] = {
            0x1, 0x2, 0x3, 0x0, 0x5, 0x6, 0x7, 0x4,
            0x9, 0xa, 0xb, 0x8, 0xd, 0xe, 0xf, 0xc,
        };
        unsigned char out[16], ref[16];
        uint8x16_t v = vld1q_u8(vb);
        uint8x16_t w;

        w = (v << 1) ^ (uint8x16_t)(((int8x16_t)v >> 7) & 0x1b);
        w ^= (uint8x16_t)vrev32q_u16((uint16x8_t)v);
        w ^= vqtbl1q_u8(v ^ w, vld1q_u8(ror32by8));

        vst1q_u8(out, w);
        for (i = 0; i < 16; i++) {
            int c = i & 12, r = i & 3;
            ref[i] = (unsigned char)(xtime(vb[c + r]) ^ xtime(vb[c + ((r + 1) & 3)]) ^
                                     vb[c + ((r + 1) & 3)] ^ vb[c + ((r + 2) & 3)] ^
                                     vb[c + ((r + 3) & 3)]);
        }
        for (i = 0; i < 16; i++)
            if (out[i] != ref[i])
                return 7;
    }
#endif
    return 42;
}
