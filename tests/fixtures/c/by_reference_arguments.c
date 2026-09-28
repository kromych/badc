// An aggregate the convention passes by reference arrives as the address of a
// copy the callee owns (AAPCS64 B.4; Microsoft x64, whose copy is 16-aligned):
// the callee may write its parameter and the caller's object keeps its value.
// On AArch64 and Win64 `write_big` stores through the pointer as a gcc, clang
// or MSVC callee may, and adds 256 times the copy's distance off its
// alignment; System V AMD64 passes the bytes on the stack, where it writes
// them. gcc takes the C definition: at -O0 it stores the register parameters
// of a naked function into its caller's frame.
#include <stdarg.h>

typedef long long ll;
struct big { ll a, b, c; };
struct odd { char c[3]; };
struct twelve { int a, b, c; };

#if (defined(__clang__) || !defined(__GNUC__)) && !defined(_MSC_VER) \
    && (defined(__aarch64__) || defined(__x86_64__))
#define NAKED_WRITE 1
#if defined(__aarch64__)
/* x0 points at the copy, x1 holds t. */
__attribute__((naked, noinline)) static ll write_big(struct big s, ll t) {
    __asm__("ldr x9, [x0, #8]\n\t"
            "add x9, x9, x1\n\t"
            "mov x10, #-1\n\t"
            "str x10, [x0]\n\t"
            "and x11, x0, #7\n\t"
            "add x0, x9, x11, lsl #8\n\t"
            "ret");
}
#elif defined(_WIN32)
/* rcx points at the copy, rdx holds t. */
__attribute__((naked, noinline)) static ll write_big(struct big s, ll t) {
    __asm__("movq 8(%rcx), %rax\n\t"
            "addq %rdx, %rax\n\t"
            "movq $-1, (%rcx)\n\t"
            "andq $15, %rcx\n\t"
            "shlq $8, %rcx\n\t"
            "addq %rcx, %rax\n\t"
            "ret");
}
#else
/* The bytes at [rsp + 8], rdi holds t. */
__attribute__((naked, noinline)) static ll write_big(struct big s, ll t) {
    __asm__("movq 16(%rsp), %rax\n\t"
            "addq %rdi, %rax\n\t"
            "movq $-1, 8(%rsp)\n\t"
            "ret");
}
#endif
#endif

static void keep(void *p) { (void)p; }
static void (*volatile sink)(void *) = keep;

#ifndef NAKED_WRITE
static ll write_big(struct big s, ll t) {
    ll r = s.b + t;
    s.a = -1;
    sink(&s);
    return r;
}
#endif

static ll pair_big(struct big x, struct big y) {
    ll r = x.a * 10 + y.c;
    x.a = y.a = -1;
    sink(&x);
    sink(&y);
    return r;
}

static ll stack_big(ll a0, ll a1, ll a2, ll a3, ll a4, ll a5, ll a6, ll a7, struct big s) {
    ll r = s.a * 100 + s.b * 10 + s.c + a0 + a7;
    s.a = -1;
    sink(&s);
    return r + a1 + a2 + a3 + a4 + a5 + a6;
}

static struct big make_big(ll k) {
    struct big r = { k, k + 1, k + 2 };
    return r;
}

static ll va_mixed(int n, ...) {
    va_list ap;
    ll s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct odd o = va_arg(ap, struct odd);
        struct twelve w = va_arg(ap, struct twelve);
        struct big g = va_arg(ap, struct big);
        s = s * 1000 + o.c[0] * 100 + o.c[2] * 10 + w.c + g.b;
    }
    va_end(ap);
    return s;
}

int main(void) {
    struct big b = { 1, 2, 3 };
    if (write_big(b, 4) != 6) return 1;
    if (b.a != 1 || b.b != 2 || b.c != 3) return 2;
    volatile struct big vb = { 5, 6, 7 };
    if (write_big(vb, 1) != 7) return 3;
    if (vb.a != 5) return 4;
    if (write_big(make_big(10), 1) != 12) return 5;
    if (pair_big(b, b) != 13 || b.a != 1) return 6;
    if (stack_big(1, 2, 3, 4, 5, 6, 7, 8, b) != 159 || b.a != 1) return 7;
    struct odd o = { { 1, 2, 3 } };
    struct twelve w = { 4, 5, 6 };
    if (va_mixed(2, o, w, b, o, w, b) != 138138) return 8;
    if (o.c[0] != 1 || w.a != 4 || b.a != 1) return 9;
    return 0;
}
