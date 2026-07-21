/* An always_inline `asm goto` callee with more than one Return: -O
 * splices it into the caller through the multi-block path, routing the
 * returns into a join-block phi and cloning the asm-goto `jump_table`
 * row into the caller. Out of line the operand is a compile-time
 * constant, so the body also compiles at -O0; the two runs must agree.
 * The template branches unconditionally, so the callee returns the
 * label value at runtime. `.pushsection` data naming the operand parses
 * on both ISAs (see inline_asm_pushsection.c). */

/* Two returns: fall-through (dead, template jumps) and label. */
static inline __attribute__((always_inline)) int jump_label(void) {
#if defined(__x86_64__)
    __asm__ goto("jmp %l[yes]\n"
                 ".pushsection .discard.jl,\"a\"\n"
                 ".long %c[k]\n"
                 ".popsection\n"
                 : : [k] "i"(11) : : yes);
#elif defined(__aarch64__)
    __asm__ goto("b %l[yes]\n"
                 ".pushsection .discard.jl,\"a\"\n"
                 ".long %c[k]\n"
                 ".popsection\n"
                 : : [k] "i"(11) : : yes);
#else
    goto yes;
#endif
    return 3;
yes:
    return 4;
}

/* Two returns, fall-through taken: a bare nop does not branch. */
static inline __attribute__((always_inline)) int fall_label(void) {
#if defined(__x86_64__)
    __asm__ goto("nop\n" : : [k] "i"(22) : : yes);
#elif defined(__aarch64__)
    __asm__ goto("nop\n" : : [k] "i"(22) : : yes);
#else
    if (0) goto yes;
#endif
    return 5;
yes:
    return 6;
}

/* Three returns: a runtime guard keeps its own return live alongside
 * the asm-goto's two, forcing a three-way join phi. */
static inline __attribute__((always_inline)) int guarded(int g) {
    if (g < 0)
        return 7;
#if defined(__x86_64__)
    __asm__ goto("jmp %l[yes]\n" : : [k] "i"(33) : : yes);
#elif defined(__aarch64__)
    __asm__ goto("b %l[yes]\n" : : [k] "i"(33) : : yes);
#else
    goto yes;
#endif
    return 8;
yes:
    return 9;
}

int main(void) {
    if (jump_label() != 4)
        return 1;
    if (fall_label() != 5)
        return 2;
    if (guarded(1) != 9)
        return 3;
    if (guarded(-1) != 7)
        return 4;
    return 42;
}
