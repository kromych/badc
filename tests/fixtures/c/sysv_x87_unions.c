/* System V AMD64 3.2.3: overlapping `long double` members merge to one
   X87 + X87UP eightbyte pair, so an aggregate of them returns in st(0) and
   is passed in memory; beside an integer member the pair breaks and the
   aggregate is MEMORY class both ways. On x86-64 System V the naked
   functions read and set the registers the convention assigns, so a badc
   caller and a badc callee are each checked against the convention;
   elsewhere the same calls go through C. The exit code names the first
   failed check. */

union u2 { long double a; long double b; };
union u1 { long double x; long double y[1]; };
struct s1 { union { long double a; long double b; } u; };
union m1 { long double x; long long l; };

__attribute__((noinline)) static union u2 make_u2(void) { union u2 r; r.a = 2.5L; return r; }
__attribute__((noinline)) static union u1 make_u1(void) { union u1 r; r.x = 3.5L; return r; }
__attribute__((noinline)) static struct s1 make_s1(void) { struct s1 r; r.u.a = 4.5L; return r; }
__attribute__((noinline)) static long double take_u2(union u2 t, long n) { return t.b * 10 + n; }
__attribute__((noinline)) static long double take_s1(long k, struct s1 t, long n)
{ return k * 100 + t.u.b * 10 + n; }
__attribute__((noinline)) static union m1 swap_m1(union m1 t, long n)
{ union m1 r; r.x = t.x + n; return r; }

#if defined(__x86_64__) && !defined(_WIN32)
#define NAKED __attribute__((naked))
/* The integer after the aggregate arrives in rdi: the aggregate is on the
   stack. */
NAKED static long after_u2(union u2 t, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
NAKED static long after_s1(struct s1 t, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
/* 2.5 in st(0), loaded through the red zone. */
NAKED static union u2 ret_u2(void) {
    __asm__("movabsq $0x4004000000000000, %rax\n\tmovq %rax, -8(%rsp)\n\t"
            "fldl -8(%rsp)\n\tret\n");
}
/* The callee's result as a `long double`: a result in st(0) stays there. A
   buffer in rdi takes the store of a callee that returns through memory,
   which leaves st(0) empty. */
NAKED static long double via_u2(union u2 (*fn)(void)) {
    __asm__("movq %rdi, %rax\n\tsubq $24, %rsp\n\tmovq %rsp, %rdi\n\tcall *%rax\n\t"
            "addq $24, %rsp\n\tret\n");
}
NAKED static long double via_s1(struct s1 (*fn)(void)) {
    __asm__("movq %rdi, %rax\n\tsubq $24, %rsp\n\tmovq %rsp, %rdi\n\tcall *%rax\n\t"
            "addq $24, %rsp\n\tret\n");
}
#else
static long after_u2(union u2 t, long n) { (void)t; return n; }
static long after_s1(struct s1 t, long n) { (void)t; return n; }
static union u2 ret_u2(void) { union u2 r; r.a = 2.5L; return r; }
static long double via_u2(union u2 (*fn)(void)) { return fn().b; }
static long double via_s1(struct s1 (*fn)(void)) { return fn().u.b; }
#endif

int main(void) {
    union u2 t2;
    struct s1 s;
    union m1 m;
    t2.a = 1.5L;
    s.u.a = 2.5L;
    m.x = 0.5L;
    if (after_u2(t2, 42) != 42) return 1;
    if (after_s1(s, 42) != 42) return 2;
    if (ret_u2().b != 2.5L) return 3;
    if (via_u2(make_u2) != 2.5L) return 4;
    if (via_s1(make_s1) != 4.5L) return 5;
    if (make_u1().y[0] != 3.5L) return 6;
    if (take_u2(t2, 3) != 18.0L) return 7;
    if (take_s1(7, s, 3) != 728.0L) return 8;
    if (swap_m1(m, 2).x != 2.5L) return 9;
    return 0;
}
