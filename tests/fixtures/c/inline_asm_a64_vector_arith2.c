/* AArch64 inline asm: NEON three-same batch. `mla` multiplies two vectors and
 * accumulates into the destination; `uabd` is the unsigned absolute difference;
 * `sqadd` saturates instead of wrapping on signed overflow. Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * scalar equivalent runs in plain C. */

static int mla_acc(int acc, int x, int y) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "dup v1.4s, %w2\n\t"
            "dup v2.4s, %w3\n\t"
            "mla v0.4s, v1.4s, v2.4s\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(acc), "r"(x), "r"(y)
            : "d0", "d1", "d2", "memory");
#else
    r = acc + x * y;
#endif
    return r;
}

static int uabd_diff(unsigned a, unsigned b) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "dup v1.4s, %w2\n\t"
            "uabd v0.4s, v0.4s, v1.4s\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "memory");
#else
    r = (int)(a > b ? a - b : b - a);
#endif
    return r;
}

static int sqadd_saturates(int max) {
    int r;
#if defined(__aarch64__)
    /* max + max saturates to max; a plain add would wrap to -2. */
    __asm__("dup v0.4s, %w1\n\t"
            "sqadd v0.4s, v0.4s, v0.4s\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(max)
            : "d0", "memory");
#else
    r = max;
#endif
    return r;
}

int main(void) {
    if (mla_acc(2, 8, 5) != 42) return 1;              /* 2 + 8*5      */
    if (uabd_diff(100, 58) != 42) return 2;            /* |100 - 58|   */
    if (sqadd_saturates(0x7FFFFFFF) != 0x7FFFFFFF) return 3; /* clamped */
    return 42;
}
