// A variadic function returning an aggregate through the hidden result
// pointer takes that pointer in the first integer register and its named and
// variadic arguments after it as any call does (System V AMD64 3.2.3 and
// 3.5.7, Microsoft x64). On x86_64 the naked callees below read the
// registers: System V passes `struct pair` in rsi:rdx, the double in xmm0
// with al counting one vector register, n in ecx and the first variadic
// argument in r8; Win64 passes the pair by reference in rdx and `struct w8`
// by value in rdx, n in r8d and the first variadic argument in r9.
// Elsewhere, and under gcc, whose -O0 stores the register parameters of a
// naked function into its caller's frame, the C definitions stand in.
#include <stdarg.h>
#include <string.h>

typedef long long ll;
struct quad { ll a, b, c, d; };
struct pair { ll lo, hi; };
struct w8 { int x, y; };

#if (defined(__clang__) || !defined(__GNUC__)) && !defined(_MSC_VER) && defined(__x86_64__)
#define NAKED_CALLEES 1
#if defined(_WIN32)
__attribute__((naked, noinline)) static struct quad vpair(struct pair p, int n, ...) {
    __asm__("movq (%rdx), %rax\n\t"
            "movq %rax, (%rcx)\n\t"
            "movq 8(%rdx), %rax\n\t"
            "movq %rax, 8(%rcx)\n\t"
            "movq $0, 16(%rcx)\n\t"
            "movslq %r8d, %rax\n\t"
            "addq %r9, %rax\n\t"
            "movq %rax, 24(%rcx)\n\t"
            "movq %rcx, %rax\n\t"
            "ret");
}
__attribute__((naked, noinline)) static struct quad vw8(struct w8 s, int n, ...) {
    __asm__("movslq %edx, %rax\n\t"
            "movq %rax, (%rcx)\n\t"
            "sarq $32, %rdx\n\t"
            "movq %rdx, 8(%rcx)\n\t"
            "movq $0, 16(%rcx)\n\t"
            "movslq %r8d, %rax\n\t"
            "addq %r9, %rax\n\t"
            "movq %rax, 24(%rcx)\n\t"
            "movq %rcx, %rax\n\t"
            "ret");
}
#else
__attribute__((naked, noinline)) static struct quad vpair(struct pair p, double d, int n, ...) {
    __asm__("movq %rsi, (%rdi)\n\t"
            "movq %rdx, 8(%rdi)\n\t"
            "movq %xmm0, 16(%rdi)\n\t"
            "movslq %ecx, %rcx\n\t"
            "addq %r8, %rcx\n\t"
            "movzbl %al, %eax\n\t"
            "imulq $1000, %rax, %rax\n\t"
            "addq %rax, %rcx\n\t"
            "movq %rcx, 24(%rdi)\n\t"
            "movq %rdi, %rax\n\t"
            "ret");
}
#endif
#endif

#ifndef NAKED_CALLEES
#if defined(_WIN32) && defined(__x86_64__)
static struct quad vpair(struct pair p, int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct quad r = { p.lo, p.hi, 0, n + va_arg(ap, ll) };
    va_end(ap);
    return r;
}
static struct quad vw8(struct w8 s, int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct quad r = { s.x, s.y, 0, n + va_arg(ap, ll) };
    va_end(ap);
    return r;
}
#else
static struct quad vpair(struct pair p, double d, int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct quad r = { p.lo, p.hi, 0, n + va_arg(ap, ll) + 1000 };
    memcpy(&r.c, &d, sizeof d);
    va_end(ap);
    return r;
}
#endif
#endif

/* A named MEMORY-class aggregate and a variadic one, read in C. */
static struct quad vquad(struct quad g, int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct quad h = va_arg(ap, struct quad);
    va_end(ap);
    struct quad r = { g.a * 10 + h.a, g.b * 10 + h.b, g.c * 10 + h.c, g.d * 10 + h.d + n };
    return r;
}

int main(void) {
    struct pair p = { 11, 22 };
#if defined(_WIN32) && defined(__x86_64__)
    struct quad r = vpair(p, 3, 40LL);
    if (r.a != 11 || r.b != 22 || r.c != 0 || r.d != 43) return 1;
    struct quad (*vp)(struct pair, int, ...) = vpair;
    r = vp(p, 5, 50LL);
    if (r.a != 11 || r.b != 22 || r.c != 0 || r.d != 55) return 2;
    struct w8 w = { -7, 9 };
    r = vw8(w, 6, 60LL);
    if (r.a != -7 || r.b != 9 || r.c != 0 || r.d != 66) return 4;
#else
    double d = 2.5, e;
    struct quad r = vpair(p, d, 3, 40LL);
    memcpy(&e, &r.c, sizeof e);
    if (r.a != 11 || r.b != 22 || e != 2.5 || r.d != 1043) return 1;
    struct quad (*vp)(struct pair, double, int, ...) = vpair;
    r = vp(p, 4.5, 5, 50LL);
    memcpy(&e, &r.c, sizeof e);
    if (r.a != 11 || r.b != 22 || e != 4.5 || r.d != 1055) return 2;
#endif
    struct quad g = { 1, 2, 3, 4 }, h = { 5, 6, 7, 8 };
    r = vquad(g, 9, h);
    if (r.a != 15 || r.b != 26 || r.c != 37 || r.d != 57) return 3;
    return 0;
}
