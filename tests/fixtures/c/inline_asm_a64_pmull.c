/* AArch64 inline asm: NEON polynomial (carryless) multiply. `pmull` multiplies
 * over GF(2): the .8b->.8h form multiplies bytes, the .1d->.1q form multiplies
 * 64-bit values into a 128-bit product (the GHASH primitive). Results are read
 * back and checked against a plain-C carryless multiply. Native-only on AArch64
 * with the AES/PMULL feature (present on the hosts this runs on); on x86_64 the
 * carryless multiply runs in plain C. */

static unsigned clmul(unsigned long long x, unsigned long long y) {
    unsigned long long p = 0;
    while (y) {
        if (y & 1)
            p ^= x;
        x <<= 1;
        y >>= 1;
    }
    return (unsigned) p;
}

static int pmull_byte(int a, int b) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v1.8b, %w1\n\t"
            "dup v2.8b, %w2\n\t"
            "pmull v0.8h, v1.8b, v2.8b\n\t" /* per-lane carryless product */
            "umov %w0, v0.h[0]"             /* lane 0 (16-bit)            */
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "d2", "memory");
#else
    r = (int) (clmul((unsigned char) a, (unsigned char) b) & 0xFFFF);
#endif
    return r;
}

static long long pmull_dword(long long a, long long b) {
    long long r;
#if defined(__aarch64__)
    __asm__("fmov d1, %1\n\t"
            "fmov d2, %2\n\t"
            "pmull v0.1q, v1.1d, v2.1d\n\t" /* 64x64 -> 128 carryless */
            "umov %0, v0.d[0]"              /* low 64 bits            */
            : "=r"(r)
            : "r"(a), "r"(b)
            : "d0", "d1", "d2", "memory");
#else
    r = (long long) clmul((unsigned long long) a, (unsigned long long) b);
#endif
    return r;
}

int main(void) {
    if (pmull_byte(3, 3) != 5) return 1;   /* (x+1)^2 = x^2+1 = 0b101 */
    if (pmull_byte(7, 6) != 18) return 2;  /* 0b111 (x) 0b110         */
    if (pmull_dword(3, 3) != 5) return 3;  /* same product, 64-bit    */
    return 42;
}
