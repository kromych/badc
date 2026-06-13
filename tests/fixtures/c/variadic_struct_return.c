// A variadic function may return a struct by value (AAPCS64 / System V
// AMD64): the result rides the result registers (<=16 bytes) just as a
// non-variadic struct return does. The call lowering must recover those
// registers into the caller's result temp; the variadic call paths
// previously emitted only the scalar return bridge, dropping the
// aggregate (a near-null deref of the unwritten result, and corrupted
// values).

#include <stdarg.h>

struct S8 { long a; };
struct S16 { long a, b; };

static struct S8 v8(int ctx, const char *fmt, ...) {
    struct S8 v;
    v.a = 9;
    return v;
}

static struct S16 v16(int ctx, const char *fmt, ...) {
    struct S16 v;
    v.a = 11;
    v.b = 22;
    return v;
}

// The variadic argument must still reach the callee's va_list while the
// struct return rides the result registers.
static struct S16 sum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct S16 v;
    v.a = 0;
    v.b = 0;
    for (int i = 0; i < n; i++) {
        v.a += va_arg(ap, int);
    }
    va_end(ap);
    v.b = n;
    return v;
}

int main(void) {
    struct S8 a = v8(0, "x", 1, 2);
    if (a.a != 9) return 1;

    struct S16 b = v16(0, "y", 3);
    if (b.a != 11 || b.b != 22) return 2;

    struct S16 c = sum(4, 10, 20, 30, 40);
    if (c.a != 100 || c.b != 4) return 3;

    return 0;
}
