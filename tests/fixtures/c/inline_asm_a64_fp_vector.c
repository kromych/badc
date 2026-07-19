/* AArch64 inline asm: NEON floating-point vector arithmetic. A float is
 * broadcast across a 4-lane single-precision vector with `dup`, each lane is
 * doubled with a vector `fadd v0.4s`, and lane 0 is read back with `fmov`. The
 * value crosses the GP boundary as its bit pattern (a union). Native-only on
 * AArch64 (the interpreter's inline-asm evaluator is x86-only); on x86_64 the
 * scalar equivalent runs in plain C. */

static int fadd_lane0(int xbits) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"          /* v0 = [x, x, x, x]     */
            "fadd v0.4s, v0.4s, v0.4s\n\t" /* v0 = [2x, 2x, 2x, 2x] */
            "fmov %w0, s0"                /* r  = lane 0 = (2x)    */
            : "=r"(r)
            : "r"(xbits)
            : "d0", "memory");
#else
    union {
        float f;
        int i;
    } u = {.i = xbits};
    u.f = u.f + u.f;
    r = u.i;
#endif
    return r;
}

int main(void) {
    union {
        float f;
        int i;
    } x = {.f = 21.0f}, r;
    r.i = fadd_lane0(x.i);       /* 21.0f + 21.0f = 42.0f */
    return (r.f == 42.0f) ? 42 : 0;
}
