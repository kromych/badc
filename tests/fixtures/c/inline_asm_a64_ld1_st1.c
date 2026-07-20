/* AArch64 inline asm: NEON vector load/store with register lists (ld1/st1). A
 * vector is broadcast, stored to a buffer with `st1`, reloaded with `ld1`, and
 * a lane read back. The multi-register list stores and reloads two consecutive
 * vectors at once. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int st1_ld1_roundtrip(int w) {
    int r;
#if defined(__aarch64__)
    int buf[4];
    __asm__("dup v0.4s, %w1\n\t"
            "st1 {v0.4s}, [%2]\n\t"
            "ld1 {v1.4s}, [%2]\n\t"
            "umov %w0, v1.s[3]"
            : "=r"(r)
            : "r"(w), "r"(buf)
            : "d0", "d1", "memory");
#else
    r = w;
#endif
    return r;
}

static int st1_ld1_multi(int a, int b) {
    int r;
#if defined(__aarch64__)
    int buf[8];
    __asm__("dup v0.4s, %w1\n\t"
            "dup v1.4s, %w2\n\t"
            "st1 {v0.4s, v1.4s}, [%3]\n\t" /* 32 bytes: a's vector then b's */
            "ld1 {v2.4s, v3.4s}, [%3]\n\t"
            "umov %w0, v3.s[0]" /* v3 is the second loaded vector = b */
            : "=r"(r)
            : "r"(a), "r"(b), "r"(buf)
            : "d0", "d1", "d2", "d3", "memory");
#else
    (void)a;
    r = b;
#endif
    return r;
}

int main(void) {
    if (st1_ld1_roundtrip(42) != 42) return 1;
    if (st1_ld1_multi(7, 42) != 42) return 2;
    return 42;
}
