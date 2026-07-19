/* AArch64 inline asm: FP operand view modifiers %dN / %sN. GCC-style AArch64
 * inline asm names an FP operand with a register-view modifier (%dN double,
 * %sN single) rather than the bare %N. badc's `w` (double) operands accept
 * %dN as the double view (the same register the bare %N gives). Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * plain-C computation runs. */

static double mul_dmod(double a, double b) {
    double r;
#if defined(__aarch64__)
    __asm__("fmul %d0, %d1, %d2" /* explicit double view of the operands */
            : "=w"(r)
            : "w"(a), "w"(b)
            : "memory");
#else
    r = a * b;
#endif
    return r;
}

int main(void) {
    return (mul_dmod(6.0, 7.0) == 42.0) ? 42 : 0;
}
