// A System V callee preserves neither rsi, rdi nor any xmm register, which
// Microsoft x64 preserves (AMD64 psABI 3.2.1), and takes its seventh and
// eighth floating arguments in xmm6 and xmm7 (3.2.3). Where System V is the
// target's own convention every result is the same.

typedef long long ll;

#define SYSV __attribute__((sysv_abi))

// Writes each register System V leaves volatile and Microsoft x64 preserves.
#if defined(__x86_64__)
SYSV __attribute__((naked, noinline)) static void clobber(void) {
    __asm__("movq $-1, %rsi\n\tmovq $-1, %rdi\n\t"
            "pcmpeqd %xmm6, %xmm6\n\tpcmpeqd %xmm7, %xmm7\n\t"
            "pcmpeqd %xmm8, %xmm8\n\tpcmpeqd %xmm9, %xmm9\n\t"
            "pcmpeqd %xmm10, %xmm10\n\tpcmpeqd %xmm11, %xmm11\n\t"
            "pcmpeqd %xmm12, %xmm12\n\tpcmpeqd %xmm13, %xmm13\n\t"
            "pcmpeqd %xmm14, %xmm14\n\tpcmpeqd %xmm15, %xmm15\n\tret");
}
#else
__attribute__((noinline)) static void clobber(void) {}
#endif

__attribute__((noinline)) static double keep_fp(double p, double q) {
    double s = p * q;
    clobber();
    return s + p + q;
}

__attribute__((noinline)) static ll keep_gpr(ll a, ll b, ll c, ll d) {
    ll s = a * b + c * d;
    clobber();
    return s + a + b + c + d;
}

// Eight floating arguments: the marshal writes xmm6 and xmm7.
SYSV __attribute__((noinline)) static double sv8(double a, double b, double c, double d,
                                                 double e, double f, double g, double h) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
}

__attribute__((noinline)) static double keep_across_sv8(double p, double q) {
    double s = p * q;
    double t = sv8(1, 2, 3, 4, 5, 6, 7, 8);
    return s + t + p + q;
}

// An indirect call: the marshal writes rdi, the pointer is called twice.
typedef ll (*svfn)(ll) SYSV;

SYSV __attribute__((noinline)) static ll twice(ll x) { return 2 * x; }

__attribute__((noinline)) static ll keep_pointer(svfn fn, ll a, ll b, ll c) {
    ll s = fn(a);
    ll t = fn(b);
    return s + t + a * b + c;
}

// Six floating arguments, the first two swapped; the sixth goes in xmm5.
SYSV __attribute__((noinline)) static double sv6(double a, double b, double c, double d, double e,
                                                 double f) {
    return a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000;
}

__attribute__((noinline)) static double swap6(double x, double y, double z) {
    return sv6(y, x, 3.0, 4.0, 5.0, z);
}

static volatile double fin[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
static volatile ll gin[6] = {11, 12, 13, 14, 15, 16};
static volatile double fa[3] = {2.0, 3.0, 6.0};
static volatile ll ga[5] = {2, 3, 4, 5, 9};

int main(void) {
    // Live across every call.
    double x0 = fin[0], x1 = fin[1], x2 = fin[2], x3 = fin[3], x4 = fin[4];
    double x5 = fin[5], x6 = fin[6], x7 = fin[7], x8 = fin[8], x9 = fin[9];
    ll g0 = gin[0], g1 = gin[1], g2 = gin[2], g3 = gin[3], g4 = gin[4], g5 = gin[5];
    int bad = 0;
    if (keep_fp(fa[0], fa[1]) != 11.0)
        bad |= 1;
    if (keep_gpr(ga[0], ga[1], ga[2], ga[3]) != 40)
        bad |= 2;
    if (keep_across_sv8(fa[0], fa[1]) != 215.0)
        bad |= 4;
    if (keep_pointer(twice, ga[1], ga[2], ga[4]) != 35)
        bad |= 8;
    if (swap6(fa[0], fa[1], fa[2]) != 654323.0)
        bad |= 16;
    double fs = x0 + x1 * 2 + x2 * 3 + x3 * 4 + x4 * 5 + x5 * 6 + x6 * 7 + x7 * 8 + x8 * 9 +
                x9 * 10;
    if (fs != 385.0)
        bad |= 32;
    ll gs = g0 + g1 * 2 + g2 * 3 + g3 * 4 + g4 * 5 + g5 * 6;
    if (gs != 301)
        bad |= 64;
    return bad;
}
