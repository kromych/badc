/* AAPCS64 B.4 / C.3: a variadic homogeneous floating-point aggregate rides
   the SIMD registers, one per element, and the stack once they run out; an
   aggregate that does not fit the registers left goes to the stack and
   exhausts them. `va_arg` reads each element from its own 16-byte slot of
   the vector save area. macOS and Windows pass it in memory or the integer
   bank and walk one cursor. The exit code names the first failed check. */
#include <stdarg.h>

struct d2 { double x, y; };
struct f4 { float a, b, c, d; };
struct d3 { double a, b, c; };
struct ld1 { long double v; };
union u1 { double a; double b; };

static double sum_d2(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct d2 p = va_arg(ap, struct d2);
        s = s * 100 + p.x * 10 + p.y;
    }
    va_end(ap);
    return s;
}

static double sum_f4(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct f4 q = va_arg(ap, struct f4);
        s = s * 10000 + q.a * 1000 + q.b * 100 + q.c * 10 + q.d;
    }
    va_end(ap);
    return s;
}

/* TODO: Windows AArch64 passes a variadic composite over 16 bytes by
   reference, which the call lowering does not emit yet. */
#if !(defined(_WIN32) && defined(__aarch64__))
#define OVER_16 1
/* A double, three three-element aggregates and a double: the third
   aggregate finds one register left and goes to the stack, the double
   after it too. */
static double straddle(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = va_arg(ap, double);
    for (int i = 0; i < n; i++) {
        struct d3 t = va_arg(ap, struct d3);
        s = s * 1000 + t.a * 100 + t.b * 10 + t.c;
    }
    s = s * 10 + va_arg(ap, double);
    va_end(ap);
    return s;
}
#endif

static long double last_ld(int n, ...) {
    va_list ap;
    struct ld1 l = { 0 };
    va_start(ap, n);
    for (int i = 0; i < n; i++) l = va_arg(ap, struct ld1);
    va_end(ap);
    return l.v;
}

static double mixed(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        int k = va_arg(ap, int);
        union u1 u = va_arg(ap, union u1);
        s = s * 100 + k * 10 + u.b;
    }
    va_end(ap);
    return s;
}

/* Two traversals of the same arguments, the second through a copy taken
   before the first: reading an aggregate leaves the save area as it was. */
static double twice(int n, ...) {
    va_list ap, again;
    double s = 0, t = 0;
    va_start(ap, n);
    va_copy(again, ap);
    for (int i = 0; i < n; i++) {
        struct d2 p = va_arg(ap, struct d2);
        s = s * 100 + p.x * 10 + p.y;
    }
    for (int i = 0; i < n; i++) {
        struct d2 p = va_arg(again, struct d2);
        t = t * 100 + p.x * 10 + p.y;
    }
    va_end(again);
    va_end(ap);
    return s == t ? s : -1;
}

int main(void) {
    struct d2 a = { 1, 2 }, b = { 3, 4 }, c = { 5, 6 }, d = { 7, 8 }, e = { 9, 1 };
    struct f4 f = { 1, 2, 3, 4 }, g = { 5, 6, 7, 8 }, h = { 9, 8, 7, 6 };
    struct ld1 l1 = { 2.5L }, l2 = { 7.25L };
    union u1 u = { 3 }, v = { 4 };
    if (sum_d2(1, a) != 12) return 1;
    if (sum_d2(2, a, b) != 1234) return 2;
    if (sum_d2(5, a, b, c, d, e) != 1234567891) return 3;
    if (sum_f4(1, f) != 1234) return 4;
    if (sum_f4(3, f, g, h) != 123456789876.0) return 5;
#ifdef OVER_16
    struct d3 p = { 1, 2, 3 }, q = { 4, 5, 6 }, r = { 7, 8, 9 };
    if (straddle(3, 0.5, p, q, r, 2.0) != 6234567892.0) return 6;
#endif
    if (last_ld(2, l1, l2) != 7.25L) return 7;
    if (last_ld(9, l1, l1, l1, l1, l1, l1, l1, l1, l2) != 7.25L) return 8;
    if (mixed(2, 1, u, 2, v) != 1324) return 9;
    if (twice(5, a, b, c, d, e) != 1234567891) return 10;
    return 0;
}
