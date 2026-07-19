/* AArch64 inline asm: 128-bit vector load/store (ldr/str q). A word is
 * broadcast across a vector, the whole 16-byte register is stored to a buffer
 * with `str q`, reloaded into another register with `ldr q`, and a lane is read
 * back. Native-only on AArch64 (the interpreter's inline-asm evaluator is
 * x86-only); on x86_64 the scalar equivalent runs in plain C. */

static int q_roundtrip(int w) {
    int r;
#if defined(__aarch64__)
    int buf[4];
    __asm__("dup v0.4s, %w1\n\t"
            "str q0, [%2]\n\t"
            "ldr q1, [%2]\n\t"
            "umov %w0, v1.s[2]"
            : "=r"(r)
            : "r"(w), "r"(buf)
            : "d0", "d1", "memory");
#else
    r = w;
#endif
    return r;
}

int main(void) {
    return (q_roundtrip(42) == 42) ? 42 : 0;
}
