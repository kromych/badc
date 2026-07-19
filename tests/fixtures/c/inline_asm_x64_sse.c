/* x86-64 inline asm: SSE2 integer / move ops. A value crosses the GP<->xmm
 * boundary with movd, is added packed with paddd (register and memory forms),
 * and moved with movdqu. Native-only on x86_64 (the interpreter has no XMM
 * register file); on other targets the plain-C computation runs.
 *
 * Note on alignment: a memory operand to paddd (and the aligned move movdqa)
 * requires a 16-byte-aligned m128. badc aligns automatic objects to 8, so the
 * paddd memory operand uses a 16-byte-aligned static object, and the move test
 * uses movdqu, which is defined on unaligned storage. */

static int sse_add(int a, int b) {
    int r;
#if defined(__x86_64__)
    __asm__("movd %1, %%xmm0\n\t"
            "movd %2, %%xmm1\n\t"
            "paddd %%xmm1, %%xmm0\n\t" /* register-source add */
            "movd %%xmm0, %0"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "xmm0", "xmm1");
#else
    r = a + b;
#endif
    return r;
}

static int sse_mem_add(int b) {
    static _Alignas(16) const int addend[4] = {19, 0, 0, 0};
    int r;
#if defined(__x86_64__)
    __asm__("movd %1, %%xmm0\n\t"
            "paddd %2, %%xmm0\n\t" /* memory-source add (16-byte-aligned m128) */
            "movd %%xmm0, %0"
            : "=r"(r)
            : "r"(b), "m"(addend[0])
            : "xmm0", "memory");
#else
    r = b + addend[0];
#endif
    return r;
}

static int sse_movdqu(int w) {
    int r;
#if defined(__x86_64__)
    int buf[4] = {w, w, w, w};
    int out[4];
    __asm__("movdqu %1, %%xmm0\n\t" /* unaligned load  */
            "movdqu %%xmm0, %0"     /* unaligned store */
            : "=m"(out[0])
            : "m"(buf[0])
            : "xmm0", "memory");
    r = out[0];
#else
    r = w;
#endif
    return r;
}

static int sse_shift(int w) {
    int r;
#if defined(__x86_64__)
    __asm__("movd %1, %%xmm0\n\t"
            "pslld $1, %%xmm0\n\t" /* each lane <<= 1 */
            "movd %%xmm0, %0"
            : "=r"(r)
            : "r"(w)
            : "xmm0");
#else
    r = w << 1;
#endif
    return r;
}

static int sse_shuffle(int a, int b) {
    int r;
#if defined(__x86_64__)
    __asm__("movd %1, %%xmm0\n\t"           /* xmm0 = [a,0,0,0]     */
            "movd %2, %%xmm1\n\t"           /* xmm1 = [b,0,0,0]     */
            "punpckldq %%xmm1, %%xmm0\n\t"  /* xmm0 = [a,b,0,0]     */
            "pshufd $1, %%xmm0, %%xmm0\n\t" /* lane0 <- old lane1=b */
            "movd %%xmm0, %0"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "xmm0", "xmm1");
#else
    (void) a;
    r = b;
#endif
    return r;
}

static long long movq_roundtrip(long long w) {
    long long r;
#if defined(__x86_64__)
    __asm__("movq %1, %%xmm0\n\t" /* xmm0 = w (64-bit)     */
            "movq %%xmm0, %0"     /* r = low 64 bits of w  */
            : "=r"(r)
            : "r"(w)
            : "xmm0");
#else
    r = w;
#endif
    return r;
}

int main(void) {
    if (sse_add(19, 23) != 42) return 1;    /* 19 + 23, register paddd     */
    if (sse_mem_add(23) != 42) return 2;    /* 23 + 19, memory-source paddd */
    if (sse_movdqu(42) != 42) return 3;     /* movdqu load then store       */
    if (sse_shift(21) != 42) return 4;      /* pslld $1: 21 << 1            */
    if (sse_shuffle(7, 42) != 42) return 5; /* pshufd picks lane 1 = b      */
    if (movq_roundtrip(42) != 42) return 6; /* movq GP64 <-> xmm            */
    return 42;
}
