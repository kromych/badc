/* A clobber list names a register under each of these spellings and no value
   stays in it across the statement: x86-64 high bytes, ymm and zmm names of
   xmm registers, `#` names and numbers gcc and clang agree on; AArch64 SVE z
   names, rN, `#` names, agreed numbers, and lr and fp (x30 and x29 under gcc,
   which has neither name). Exits 42 when every value reads back. */

#define NOINLINE __attribute__((noinline))

static volatile long sink;
static volatile long one = 1;
static volatile double half = 0.5;

NOINLINE static void touch(void) { sink++; }

#if defined(__x86_64__)
#define WRITE(r) __asm__ volatile("movb $0x7f, %%" #r ::: #r)

NOINLINE static long across(long a, long b, long c, long d, long e) {
    long x1 = a * 3 + 1, x2 = b * 5 + 2, x3 = c * 7 + 3, x4 = d * 11 + 4, x5 = e * 13 + 5;
    touch();
    WRITE(bh);
    WRITE(ah);
    WRITE(ch);
    WRITE(dh);
    touch();
    return x1 ^ (x2 << 1) ^ (x3 << 2) ^ (x4 << 3) ^ (x5 << 4);
}

NOINLINE static long long numbered(long long a, long long b) {
    long long y1 = a * 3 + b, y2 = a * 5 - b, y3 = a ^ (b << 4), y4 = a + 7 * b;
    long long y5 = a * b + 1, y6 = a - 3 * b, y7 = b * 9 + 2;
    __asm__ volatile("xorl %%edx, %%edx" ::: "1");
    __asm__ volatile("xorl %%ebx, %%ebx" ::: "3");
    __asm__ volatile("xorl %%esi, %%esi" ::: "#rsi");
    return y1 + 2 * y2 + 3 * y3 + 4 * y4 + 5 * y5 + 6 * y6 + 7 * y7;
}

/* clang honors a ymm or zmm clobber only where the function has the ISA. */
__attribute__((target("avx512f"))) NOINLINE static double vectors(double a, double b) {
    double v0 = a * 1.5, v1 = b * 2.5, v2 = a + b, v3 = a - b;
    double v4 = a * b, v5 = a / b, v6 = a * 3.25, v7 = b * 7.0;
    __asm__ volatile("xorps %%xmm0, %%xmm0\n\txorps %%xmm1, %%xmm1\n\t"
                     "xorps %%xmm2, %%xmm2\n\txorps %%xmm3, %%xmm3"
                     ::: "ymm0", "zmm1", "#xmm2", "ymm3");
    __asm__ volatile("xorps %%xmm4, %%xmm4\n\txorps %%xmm5, %%xmm5" ::: "zmm4", "ymm5");
    return v0 + 2 * v1 + 3 * v2 + 4 * v3 + 5 * v4 + 6 * v5 + 7 * v6 + 8 * v7;
}

static int checks(void) {
    long n = one;
    long want = (1 * 3 + 1) ^ ((2 * 5 + 2) << 1) ^ ((3 * 7 + 3) << 2) ^ ((4 * 11 + 4) << 3) ^
                ((5 * 13 + 5) << 4);
    if (across(n, 2 * n, 3 * n, 4 * n, 5 * n) != want)
        return 1;
    if (numbered(n, 2 * n) != 295)
        return 2;
    if (vectors(2 * half, 4 * half) != 164.25)
        return 3;
    return 0;
}
#elif defined(__aarch64__)
#if defined(__clang__) || !defined(__GNUC__)
#define FP_NAME "fp"
#define LR_NAME "lr"
#else
#define FP_NAME "x29"
#define LR_NAME "x30"
#endif

/* Values live across calls, in the callee-saved registers the asm writes. */
NOINLINE static long gprs(long a, long b) {
    long y1 = a * 3 + b, y2 = a * 5 - b, y3 = a ^ (b << 4), y4 = a + 7 * b;
    long y5 = a * b + 1, y6 = a - 3 * b, y7 = b * 9 + 2;
    touch();
    __asm__ volatile("mov x20, xzr" ::: "r20");
    __asm__ volatile("mov x21, xzr" ::: "21");
    __asm__ volatile("mov x22, xzr\n\tmov x23, xzr" ::: "#x22", "#w23");
    touch();
    return y1 + 2 * y2 + 3 * y3 + 4 * y4 + 5 * y5 + 6 * y6 + 7 * y7;
}

NOINLINE static double simd(double a, double b) {
    double v0 = a * 1.5, v1 = b * 2.5, v2 = a + b, v3 = a - b;
    double v4 = a * b, v5 = a / b, v6 = a * 3.25, v7 = b * 7.0;
    touch();
    __asm__ volatile("movi v8.2d, #0\n\tmovi v9.2d, #0\n\tmovi v10.2d, #0\n\tmovi v11.2d, #0"
                     ::: "z8", "z9", "#v10", "z11");
    __asm__ volatile("movi v12.2d, #0\n\tmovi v13.2d, #0\n\tmovi v14.2d, #0\n\tmovi v15.2d, #0"
                     ::: "z12", "z13", "z14", "#d15");
    touch();
    return v0 + 2 * v1 + 3 * v2 + 4 * v3 + 5 * v4 + 6 * v5 + 7 * v6 + 8 * v7;
}

NOINLINE static long leaf_lr(long a) {
    __asm__ volatile("mov x30, xzr" ::: LR_NAME);
    return a + 1;
}

/* clang does not keep a clobbered frame pointer (-Winline-asm). */
#if !defined(__clang__)
NOINLINE static long frame_fp(long a) {
    volatile char buf[300];
    for (int i = 0; i < 300; i++)
        buf[i] = (char)(i & 7);
    touch();
    __asm__ volatile("mov x29, xzr" ::: FP_NAME);
    touch();
    return buf[299] + buf[1] + a;
}
#endif

static int checks(void) {
    long n = one;
    if (gprs(n, 2 * n) != 295)
        return 1;
    if (simd(2 * half, 4 * half) != 164.25)
        return 2;
    if (leaf_lr(n) != 2)
        return 3;
#if !defined(__clang__)
    if (frame_fp(n) != 3 + 1 + 1)
        return 4;
#endif
    return 0;
}
#else
static int checks(void) { return 0; }
#endif

int main(void) {
    int bad = checks();
    return bad ? bad : 42;
}
