/* AArch64 inline asm: NEON lane transfer between vector elements and GP
 * registers. `ins` writes a GP value into a chosen lane; `umov` reads a lane
 * back zero-extended; `smov` reads it sign-extended. The lane index reaches
 * lanes a scalar `fmov` cannot. Native-only on AArch64 (the interpreter's
 * inline-asm evaluator is x86-only); on x86_64 the scalar equivalent runs in
 * plain C. */

static int lane_roundtrip(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("ins v0.s[0], %w1\n\t"
            "ins v0.s[2], %w2\n\t"
            "umov %w0, v0.s[2]"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "memory");
#else
    (void)a;
    r = b;
#endif
    return r;
}

static int smov_byte(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.16b, %w1\n\t"
            "smov %w0, v0.b[0]"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = (signed char)w;
#endif
    return r;
}

int main(void) {
    if (lane_roundtrip(7, 42) != 42) return 1; /* insert lane 2, read it back */
    if (smov_byte(0xEE) != -18) return 2;      /* 0xEE as signed char = -18   */
    return 42;
}
