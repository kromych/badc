/* AArch64 inline asm that clobbers x19 in a frame that calls alloca and
 * keeps scalar locals more than 4 KiB below fp. Such a frame would hold
 * its locals base in x19; a statement that writes x19 leaves the base
 * unselected, so the statement's register saves, its fall-through exit
 * and the `asm goto` label exit all reach their slots. Returns 42 when
 * every value round-trips. On x86_64 the plain-C computation runs. */

static long touch(char *p, long n) {
    long i;
    for (i = 0; i < n; i++) p[i] = 3;
    return n;
}

static long clobbered(long n) {
    volatile char pad[4096];
    volatile long v = 5, w = 7, d = 11;
    char *q;
    long out;
    pad[0] = 1;
    q = (char *)__builtin_alloca(n);
    touch(q, n);
#if defined(__aarch64__)
    __asm__ volatile("mov x19, #0\n\tmov %0, #42" : "=r"(out) : : "x19");
#else
    out = 42;
#endif
    v += w + d + out; /* 65 */
    w += v;           /* 72 */
    d += w;           /* 83 */
    return v + w + d + q[0] + pad[0]; /* 224 */
}

static long jumped(long n, int take) {
    volatile char pad[4096];
    volatile long v = 5, w = 7, d = 11;
    char *q;
    pad[0] = 1;
    q = (char *)__builtin_alloca(n);
    touch(q, n);
#if defined(__aarch64__)
    __asm__ goto("mov x19, #0\n\tcbnz %w0, %l[out]" : : "r"(take) : "x19" : out);
#else
    if (take) goto out;
#endif
    v += 100;
out:
    v += w + d; /* 23 taken, 123 not */
    w += v;     /* 30, 130 */
    d += w;     /* 41, 141 */
    return v + w + d + q[0] + pad[0];
}

int main(void) {
    if (clobbered(32) != 224) return 1;
    if (jumped(32, 1) != 23 + 30 + 41 + 4) return 2;
    if (jumped(32, 0) != 123 + 130 + 141 + 4) return 3;
    return 42;
}
