/* x86-64 inline asm: SSE2 integer ops. An operand is moved into an XMM register
 * with movd, the low lane is added packed with paddd, and the result moved back
 * with movd. Native-only on x86_64 (the interpreter has no XMM register file);
 * on other targets the plain-C add runs. */

static int sse_add(int a, int b) {
    int r;
#if defined(__x86_64__)
    __asm__("movd %1, %%xmm0\n\t"      /* xmm0 low = a       */
            "movd %2, %%xmm1\n\t"      /* xmm1 low = b       */
            "paddd %%xmm1, %%xmm0\n\t" /* xmm0 += xmm1       */
            "movd %%xmm0, %0"          /* r = xmm0 low = a+b */
            : "=r"(r)
            : "r"(a), "r"(b)
            : "xmm0", "xmm1");
#else
    r = a + b;
#endif
    return r;
}

int main(void) {
    return (sse_add(19, 23) == 42) ? 42 : 0;
}
