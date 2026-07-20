/* AArch64 inline asm: register clobbers are honored. The template trashes a
 * declared clobber register (x2) before reading an operand; without clobber
 * avoidance the allocator would place an operand in x2 and the trash would
 * corrupt it. With the clobber recorded, operands avoid x2 and the result is
 * correct. A second function checks a SIMD/FP (d-register) clobber the same
 * way. Native-only on AArch64 (the interpreter's inline-asm evaluator is
 * x86-only); on x86_64 the plain-C computation runs. */

static int gp_clobber(int a, int b, int c) {
    int r;
#if defined(__aarch64__)
    __asm__("mov x2, #0\n\t"          /* trash x2 (a declared clobber) */
            "add %w0, %w1, %w2\n\t"   /* r = a + b; b must not alias x2 */
            "add %w0, %w0, %w3"       /* r += c                        */
            : "=r"(r)
            : "r"(a), "r"(b), "r"(c)
            : "x2", "memory");
#else
    r = a + b + c;
#endif
    return r;
}

static int fp_clobber(int a, int b, int c) {
    int r;
#if defined(__aarch64__)
    /* d1 is trashed before the sum is read from the "w" operands, which must
     * therefore not alias d1. */
    double x = a, y = b, z = c, s;
    __asm__("fmov d1, xzr\n\t" /* trash d1 (a declared clobber) */
            "fadd %0, %1, %2\n\t"
            "fadd %0, %0, %3"
            : "=w"(s)
            : "w"(x), "w"(y), "w"(z)
            : "d1", "memory");
    r = (int) s;
#else
    r = a + b + c;
#endif
    return r;
}

int main(void) {
    if (gp_clobber(19, 14, 9) != 42) return 1;
    if (fp_clobber(20, 14, 8) != 42) return 2;
    return 42;
}
