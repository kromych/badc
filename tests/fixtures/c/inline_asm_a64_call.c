/* AArch64 inline asm: a direct `bl` to a C symbol -- the pattern an interrupt
 * handler uses to reach its C service routine. The target is resolved to a
 * rel26 by the same fixup pass as a compiler-emitted call. The caller saves and
 * restores the link register (clobbered by `bl`) with the pre/post-index
 * pair load/store. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the same call runs in plain C. */

int g_val = 0;
void bump(void) { g_val = 42; }

int main(void) {
#if defined(__aarch64__)
    __asm__ volatile(
        "stp x29, x30, [sp, #-16]!\n\t"
        "bl bump\n\t"
        "ldp x29, x30, [sp], #16"
        : : : "x30", "memory");
#else
    bump();
#endif
    return g_val; /* 42 */
}
