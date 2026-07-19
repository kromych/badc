/* AArch64 inline asm: FP immediate (fmov #imm). fmov loads a VFP-encodable
 * float constant into a scalar register or every lane of a vector. Reading the
 * constant back as its IEEE-754 bit pattern checks the encoding end to end.
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is x86-only);
 * on x86_64 the bit patterns are the plain-C constants. */

static long long dbl_two_bits(void) {
    long long r;
#if defined(__aarch64__)
    __asm__("fmov d0, #2.0\n\t" /* d0 = 2.0        */
            "fmov %0, d0"        /* r  = bits(2.0)  */
            : "=r"(r)
            :
            : "d0");
#else
    r = 0x4000000000000000LL; /* IEEE-754 double 2.0 */
#endif
    return r;
}

static int vec_one_bits(void) {
    int r;
#if defined(__aarch64__)
    __asm__("fmov v0.4s, #1.0\n\t" /* every lane = 1.0f  */
            "umov %w0, v0.s[2]"    /* r = bits(1.0f)     */
            : "=r"(r)
            :
            : "d0", "memory");
#else
    r = 0x3F800000; /* IEEE-754 float 1.0 */
#endif
    return r;
}

int main(void) {
    if (dbl_two_bits() != 0x4000000000000000LL) return 1;
    if (vec_one_bits() != 0x3F800000) return 2;
    return 42;
}
