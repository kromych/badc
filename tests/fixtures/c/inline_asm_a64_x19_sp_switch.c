/* AArch64 inline asm that moves sp, puts it back through x19 and lists
 * x19 among its clobbers, in a frame without alloca whose scalar locals
 * lie past fp's unscaled reach. The sp move makes the frame dynamic and
 * would give it a locals base in x19; the clobber leaves the base
 * unselected, so the locals reached after the statement keep their
 * values. Returns 42 when they round-trip. On x86_64 the plain-C
 * computation runs. */

static long switched(long n) {
    volatile char pad[512];
    volatile long v = n, w = 2 * n, d = 3 * n;
    pad[0] = 1;
#if defined(__aarch64__)
    __asm__ volatile("mov x19, sp\n\tsub sp, sp, #64\n\tmov sp, x19\n\tmov x19, #64"
                     :
                     :
                     : "x19", "memory");
#endif
    v += w + d; /* 6n */
    w += v;     /* 8n */
    d += w;     /* 11n */
    return v + w + d + pad[0];
}

int main(void) {
    return switched(5) == 6 * 5 + 8 * 5 + 11 * 5 + 1 ? 42 : 1;
}
