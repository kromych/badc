/* An aggregate with no member of storage -- empty, a zero-width bit-field,
   a zero-length array, or only such aggregates -- takes no register and no
   stack slot on System V x86-64 and AAPCS64, as a named or a variadic
   argument, and no register as a result: gcc passes it so on x86-64 and
   clang on both. Microsoft x64 gives it 4 bytes and a slot. Each call
   checks the arguments around the empty ones. The exit code names the first
   failed check. */
#include <stdarg.h>

struct E {};
union U {};
struct B { int :0; };
struct Z { char a[0]; };
struct N { struct E x; struct E y[3]; };

__attribute__((noinline)) static struct E mk(int y, int *out) {
    struct E e;
    *out = y;
    return e;
}

__attribute__((noinline)) static int first(struct E e, int y) {
    (void)e;
    return y;
}

__attribute__((noinline)) static int mid(int a, union U u, int b, struct B c, double d,
                                         struct Z z, int e) {
    (void)u;
    (void)c;
    (void)z;
    return a * 1000 + b * 100 + (int)d * 10 + e;
}

__attribute__((noinline)) static long last(int a, long b, struct N n) {
    (void)n;
    return a + b;
}

__attribute__((noinline)) static double fp(double x, struct E e, float y, struct Z z,
                                           double w) {
    (void)e;
    (void)z;
    return x + y + w;
}

__attribute__((noinline)) static int var(int n, ...) {
    va_list ap;
    va_start(ap, n);
    int a = va_arg(ap, int);
    struct E e = va_arg(ap, struct E);
    int b = va_arg(ap, int);
    struct N m = va_arg(ap, struct N);
    double d = va_arg(ap, double);
    va_end(ap);
    (void)e;
    (void)m;
    return n + a * 10 + b * 100 + (int)d * 1000;
}

int main(void) {
    struct E e;
    union U u;
    struct B c;
    struct Z z;
    struct N n;
    int got = 0;
    struct E r = mk(7, &got);
    (void)r;
    if (got != 7)
        return 1;
    if (first(e, 42) != 42)
        return 2;
    if (mid(1, u, 2, c, 3.0, z, 4) != 1234)
        return 3;
    if (last(5, 6, n) != 11)
        return 4;
    if (fp(1.5, e, 2.25f, z, 4.0) != 7.75)
        return 5;
    if (var(1, 2, e, 3, n, 4.0) != 4321)
        return 6;
    return 0;
}
