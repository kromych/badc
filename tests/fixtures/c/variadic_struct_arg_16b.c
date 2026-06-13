// A variadic struct wider than one eightbyte rides by value (C99 6.5.2.2
// plus the host ABI): its eightbytes occupy consecutive argument
// registers / save-area slots, and the callee's va_arg advances the
// cursor by the struct's eightbyte span. The b-field is weighted so a
// half-stride advance (reading the second eightbyte of one struct as the
// first of the next) yields a different total.
// sumv(3, {3,4}, {5,6}, {7,8}) = (3+8) + (5+12) + (7+16) = 51.
#include <stdarg.h>

struct B {
    long a, b;
};

static long sumv(int n, ...) {
    va_list ap;
    va_start(ap, n);
    long t = 0;
    for (int i = 0; i < n; i++) {
        struct B p = va_arg(ap, struct B);
        t += p.a + p.b * 2;
    }
    va_end(ap);
    return t;
}

int main(void) {
    struct B x = {3, 4}, y = {5, 6}, z = {7, 8};
    return (int)sumv(3, x, y, z);
}
