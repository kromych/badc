/* AArch64 inline asm: NEON one-source ops. `neg` negates each lane, `abs`
 * takes its absolute value, `not` complements every bit. Each result lane is
 * read back with umov. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int neg_lane(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "neg v0.4s, v0.4s\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = -w;
#endif
    return r;
}

static int abs_lane(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "abs v0.4s, v0.4s\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = w < 0 ? -w : w;
#endif
    return r;
}

static int not_lane(int w) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "not v0.16b, v0.16b\n\t"
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(w)
            : "d0", "memory");
#else
    r = ~w;
#endif
    return r;
}

int main(void) {
    if (neg_lane(-42) != 42) return 1;
    if (abs_lane(-42) != 42) return 2;
    if (not_lane(~42) != 42) return 3; /* ~(~42) = 42 */
    return 42;
}
