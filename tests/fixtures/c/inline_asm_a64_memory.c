/* AArch64 inline asm with memory operands: `ldr` / `str` through a `[base,
 * #off]` reference whose base is a register operand. Native-only on AArch64 (the
 * SSA interpreter's inline-asm evaluator is x86-only), so it is registered in
 * the native suites. On x86_64 the same computation runs in plain C. */

int main(void) {
    long buf[2] = {40, 2};
#if defined(__aarch64__)
    long a, b;
    __asm__("ldr %0, [%1]" : "=r"(a) : "r"(buf));     /* a = buf[0] = 40 */
    __asm__("ldr %0, [%1, #8]" : "=r"(b) : "r"(buf)); /* b = buf[1] = 2  */
    long s = a + b;                                   /* 42 */
    __asm__("str %1, [%0]" : : "r"(buf), "r"(s));     /* buf[0] = 42     */
#else
    buf[0] = buf[0] + buf[1];
#endif
    return (int)buf[0]; /* 42 */
}
