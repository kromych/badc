/* AArch64 inline asm: NEON across-lane reductions. `addv` sums every lane into
 * a scalar at the source element width (here s, an S register); `saddlv` sums
 * into a wider scalar (here h, a byte/half scalar-SIMD register). Each result
 * is read back with umov. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int addv_sum(int a, int b, int c, int e) {
    int r;
#if defined(__aarch64__)
    __asm__("ins v0.s[0], %w1\n\t"
            "ins v0.s[1], %w2\n\t"
            "ins v0.s[2], %w3\n\t"
            "ins v0.s[3], %w4\n\t"
            "addv s0, v0.4s\n\t" /* s0 = a + b + c + e */
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(a), "r"(b), "r"(c), "r"(e)
            : "d0", "memory");
#else
    r = a + b + c + e;
#endif
    return r;
}

static int saddlv_halves(int byteval) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.16b, %w1\n\t"  /* 16 lanes = byteval          */
            "saddlv h0, v0.16b\n\t" /* h0 = 16-bit sum = 16*byteval */
            "umov %w0, v0.h[0]"
            : "=r"(r)
            : "r"(byteval)
            : "d0", "memory");
#else
    r = 16 * (signed char) byteval;
#endif
    return r;
}

int main(void) {
    if (addv_sum(10, 12, 11, 9) != 42) return 1; /* word reduction -> S reg  */
    if (saddlv_halves(2) != 32) return 2;        /* long reduction -> H reg  */
    return 42;
}
