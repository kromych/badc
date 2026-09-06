/* A clobber list names registers; the values live across the block must
   still read back. The allocator keeps them out of the clobbered set, so
   the block needs no save / restore pair; where it cannot, the block
   preserves what it names. Both readings are checked by the result.

   `spread` holds eight values across two blocks: the first names the
   caller-saved set the System V / AAPCS64 call sequence uses, the second
   the callee-saved one. The weights make a lost or crossed value change
   the sum. */

#if defined(__x86_64__)
#define CLOBBER_CALLER "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11"
#define CLOBBER_CALLEE "rbx", "r12", "r13", "r14", "r15"
#define ZERO_CALLER                                                            \
    "xorl %%eax, %%eax\n\txorl %%ecx, %%ecx\n\txorl %%edx, %%edx\n\t"          \
    "xorl %%esi, %%esi\n\txorl %%edi, %%edi\n\txorq %%r8, %%r8\n\t"            \
    "xorq %%r9, %%r9\n\txorq %%r10, %%r10\n\txorq %%r11, %%r11"
#define ZERO_CALLEE                                                            \
    "xorl %%ebx, %%ebx\n\txorq %%r12, %%r12\n\txorq %%r13, %%r13\n\t"          \
    "xorq %%r14, %%r14\n\txorq %%r15, %%r15"
#elif defined(__aarch64__)
#define CLOBBER_CALLER "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10"
#define CLOBBER_CALLEE "x20", "x21", "x22", "x23", "x24", "x25"
#define ZERO_CALLER                                                            \
    "mov x0, xzr\n\tmov x1, xzr\n\tmov x2, xzr\n\tmov x3, xzr\n\t"             \
    "mov x4, xzr\n\tmov x5, xzr\n\tmov x6, xzr\n\tmov x7, xzr\n\t"             \
    "mov x9, xzr\n\tmov x10, xzr"
#define ZERO_CALLEE                                                            \
    "mov x20, xzr\n\tmov x21, xzr\n\tmov x22, xzr\n\t"                         \
    "mov x23, xzr\n\tmov x24, xzr\n\tmov x25, xzr"
#else
#define CLOBBER_CALLER "memory"
#define CLOBBER_CALLEE "memory"
#define ZERO_CALLER ""
#define ZERO_CALLEE ""
#endif

long spread(long seed) {
    long a = seed + 1, b = seed + 2, c = seed + 3, d = seed + 4;
    long e = seed + 5, f = seed + 6, g = seed + 7, h = seed + 8;
    __asm__ volatile(ZERO_CALLER : : : CLOBBER_CALLER, "cc", "memory");
    __asm__ volatile(ZERO_CALLEE : : : CLOBBER_CALLEE, "cc", "memory");
    return a + 2 * b + 4 * c + 8 * d + 16 * e + 32 * f + 64 * g + 128 * h;
}

/* The same, with the block between the definition and the use on one
   arm of a branch only: the value crosses it on that path alone, which a
   linear live interval does not cover. */
long branchy(long seed, int take) {
    long v = seed * 3 + 1;
    if (take) {
        __asm__ volatile(ZERO_CALLER : : : CLOBBER_CALLER, "cc", "memory");
        __asm__ volatile(ZERO_CALLEE : : : CLOBBER_CALLEE, "cc", "memory");
    }
    return v;
}

/* A loop carries its counter and accumulator across the block on the
   back edge. */
long carried(long n) {
    long acc = 0;
    for (long i = 0; i < n; i++) {
        acc += i * i;
        __asm__ volatile(ZERO_CALLER : : : CLOBBER_CALLER, "cc", "memory");
    }
    return acc;
}

/* An `asm goto` clobber applies on every edge out of the block, the
   label edge included: `v` is read only after the branch is taken, so
   the block's clobbers must not reach it there either. */
long jumped(long seed, int take) {
    long v = seed * 5 + 3;
#if defined(__x86_64__)
    /* The branch comes first: the zeroing writes the flags the test set. */
    __asm__ goto("testl %0, %0\n\tjz 1f\n\t" ZERO_CALLER
                 "\n\tjmp %l[away]\n1:\n\t" ZERO_CALLER
                 :
                 : "r"(take)
                 : CLOBBER_CALLER, "cc", "memory"
                 : away);
#elif defined(__aarch64__)
    __asm__ goto("cbz %w0, 1f\n\t" ZERO_CALLER "\n\tb %l[away]\n1:\n\t" ZERO_CALLER
                 :
                 : "r"(take)
                 : CLOBBER_CALLER, "cc", "memory"
                 : away);
#else
    if (take) goto away;
#endif
    return v;
away:
    return v + 1;
}

int main(void) {
    /* seed 10: 11 + 24 + 52 + 112 + 240 + 512 + 1088 + 2304 = 4343 */
    if (spread(10) != 4343) {
        return 1;
    }
    if (branchy(7, 1) != 22 || branchy(7, 0) != 22) {
        return 2;
    }
    /* 0 + 1 + 4 + 9 + 16 + 25 + 36 + 49 + 64 + 81 = 285 */
    if (carried(10) != 285) {
        return 3;
    }
    if (jumped(4, 0) != 23 || jumped(4, 1) != 24) {
        return 4;
    }
    return 42;
}
