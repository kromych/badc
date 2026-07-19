/* AArch64 inline asm load/store addressing modes through the table catalogue:
 * the unscaled-simm9 fallback an offset outside the scaled uimm12 form takes
 * (as the assembler selects), pre-/post-index writeback including the subword
 * forms, register pairs with a negative scaled offset, and a sign-extending
 * register offset. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the same reads run in plain C. */

long g_q[4] = {5, 9, 11, 17};
unsigned char g_b[4] = {1, 2, 3, 4};

int main(void) {
    long neg, pre, post, lo, hi, ext;
#if defined(__aarch64__)
    long *p1 = &g_q[1], *p2 = &g_q[0];
    long idx = 3;
    /* -8 is not a non-negative multiple of 8: encodes as ldur. */
    __asm__ volatile("ldr %0, [%1, #-8]" : "=r"(neg) : "r"(p1)); /* g_q[0] */
    /* Pre-index: base advances first, then loads g_q[1]; the write-back
     * leaves p2 at &g_q[1]. Post-index loads g_q[1] then advances. */
    __asm__ volatile("ldr %0, [%1, #8]!" : "=r"(pre), "+r"(p2));
    __asm__ volatile("ldr %0, [%1], #8" : "=r"(post), "+r"(p2));
    /* Subword writeback: store 6 at g_b[1] (pre), reload it (post). */
    unsigned char *pb = g_b;
    long six = 6, rb;
    __asm__ volatile("strb %w1, [%0, #1]!" : "+r"(pb) : "r"(six));
    __asm__ volatile("ldrb %w0, [%1], #1" : "=r"(rb), "+r"(pb));
    /* Pair load at a negative scaled offset. */
    __asm__ volatile("ldp %0, %1, [%2, #-16]" : "=r"(lo), "=r"(hi) : "r"(&g_q[2]));
    /* Register offset, 32-bit index sign-extended and scaled. */
    __asm__ volatile("ldr %0, [%1, %w2, sxtw #3]" : "=r"(ext) : "r"(g_q), "r"(idx));
    if (rb != 6 || pb != g_b + 2) {
        return 1;
    }
#else
    neg = g_q[0];
    pre = g_q[1];
    post = g_q[1];
    lo = g_q[0];
    hi = g_q[1];
    ext = g_q[3];
#endif
    /* 5 + 9 + 9 + 5 + (9 - 17) + 17 + 5 = 42 */
    return (int)(neg + pre + post + lo + (hi - g_q[3]) + ext + g_q[0]);
}
