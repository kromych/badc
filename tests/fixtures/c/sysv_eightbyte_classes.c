/* System V AMD64 3.2.3: each eightbyte of an aggregate merges the classes
   of the fields overlapping it. One no field overlaps is NO_CLASS and takes
   no register, and a 16-byte vector's high half is SSEUP, so a vector
   beside a double in a union takes one whole xmm register. On x86-64
   System V the naked functions read and set the registers the convention
   assigns, so a badc caller and a badc callee are each checked against
   the convention; elsewhere the same calls go through C. The exit code
   names the first failed check. */

typedef float v4f __attribute__((vector_size(16)));
struct __attribute__((aligned(16))) a1 { double d; };      /* xmm0 */
union a3 { double d; __attribute__((aligned(16))) char c; }; /* rdi */
union a5 { v4f v; double d; };                              /* xmm0, whole */

/* Unnamed bit-fields fill the first eightbyte, so the field that follows
   is carried at offset 8. */
struct b1 { int : 32; int : 32; double d; };
struct b2 { int : 32; int : 32; long long l; };
__attribute__((noinline)) static long take_b1(long k, struct b1 t, long n)
{ return k * 1000 + (long)(t.d * 10) + n; }
__attribute__((noinline)) static long take_b2(struct b2 t, double x, long n)
{ return (long)(t.l * 100 + x * 10) + n; }
__attribute__((noinline)) static struct b1 make_b1(double v) { struct b1 r; r.d = v; return r; }
__attribute__((noinline)) static struct b2 make_b2(long long v) { struct b2 r; r.l = v; return r; }

static long take_a1(struct a1 t, long n) { return (long)(t.d * 100) + n; }
static long take_a3(union a3 t, long n) { return (long)(t.d * 100) + n; }
static double take_a5(union a5 t, double x) { return t.v[0] * 100 + t.v[3] * 10 + x; }

#if defined(__x86_64__) && !defined(_WIN32)
#define NAKED __attribute__((naked))
/* The argument after the aggregate, from the register past its own. */
NAKED static long after_a1(struct a1 t, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
NAKED static long after_a3(union a3 t, long n) { __asm__("movq %rsi, %rax\n\tret\n"); }
NAKED static double after_a5(union a5 t, double x) { __asm__("movaps %xmm1, %xmm0\n\tret\n"); }
/* The result in its registers; the next register of its bank holds -1. */
NAKED static struct a1 ret_a1(void) {
    __asm__("movabsq $0x4004000000000000, %rax\n\tmovq %rax, %xmm0\n\t"
            "movq $-1, %rax\n\tmovq %rax, %xmm1\n\tret\n");
}
NAKED static union a3 ret_a3(void) {
    __asm__("movabsq $0x4004000000000000, %rax\n\tmovq $-1, %rdx\n\tret\n");
}
/* {1.5f, 0, 0, 2.5f} whole in xmm0. */
NAKED static union a5 ret_a5(void) {
    __asm__("movabsq $0x3fc00000, %rax\n\tmovq %rax, %xmm0\n\t"
            "movabsq $0x4020000000000000, %rax\n\tmovq %rax, %xmm1\n\t"
            "punpcklqdq %xmm1, %xmm0\n\tmovq $-1, %rax\n\tmovq %rax, %xmm1\n\tret\n");
}
/* Tail calls into the badc function with the arguments in place: 3.0 and
   42, and {1, 0, 0, 2} then 0.5. */
NAKED static long via_a1(long (*fn)(struct a1, long)) {
    __asm__("movq %rdi, %r11\n\tmovabsq $0x4008000000000000, %rax\n\tmovq %rax, %xmm0\n\t"
            "movq $42, %rdi\n\tmovq $-1, %rsi\n\tjmp *%r11\n");
}
NAKED static long via_a3(long (*fn)(union a3, long)) {
    __asm__("movq %rdi, %r11\n\tmovabsq $0x4008000000000000, %rdi\n\t"
            "movq $42, %rsi\n\tmovq $-1, %rdx\n\tjmp *%r11\n");
}
NAKED static double via_a5(double (*fn)(union a5, double)) {
    __asm__("movq %rdi, %r11\n\tmovabsq $0x3f800000, %rax\n\tmovq %rax, %xmm0\n\t"
            "movabsq $0x4000000000000000, %rax\n\tmovq %rax, %xmm1\n\t"
            "punpcklqdq %xmm1, %xmm0\n\tmovabsq $0x3fe0000000000000, %rax\n\t"
            "movq %rax, %xmm1\n\tjmp *%r11\n");
}
#else
static long after_a1(struct a1 t, long n) { (void)t; return n; }
static long after_a3(union a3 t, long n) { (void)t; return n; }
static double after_a5(union a5 t, double x) { (void)t; return x; }
static struct a1 ret_a1(void) { struct a1 r = { 2.5 }; return r; }
static union a3 ret_a3(void) { union a3 r; r.d = 2.5; return r; }
static union a5 ret_a5(void) { union a5 r; r.v = (v4f){ 1.5f, 0, 0, 2.5f }; return r; }
static long via_a1(long (*fn)(struct a1, long)) { struct a1 t = { 3 }; return fn(t, 42); }
static long via_a3(long (*fn)(union a3, long)) { union a3 t; t.d = 3; return fn(t, 42); }
static double via_a5(double (*fn)(union a5, double)) {
    union a5 t;
    t.v = (v4f){ 1, 0, 0, 2 };
    return fn(t, 0.5);
}
#endif

int main(void) {
    struct a1 t1 = { 3 };
    union a3 t3;
    union a5 t5;
    t3.d = 3;
    t5.v = (v4f){ 1, 0, 0, 2 };
    if (after_a1(t1, 42) != 42) return 1;
    if (after_a3(t3, 42) != 42) return 2;
    if (after_a5(t5, 0.5) != 0.5) return 3;
    if (ret_a1().d != 2.5) return 4;
    if (ret_a3().d != 2.5) return 5;
    t5 = ret_a5();
    if (t5.v[0] != 1.5f || t5.v[3] != 2.5f) return 6;
    if (via_a1(take_a1) != 342) return 7;
    if (via_a3(take_a3) != 342) return 8;
    if (via_a5(take_a5) != 120.5) return 9;
    struct b1 u1;
    struct b2 u2;
    u1.d = 4.5;
    u2.l = 7;
    if (take_b1(3, u1, 2) != 3047) return 10;
    if (take_b2(u2, 0.5, 2) != 707) return 11;
    if (make_b1(2.5).d != 2.5) return 12;
    if (make_b2(9).l != 9) return 13;
    return 0;
}
