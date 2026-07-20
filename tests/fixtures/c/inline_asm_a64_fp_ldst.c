/* AArch64 inline asm: FP/SIMD scalar load/store -- `ldr`/`str` of a d-register
 * through a GP address, moving a double between memory and the FP register file.
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is x86-only);
 * on x86_64 the same moves run in plain C. */

int main(void) {
    double src = 42.0, dst = 0.0;
    long bits = 0;
#if defined(__aarch64__)
    __asm__("ldr d0, [%1]\n\t" /* d0 = src        */
            "str d0, [%2]\n\t" /* dst = d0        */
            "ldr d0, [%2]\n\t" /* d0 = dst (back) */
            "fmov %0, d0"      /* bits = d0       */
            : "=r"(bits)
            : "r"(&src), "r"(&dst)
            : "d0", "memory");
#else
    union {
        double d;
        long b;
    } u = {.d = src};
    dst = src;
    bits = u.b;
#endif
    /* 0x4045000000000000 is the IEEE-754 bit pattern of 42.0. */
    return (bits == 0x4045000000000000L && dst == 42.0) ? 42 : 0;
}
