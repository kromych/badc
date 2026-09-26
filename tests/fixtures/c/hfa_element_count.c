/* AAPCS64 5.9.5: a homogeneous floating-point aggregate has one element per
   uniquely addressable member -- a union as many as its largest member, a
   struct the sum of its members'. On AArch64 the naked functions read and
   set the registers the convention assigns, so a badc caller and a badc
   callee are each checked against the convention, not against each other;
   elsewhere the same calls go through C. The exit code names the first
   failed check. */

union u1 { double a; double b; };                     /* d0 */
union f3 { float f[3]; struct { float x, y; } p; };   /* s0-s2 */
union d3 { double d[3]; struct { double a, b; } s; }; /* d0-d2, 24 bytes */
struct nest { double x; union { double y; double z[1]; } u; double w; };
struct anon { float a; union { float b; float c; }; }; /* s0, s1 */
union fd { float f; double d; };                      /* no HFA: x0 */

static double take_u1(union u1 u, double x) { return u.b * 10 + x; }
static double take_f3(union f3 u, double x) { return u.f[0] * 100 + u.p.y * 10 + u.f[2] + x; }
static double take_d3(union d3 u, double x) { return u.s.a * 100 + u.s.b * 10 + u.d[2] + x; }
static double take_nest(struct nest s, double x) { return s.x * 100 + s.u.z[0] * 10 + s.w + x; }
static double take_anon(struct anon s, double x) { return s.a * 10 + s.c + x; }
static double take_fd(union fd u, double x) { return u.d * 10 + x; }

/* gcc has no `naked` on AArch64; it takes the C definitions. */
#if defined(__aarch64__) && (defined(__clang__) || !defined(__GNUC__))
#define NAKED __attribute__((naked))
/* The double after the aggregate, from the register past its elements. */
NAKED static double after_u1(union u1 u, double x) { __asm__("fmov d0, d1\n\tret\n"); }
NAKED static double after_f3(union f3 u, double x) { __asm__("fmov d0, d3\n\tret\n"); }
NAKED static double after_d3(union d3 u, double x) { __asm__("fmov d0, d3\n\tret\n"); }
NAKED static double after_nest(struct nest s, double x) { __asm__("fmov d0, d3\n\tret\n"); }
NAKED static double after_anon(struct anon s, double x) { __asm__("fmov d0, d2\n\tret\n"); }
NAKED static double after_fd(union fd u, double x) { __asm__("ret\n"); }
/* Element k in v[k]; the register past the elements holds -1. */
NAKED static union u1 ret_u1(void) { __asm__("fmov d0, #2.5\n\tfmov d1, #-1.0\n\tret\n"); }
NAKED static union f3 ret_f3(void) {
    __asm__("fmov s0, #1.0\n\tfmov s1, #2.0\n\tfmov s2, #3.0\n\tfmov s3, #-1.0\n\tret\n");
}
NAKED static union d3 ret_d3(void) {
    __asm__("fmov d0, #1.0\n\tfmov d1, #2.0\n\tfmov d2, #3.0\n\tfmov d3, #-1.0\n\tret\n");
}
NAKED static struct nest ret_nest(void) {
    __asm__("fmov d0, #1.0\n\tfmov d1, #2.0\n\tfmov d2, #3.0\n\tfmov d3, #-1.0\n\tret\n");
}
NAKED static struct anon ret_anon(void) {
    __asm__("fmov s0, #1.0\n\tfmov s1, #2.0\n\tfmov s2, #-1.0\n\tret\n");
}
/* 0.75 in x0, -1 in d0. */
NAKED static union fd ret_fd(void) {
    __asm__("movz x0, #0x3fe8, lsl #48\n\tfmov d0, #-1.0\n\tret\n");
}
/* Tail calls into the badc function with the arguments in place. */
NAKED static double via_u1(double (*fn)(union u1, double)) {
    __asm__("mov x16, x0\n\tfmov d0, #4.0\n\tfmov d1, #0.5\n\tbr x16\n");
}
NAKED static double via_f3(double (*fn)(union f3, double)) {
    __asm__("mov x16, x0\n\tfmov s0, #1.0\n\tfmov s1, #2.0\n\tfmov s2, #3.0\n\t"
            "fmov d3, #0.5\n\tbr x16\n");
}
NAKED static double via_d3(double (*fn)(union d3, double)) {
    __asm__("mov x16, x0\n\tfmov d0, #1.0\n\tfmov d1, #2.0\n\tfmov d2, #3.0\n\t"
            "fmov d3, #0.5\n\tbr x16\n");
}
NAKED static double via_nest(double (*fn)(struct nest, double)) {
    __asm__("mov x16, x0\n\tfmov d0, #1.0\n\tfmov d1, #2.0\n\tfmov d2, #3.0\n\t"
            "fmov d3, #0.5\n\tbr x16\n");
}
NAKED static double via_anon(double (*fn)(struct anon, double)) {
    __asm__("mov x16, x0\n\tfmov s0, #1.0\n\tfmov s1, #2.0\n\tfmov d2, #0.5\n\tbr x16\n");
}
NAKED static double via_fd(double (*fn)(union fd, double)) {
    __asm__("mov x16, x0\n\tmovz x0, #0x3fe0, lsl #48\n\tfmov d0, #0.25\n\tbr x16\n");
}
#else
static double after_u1(union u1 u, double x) { (void)u; return x; }
static double after_f3(union f3 u, double x) { (void)u; return x; }
static double after_d3(union d3 u, double x) { (void)u; return x; }
static double after_nest(struct nest s, double x) { (void)s; return x; }
static double after_anon(struct anon s, double x) { (void)s; return x; }
static double after_fd(union fd u, double x) { (void)u; return x; }
static union u1 ret_u1(void) { union u1 r = { 2.5 }; return r; }
static union f3 ret_f3(void) { union f3 r = { { 1, 2, 3 } }; return r; }
static union d3 ret_d3(void) { union d3 r = { { 1, 2, 3 } }; return r; }
static struct nest ret_nest(void) { struct nest r = { 1, { 2 }, 3 }; return r; }
static struct anon ret_anon(void) { struct anon r; r.a = 1; r.b = 2; return r; }
static union fd ret_fd(void) { union fd r; r.d = 0.75; return r; }
static double via_u1(double (*fn)(union u1, double)) { union u1 u = { 4 }; return fn(u, 0.5); }
static double via_f3(double (*fn)(union f3, double)) { union f3 u = { { 1, 2, 3 } }; return fn(u, 0.5); }
static double via_d3(double (*fn)(union d3, double)) { union d3 u = { { 1, 2, 3 } }; return fn(u, 0.5); }
static double via_nest(double (*fn)(struct nest, double)) { struct nest s = { 1, { 2 }, 3 }; return fn(s, 0.5); }
static double via_anon(double (*fn)(struct anon, double)) { struct anon s; s.a = 1; s.b = 2; return fn(s, 0.5); }
static double via_fd(double (*fn)(union fd, double)) { union fd u; u.d = 0.5; return fn(u, 0.25); }
#endif

int main(void) {
    union u1 u1 = { 4 };
    union f3 f3 = { { 1, 2, 3 } };
    union d3 d3 = { { 1, 2, 3 } };
    struct nest nest = { 1, { 2 }, 3 };
    struct anon anon;
    union fd fd;
    anon.a = 1;
    anon.b = 2;
    fd.d = 0.5;
    if (after_u1(u1, 0.5) != 0.5) return 1;
    if (after_f3(f3, 0.5) != 0.5) return 2;
    if (after_d3(d3, 0.5) != 0.5) return 3;
    if (after_nest(nest, 0.5) != 0.5) return 4;
    if (after_anon(anon, 0.5) != 0.5) return 5;
    if (after_fd(fd, 0.5) != 0.5) return 6;
    if (ret_u1().a != 2.5) return 7;
    f3 = ret_f3();
    if (f3.f[0] != 1 || f3.p.y != 2 || f3.f[2] != 3) return 8;
    d3 = ret_d3();
    if (d3.s.a != 1 || d3.d[1] != 2 || d3.d[2] != 3) return 9;
    nest = ret_nest();
    if (nest.x != 1 || nest.u.z[0] != 2 || nest.w != 3) return 10;
    anon = ret_anon();
    if (anon.a != 1 || anon.c != 2) return 11;
    if (ret_fd().d != 0.75) return 12;
    if (via_u1(take_u1) != 40.5) return 13;
    if (via_f3(take_f3) != 123.5) return 14;
    if (via_d3(take_d3) != 123.5) return 15;
    if (via_nest(take_nest) != 123.5) return 16;
    if (via_anon(take_anon) != 12.5) return 17;
    if (via_fd(take_fd) != 5.25) return 18;
    return 0;
}
