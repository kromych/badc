/* AArch64 inline asm: NEON shift by immediate. A word is broadcast across a
 * 4-lane vector, every lane is shifted by a compile-time immediate, and lane 0
 * is read back. `shl` shifts left, `sshr` shifts right arithmetically (sign
 * preserved), `ushr` shifts right logically (zero fill). Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * scalar equivalent runs in plain C. */

static int shl3(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "shl v0.4s, v0.4s, #3\n\t"
            "fmov %w0, s0"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = w << 3;
#endif
    return r;
}

static int sshr1(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "sshr v0.4s, v0.4s, #1\n\t"
            "fmov %w0, s0"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = w >> 1;
#endif
    return r;
}

static int ushr2(unsigned w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "ushr v0.4s, v0.4s, #2\n\t"
            "fmov %w0, s0"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = (int)(w >> 2);
#endif
    return r;
}

int main(void) {
    if (shl3(5) != 40) return 1;    /* 5 << 3       */
    if (sshr1(-84) != -42) return 2; /* -84 >> 1, arithmetic */
    if (ushr2(168) != 42) return 3; /* 168 >> 2, logical    */
    return 42;
}
