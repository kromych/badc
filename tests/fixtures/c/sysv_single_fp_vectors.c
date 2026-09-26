/* System V AMD64 3.2.3 names no class for a floating-point vector of one
   element -- `float` or `double` with a `vector_size` of its own width -- and
   gcc passes one in memory, bare or as a member: an argument on the stack, a
   result through the pointer the caller passes in rdi. On x86-64 System V the
   naked functions read and set that memory and the registers around it, so a
   badc caller and a badc callee are each checked against the placement;
   elsewhere, and under clang, which passes the `float` one in a
   general-purpose register, the same calls go through C. The exit code names
   the first failed check. */

typedef long long ll;
typedef float v1f __attribute__((vector_size(4)));
typedef double v1d __attribute__((vector_size(8)));
struct f1 { v1f v; };
struct ff { v1f v; float f; };

static ll take_f1(struct f1 s, double x, ll n) { return (ll)(s.v[0] * 100 + x * 10) + n; }
static ll take_d1(v1d v, double x, ll n) { return (ll)(v[0] * 100 + x * 10) + n; }
static ll take_ff(struct ff s, double x, ll n) {
    return (ll)(s.v[0] * 100 + s.f * 1000 + x * 10) + n;
}
static struct f1 make_f1(float x) {
    struct f1 r = { { x } };
    return r;
}
static v1d make_d1(double x) {
    v1d r = { x };
    return r;
}

#if defined(__x86_64__) && !defined(_WIN32) && !defined(__clang__)
#define NAKED __attribute__((naked))
/* Bits 1, 2 and 4: the vector's bytes in the first stack slot, 2.5 in xmm0
   and 7 in rdi. */
#define PEEK_TAIL                                                                    \
    "movq %xmm0, %rcx\n\tmovabsq $0x4004000000000000, %rdx\n\tcmpq %rdx, %rcx\n\t" \
    "jne 2f\n\torl $2, %eax\n2:\n\tcmpq $7, %rdi\n\tjne 3f\n\torl $4, %eax\n3:\n\tret\n"
NAKED static ll peek_f1(struct f1 s, double x, ll n) {
    __asm__("xorl %eax, %eax\n\tcmpl $0x3fc00000, 8(%rsp)\n\tjne 1f\n\torl $1, %eax\n1:\n\t"
            PEEK_TAIL);
}
NAKED static ll peek_d1(v1d v, double x, ll n) {
    __asm__("xorl %eax, %eax\n\tmovabsq $0x3ff8000000000000, %rdx\n\tcmpq %rdx, 8(%rsp)\n\t"
            "jne 1f\n\torl $1, %eax\n1:\n\t" PEEK_TAIL);
}
NAKED static ll peek_ff(struct ff s, double x, ll n) {
    __asm__("xorl %eax, %eax\n\tmovabsq $0x404000003fc00000, %rdx\n\tcmpq %rdx, 8(%rsp)\n\t"
            "jne 1f\n\torl $1, %eax\n1:\n\t" PEEK_TAIL);
}
/* The result through the pointer in rdi, which rax returns. */
NAKED static struct f1 give_f1(void) {
    __asm__("movl $0x3fc00000, (%rdi)\n\tmovq %rdi, %rax\n\tret\n");
}
NAKED static v1d give_d1(void) {
    __asm__("movabsq $0x3ff8000000000000, %rax\n\tmovq %rax, (%rdi)\n\tmovq %rdi, %rax\n\tret\n");
}
/* Calls into the badc function with the vector in the first stack slot, 2.5
   in xmm0 and 7 in rdi; rsi and xmm1 hold -1. */
#define VIA_CALL                                                                  \
    "movabsq $0x4004000000000000, %rax\n\tmovq %rax, %xmm0\n\tmovq $7, %rdi\n\t" \
    "movq $-1, %rsi\n\tmovq %rsi, %xmm1\n\tcall *%r11\n\taddq $24, %rsp\n\tret\n"
NAKED static ll via_take_f1(ll (*fn)(struct f1, double, ll)) {
    __asm__("movq %rdi, %r11\n\tsubq $24, %rsp\n\tmovl $0x3fc00000, (%rsp)\n\t" VIA_CALL);
}
NAKED static ll via_take_d1(ll (*fn)(v1d, double, ll)) {
    __asm__("movq %rdi, %r11\n\tsubq $24, %rsp\n\tmovabsq $0x3ff8000000000000, %rax\n\t"
            "movq %rax, (%rsp)\n\t" VIA_CALL);
}
NAKED static ll via_take_ff(ll (*fn)(struct ff, double, ll)) {
    __asm__("movq %rdi, %r11\n\tsubq $24, %rsp\n\tmovabsq $0x404000003fc00000, %rax\n\t"
            "movq %rax, (%rsp)\n\t" VIA_CALL);
}
/* Calls into the badc function with a result buffer holding -1 in rdi and
   1.5 in xmm0; returns the bits the callee stored, or -2 when rax does not
   hold the buffer's address. */
NAKED static ll via_make_f1(struct f1 (*fn)(float)) {
    __asm__("movq %rdi, %r11\n\tsubq $24, %rsp\n\tmovq $-1, 8(%rsp)\n\tleaq 8(%rsp), %rdi\n\t"
            "movl $0x3fc00000, %eax\n\tmovd %eax, %xmm0\n\tcall *%r11\n\t"
            "leaq 8(%rsp), %rcx\n\tcmpq %rcx, %rax\n\tmovl 8(%rsp), %eax\n\tje 1f\n\t"
            "movq $-2, %rax\n1:\n\taddq $24, %rsp\n\tret\n");
}
NAKED static ll via_make_d1(v1d (*fn)(double)) {
    __asm__("movq %rdi, %r11\n\tsubq $24, %rsp\n\tmovq $-1, 8(%rsp)\n\tleaq 8(%rsp), %rdi\n\t"
            "movabsq $0x3ff8000000000000, %rax\n\tmovq %rax, %xmm0\n\tcall *%r11\n\t"
            "leaq 8(%rsp), %rcx\n\tcmpq %rcx, %rax\n\tmovq 8(%rsp), %rax\n\tje 1f\n\t"
            "movq $-2, %rax\n1:\n\taddq $24, %rsp\n\tret\n");
}
#else
static ll peek_f1(struct f1 s, double x, ll n) {
    return (s.v[0] == 1.5f) | (x == 2.5) << 1 | (n == 7) << 2;
}
static ll peek_d1(v1d v, double x, ll n) { return (v[0] == 1.5) | (x == 2.5) << 1 | (n == 7) << 2; }
static ll peek_ff(struct ff s, double x, ll n) {
    return (s.v[0] == 1.5f && s.f == 3.0f) | (x == 2.5) << 1 | (n == 7) << 2;
}
static struct f1 give_f1(void) { return make_f1(1.5f); }
static v1d give_d1(void) { return make_d1(1.5); }
static ll via_take_f1(ll (*fn)(struct f1, double, ll)) { return fn(make_f1(1.5f), 2.5, 7); }
static ll via_take_d1(ll (*fn)(v1d, double, ll)) { return fn(make_d1(1.5), 2.5, 7); }
static ll via_take_ff(ll (*fn)(struct ff, double, ll)) {
    struct ff s = { { 1.5f }, 3.0f };
    return fn(s, 2.5, 7);
}
static ll via_make_f1(struct f1 (*fn)(float)) {
    union { float f; unsigned u; } b = { fn(1.5f).v[0] };
    return b.u;
}
static ll via_make_d1(v1d (*fn)(double)) {
    union { double d; ll l; } b = { fn(1.5)[0] };
    return b.l;
}
#endif

int main(void) {
    struct f1 s = { { 1.5f } };
    v1d d = { 1.5 };
    struct ff t = { { 1.5f }, 3.0f };
    if (peek_f1(s, 2.5, 7) != 7) return 1;
    if (peek_d1(d, 2.5, 7) != 7) return 2;
    if (peek_ff(t, 2.5, 7) != 7) return 3;
    if (give_f1().v[0] != 1.5f) return 4;
    if (give_d1()[0] != 1.5) return 5;
    if (via_take_f1(take_f1) != 182) return 6;
    if (via_take_d1(take_d1) != 182) return 7;
    if (via_take_ff(take_ff) != 3182) return 8;
    if (via_make_f1(make_f1) != 0x3fc00000) return 9;
    if (via_make_d1(make_d1) != 0x3ff8000000000000) return 10;
    return 0;
}
