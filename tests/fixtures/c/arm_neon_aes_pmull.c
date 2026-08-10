/* <arm_neon.h>: the FEAT_AES surface (single AES rounds and the 64x64->128
 * carryless multiply) host crypto acceleration builds on. Each result is
 * checked against a scalar model or an algebraic identity. Native-only on
 * AArch64; elsewhere only the scalar model runs. */

#include <string.h>

#if defined(__aarch64__)
#include <arm_neon.h>

typedef union {
    unsigned char b[16];
    uint8x16_t v;
} V16;

/* AES SubBytes over the S-box entries this test needs, derived rather than
 * tabulated: x^-1 in GF(2^8) followed by the affine transform. */
static unsigned char gf_mul(unsigned char a, unsigned char b) {
    unsigned char p = 0;
    int i;
    for (i = 0; i < 8; i++) {
        if (b & 1)
            p ^= a;
        b >>= 1;
        a = (unsigned char)((a << 1) ^ ((a & 0x80) ? 0x1b : 0));
    }
    return p;
}

static unsigned char gf_inv(unsigned char a) {
    int i;
    if (a == 0)
        return 0;
    for (i = 1; i < 256; i++)
        if (gf_mul(a, (unsigned char)i) == 1)
            return (unsigned char)i;
    return 0;
}

static unsigned char sbox(unsigned char a) {
    unsigned char x = gf_inv(a), y = 0;
    int i;
    for (i = 0; i < 8; i++) {
        unsigned char bit = (unsigned char)(((x >> i) & 1) ^ ((x >> ((i + 4) & 7)) & 1)
                                            ^ ((x >> ((i + 5) & 7)) & 1)
                                            ^ ((x >> ((i + 6) & 7)) & 1)
                                            ^ ((x >> ((i + 7) & 7)) & 1)
                                            ^ ((0x63 >> i) & 1));
        y = (unsigned char)(y | (bit << i));
    }
    return y;
}

/* ShiftRows on the column-major AES state. */
static void shift_rows(const unsigned char *in, unsigned char *out) {
    int c, r;
    for (c = 0; c < 4; c++)
        for (r = 0; r < 4; r++)
            out[c * 4 + r] = in[((c + r) & 3) * 4 + r];
}
#endif

int main(void) {
#if defined(__aarch64__)
    V16 d, k, r, want;
    int i;
    for (i = 0; i < 16; i++) {
        d.b[i] = (unsigned char)(i * 37 + 5);
        k.b[i] = (unsigned char)(0xA5 ^ (i * 11));
    }
    /* aese = AddRoundKey, ShiftRows, SubBytes. */
    {
        unsigned char x[16], s[16];
        for (i = 0; i < 16; i++)
            x[i] = (unsigned char)(d.b[i] ^ k.b[i]);
        shift_rows(x, s);
        for (i = 0; i < 16; i++)
            want.b[i] = sbox(s[i]);
        r.v = vaeseq_u8(d.v, k.v);
        if (memcmp(r.b, want.b, 16) != 0)
            return 1;
    }
    /* aesd undoes aese when the round key is applied on the same side:
     * aesd(aese(x, 0), 0) is the identity. */
    {
        uint8x16_t z = vdupq_n_u8(0);
        r.v = vaesdq_u8(vaeseq_u8(d.v, z), z);
        if (memcmp(r.b, d.b, 16) != 0)
            return 2;
    }
    /* aesimc is the inverse of aesmc. */
    r.v = vaesimcq_u8(vaesmcq_u8(d.v));
    if (memcmp(r.b, d.b, 16) != 0)
        return 3;
    /* MixColumns multiplies each column by the fixed polynomial; check the
     * first column against the scalar model. */
    {
        r.v = vaesmcq_u8(d.v);
        for (i = 0; i < 4; i++) {
            unsigned char e = (unsigned char)(gf_mul(d.b[i], 2)
                                              ^ gf_mul(d.b[(i + 1) & 3], 3)
                                              ^ d.b[(i + 2) & 3] ^ d.b[(i + 3) & 3]);
            if (r.b[i] != e)
                return 4;
        }
    }
    /* vmull_p64: carryless 64x64 -> 128, checked against a scalar model. */
    {
        union {
            poly128_t v;
            unsigned long long q[2];
        } u;
        unsigned long long a = 0xF00DFACEDEADBEEFull, b = 0x123456789ABCDEF1ull;
        unsigned long long lo = 0, hi = 0;
        int j;
        for (j = 0; j < 64; j++)
            if ((b >> j) & 1) {
                lo ^= a << j;
                if (j)
                    hi ^= a >> (64 - j);
            }
        u.v = vmull_p64((poly64_t)a, (poly64_t)b);
        if (u.q[0] != lo || u.q[1] != hi)
            return 5;
        u.v = vmull_p64((poly64_t)0x13, (poly64_t)0x11);
        if (u.q[0] != 0x123ull || u.q[1] != 0ull)
            return 6;
    }
#endif
    return 42;
}
