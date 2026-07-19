/* AArch64 inline asm: NEON permutes. `zip1` interleaves the low halves of two
 * vectors; `ext` extracts a byte-granular window from their concatenation.
 * Each result lane is read back with `umov` and checked against the expected
 * source, so a wrong permute would surface as the wrong lane value.
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is x86-only);
 * on x86_64 the scalar equivalent runs in plain C. */

static int zip1_lane1(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "dup v1.4s, %w2\n\t"
            "zip1 v2.4s, v0.4s, v1.4s\n\t" /* [a, b, a, b] */
            "umov %w0, v2.s[1]"            /* lane 1 = b   */
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "d2", "memory");
#else
    (void)a;
    r = b;
#endif
    return r;
}

static int ext4_lane3(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "dup v1.4s, %w2\n\t"
            "ext v2.16b, v0.16b, v1.16b, #4\n\t" /* [a, a, a, b] */
            "umov %w0, v2.s[3]"                  /* lane 3 = b   */
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "d2", "memory");
#else
    (void)a;
    r = b;
#endif
    return r;
}

int main(void) {
    if (zip1_lane1(7, 42) != 42) return 1; /* interleave picks b into lane 1 */
    if (ext4_lane3(7, 42) != 42) return 2; /* byte window puts b into lane 3 */
    return 42;
}
