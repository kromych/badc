// A struct passed as a variadic argument rides by value (C99 6.5.2.2
// plus the host ABI): its eightbyte occupies the register save area /
// stack slot that va_arg reads, not a c5 address-as-value pointer.
// sumv(2, {3,4}, {5,6}) = 3+4+5+6 = 18.
#include <stdarg.h>

struct P {
    int a, b;
};

static int sumv(int n, ...) {
    va_list ap;
    va_start(ap, n);
    int t = 0;
    for (int i = 0; i < n; i++) {
        struct P p = va_arg(ap, struct P);
        t += p.a + p.b;
    }
    va_end(ap);
    return t;
}

int main(void) {
    struct P x = {3, 4}, y = {5, 6};
    return sumv(2, x, y);
}
