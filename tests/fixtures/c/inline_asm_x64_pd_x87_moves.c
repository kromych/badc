// x86-64 inline asm: the packed-double moves `movapd` and `movupd` in their
// register, load and store forms, the x87 constant loads `fld1` to `fldz`,
// and the x87 loads and stores of each memory width -- `flds`, `fsts` and
// `fstps` at 32 bits, `fstl` at 64 and `fldt` / `fstpt` at 80. Returns 0 when
// every value comes back as the instruction defines it; other targets skip
// the checks.

#include <string.h>

#if defined(__x86_64__)
struct ext80 {
    unsigned char b[10];
};

static _Alignas(16) double pair_in[2] = {1.25, -3.5};
static _Alignas(16) double pair_out[2];
static _Alignas(16) unsigned char unaligned[48];

static int packed_double_moves(void)
{
    __asm__ volatile("movapd %1, %%xmm1\n\t"
                     "movapd %%xmm1, %%xmm2\n\t"
                     "movapd %%xmm2, %0"
                     : "=m"(pair_out[0])
                     : "m"(pair_in[0])
                     : "xmm1", "xmm2", "memory");
    if (pair_out[0] != 1.25 || pair_out[1] != -3.5)
        return 1;
    // 16 bytes at an address 8 past a 16-byte boundary: only the unaligned
    // move is defined there.
    memcpy(unaligned + 8, pair_in, 16);
    __asm__ volatile("movupd %1, %%xmm3\n\t"
                     "movupd %%xmm3, %%xmm4\n\t"
                     "movupd %%xmm4, %0"
                     : "=m"(unaligned[24])
                     : "m"(unaligned[8])
                     : "xmm3", "xmm4", "memory");
    double back[2];
    memcpy(back, unaligned + 24, 16);
    return back[0] == 1.25 && back[1] == -3.5 ? 0 : 2;
}

static int near(double got, double want)
{
    double d = got - want;
    return d <= want * 4e-16 && -d <= want * 4e-16;
}

static int x87_constants(void)
{
    double one, zero, pi, l2t, l2e, lg2, ln2;
    __asm__ volatile("fld1\n\tfstpl %0" : "=m"(one));
    __asm__ volatile("fldz\n\tfstpl %0" : "=m"(zero));
    __asm__ volatile("fldpi\n\tfstpl %0" : "=m"(pi));
    __asm__ volatile("fldl2t\n\tfstpl %0" : "=m"(l2t));
    __asm__ volatile("fldl2e\n\tfstpl %0" : "=m"(l2e));
    __asm__ volatile("fldlg2\n\tfstpl %0" : "=m"(lg2));
    __asm__ volatile("fldln2\n\tfstpl %0" : "=m"(ln2));
    if (one != 1.0 || zero != 0.0)
        return 3;
    if (!near(pi, 3.141592653589793) || !near(l2t, 3.321928094887362) ||
        !near(l2e, 1.4426950408889634) || !near(lg2, 0.3010299956639812) ||
        !near(ln2, 0.6931471805599453))
        return 4;
    return 0;
}

static int x87_widths(void)
{
    float f_in = 2.5f, f_kept = 0, f_popped = 0;
    double d_in = -0.75, d_kept = 0, d_widened = 0;
    // A 32-bit load, a 32-bit store that keeps it, and a 64-bit store-and-pop.
    __asm__ volatile("flds %2\n\tfsts %0\n\tfstpl %1" : "=m"(f_kept), "=m"(d_widened) : "m"(f_in));
    // A 64-bit load, a 64-bit store that keeps it, and a 32-bit store-and-pop.
    __asm__ volatile("fldl %2\n\tfstl %0\n\tfstps %1" : "=m"(d_kept), "=m"(f_popped) : "m"(d_in));
    if (f_kept != 2.5f || d_widened != 2.5 || d_kept != -0.75 || f_popped != -0.75f)
        return 5;
    // 1.5 in the 80-bit format: significand 0xC000000000000000, exponent 0x3FFF.
    struct ext80 in = {{0, 0, 0, 0, 0, 0, 0, 0xC0, 0xFF, 0x3F}}, out, one;
    double narrowed = 0;
    memset(&out, 0xAA, sizeof out);
    __asm__ volatile("fldt %1\n\tfstpt %0" : "=m"(out) : "m"(in));
    __asm__ volatile("fldt %1\n\tfstpl %0" : "=m"(narrowed) : "m"(in));
    __asm__ volatile("fld1\n\tfstpt %0" : "=m"(one));
    static const unsigned char one80[10] = {0, 0, 0, 0, 0, 0, 0, 0x80, 0xFF, 0x3F};
    if (memcmp(out.b, in.b, 10) != 0 || narrowed != 1.5 || memcmp(one.b, one80, 10) != 0)
        return 6;
    return 0;
}
#endif

int main(void)
{
#if defined(__x86_64__)
    int r = packed_double_moves();
    if (r == 0)
        r = x87_constants();
    if (r == 0)
        r = x87_widths();
    return r;
#else
    return 0;
#endif
}
