/* AArch64 mnemonic inline asm with register operands: the template's `%N`
 * references resolve to machine registers, the instructions lower through the
 * table encoder, and the results flow back to the C variables. Native-only on
 * AArch64 -- the SSA interpreter's inline-asm evaluator is x86-only -- so this
 * fixture is registered in the native suites, not the interpreter one. On
 * x86_64 the same computation runs in plain C for a target-neutral result. */

long compute(long b, long c) {
#if defined(__aarch64__)
    long sum;
    __asm__("add %0, %1, %2" : "=r"(sum) : "r"(b), "r"(c)); /* b + c */
    long doubled;
    __asm__("lsl %0, %1, #1" : "=r"(doubled) : "r"(sum)); /* sum << 1 */
    return doubled;
#else
    return (b + c) << 1;
#endif
}

int main(void) {
    return (int)compute(20, 1); /* (20 + 1) << 1 == 42 */
}
