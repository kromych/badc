/* AArch64 inline asm: prfm (prefetch hint) in its immediate, immediate-offset,
 * and register-offset forms. A prefetch is a memory-system hint with no
 * architectural effect on values, so a correct encoding just prefetches and the
 * program continues; a wrong one faults. Native-only on AArch64 (the
 * interpreter's inline-asm evaluator is x86-only); on x86_64 these are no-ops. */

int main(void) {
    long buf[8] = {0};
    long idx = 8; /* byte offset into buf */
#if defined(__aarch64__)
    __asm__ volatile("prfm pldl1keep, [%0]" : : "r"(buf) : "memory");
    __asm__ volatile("prfm pstl1strm, [%0, #16]" : : "r"(buf) : "memory");
    __asm__ volatile("prfm pldl2keep, [%0, %1]" : : "r"(buf), "r"(idx) : "memory");
#else
    (void)idx;
#endif
    return 42;
}
