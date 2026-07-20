/* AArch64 inline asm: NEON widening and narrowing. `uaddl` adds two vectors of
 * 16-bit lanes into 32-bit lanes (no overflow); `xtn` extracts the low byte of
 * each 16-bit lane. Results are read back with umov. Native-only on AArch64
 * (the interpreter's inline-asm evaluator is x86-only); on x86_64 the scalar
 * equivalent runs in plain C. */

static int uaddl_widen(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v1.4h, %w1\n\t"
            "dup v2.4h, %w2\n\t"
            "uaddl v0.4s, v1.4h, v2.4h\n\t" /* 32-bit sums of 16-bit lanes */
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "d2", "memory");
#else
    r = (a & 0xFFFF) + (b & 0xFFFF);
#endif
    return r;
}

static int xtn_narrow(int hw) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v1.8h, %w1\n\t"
            "xtn v0.8b, v1.8h\n\t" /* low byte of each 16-bit lane */
            "umov %w0, v0.b[0]"
            : "=r"(r)
            : "r"(hw)
            : "d0", "d1", "memory");
#else
    r = hw & 0xFF;
#endif
    return r;
}

int main(void) {
    if (uaddl_widen(20, 22) != 42) return 1; /* 20 + 22, widened */
    if (xtn_narrow(0x2A) != 42) return 2;    /* low byte 0x2A    */
    return 42;
}
