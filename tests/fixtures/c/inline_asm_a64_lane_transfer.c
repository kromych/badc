/* AArch64 inline asm: `ins`, `umov`, `smov` and `ld1` lane transfers, the
 * lane a literal or an `i` operand (`%1.s[%2]`, `{%0.h}[%c2]`). Native-only
 * on AArch64; elsewhere the scalar equivalent runs in plain C. */

static int lane_roundtrip(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("ins v0.s[0], %w1\n\t"
            "ins v0.s[2], %w2\n\t"
            "umov %w0, v0.s[2]"
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "memory");
#else
    (void)a;
    r = b;
#endif
    return r;
}

static int smov_byte(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.16b, %w1\n\t"
            "smov %w0, v0.b[0]"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = (signed char)w;
#endif
    return r;
}

static int lane_by_operand(int a, short h) {
    int r;
#if defined(__aarch64__)
    int __attribute__((vector_size(16))) v = {0, 0, 0, 0};
    __asm__("ins %0.s[%2], %w1" : "+w"(v) : "r"(a), "i"(3));
    __asm__("ld1 {%0.h}[%c2], [%1]" : "+w"(v) : "r"(&h), "i"(2 * sizeof(short)) : "memory");
    __asm__("umov %w0, %1.s[%2]" : "=r"(r) : "w"(v), "i"(1 + 2));
    r += v[2];
#else
    r = a + (unsigned short)h;
#endif
    return r;
}

int main(void) {
    if (lane_roundtrip(7, 42) != 42) return 1; /* insert lane 2, read it back */
    if (smov_byte(0xEE) != -18) return 2;      /* 0xEE as signed char = -18   */
    if (lane_by_operand(1000, -2) != 1000 + 0xFFFE) return 3; /* lanes 3 and 4h */
    return 42;
}
