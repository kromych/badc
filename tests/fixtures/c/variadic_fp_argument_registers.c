// A floating-point argument to a variadic or unprototyped callee reaches it
// where the convention lets such a callee read it: a named one keeps its type,
// a variadic or unprototyped one widens to `double`. Microsoft x64 puts each
// in both the xmm and the integer register of its position; the naked callees
// report, as bits 1, 2, 4 and 8, which of rcx/xmm0 .. r9/xmm3 carry the same
// value, 32 bits of a `float` and 64 of a `double`. Windows arm64 puts each in
// the integer bank, x0-x7 and then the stack; the naked callees return the
// low word of a named `float`'s register or slot, or the whole of a variadic
// one's.
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

#if defined(_WIN32) && defined(__aarch64__) && !defined(_MSC_VER)
#define BANK_CHECKS 1
__attribute__((naked, noinline)) static ll low_x0(float a, ...) { __asm__("mov w0, w0\n\tret"); }
__attribute__((naked, noinline)) static ll whole_x1(float a, ...) { __asm__("mov x0, x1\n\tret"); }
__attribute__((naked, noinline)) static ll low_slot0(int a, int b, int c, int d, int e, int g,
                                                      int h, int i, float j, ...) {
    __asm__("ldr w0, [sp]\n\tret");
}
__attribute__((naked, noinline)) static ll whole_slot1(int a, int b, int c, int d, int e, int g,
                                                        int h, int i, float j, ...) {
    __asm__("ldr x0, [sp, #8]\n\tret");
}
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

// The named `float` past the eight integer registers of Windows arm64.
static double far8(int a, int b, int c, int d, int e, int g, int h, int i, float j, int k, ...) {
    va_list ap;
    va_start(ap, k);
    double l = va_arg(ap, double);
    va_end(ap);
    return a + b + c + d + e + g + h + i + j * 10 + k * 100 + l;
}

static double two(double a, double b) { return a * 10 + b; }

int main(void) {
    if (vsum(1.5, 2, 2.5, 3.5) != 178.5) return 1;
    if (vfsum(1.5f, 1, 2.5) != 17.5) return 2;
    float f = 2.5f;
    if (vfsum(1.5f, 2, f, 3.5) != 178.5) return 3;
    if (mixed(1, 2.0f, 3.0, 4.0, 5, 6.0) != 123456) return 4;
    if (far(1, 2, 3, 4, 5.5f, 7, 0.25) != 765.25) return 5;
    if (far8(1, 2, 3, 4, 5, 6, 7, 8, f, 9, 0.25) != 961.25) return 13;
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
#ifdef BANK_CHECKS
    if (low_x0(1.5f, 2.5f) != 0x3fc00000) return 14;
    if (low_x0(f, f) != 0x40200000) return 15;
    if (whole_x1(1.5f, f) != 0x4004000000000000) return 16;
    if (low_slot0(1, 2, 3, 4, 5, 6, 7, 8, f, 0.25) != 0x40200000) return 17;
    if (whole_slot1(1, 2, 3, 4, 5, 6, 7, 8, 1.5f, f) != 0x4004000000000000) return 18;
#endif
    return 0;
}
