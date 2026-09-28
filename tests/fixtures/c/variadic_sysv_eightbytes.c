/* System V AMD64 3.5.7: va_arg of an aggregate in registers takes each
   eightbyte from the save area of its class -- INTEGER ones from the
   general area, SSE ones 16 bytes apart from the vector area, the SSEUP
   half of a vector from the same slot -- and takes the whole aggregate
   from the overflow area when either area has too few left, the other
   area's registers staying for later arguments. An x87 aggregate is in the
   overflow area. The same calls hold on every target. The exit code names
   the first failed check. */
#include <stdarg.h>

typedef float v4f __attribute__((vector_size(16)));
struct ld { long long l; double d; };                  /* INTEGER, SSE */
struct dl { double d; long long l; };                  /* SSE, INTEGER */
struct ffl { float a, b; long long l; };               /* SSE, INTEGER */
struct __attribute__((aligned(16))) ad { double d; };  /* SSE */
struct __attribute__((aligned(16))) ai { int a; };     /* INTEGER */
union vd { v4f v; double d; };                         /* SSE + SSEUP */
struct x87 { long double x; };                         /* memory */

static double sum_ld(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        struct ld t = va_arg(ap, struct ld);
        s = s * 100 + t.l * 10 + t.d;
    }
    va_end(ap);
    return s;
}

static double mixed(int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct dl a = va_arg(ap, struct dl);
    struct ffl b = va_arg(ap, struct ffl);
    struct ad c = va_arg(ap, struct ad);
    struct ai d = va_arg(ap, struct ai);
    union vd e = va_arg(ap, union vd);
    struct x87 f = va_arg(ap, struct x87);
    long long g = va_arg(ap, long long);
    va_end(ap);
    return n + a.d * 1e8 + a.l * 1e7 + (b.a + b.b) * 1e6 + b.l * 1e5 + c.d * 1e4 + d.a * 1e3 +
           e.v[3] * 100 + (double)f.x * 10 + g;
}

/* Eight doubles use up the vector area: the aggregate after them comes from
   the overflow area whole, and the integer after it from the general area. */
static double after_fp(int n, ...) {
    va_list ap;
    double s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) s += va_arg(ap, double);
    struct ld t = va_arg(ap, struct ld);
    long long k = va_arg(ap, long long);
    va_end(ap);
    return s * 1000 + t.l * 100 + t.d * 10 + k;
}

int main(void) {
    struct ld p = { 1, 2 }, q = { 3, 4 }, r = { 5, 6 }, u = { 7, 8 }, v = { 9, 1 }, w = { 2, 3 },
              x = { 4, 5 };
    struct dl a = { 1, 2 };
    struct ffl b = { 1, 2, 4 };
    struct ad c = { 5 };
    struct ai d = { 6 };
    union vd e;
    struct x87 f = { 8.5L };
    e.v = (v4f){ 0, 0, 0, 7 };
    if (sum_ld(1, p) != 12) return 1;
    if (sum_ld(3, p, q, r) != 123456) return 2;
    /* The first five fit the general area left after `n`; two more spill. */
    if (sum_ld(7, p, q, r, u, v, w, x) != 12345678912345.0) return 3;
    if (mixed(9, a, b, c, d, e, f, 3LL) != 9 + 1e8 + 2e7 + 3e6 + 4e5 + 5e4 + 6e3 + 700 + 85 + 3)
        return 4;
    if (after_fp(8, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, p, 3LL) != 8123) return 5;
    return 0;
}
