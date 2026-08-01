/* AArch64 inline asm: 16-byte vector values as `w` operands. Vectors flow
 * in and out of the SIMD register file through the q view (`%qN`), the
 * arrangement view (`%N.16b`), and the one-register table list (`{%N.16b}`).
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is
 * x86-only); on x86_64 the scalar equivalent runs in plain C. */

typedef unsigned char u8x16 __attribute__((vector_size(16)));

#if defined(__aarch64__)
static u8x16 load16(const unsigned char *p) {
    u8x16 r;
    __asm__("ldr %q0, [%1]" : "=w"(r) : "r"(p) : "memory");
    return r;
}
static void store16(unsigned char *p, u8x16 v) {
    __asm__("str %q1, [%0]" : : "r"(p), "w"(v) : "memory");
}
static u8x16 xor16(u8x16 a, u8x16 b) {
    u8x16 r;
    __asm__("eor %0.16b, %1.16b, %2.16b" : "=w"(r) : "w"(a), "w"(b));
    return r;
}
static u8x16 dup16(unsigned char x) {
    u8x16 r;
    __asm__("dup %0.16b, %w1" : "=w"(r) : "r"(x));
    return r;
}
static u8x16 tbl16(u8x16 t, u8x16 idx) {
    u8x16 r;
    __asm__("tbl %0.16b, {%1.16b}, %2.16b" : "=w"(r) : "w"(t), "w"(idx));
    return r;
}
static u8x16 pmul16(u8x16 a, u8x16 b) {
    u8x16 r;
    __asm__("pmul %0.16b, %1.16b, %2.16b" : "=w"(r) : "w"(a), "w"(b));
    return r;
}
static u8x16 eor3_16(u8x16 a, u8x16 b, u8x16 c) {
    u8x16 r;
    __asm__(".arch_extension sha3\n"
            "eor3 %0.16b, %1.16b, %2.16b, %3.16b"
            : "=w"(r)
            : "w"(a), "w"(b), "w"(c));
    return r;
}
static u8x16 gf2x8_double(u8x16 v) {
    /* (v << 1) ^ (0x1d where the top bit was set): the GF(2^8) doubling
     * built from the immediate shifts. */
    u8x16 hi, lo, m, x1d = dup16(0x1d);
    __asm__("sshr %0.16b, %1.16b, #7" : "=w"(hi) : "w"(v));
    __asm__("shl %0.16b, %1.16b, #1" : "=w"(lo) : "w"(v));
    __asm__("and %0.16b, %1.16b, %2.16b" : "=w"(m) : "w"(hi), "w"(x1d));
    return xor16(lo, m);
}
#endif

int main(void) {
    unsigned char a[16], b[16], out[16];
    int i;
    for (i = 0; i < 16; i++) {
        a[i] = (unsigned char)(i * 17 + 3);
        b[i] = (unsigned char)(0xF0 - i);
    }
#if defined(__aarch64__)
    u8x16 va = load16(a), vb = load16(b);
    /* xor */
    store16(out, xor16(va, vb));
    for (i = 0; i < 16; i++)
        if (out[i] != (unsigned char)(a[i] ^ b[i]))
            return 1;
    /* three-way xor (eor3) */
    store16(out, eor3_16(va, vb, dup16(0xA5)));
    for (i = 0; i < 16; i++)
        if (out[i] != (unsigned char)(a[i] ^ b[i] ^ 0xA5))
            return 2;
    /* table lookup: reverse the lanes of a */
    for (i = 0; i < 16; i++)
        out[i] = (unsigned char)(15 - i);
    store16(out, tbl16(va, load16(out)));
    for (i = 0; i < 16; i++)
        if (out[i] != a[15 - i])
            return 3;
    /* polynomial multiply: carryless 0x13 * 0x11 = 0x123, low byte 0x23 */
    store16(out, pmul16(dup16(0x13), dup16(0x11)));
    if (out[0] != 0x23)
        return 4;
    /* GF(2^8) doubling from shl/sshr/and */
    store16(out, gf2x8_double(va));
    for (i = 0; i < 16; i++) {
        unsigned char want =
            (unsigned char)((a[i] << 1) ^ ((a[i] & 0x80) ? 0x1d : 0));
        if (out[i] != want)
            return 5;
    }
#else
    for (i = 0; i < 16; i++)
        out[i] = (unsigned char)(a[i] ^ b[i]);
    for (i = 0; i < 16; i++)
        if (out[i] != (unsigned char)(a[i] ^ b[i]))
            return 1;
#endif
    return 42;
}
