// A floating-point argument to a variadic or unprototyped callee reaches it
// where the convention lets such a callee read it: a named one keeps its type,
// a variadic or unprototyped one widens to `double`. Microsoft x64 puts each
// in both the xmm and the integer register of its position; the naked callees
// report, as bits 1, 2, 4 and 8, which of rcx/xmm0 .. r9/xmm3 carry the same
// value, 32 bits of a `float` and 64 of a `double`.
#include <stdarg.h>

typedef long long ll;

#if defined(_WIN32) && defined(__x86_64__) && !defined(_MSC_VER)
#define MIRROR_CHECKS 1
#define PAIR(x, r, bit) \
    "movq %" x ", %r10\n\tcmpq %r10, %" r "\n\tjne " bit "f\n\torl $" bit ", %eax\n" bit ":\n\t"
#define PAIRS_TAIL PAIR("xmm1", "rdx", "2") PAIR("xmm2", "r8", "4") PAIR("xmm3", "r9", "8") "ret"
#define PAIRS_BODY __asm__("xorl %eax, %eax\n\t" PAIR("xmm0", "rcx", "1") PAIRS_TAIL)
__attribute__((naked, noinline)) static ll pairs_d(double a, ...) { PAIRS_BODY; }
// The named `float` compares its 32 bits.
__attribute__((naked, noinline)) static ll pairs_f(float a, double b, ...) {
    __asm__("xorl %eax, %eax\n\tmovd %xmm0, %r10d\n\tcmpl %r10d, %ecx\n\tjne 1f\n\t"
            "orl $1, %eax\n1:\n\t" PAIRS_TAIL);
}
__attribute__((naked, noinline)) static ll pairs_fixed(double a, double b, double c, double d) {
    PAIRS_BODY;
}
__attribute__((naked, noinline)) static ll pairs_kr(a, b, c, d) double a, b, c, d; { PAIRS_BODY; }
// A direct call without a prototype, in tail position.
__attribute__((noinline)) static ll tail_kr(void) { return pairs_kr(1.5, 2.5, 3.5, 4.5); }
#endif

static double vsum(double d, int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = d;
    for (int i = 0; i < n; i++) s = s * 10 + va_arg(ap, double);
    va_end(ap);
    return s;
}

static double vfsum(float f, int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = f;
    for (int i = 0; i < n; i++) s = s * 10 + va_arg(ap, double);
    va_end(ap);
    return s;
}

static double mixed(int a, float b, double c, ...) {
    va_list ap;
    va_start(ap, c);
    double d = va_arg(ap, double);
    int e = va_arg(ap, int);
    double f = va_arg(ap, double);
    va_end(ap);
    return a * 100000 + b * 10000 + c * 1000 + d * 100 + e * 10 + f;
}

// The named `float` and the variadic `double` past the register positions.
static double far(int a, int b, int c, int d, float e, int g, ...) {
    va_list ap;
    va_start(ap, g);
    double f = va_arg(ap, double);
    va_end(ap);
    return a + b + c + d + e * 10 + g * 100 + f;
}

static double two(double a, double b) { return a * 10 + b; }

int main(void) {
    if (vsum(1.5, 2, 2.5, 3.5) != 178.5) return 1;
    if (vfsum(1.5f, 1, 2.5) != 17.5) return 2;
    float f = 2.5f;
    if (vfsum(1.5f, 2, f, 3.5) != 178.5) return 3;
    if (mixed(1, 2.0f, 3.0, 4.0, 5, 6.0) != 123456) return 4;
    if (far(1, 2, 3, 4, 5.5f, 7, 0.25) != 765.25) return 5;
    double (*unproto)() = two;
    if (unproto(2.5, 3.5) != 28.5) return 6;
    if (unproto(f, 3.5f) != 28.5) return 7;
#ifdef MIRROR_CHECKS
    if (pairs_d(1.5, 2.5, 3.5, 4.5) != 15) return 8;
    if (pairs_f(1.5f, 2.5, 3.5, 4.5) != 15) return 9;
    if (pairs_d(1.5, 2.5f, 3.5f, 4.5f) != 15) return 10;
    ll (*pairs_unproto)() = pairs_fixed;
    if (pairs_unproto(1.5, 2.5, 3.5f, 4.5) != 15) return 11;
    if (tail_kr() != 15) return 12;
#endif
    return 0;
}
