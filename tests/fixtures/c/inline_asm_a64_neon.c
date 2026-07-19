/* AArch64 inline asm: NEON vector arrangement registers (vN.T). A word is
 * broadcast across a 4-lane vector with `dup`, each lane is doubled with a
 * vector `add`, and lane 0 is read back with `fmov`. Native-only on AArch64 (the
 * interpreter's inline-asm evaluator is x86-only); on x86_64 the scalar
 * equivalent runs in plain C. */

static int lane0_doubled(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"          /* v0 = [w, w, w, w]     */
            "add v0.4s, v0.4s, v0.4s\n\t" /* v0 = [2w, 2w, 2w, 2w] */
            "fmov %w0, s0"                /* r  = lane 0 = 2w      */
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = w * 2;
#endif
    return r;
}

int main(void) {
    return lane0_doubled(21); /* 42 */
}
