/* AArch64 inline asm: SIMD/FP arithmetic between the FP registers, with operands
 * supplied through the `w` constraint. `fmul`/`fadd` are two-source, `fneg` is
 * one-source; the compiler allocates a d-register per `w` operand. Native-only
 * on AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * same arithmetic runs in plain C. */

#if defined(__aarch64__)
static double mul(double a, double b) {
    double r;
    __asm__("fmul %0, %1, %2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}
static double add(double a, double b) {
    double r;
    __asm__("fadd %0, %1, %2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}
static double neg(double a) {
    double r;
    __asm__("fneg %0, %1" : "=w"(r) : "w"(a));
    return r;
}
#else
static double mul(double a, double b) { return a * b; }
static double add(double a, double b) { return a + b; }
static double neg(double a) { return -a; }
#endif

int main(void) {
    double p = mul(6.0, 8.0); /* 48 */
    double n = neg(6.0);      /* -6 */
    double r = add(p, n);     /* 48 - 6 = 42 */
    return (int)r;            /* 42 */
}
