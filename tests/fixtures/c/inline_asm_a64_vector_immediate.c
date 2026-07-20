/* AArch64 inline asm: NEON modified immediate (movi/mvni). `movi` sets every
 * lane to a constant; `mvni` sets its bitwise complement. Each result is read
 * back with umov. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int movi_const(void) {
    int r;
#if defined(__aarch64__)
    __asm__("movi v0.4s, #42\n\t"
            "umov %w0, v0.s[1]"
            : "=r"(r)
            :
            : "d0", "memory");
#else
    r = 42;
#endif
    return r;
}

static int mvni_all_ones(void) {
    int r;
#if defined(__aarch64__)
    __asm__("mvni v0.4s, #0\n\t" /* every lane = ~0 = -1 */
            "umov %w0, v0.s[0]"
            : "=r"(r)
            :
            : "d0", "memory");
#else
    r = -1;
#endif
    return r;
}

int main(void) {
    if (movi_const() != 42) return 1;
    if (mvni_all_ones() != -1) return 2;
    return 42;
}
