// AArch64 `fmov Vd.D[1], Xn` and `fmov Xd, Vn.D[1]`, the top-half moves of
// FMOV (general): a 128-bit vector filled from two general registers, and
// each half read back. Returns 42 when both halves carry their values; the
// other architectures take the portable arm.

typedef unsigned long long u64;

#if defined(__aarch64__)
static u64 top(u64 lo, u64 hi) {
    u64 r;
    __asm__("fmov d0, %1\n\tfmov v0.d[1], %2\n\tfmov %0, v0.d[1]"
            : "=r"(r)
            : "r"(lo), "r"(hi)
            : "v0");
    return r;
}
static u64 bottom(u64 lo, u64 hi) {
    u64 r;
    __asm__("fmov d0, %1\n\tfmov v0.d[1], %2\n\tfmov %0, d0"
            : "=r"(r)
            : "r"(lo), "r"(hi)
            : "v0");
    return r;
}
#else
static u64 top(u64 lo, u64 hi) { return (void)lo, hi; }
static u64 bottom(u64 lo, u64 hi) { return (void)hi, lo; }
#endif

static volatile u64 in[] = {0x0123456789abcdefull, 0xfedcba9876543210ull};

int main(void) {
    if (top(in[0], in[1]) != 0xfedcba9876543210ull)
        return 1;
    if (bottom(in[0], in[1]) != 0x0123456789abcdefull)
        return 2;
    return 42;
}
