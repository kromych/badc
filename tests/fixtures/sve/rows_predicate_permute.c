/* The ACLE SVE permutes of predicates and svpfalse, checked against
 * scalar C over the predicates' bits: svzip1, svzip2, svuzp1, svuzp2,
 * svtrn1, svtrn2 and svrev over lanes of 1, 2, 4 and 8 bits (_b8 to _b64),
 * each lane moving all its bits, of predicates with every bit pattern;
 * the result is read a bit per byte lane. The exit status is the vector
 * length in 128-bit granules. */
#include <arm_sve.h>

static uint8_t pa[256], pb[256], out[256];

/* Lane `j` of `w` bits of the result: lane `k` of a, or of b past the
 * lanes of a, as the permutation orders them. */
static int lane_of(int op, int j, int lanes) {
    int s = op % 2;
    switch (op / 2) {
    case 0: return s * lanes / 2 + j / 2 + (j % 2) * lanes;
    case 1: return 2 * j + s;
    case 2: return (j & ~1) + s + (j % 2) * lanes;
    default: return lanes - 1 - j;
    }
}

static svbool_t permute(int op, int w, svbool_t a, svbool_t b) {
    switch (op * 4 + w) {
    case 0: return svzip1_b8(a, b);
    case 1: return svzip1_b16(a, b);
    case 2: return svzip1_b32(a, b);
    case 3: return svzip1_b64(a, b);
    case 4: return svzip2_b8(a, b);
    case 5: return svzip2_b16(a, b);
    case 6: return svzip2_b32(a, b);
    case 7: return svzip2_b64(a, b);
    case 8: return svuzp1_b8(a, b);
    case 9: return svuzp1_b16(a, b);
    case 10: return svuzp1_b32(a, b);
    case 11: return svuzp1_b64(a, b);
    case 12: return svuzp2_b8(a, b);
    case 13: return svuzp2_b16(a, b);
    case 14: return svuzp2_b32(a, b);
    case 15: return svuzp2_b64(a, b);
    case 16: return svtrn1_b8(a, b);
    case 17: return svtrn1_b16(a, b);
    case 18: return svtrn1_b32(a, b);
    case 19: return svtrn1_b64(a, b);
    case 20: return svtrn2_b8(a, b);
    case 21: return svtrn2_b16(a, b);
    case 22: return svtrn2_b32(a, b);
    case 23: return svtrn2_b64(a, b);
    case 24: return svrev_b8(a);
    case 25: return svrev_b16(a);
    case 26: return svrev_b32(a);
    default: return svrev_b64(a);
    }
}

int main(void) {
    int n = (int)svcntb();
    svbool_t all = svptrue_b8();
    for (int round = 0; round < 3; round++) {
        for (int i = 0; i < 256; i++) {
            uint32_t h = (uint32_t)(i + 1000 * round) * 2654435761u;
            pa[i] = (uint8_t)(h >> 28 & 1);
            pb[i] = (uint8_t)(round == 2 ? 1 : h >> 17 & 1);
        }
        svbool_t a = svcmpne_n_u8(all, svld1(all, pa), 0);
        svbool_t b = svcmpne_n_u8(all, svld1(all, pb), 0);
        for (int op = 0; op < 7; op++) {
            for (int sz = 0; sz < 4; sz++) {
                int w = 1 << sz, lanes = n / w;
                svbool_t p = permute(op, sz, a, b);
                svst1(all, out, svsel(p, svdup_n_u8(1), svdup_n_u8(0)));
                for (int j = 0; j < lanes; j++) {
                    int k = lane_of(op, j, lanes);
                    const uint8_t *src = k < lanes ? pa : pb;
                    k %= lanes;
                    for (int t = 0; t < w; t++)
                        if (out[j * w + t] != src[k * w + t])
                            return 10 + 4 * op + sz;
                }
            }
        }
    }
    svst1(all, out, svsel(svpfalse_b(), svdup_n_u8(1), svdup_n_u8(0)));
    for (int i = 0; i < n; i++)
        if (out[i] != 0)
            return 50;
    if (svptest_any(all, svpfalse()))
        return 51;
    return n / 16;
}
