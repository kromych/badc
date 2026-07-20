/* AArch64 inline asm: NEON single-structure lane load/store. `st1 {v0.s}[2]`
 * stores one chosen lane to memory; `ld1 {v1.s}[0]` loads one memory word into
 * one lane. Routing a value through lane 2 and back through lane 0 exercises
 * both. Native-only on AArch64 (the interpreter's inline-asm evaluator is
 * x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int lane_store_load(int w) {
    int r;
#if defined(__aarch64__)
    int buf = 0;
    __asm__("ins v0.s[2], %w1\n\t"
            "st1 {v0.s}[2], [%2]\n\t" /* buf = lane 2 = w */
            "ld1 {v1.s}[0], [%2]\n\t" /* v1 lane 0 = buf  */
            "umov %w0, v1.s[0]"
            : "=r"(r)
            : "r"(w), "r"(&buf)
            : "d0", "d1", "memory");
#else
    r = w;
#endif
    return r;
}

int main(void) {
    return (lane_store_load(42) == 42) ? 42 : 0;
}
