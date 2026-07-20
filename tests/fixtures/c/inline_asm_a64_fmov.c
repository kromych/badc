/* AArch64 inline asm: fmov bridging the general-purpose and SIMD/FP register
 * files. A value is moved into d0 (GP -> FP) and read back (FP -> GP),
 * round-tripping unchanged -- the bit pattern is preserved. Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * value passes through directly. */

int main(void) {
    long x = 42, r = 0;
#if defined(__aarch64__)
    __asm__ volatile(
        "fmov d0, %1\n\t" /* d0 = x (GP -> FP) */
        "fmov %0, d0"     /* r  = d0 (FP -> GP) */
        : "=r"(r)
        : "r"(x)
        : "d0");
#else
    r = x;
#endif
    return (int)r; /* 42 */
}
