/* AArch64 inline asm: bitfield extract (`ubfx`) and insert (`bfi`), aliases of
 * ubfm/bfm. ubfx pulls a field out at a given lsb/width; bfi splices one in.
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is x86-only);
 * on x86_64 the same shifts and masks run in plain C. */

int main(void) {
    unsigned long src = 0x2A00, field = 0, dst = 0;
#if defined(__aarch64__)
    __asm__ volatile("ubfx %0, %1, #8, #8" : "=r"(field) : "r"(src)); /* (0x2A00>>8)&0xFF = 42 */
    __asm__ volatile("bfi %0, %1, #0, #8" : "+r"(dst) : "r"(field));  /* dst[7:0] = 42 */
#else
    field = (src >> 8) & 0xFF;
    dst = (dst & ~0xFFUL) | (field & 0xFF);
#endif
    return (int)dst; /* 42 */
}
