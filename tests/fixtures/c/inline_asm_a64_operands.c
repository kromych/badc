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
    /* mrs reads a system register: CNTVCT_EL0 (the EL0-readable virtual
     * counter), spelled generically so it takes the general inline-asm path
     * rather than the pattern-matched ctr_el0 special case. It is nonzero on
     * any running system, so the deterministic result survives. */
    long cnt;
    __asm__("mrs %0, s3_3_c14_c0_2" : "=r"(cnt));
    return cnt != 0 ? doubled : 0;
#else
    return (b + c) << 1;
#endif
}

int main(void) {
    return (int)compute(20, 1); /* (20 + 1) << 1 == 42 */
}
