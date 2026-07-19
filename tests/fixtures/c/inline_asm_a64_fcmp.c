/* AArch64 inline asm: `fcmp` against #0.0 sets the condition flags, which a
 * conditional select then consumes -- the branchless "sign test" idiom. The FP
 * value arrives through the `w` constraint. Native-only on AArch64 (the
 * interpreter's inline-asm evaluator is x86-only); on x86_64 the same comparison
 * runs in plain C. */

#if defined(__aarch64__)
static int nonneg(double x) {
    int r;
    __asm__("fcmp %1, #0.0\n\t"
            "cset %w0, ge"
            : "=r"(r)
            : "w"(x)
            : "cc");
    return r;
}
#else
static int nonneg(double x) { return x >= 0.0 ? 1 : 0; }
#endif

int main(void) {
    return (nonneg(3.0) && !nonneg(-3.0)) ? 42 : 0; /* 42 */
}
