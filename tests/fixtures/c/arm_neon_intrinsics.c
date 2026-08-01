/* <arm_neon.h>: the embedded NEON intrinsic subset, exercised end to end.
 * Computes an xor parity block, the GF(2^8) doubling used by RAID-6
 * syndromes, a nibble table lookup, and the polynomial byte multiply, and
 * checks each against its scalar equivalent. Native-only on AArch64; on
 * x86_64 the scalar path alone runs. */

#if defined(__aarch64__)
#include <arm_neon.h>
#endif

static unsigned char gf_double(unsigned char x) {
    return (unsigned char)((x << 1) ^ ((x & 0x80) ? 0x1d : 0));
}

int main(void) {
    unsigned char d0[16], d1[16], d2[16], out[16];
    int i;
    for (i = 0; i < 16; i++) {
        d0[i] = (unsigned char)(i * 31 + 7);
        d1[i] = (unsigned char)(0xC3 ^ (i * 5));
        d2[i] = (unsigned char)(i * i + 1);
    }
#if defined(__aarch64__)
    {
        /* P parity and the Q syndrome step of a 3-disk group, as the
         * syndrome kernels compute them. */
        uint8x16_t x1d = vdupq_n_u8(0x1d);
        uint8x16_t wp, wq, wd, w1, w2;
        wq = wp = vld1q_u8(d0);
        wd = vld1q_u8(d1);
        wp = veorq_u8(wp, wd);
        w2 = (uint8x16_t)vshrq_n_s8((int8x16_t)wq, 7);
        w1 = vshlq_n_u8(wq, 1);
        w2 = vandq_u8(w2, x1d);
        w1 = veorq_u8(w1, w2);
        wq = veorq_u8(w1, wd);
        vst1q_u8(out, wp);
        for (i = 0; i < 16; i++)
            if (out[i] != (unsigned char)(d0[i] ^ d1[i]))
                return 1;
        vst1q_u8(out, wq);
        for (i = 0; i < 16; i++)
            if (out[i] != (unsigned char)(gf_double(d0[i]) ^ d1[i]))
                return 2;
        /* Nibble table lookup, as the recovery kernel uses it. */
        {
            unsigned char tbl[16];
            uint8x16_t vt, vx;
            for (i = 0; i < 16; i++)
                tbl[i] = (unsigned char)(i * 9 + 2);
            vt = vld1q_u8(tbl);
            vx = vqtbl1q_u8(vt, vandq_u8(vld1q_u8(d2), vdupq_n_u8(0x0f)));
            vst1q_u8(out, vx);
            for (i = 0; i < 16; i++)
                if (out[i] != tbl[d2[i] & 0x0f])
                    return 3;
        }
        /* Polynomial byte multiply against a scalar carryless product. */
        {
            uint8x16_t p = vmulq_p8((poly8x16_t)vld1q_u8(d0),
                                    (poly8x16_t)vld1q_u8(d1));
            vst1q_u8(out, p);
            for (i = 0; i < 16; i++) {
                unsigned char acc = 0, x = d0[i];
                int b;
                for (b = 0; b < 8; b++)
                    if (d1[i] & (1 << b))
                        acc ^= (unsigned char)(x << b);
                if (out[i] != acc)
                    return 4;
            }
        }
        /* 64x2 xor pipeline, as the xor block ops use it. */
        {
            uint64x2_t v = veorq_u64(vld1q_u64((const uint64_t *)d0),
                                     vld1q_u64((const uint64_t *)d1));
            vst1q_u64((uint64_t *)out, v);
            for (i = 0; i < 16; i++)
                if (out[i] != (unsigned char)(d0[i] ^ d1[i]))
                    return 5;
        }
    }
#else
    for (i = 0; i < 16; i++) {
        out[i] = (unsigned char)(d0[i] ^ d1[i]);
        if (out[i] != (unsigned char)(d0[i] ^ d1[i]))
            return 1;
        if (gf_double(d2[i]) != (unsigned char)((d2[i] << 1) ^ ((d2[i] & 0x80) ? 0x1d : 0)))
            return 2;
    }
#endif
    return 42;
}
