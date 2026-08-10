/* AArch64 inline asm: `:abs_gN:` group specifiers over a constant, the shape
 * the kernel's `mov_q` macro expands to inside a function body. A function
 * body has no layout pass, so only an expression that folds resolves; each
 * `movz` / `movk` takes its own 16-bit group of the value. The `_s` groups
 * encode a negative value as `movn` over the complement, so the groups the
 * sequence does not write come out set. Native-only on AArch64 (the
 * interpreter's inline-asm evaluator is x86-only); elsewhere the plain C
 * value runs. */

static unsigned long build_u64(void) {
    unsigned long v;
#if defined(__aarch64__)
    __asm__("movz %0, :abs_g3:0x1234567890abcdef\n\t"
            "movk %0, :abs_g2_nc:0x1234567890abcdef\n\t"
            "movk %0, :abs_g1_nc:0x1234567890abcdef\n\t"
            "movk %0, :abs_g0_nc:0x1234567890abcdef"
            : "=r"(v));
#else
    v = 0x1234567890abcdefUL;
#endif
    return v;
}

/* A negative value through the signed group: `movz :abs_g2_s:` becomes
 * `movn`, and the two `_nc` halves fill the rest. */
static long build_negative(void) {
    long v;
#if defined(__aarch64__)
    __asm__("movz %0, :abs_g2_s:-0xc0d000\n\t"
            "movk %0, :abs_g1_nc:-0xc0d000\n\t"
            "movk %0, :abs_g0_nc:-0xc0d000"
            : "=r"(v));
#else
    v = -0xc0d000L;
#endif
    return v;
}

/* A 32-bit destination clears the operand size bit and takes the two groups
 * that fit its width; this is the SHA-1 round constant the kernel's
 * `sha1-ce-core.S` materializes the same way. */
static unsigned int build_u32(void) {
    unsigned int v;
#if defined(__aarch64__)
    __asm__("movz %w0, :abs_g1_nc:0x5a827999\n\t"
            "movk %w0, :abs_g0_nc:0x5a827999"
            : "=r"(v));
#else
    v = 0x5a827999U;
#endif
    return v;
}

int main(void) {
    if (build_u64() != 0x1234567890abcdefUL) return 1;
    if (build_negative() != -0xc0d000L) return 2;
    if (build_u32() != 0x5a827999U) return 3;
    return 42;
}
