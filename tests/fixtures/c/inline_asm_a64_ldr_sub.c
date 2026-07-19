/* AArch64 inline asm: the scaled subword loads -- `ldrh` (halfword, byte offset
 * scaled by 2) and `ldrsw` (signed word, scaled by 4, sign-extending into the
 * 64-bit destination). The written byte offset is divided by the access size
 * for the encoded field. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the same reads run in plain C. */

unsigned short g_h[4] = {10, 20, 33, 40};
int g_w[4] = {0, 0, 0, -7};

int main(void) {
    long long h = 0, w = 0;
#if defined(__aarch64__)
    __asm__ volatile("ldrh %w0, [%1, #4]" : "=r"(h) : "r"(g_h));  /* g_h[2] = 33 */
    __asm__ volatile("ldrsw %0, [%1, #12]" : "=r"(w) : "r"(g_w)); /* g_w[3] = -7 */
#else
    h = g_h[2];
    w = g_w[3];
#endif
    return (h == 33 && w == -7) ? 42 : 0; /* 42 iff both loads (and the sign
                                             extension) are correct */
}
