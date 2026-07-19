/* AArch64 inline asm: NEON load-replicate (ld1r/ld2r). ld1r loads a single
 * element and broadcasts it to every lane; ld2r loads two consecutive elements,
 * broadcasting each into its own register. Reading a lane back returns the
 * broadcast element. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the scalar equivalent runs in plain C. */

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

static int ld2r_pair(int a, int b) {
#if defined(__aarch64__)
    int buf[2] = {a, b};
    int va, vb;
    __asm__("ld2r {v0.4s, v1.4s}, [%2]\n\t" /* v0 = a.., v1 = b.. */
            "umov %w0, v0.s[2]\n\t"          /* va = a             */
            "umov %w1, v1.s[1]"              /* vb = b             */
            : "=&r"(va), "=r"(vb)
            : "r"(buf)
            : "d0", "d1", "memory");
    return va + vb;
#else
    return a + b;
#endif
}

int main(void) {
    if (ld1r_broadcast(42) != 42) return 1;
    if (ld2r_pair(19, 23) != 42) return 2; /* 19 + 23 */
    return 42;
}
