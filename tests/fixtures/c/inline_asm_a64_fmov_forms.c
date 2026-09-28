// AArch64 `fmov` in each scalar form: between the register files at both
// widths, within the FP file, from an immediate, and to and from a vector's
// top half. A write to a D or S view clears the rest of its vector register.
// Every result is the bit pattern C computes; returns 42, or the number of
// the first mismatch. The other architectures take the portable arm.

typedef unsigned long long u64;
typedef unsigned int u32;

static volatile u64 in64 = 0x0123456789abcdefull;
static volatile u32 in32 = 0x89abcdefu;

int main(void) {
    u64 x = in64, d_bits, dd_bits, imm_d, top, cleared;
    u32 w = in32, s_bits, ss_bits, imm_s;
#if defined(__aarch64__)
    __asm__("fmov d0, %1\n\tfmov %0, d0" : "=r"(d_bits) : "r"(x) : "v0");
    __asm__("fmov s1, %w1\n\tfmov %w0, s1" : "=r"(s_bits) : "r"(w) : "v1");
    __asm__("fmov d0, %1\n\tfmov d2, d0\n\tfmov %0, d2" : "=r"(dd_bits) : "r"(x) : "v0", "v2");
    __asm__("fmov s1, %w1\n\tfmov s3, s1\n\tfmov %w0, s3" : "=r"(ss_bits) : "r"(w) : "v1", "v3");
    __asm__("fmov d4, #-2.5\n\tfmov %0, d4" : "=r"(imm_d) : : "v4");
    __asm__("fmov s5, #0.125\n\tfmov %w0, s5" : "=r"(imm_s) : : "v5");
    __asm__("fmov v6.d[1], %1\n\tfmov %0, v6.d[1]" : "=r"(top) : "r"(x) : "v6");
    __asm__("fmov v7.d[1], %1\n\tfmov s7, %w1\n\tfmov %0, v7.d[1]" : "=r"(cleared) : "r"(x) : "v7");
#else
    d_bits = x;
    s_bits = w;
    dd_bits = x;
    ss_bits = w;
    imm_d = 0xc004000000000000ull;
    imm_s = 0x3e000000u;
    top = x;
    cleared = 0;
#endif
    if (d_bits != 0x0123456789abcdefull) return 1;
    if (s_bits != 0x89abcdefu) return 2;
    if (dd_bits != 0x0123456789abcdefull) return 3;
    if (ss_bits != 0x89abcdefu) return 4;
    if (imm_d != 0xc004000000000000ull) return 5;
    if (imm_s != 0x3e000000u) return 6;
    if (top != 0x0123456789abcdefull) return 7;
    if (cleared != 0) return 8;
    return 42;
}
