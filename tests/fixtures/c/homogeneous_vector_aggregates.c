/* AAPCS64 5.9.5: an aggregate of one to four short vectors of one width
   (8 or 16 bytes, whatever their element types), a union counting its
   largest member once, is a homogeneous short-vector aggregate: one SIMD
   register per vector as an argument and as a result, one 16-byte slot
   of the vector save area per vector for va_arg. A vector beside a
   scalar of its size is not. On AArch64 the naked functions read and set
   the registers the convention assigns, so a badc caller and a badc callee
   are each checked against it; gcc, which has no `naked` there, and the
   other targets take the same calls in C. The exit code names the first
   failed check. gcc 16.2.1 at -O2 on AArch64 reads the variadic ones wrong
   and exits 12; with -fdisable-tree-stdarg it exits 0. */
#include <stdarg.h>

typedef float v4f __attribute__((vector_size(16)));
typedef int v4i __attribute__((vector_size(16)));
typedef float v2f __attribute__((vector_size(8)));
union v1 { v4f v; v4f w; };                          /* q0 */
struct s2 { v4f a; v4i b; };                         /* q0, q1 */
struct d3 { v2f a, b, c; };                          /* d0-d2 */
struct x2 { v2f a; double d; };                      /* no HVA: x0, x1 */

static double take_v1(union v1 u, double x) { return u.w[0] * 100 + u.v[3] * 10 + x; }
static double take_s2(struct s2 s, double x) { return s.a[3] * 100 + s.b[2] * 10 + x; }
static double take_d3(struct d3 d, double x) { return d.a[0] * 100 + d.b[0] * 10 + d.c[1] + x; }
static double take_x2(struct x2 s, double x) { return s.a[1] * 100 + s.d * 10 + x; }

#if defined(__aarch64__) && (defined(__clang__) || !defined(__GNUC__))
#define NAKED __attribute__((naked))
/* The double after the aggregate, from the register past its vectors. */
NAKED static double after_v1(union v1 u, double x) { __asm__("fmov d0, d1\n\tret\n"); }
NAKED static double after_s2(struct s2 s, double x) { __asm__("fmov d0, d2\n\tret\n"); }
NAKED static double after_d3(struct d3 d, double x) { __asm__("fmov d0, d3\n\tret\n"); }
NAKED static double after_x2(struct x2 s, double x) { __asm__("ret\n"); }
/* {1, 0, 0, 2} in q0; the next vector register holds -1. */
NAKED static union v1 ret_v1(void) {
    __asm__("fmov s0, #1.0\n\tfmov s1, #2.0\n\tmov v0.s[3], v1.s[0]\n\t"
            "fmov s1, #-1.0\n\tret\n");
}
/* {1, 0, 0, 2} in q0 and {3, 3, 3, 3} in q1. */
NAKED static struct s2 ret_s2(void) {
    __asm__("fmov s0, #1.0\n\tfmov s1, #2.0\n\tmov v0.s[3], v1.s[0]\n\t"
            "movi v1.4s, #3\n\tfmov s2, #-1.0\n\tret\n");
}
/* {1, 0}, {2, 0}, {3, 0} in d0-d2. */
NAKED static struct d3 ret_d3(void) {
    __asm__("fmov s0, #1.0\n\tfmov s1, #2.0\n\tfmov s2, #3.0\n\tfmov s3, #-1.0\n\tret\n");
}
/* Tail calls into the badc function with the arguments in place. */
NAKED static double via_v1(double (*fn)(union v1, double)) {
    __asm__("mov x16, x0\n\tfmov s0, #3.0\n\tfmov s1, #4.0\n\tmov v0.s[3], v1.s[0]\n\t"
            "fmov d1, #0.5\n\tbr x16\n");
}
NAKED static double via_s2(double (*fn)(struct s2, double)) {
    __asm__("mov x16, x0\n\tfmov s0, #3.0\n\tfmov s1, #4.0\n\tmov v0.s[3], v1.s[0]\n\t"
            "movi v1.4s, #5\n\tfmov d2, #0.5\n\tbr x16\n");
}
NAKED static double via_d3(double (*fn)(struct d3, double)) {
    __asm__("mov x16, x0\n\tfmov s0, #3.0\n\tfmov s1, #4.0\n\tmovi v2.2s, #0\n\t"
            "fmov s3, #5.0\n\tmov v2.s[1], v3.s[0]\n\tfmov d3, #0.5\n\tbr x16\n");
}
#else
static double after_v1(union v1 u, double x) { (void)u; return x; }
static double after_s2(struct s2 s, double x) { (void)s; return x; }
static double after_d3(struct d3 d, double x) { (void)d; return x; }
static double after_x2(struct x2 s, double x) { (void)s; return x; }
static union v1 ret_v1(void) { union v1 r; r.v = (v4f){ 1, 0, 0, 2 }; return r; }
static struct s2 ret_s2(void) {
    struct s2 r;
    r.a = (v4f){ 1, 0, 0, 2 };
    r.b = (v4i){ 3, 3, 3, 3 };
    return r;
}
static struct d3 ret_d3(void) {
    struct d3 r;
    r.a = (v2f){ 1, 0 };
    r.b = (v2f){ 2, 0 };
    r.c = (v2f){ 3, 0 };
    return r;
}
static double via_v1(double (*fn)(union v1, double)) {
    union v1 u;
    u.v = (v4f){ 3, 0, 0, 4 };
    return fn(u, 0.5);
}
static double via_s2(double (*fn)(struct s2, double)) {
    struct s2 s;
    s.a = (v4f){ 3, 0, 0, 4 };
    s.b = (v4i){ 5, 5, 5, 5 };
    return fn(s, 0.5);
}
static double via_d3(double (*fn)(struct d3, double)) {
    struct d3 d;
    d.a = (v2f){ 3, 0 };
    d.b = (v2f){ 4, 0 };
    d.c = (v2f){ 0, 5 };
    return fn(d, 0.5);
}
#endif

static double sum_v1(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        union v1 u = va_arg(ap, union v1);
        s = s * 100 + u.w[0] * 10 + u.v[3];
    }
    va_end(ap);
    return s;
}

static double sum_s2(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct s2 t = va_arg(ap, struct s2);
        s = s * 1000 + t.a[3] * 100 + t.b[1] * 10 + t.a[0];
    }
    va_end(ap);
    return s;
}
static double sum_d3(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct d3 t = va_arg(ap, struct d3);
        s = s * 1000 + t.a[0] * 100 + t.b[1] * 10 + t.c[0];
    }
    va_end(ap);
    return s;
}

int main(void) {
    union v1 u;
    struct s2 s;
    struct d3 d;
    struct x2 x;
    u.v = (v4f){ 1, 0, 0, 2 };
    s.a = (v4f){ 1, 0, 0, 2 };
    s.b = (v4i){ 3, 3, 3, 3 };
    d.a = (v2f){ 1, 0 };
    d.b = (v2f){ 2, 3 };
    d.c = (v2f){ 4, 0 };
    x.a = (v2f){ 1, 2 };
    x.d = 3;
    if (after_v1(u, 0.5) != 0.5) return 1;
    if (after_s2(s, 0.5) != 0.5) return 2;
    if (after_d3(d, 0.5) != 0.5) return 3;
    if (after_x2(x, 0.5) != 0.5) return 4;
    union v1 rv = ret_v1();
    if (rv.v[0] != 1 || rv.w[3] != 2) return 5;
    struct s2 rs = ret_s2();
    if (rs.a[0] != 1 || rs.a[3] != 2 || rs.b[2] != 3) return 6;
    struct d3 rd = ret_d3();
    if (rd.a[0] != 1 || rd.b[0] != 2 || rd.c[0] != 3) return 7;
    if (via_v1(take_v1) != 340.5) return 8;
    if (via_s2(take_s2) != 450.5) return 9;
    if (via_d3(take_d3) != 345.5) return 10;
    if (take_x2(x, 0.5) != 230.5) return 11;
    if (sum_v1(3, u, u, u) != 121212) return 12;
    if (sum_s2(3, s, s, s) != 231231231) return 13;
    if (sum_d3(5, d, d, d, d, d) != 134134134134134.0) return 14;
    return 0;
}
