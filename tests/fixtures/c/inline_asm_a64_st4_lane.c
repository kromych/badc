/* AArch64 inline asm: NEON single-structure lane load/store with 2, 3 and 4
 * registers. `ld4 {v0.s, .., v3.s}[i]` loads four consecutive words into lane i
 * of four registers and `st4` writes that lane back, so a load/store pair
 * round-trips the words. The 2- and 3-register forms, the comma and range
 * spellings of the list, and both post-index modes (immediate and register) are
 * exercised the same way. Native-only on AArch64 (the interpreter's inline-asm
 * evaluator is x86-only); on x86_64 the copies run in plain C. */

static int st4_lane_words(void) {
    unsigned int src[8] = {1u, 2u, 3u, 4u, 5u, 6u, 7u, 8u};
    unsigned int dst[8] = {0};
#if defined(__aarch64__)
    const unsigned int *s = src;
    unsigned int *d = dst;
    /* Lane 0 takes src[0..3], lane 3 takes src[4..7]; the stores put each lane
     * back where it came from. Lane 3 of a .s list sets the Q bit. */
    __asm__ volatile("ld4 {v0.s, v1.s, v2.s, v3.s}[0], [%0], #16\n\t"
                     "ld4 {v0.s-v3.s}[3], [%0]\n\t"
                     "st4 {v0.s, v1.s, v2.s, v3.s}[0], [%1], #16\n\t"
                     "st4 {v0.s-v3.s}[3], [%1]"
                     : "+r"(s), "+r"(d)
                     :
                     : "d0", "d1", "d2", "d3", "memory");
#else
    for (int i = 0; i < 8; i++) {
        dst[i] = src[i];
    }
#endif
    for (int i = 0; i < 8; i++) {
        if (dst[i] != src[i]) {
            return 0;
        }
    }
    return 1;
}

static int ld2_lane_halves(void) {
    unsigned short src[4] = {11, 12, 13, 14};
    unsigned short dst[4] = {0};
#if defined(__aarch64__)
    const unsigned short *s = src;
    unsigned short *d = dst;
    unsigned long step = 4; /* two halfwords, the register post-index amount */
    __asm__ volatile("ld2 {v4.h, v5.h}[0], [%0], %2\n\t"
                     "ld2 {v4.h, v5.h}[7], [%0]\n\t"
                     "st2 {v4.h, v5.h}[0], [%1], %2\n\t"
                     "st2 {v4.h, v5.h}[7], [%1]"
                     : "+r"(s), "+r"(d)
                     : "r"(step)
                     : "d4", "d5", "memory");
#else
    for (int i = 0; i < 4; i++) {
        dst[i] = src[i];
    }
#endif
    for (int i = 0; i < 4; i++) {
        if (dst[i] != src[i]) {
            return 0;
        }
    }
    return 1;
}

static int ld3_lane_doublewords(void) {
    unsigned long long src[3] = {0x1122334455667788ull, 0x99aabbccddeeff00ull,
                                 0x0123456789abcdefull};
    unsigned long long dst[3] = {0};
#if defined(__aarch64__)
    const unsigned long long *s = src;
    unsigned long long *d = dst;
    /* Lane 1 of a .d list is the upper half of each register. */
    __asm__ volatile("ld3 {v5.d, v6.d, v7.d}[1], [%0], #24\n\t"
                     "st3 {v5.d, v6.d, v7.d}[1], [%1]"
                     : "+r"(s), "+r"(d)
                     :
                     : "d5", "d6", "d7", "memory");
#else
    for (int i = 0; i < 3; i++) {
        dst[i] = src[i];
    }
#endif
    for (int i = 0; i < 3; i++) {
        if (dst[i] != src[i]) {
            return 0;
        }
    }
    return 1;
}

#if defined(__aarch64__)
typedef unsigned int u32x4 __attribute__((vector_size(16)));
#endif

/* `{%N.T}[i]`: the same list with the register named by an operand reference
 * rather than written out. One register only -- separate operands carry no
 * consecutive-register guarantee. */
static int st1_lane_operand_ref(void) {
    unsigned int dst[2] = {0, 0};
#if defined(__aarch64__)
    unsigned int *d = dst;
    u32x4 v = {7u, 9u, 11u, 13u};
    __asm__ volatile("st1 {%1.s}[1], [%0]\n\t"
                     "add %0, %0, #4\n\t"
                     "st1 {%1.s}[3], [%0]"
                     : "+r"(d)
                     : "w"(v)
                     : "memory");
#else
    dst[0] = 9u;
    dst[1] = 13u;
#endif
    return dst[0] == 9u && dst[1] == 13u;
}

int main(void) {
    if (!st4_lane_words() || !ld2_lane_halves() || !ld3_lane_doublewords()
        || !st1_lane_operand_ref()) {
        return 0;
    }
    return 42;
}
