/* AArch64 inline asm: post-index vector load. `ld1 {v}, [ptr], #16` loads a
 * vector and advances the pointer by the list byte size in one instruction --
 * the common loop idiom. Loading twice from one pointer reads two consecutive
 * vectors, which only works if the first load advanced the pointer. Native-only
 * on AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64
 * the scalar equivalent runs in plain C. */

static int postindex_walk(void) {
    int buf[8] = {10, 0, 0, 0, 32, 0, 0, 0};
    int first, second;
#if defined(__aarch64__)
    int *p = buf;
    __asm__("ld1 {v0.4s}, [%2], #16\n\t" /* v0 = buf[0..3], p += 16 */
            "umov %w0, v0.s[0]\n\t"       /* first  = buf[0] = 10    */
            "ld1 {v1.4s}, [%2], #16\n\t"  /* v1 = buf[4..7], p += 16 */
            "umov %w1, v1.s[0]"           /* second = buf[4] = 32    */
            : "=r"(first), "=r"(second), "+r"(p)
            :
            : "d0", "d1", "memory");
#else
    first = buf[0];
    second = buf[4];
#endif
    return first + second;
}

int main(void) {
    return (postindex_walk() == 42) ? 42 : 0; /* 10 + 32 */
}
