/* A constant-time DES round function used as a self-contained
 * regression. At -O on x86_64 the optimizer folds each
 *
 *     y = const ^ (x & mask)
 *
 * line into a `BinopI{Xor}` against a 32-bit constant outside i32
 * range. The ~30 `y` temporaries are all live at once, which saturates
 * the caller-saved registers; the wide-immediate Xor lowering then had
 * no free scratch and bailed ("op outside the implemented subset") at
 * ent_pc 113. The reserved r13 scratch closes that hole.
 *
 * `rotl` is inlined; the driver runs a fixed set of inputs and folds
 * the 32-bit accumulator into one byte, observable through the process
 * exit status.
 */

typedef unsigned int uint32_t;

static uint32_t rotl(uint32_t x, int n) {
    return (x << n) | (x >> (32 - n));
}

static uint32_t des_round(uint32_t r0, const uint32_t *sk) {
    uint32_t x0, x1, x2, x3, x4, x5, z0;
    uint32_t y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
    uint32_t y10, y11, y12, y13, y14, y15, y16, y17, y18, y19;
    uint32_t y20, y21, y22, y23, y24, y25, y26, y27, y28, y29;
    uint32_t y30;

    x1 = r0 & (uint32_t)0x11111111;
    x2 = (r0 >> 1) & (uint32_t)0x11111111;
    x3 = (r0 >> 2) & (uint32_t)0x11111111;
    x4 = (r0 >> 3) & (uint32_t)0x11111111;
    x1 = (x1 << 4) - x1;
    x2 = (x2 << 4) - x2;
    x3 = (x3 << 4) - x3;
    x4 = (x4 << 4) - x4;
    x0 = (x4 << 4) | (x4 >> 28);
    x5 = (x1 >> 4) | (x1 << 28);

    x0 ^= sk[0];
    x1 ^= sk[1];
    x2 ^= sk[2];
    x3 ^= sk[3];
    x4 ^= sk[4];
    x5 ^= sk[5];

    y0 = (uint32_t)0xEFA72C4D ^ (x0 & (uint32_t)0xEC7AC69C);
    y1 = (uint32_t)0xAEAAEDFF ^ (x0 & (uint32_t)0x500FB821);
    y2 = (uint32_t)0x37396665 ^ (x0 & (uint32_t)0x40EFA809);
    y3 = (uint32_t)0x68D7B833 ^ (x0 & (uint32_t)0xA5EC0B28);
    y4 = (uint32_t)0xC9C755BB ^ (x0 & (uint32_t)0x252CF820);
    y5 = (uint32_t)0x73FC3606 ^ (x0 & (uint32_t)0x40205801);
    y6 = (uint32_t)0xA2A0A918 ^ (x0 & (uint32_t)0xE220F929);
    y7 = (uint32_t)0x8222BD90 ^ (x0 & (uint32_t)0x44A3F9E1);
    y8 = (uint32_t)0xD6B6AC77 ^ (x0 & (uint32_t)0x794F104A);
    y9 = (uint32_t)0x3069300C ^ (x0 & (uint32_t)0x026F320B);
    y10 = (uint32_t)0x6CE0D5CC ^ (x0 & (uint32_t)0x7640B01A);
    y11 = (uint32_t)0x59A9A22D ^ (x0 & (uint32_t)0x238F1572);
    y12 = (uint32_t)0xAC6D0BD4 ^ (x0 & (uint32_t)0x7A63C083);
    y13 = (uint32_t)0x21C83200 ^ (x0 & (uint32_t)0x11CCA000);
    y14 = (uint32_t)0xA0E62188 ^ (x0 & (uint32_t)0x202F69AA);
    y16 = (uint32_t)0xAF7D655A ^ (x0 & (uint32_t)0x51B33BE9);
    y17 = (uint32_t)0xF0168AA3 ^ (x0 & (uint32_t)0x3B0FE8AE);
    y18 = (uint32_t)0x90AA30C6 ^ (x0 & (uint32_t)0x90BF8816);
    y19 = (uint32_t)0x5AB2750A ^ (x0 & (uint32_t)0x09E34F9B);
    y20 = (uint32_t)0x5391BE65 ^ (x0 & (uint32_t)0x0103BE88);
    y21 = (uint32_t)0x93372BAF ^ (x0 & (uint32_t)0x49AC8E25);
    y22 = (uint32_t)0xF288210C ^ (x0 & (uint32_t)0x922C313D);
    y23 = (uint32_t)0x920AF5C0 ^ (x0 & (uint32_t)0x70EF31B0);
    y24 = (uint32_t)0x63D312C0 ^ (x0 & (uint32_t)0x6A707100);
    y25 = (uint32_t)0x537B3006 ^ (x0 & (uint32_t)0xB97C9011);
    y26 = (uint32_t)0xA2EFB0A5 ^ (x0 & (uint32_t)0xA320C959);
    y27 = (uint32_t)0xBC8F96A5 ^ (x0 & (uint32_t)0x6EA0AB4A);
    y28 = (uint32_t)0xFAD176A5 ^ (x0 & (uint32_t)0x6953DDF8);
    y29 = (uint32_t)0x665A14A3 ^ (x0 & (uint32_t)0xF74F3E2B);
    y30 = (uint32_t)0xF2EFF0CC ^ (x0 & (uint32_t)0xF0306CAD);

    y0 = y0 ^ (x1 & y1);
    y1 = y2 ^ (x1 & y3);
    y2 = y4 ^ (x1 & y5);
    y3 = y6 ^ (x1 & y7);
    y4 = y8 ^ (x1 & y9);
    y5 = y10 ^ (x1 & y11);
    y6 = y12 ^ (x1 & y13);
    y7 = y14;
    y8 = y16 ^ (x1 & y17);
    y9 = y18 ^ (x1 & y19);
    y10 = y20 ^ (x1 & y21);
    y11 = y22 ^ (x1 & y23);
    y12 = y24 ^ (x1 & y25);
    y13 = y26 ^ (x1 & y27);
    y14 = y28 ^ (x1 & y29);
    y15 = y30;

    y0 = y0 ^ (x2 & y1);
    y1 = y2 ^ (x2 & y3);
    y2 = y4 ^ (x2 & y5);
    y3 = y6 ^ (x2 & y7);
    y4 = y8 ^ (x2 & y9);
    y5 = y10 ^ (x2 & y11);
    y6 = y12 ^ (x2 & y13);
    y7 = y14 ^ (x2 & y15);

    y0 = y0 ^ (x3 & y1);
    y1 = y2 ^ (x3 & y3);
    y2 = y4 ^ (x3 & y5);
    y3 = y6 ^ (x3 & y7);

    y0 = y0 ^ (x4 & y1);
    y1 = y2 ^ (x4 & y3);

    y0 = y0 ^ (x5 & y1);

    z0 = (y0 & (uint32_t)0x00000004) << 3;
    z0 |= (y0 & (uint32_t)0x00004000) << 4;
    z0 |= rotl(y0 & 0x12020120, 5);
    z0 |= (y0 & (uint32_t)0x00100000) << 6;
    z0 |= (y0 & (uint32_t)0x00008000) << 9;
    z0 |= (y0 & (uint32_t)0x04000000) >> 22;
    z0 |= (y0 & (uint32_t)0x00000001) << 11;
    z0 |= rotl(y0 & 0x20000200, 12);
    z0 |= (y0 & (uint32_t)0x00200000) >> 19;
    z0 |= (y0 & (uint32_t)0x00000040) << 14;
    z0 |= (y0 & (uint32_t)0x00010000) << 15;
    z0 |= (y0 & (uint32_t)0x00000002) << 16;
    z0 |= rotl(y0 & 0x40801800, 17);
    z0 |= (y0 & (uint32_t)0x00080000) >> 13;
    z0 |= (y0 & (uint32_t)0x00000010) << 21;
    z0 |= (y0 & (uint32_t)0x01000000) >> 10;
    z0 |= rotl(y0 & 0x88000008, 24);
    z0 |= (y0 & (uint32_t)0x00000480) >> 7;
    z0 |= (y0 & (uint32_t)0x00442000) >> 6;
    return z0;
}

int main(void) {
    /* Subkey words 0..5 and two round inputs; fixed so the result is a
     * deterministic known answer independent of any RNG. */
    static const uint32_t sk[6] = {
        0x01234567u, 0x89ABCDEFu, 0xFEDCBA98u,
        0x76543210u, 0x0F0F0F0Fu, 0xF0F0F0F0u
    };
    uint32_t acc = 0u;
    uint32_t r = 0xA5A5A5A5u;
    int i;
    for (i = 0; i < 16; i++) {
        acc ^= des_round(r, sk);
        r = (r * 1664525u) + 1013904223u; /* LCG to vary the input */
    }
    /* Fold the 32-bit accumulator into one byte so the value is
     * observable through the process exit status. */
    return (int)((acc ^ (acc >> 8) ^ (acc >> 16) ^ (acc >> 24)) & 0xffu);
}
