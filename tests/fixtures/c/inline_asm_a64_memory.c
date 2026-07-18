/* AArch64 inline asm with memory operands: scaled `ldr` / `str` through a
 * `[base, #off]` reference, plus the load-acquire / store-release and the
 * unscaled / unprivileged offset loads that the table encoder covers. Native-
 * only on AArch64 (the SSA interpreter's inline-asm evaluator is x86-only), so
 * it is registered in the native suites. On x86_64 the same computation runs
 * in plain C. */

int main(void) {
    long buf[4] = {40, 2, 0x100, -7};
#if defined(__aarch64__)
    long a, b;
    __asm__("ldr %0, [%1]" : "=r"(a) : "r"(buf));     /* a = buf[0] = 40 */
    __asm__("ldr %0, [%1, #8]" : "=r"(b) : "r"(buf)); /* b = buf[1] = 2  */
    long s = a + b;                                   /* 42 */
    __asm__("str %1, [%0]" : : "r"(buf), "r"(s));     /* buf[0] = 42     */

    /* Store-release the result to a fresh cell, load-acquire it back. */
    long cell = 0, la;
    __asm__ volatile("stlr %1, [%0]" : : "r"(&cell), "r"(s) : "memory");
    __asm__ volatile("ldar %0, [%1]" : "=&r"(la) : "r"(&cell) : "memory");
    if (la != 42) {
        return 1;
    }

    /* Unscaled (ldur) / unprivileged (ldtr) offset loads and a sign-extending
     * byte load; each reads a known buf slot. */
    long u, t;
    int sb;
    __asm__ volatile("ldur %0, [%1, #16]" : "=r"(u) : "r"(buf) : "memory");
    __asm__ volatile("ldtr %0, [%1, #8]" : "=r"(t) : "r"(buf) : "memory");
    __asm__ volatile("ldtrsb %w0, [%1, #24]" : "=r"(sb) : "r"(buf) : "memory");
    if (u != 0x100 || t != 2 || sb != -7) {
        return 1;
    }
#else
    buf[0] = buf[0] + buf[1];
#endif
    return (int)buf[0]; /* 42 */
}
