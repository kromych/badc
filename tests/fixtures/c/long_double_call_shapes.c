// A `long double` crosses a call as an argument, a return value, a
// variadic argument and an aggregate member: bare, as a struct's only
// member, in a larger struct and in a union with a `double`, through
// direct calls and pointers, and into the callers that inline the static
// functions below. An argument of another floating type converts to a
// `long double` parameter, and a `long double` one to a `double`
// parameter, through a pointer as directly. The exit code names the first
// check that fails.

#include <stdarg.h>

#define NOINLINE __attribute__((noinline))

struct ld1 { long double x; };
struct ld2 { long double x, y; };
struct nest { struct ld1 in; };
union ldu { long double x; double d; };

NOINLINE static long double ret_ld(long double a) { return a * 2; }
NOINLINE static long double ret_int(void) { return 7; }
NOINLINE static long double ret_float(float f) { return f; }
NOINLINE static struct ld1 mk1(long double v)
{
    struct ld1 s = {v};
    return s;
}
NOINLINE static struct ld2 mk2(long double a, long double b)
{
    struct ld2 s = {a, b};
    return s;
}
NOINLINE static struct nest mkn(long double v)
{
    struct nest s = {{v}};
    return s;
}
NOINLINE static union ldu mku(long double v)
{
    union ldu u;
    u.x = v;
    return u;
}
NOINLINE static long double take1(struct ld1 s) { return s.x + 1; }
NOINLINE static long double take2(struct ld2 s) { return s.x - s.y; }
NOINLINE static long double many(int a, long double b, double c, long double d, int e,
                                 long double f)
{
    return a + b + c + d + e + f;
}
// Nine doubles and seven ints fill the registers; `x` and `y` follow on
// the stack, each after an 8-byte argument.
NOINLINE static long double past(double d0, double d1, double d2, double d3, double d4,
                                 double d5, double d6, double d7, double d8, long double x,
                                 int i0, int i1, int i2, int i3, int i4, int i5, int i6,
                                 long double y)
{
    return d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + x + i0 + i1 + i2 + i3 + i4 + i5 + i6 + y;
}
NOINLINE static long double vsum(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    long double s = 0;
    for (int i = 0; i < n; i++) s += va_arg(ap, long double);
    va_end(ap);
    return s;
}
NOINLINE static long double vmix(int n, long double first, ...)
{
    va_list ap;
    va_start(ap, first);
    long double s = first;
    for (int i = 0; i < n; i++) {
        s += va_arg(ap, int);
        s += va_arg(ap, long double);
        s += va_arg(ap, double);
    }
    va_end(ap);
    return s;
}

static long double sq(long double x) { return x * x; }
static struct ld1 wrap(long double v)
{
    struct ld1 s = {v};
    return s;
}
static long double unwrap(struct ld1 s) { return s.x; }
static long double pick(int c, long double a, long double b)
{
    if (c) return a;
    return b;
}
static long double first(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    long double v = va_arg(ap, long double);
    va_end(ap);
    return v + n;
}
static long double rec(int n, long double acc) { return n ? rec(n - 1, acc * 2) : acc; }

NOINLINE static double halve(double v) { return v / 2; }

static long double (*fp_ret)(long double) = ret_ld;
static double (*fp_halve)(double) = halve;
static struct ld1 (*fp_mk1)(long double) = mk1;
static long double (*fp_vsum)(int, ...) = vsum;

int main(void)
{
    volatile long double three = 3.0L;
    if (ret_ld(three) != 6.0L) return 1;
    if (ret_int() != 7.0L) return 2;
    if (ret_float(1.5f) != 1.5L) return 3;
    if (mk1(2.5L).x != 2.5L) return 4;
    struct ld2 p = mk2(1.25L, 0.5L);
    if (p.x != 1.25L || p.y != 0.5L) return 5;
    if (mkn(4.0L).in.x != 4.0L) return 6;
    if (mku(8.0L).x != 8.0L) return 7;
    struct ld1 s1 = {10.0L};
    if (take1(s1) != 11.0L) return 8;
    if (take2(p) != 0.75L) return 9;
    if (many(1, 2.0L, 3.0, 4.0L, 5, 6.0L) != 21.0L) return 10;
    if (past(1, 2, 3, 4, 5, 6, 7, 8, 9, 10.0L, 1, 1, 1, 1, 1, 1, 1, 0.5L) != 62.5L) return 11;
    if (vsum(3, 1.0L, 2.0L, 4.0L) != 7.0L) return 12;
    if (vmix(2, 0.5L, 1, 2.0L, 3.0, 4, 5.0L, 6.0) != 21.5L) return 13;
    if (fp_ret(1.5L) != 3.0L) return 14;
    if (fp_mk1(9.0L).x != 9.0L) return 15;
    if (fp_vsum(9, 1.0L, 1.0L, 1.0L, 1.0L, 1.0L, 1.0L, 1.0L, 1.0L, 0.5L) != 8.5L) return 16;
    volatile int one = 1;
    if (sq(three) != 9) return 17;
    if (unwrap(wrap(three)) != 3) return 18;
    long double t = 0;
    for (int i = 0; i < 4; i++) t += sq(i);
    if (t != 14) return 19;
    if (pick(one, three, 5) != 3 || pick(!one, three, 5) != 5) return 20;
    if (first(2, three) != 5) return 21;
    if (rec(3, three) != 24) return 22;
    struct ld1 w = wrap(sq(three) + unwrap(wrap(1)));
    if (w.x != 10) return 23;
    volatile double d = 1.5;
    volatile float f = 0.5f;
    if (fp_ret(d) != 3.0L || fp_ret(f) != 1.0L || fp_ret(2) != 4.0L) return 24;
    if (fp_halve(three) != 1.5) return 25;
    if (ret_ld(d) != 3.0L || halve(three) != 1.5) return 26;
    return 0;
}
