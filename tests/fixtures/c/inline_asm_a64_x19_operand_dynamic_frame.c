/* AArch64 inline asm with a register variable bound to x19 as a
 * read-write operand, in a frame that calls alloca and keeps scalar
 * locals more than 4 KiB below fp. Loading the operand writes x19, so
 * the frame takes no locals base in it, and the operands loaded after
 * it and the store-backs still reach their slots. Returns 42 when every
 * value round-trips. On x86_64 the plain-C computation runs. */

static long touch(char *p, long n) {
    long i;
    for (i = 0; i < n; i++) p[i] = 3;
    return n;
}

static long bound(long n, long k) {
    volatile char pad[4096];
    volatile long v = 5, w = 7, d = 11;
    char *q;
    long t = 100;
    pad[0] = 1;
    q = (char *)__builtin_alloca(n);
    touch(q, n);
#if defined(__aarch64__)
    register long r __asm__("x19") = k;
    __asm__ volatile("add %0, %0, #1\n\tadd %1, %1, #2" : "+r"(r), "+r"(t));
#else
    long r = k + 1;
    t += 2;
#endif
    v += w + d + r + t; /* 5 + 7 + 11 + 41 + 102 = 166 */
    w += v;             /* 173 */
    d += w;             /* 184 */
    return v + w + d + q[0] + pad[0]; /* 527 */
}

int main(void) {
    return bound(32, 40) == 527 ? 42 : 1;
}
