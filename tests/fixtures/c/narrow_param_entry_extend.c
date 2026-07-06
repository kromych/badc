// A register-passed narrow parameter arrives as the caller's raw
// 64-bit value; the callee applies the C99 6.5.2.2p4 / 6.3.1.3
// conversion on entry. The entry sign-extension used to be skipped
// whenever no consumer read bits 32..63, but an I8/I16 conversion
// also rewrites bits 8..31: a product truncated to int observed the
// unconverted low word. The volatile loop keeps the callees out of
// the inliner so the parameter entry path is what executes.

volatile int big = 0x12345;

static int scale(signed char c, short s, int i) {
    volatile int pad = 0;
    for (int k = 0; k < 3; k++) pad += k;
    (void)pad;
    return (int)c * 100000 + (int)s * 10 + i;
}

static unsigned uscale(unsigned char c, unsigned short s) {
    volatile int pad = 0;
    for (int k = 0; k < 3; k++) pad += k;
    (void)pad;
    return (unsigned)c * 100000u + (unsigned)s;
}

int main(void) {
    int v = big; /* 74565: char 69, short 9029 */
    if (scale(v, v, v) != 69 * 100000 + 9029 * 10 + 74565) return 1;
    if (uscale(v, v) != 69u * 100000u + 9029u) return 2;
    return 0;
}
