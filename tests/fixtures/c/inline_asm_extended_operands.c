// GCC extended inline asm with operand lists, in the x86_64 register-
// operand forms C code reaches for (double-precision shift, byte-swap,
// the timestamp-counter read sequence). Each is gated on __x86_64__ with
// a portable fallback, mirroring the shape system headers use, so the
// aarch64 snapshot exercises the fallback and the x64 snapshot the asm.
//
// 64-bit values use `long long`, not `long`: `long` is 32-bit under the
// LLP64 model, which would narrow the 64-bit shifts and byte-swap.

#if defined(__x86_64__)
static unsigned long long shl_double(unsigned long long l, unsigned long long r, int c) {
    // shld count, src, dst: dst <<= count, feeding in the high bits of src.
    __asm__("shld %b2, %1, %0" : "+r"(l) : "r"(r), "ci"(c));
    return l;
}
static unsigned long long shr_double(unsigned long long l, unsigned long long r, int c) {
    __asm__("shrd %b2, %1, %0" : "+r"(r) : "r"(l), "ci"(c));
    return r;
}
static unsigned bswap32(unsigned v) {
    __asm__("bswapl %0" : "=r"(v) : "0"(v)); // matching constraint "0"
    return v;
}
static unsigned long long bswap64(unsigned long long v) {
    __asm__("bswapq %0" : "=r"(v) : "0"(v)); // size-modifier register name
    return v;
}
static unsigned long long tsc_read(void) {
    unsigned long long t;
    __asm__ __volatile__("rdtscp; shl $32,%%rdx; or %%rdx,%%rax"
                         : "=a"(t)
                         :
                         : "%rcx", "%rdx");
    return t;
}
#else
static unsigned long long shl_double(unsigned long long l, unsigned long long r, int c) {
    return (l << c) | (r >> (64 - c));
}
static unsigned long long shr_double(unsigned long long l, unsigned long long r, int c) {
    return (r >> c) | (l << (64 - c));
}
static unsigned bswap32(unsigned v) {
    return __builtin_bswap32(v);
}
static unsigned long long bswap64(unsigned long long v) {
    return __builtin_bswap64(v);
}
static unsigned long long tsc_read(void) {
    return 0;
}
#endif

static volatile unsigned long long sink;

int main(void) {
    unsigned long long l = 0x0123456789ABCDEFULL, r = 0xFEDCBA9876543210ULL;
    if (shl_double(l, r, 12) != ((l << 12) | (r >> 52))) {
        return 1;
    }
    if (shr_double(l, r, 20) != ((r >> 20) | (l << 44))) {
        return 2;
    }
    if (bswap32(0x11223344u) != 0x44332211u) {
        return 3;
    }
    if (bswap64(0x0102030405060708ULL) != 0x0807060504030201ULL) {
        return 4;
    }
    // Force the timestamp-read sequence to be emitted; its value is not
    // deterministic, so it is stored to a sink rather than checked.
    sink = tsc_read();
    return 0;
}
