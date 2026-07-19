/* AArch64 inline asm: `adr Xd, 1f` materializes the PC-relative address of a
 * local label (a byte-granular rel21, patched by the same local-label pass as
 * the branches). Here it points at an inline data word, which the following
 * load reads back. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the value is assigned directly. */

int main(void) {
    long v = 0;
#if defined(__aarch64__)
    __asm__ volatile(
        "adr %0, 1f\n\t"   /* %0 = &label 1 */
        "ldr %0, [%0]\n\t" /* load the data word there */
        "b 2f\n\t"         /* step over the inline data */
        "1: .quad 0x2a\n\t"
        "2:"
        : "=r"(v));
#else
    v = 0x2a;
#endif
    return (int)v; /* 42 */
}
