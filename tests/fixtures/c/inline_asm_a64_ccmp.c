/* AArch64 inline asm: `ccmp` (conditional compare, for compound conditions) and
 * `cinc` (conditional increment, an alias of csinc). The chained compare sets
 * the flags to eq only when both tests pass; two conditional increments then run
 * branchlessly. Native-only on AArch64 (the interpreter's inline-asm evaluator
 * is x86-only); on x86_64 the same logic runs in plain C. */

int main(void) {
    long a = 3, b = 5, r = 40;
#if defined(__aarch64__)
    __asm__ volatile(
        "cmp %1, #3\n\t"          /* a == 3 ? */
        "ccmp %2, #5, #0, eq\n\t" /* ... and b == 5 ? (chained) */
        "cinc %0, %0, eq\n\t"     /* if both, r + 1 */
        "cinc %0, %0, eq\n\t"     /* and again -> r + 2 */
        : "+r"(r)
        : "r"(a), "r"(b)
        : "cc");
#else
    r = (a == 3 && b == 5) ? 42 : 40;
#endif
    return (int)r; /* 42 */
}
