// Calls through expressions whose type, derived from a pointer to a System
// V function, names its convention, with integer and floating values live
// across each call. A caller on the Microsoft x64 convention keeps values
// in registers a System V callee need not preserve (rsi, rdi, xmm6-xmm15),
// so the call must clobber what the callee's convention leaves volatile;
// the callees write every such register.
// snapshot-budget: exempt
#include <stdarg.h>
typedef long long ll;
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

// svd(a, b) = a * b and svi() = 1000, on the System V convention; each
// writes a pattern into every register it leaves volatile.
#if defined(__x86_64__)
#define CLOBBER                                                                         \
    "\tmovabsq $0x7777777777777777, %rcx\n\tmovq %rcx, %rdx\n\tmovq %rcx, %rsi\n"        \
    "\tmovq %rcx, %rdi\n\tmovq %rcx, %r8\n\tmovq %rcx, %r9\n\tmovq %rcx, %r10\n"         \
    "\tmovq %rcx, %r11\n\tpcmpeqd %xmm1, %xmm1\n\tpcmpeqd %xmm2, %xmm2\n"                \
    "\tpcmpeqd %xmm3, %xmm3\n\tpcmpeqd %xmm4, %xmm4\n\tpcmpeqd %xmm5, %xmm5\n"           \
    "\tpcmpeqd %xmm6, %xmm6\n\tpcmpeqd %xmm7, %xmm7\n\tpcmpeqd %xmm8, %xmm8\n"           \
    "\tpcmpeqd %xmm9, %xmm9\n\tpcmpeqd %xmm10, %xmm10\n\tpcmpeqd %xmm11, %xmm11\n"       \
    "\tpcmpeqd %xmm12, %xmm12\n\tpcmpeqd %xmm13, %xmm13\n\tpcmpeqd %xmm14, %xmm14\n"     \
    "\tpcmpeqd %xmm15, %xmm15\n"
__asm__(".text\n.globl svd\nsvd:\n\tmulsd %xmm1, %xmm0\n" CLOBBER "\tret\n"
        ".globl svi\nsvi:\n" CLOBBER "\tmovl $1000, %eax\n\tret\n");
SVF double svd(double a, double b);
SVF ll svi(void);
#else
double svd(double a, double b) { return a * b; }
ll svi(void) { return 1000; }
#endif

// Enough values to need rsi and rdi among a Microsoft x64 caller's
// callee-saved registers, and xmm6 up; one of each where the conventions
// are inert.
static volatile ll vin[8] = {3, 5, 7, 11, 13, 17, 19, 23};
static volatile double din[4] = {1.5, 2.5, 3.5, 4.5};
#if defined(__x86_64__)
#define LOADS                                                                    \
    ll x0 = vin[0], x1 = vin[1], x2 = vin[2], x3 = vin[3], x4 = vin[4], x5 = vin[5]; \
    ll x6 = vin[6], x7 = vin[7];                                                    \
    double d0 = din[0], d1 = din[1], d2 = din[2], d3 = din[3];
#define SUM                                                                         \
    (x0 * 1 + x1 * 2 + x2 * 3 + x3 * 4 + x4 * 5 + x5 * 6 + x6 * 7 + x7 * 8 +           \
     (ll)(d0 * 2 + d1 * 4 + d2 * 6 + d3 * 8))
#else
#define LOADS                                                                    \
    ll x0 = vin[0];                                                                 \
    double d0 = din[0];
#define SUM (x0 + (ll)(d0 * 2))
#endif

typedef double (SVF *svdfn)(double, double);
typedef ll (SVF *svifn)(void);
svdfn gsd;
svifn gsi;

// Each call returns 0.375 for (0.75, 0.5); the result adds SUM after each.
NOINLINE double through_types(double a, double b) {
    LOADS
    __typeof__(gsd) t1 = gsd;
    __auto_type t2 = gsd;
    __typeof__(svd) *t3 = svd;
    __typeof__(&svd) t4 = svd;
    void *vp = (void *)gsd;
    double r = t1(a, b) + (double)SUM;
    r += t2(a, b) + (double)SUM;
    r += t3(a, b) + (double)SUM;
    r += t4(a, b) + (double)SUM;
    return r + ((svdfn)vp)(a, b) + (double)SUM;
}
double old_style(f, a, b) svdfn f; double a, b; { LOADS return f(a, b) + (double)SUM; }
NOINLINE double through_va_arg(int n, ...) {
    LOADS va_list ap;
    va_start(ap, n);
    double r = va_arg(ap, svdfn)(0.75, 0.5);
    va_end(ap);
    return r + (double)SUM;
}
NOINLINE ll int_through_types(void) {
    LOADS __typeof__(gsi) t1 = gsi;
    __auto_type t2 = gsi;
    ll r = t1() + SUM;
    return r + t2() + SUM;
}
ll int_old_style(f) svifn f; { LOADS return f() + SUM; }

int main(void) {
    ll s;
    {
        LOADS s = SUM;
    }
    gsd = svd;
    gsi = svi;
    double one = 0.375 + (double)s;
    if (through_types(0.75, 0.5) != 5 * one) return 1;
    if (old_style(gsd, 0.75, 0.5) != one) return 2;
    if (through_va_arg(1, gsd) != one) return 3;
    if (int_through_types() != 2 * (1000 + s)) return 4;
    if (int_old_style(gsi) != 1000 + s) return 5;
    return 0;
}
