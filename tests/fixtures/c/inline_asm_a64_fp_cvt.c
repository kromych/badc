/* AArch64 inline asm: integer <-> floating-point conversions across the two
 * register files. `scvtf` widens a signed integer in a GP register to a double
 * in an FP register; `fcvtzs` truncates a double back to a signed integer. The
 * `r` and `w` constraints place the operands in the right files. Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * same conversions run in plain C. */

#if defined(__aarch64__)
static long to_int(double d) {
    long r;
    __asm__("fcvtzs %0, %1" : "=r"(r) : "w"(d));
    return r;
}
static double to_dbl(long i) {
    double r;
    __asm__("scvtf %0, %1" : "=w"(r) : "r"(i));
    return r;
}
#else
static long to_int(double d) { return (long)d; }
static double to_dbl(long i) { return (double)i; }
#endif

int main(void) {
    return (int)to_int(to_dbl(42)); /* 42 -> 42.0 -> 42 */
}
