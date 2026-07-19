/* AArch64 inline asm: NEON load-replicate (ld1r). ld1r loads a single element
 * from memory and broadcasts it to every lane; reading any lane back returns
 * that element. Native-only on AArch64 (the interpreter's inline-asm evaluator
 * is x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int ld1r_broadcast(int w) {
    int r;
#if defined(__aarch64__)
    int v = w;
    __asm__("ld1r {v0.4s}, [%1]\n\t" /* every lane = *p = w */
            "umov %w0, v0.s[3]"      /* lane 3 = w          */
            : "=r"(r)
            : "r"(&v)
            : "d0", "memory");
#else
    r = w;
#endif
    return r;
}

int main(void) {
    return (ld1r_broadcast(42) == 42) ? 42 : 0;
}
