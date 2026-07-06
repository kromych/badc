// A variadic callee reached through a function pointer keeps the host
// variadic placement (C99 6.5.2.2p7; the pointee prototype's ellipsis
// selects the variadic protocol at the call site). Mixed int/double
// varargs exercise both banks and the stack tail.

#include <stdarg.h>

static double vsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double acc = 0.0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            acc += (double)va_arg(ap, int);
        } else {
            acc += va_arg(ap, double);
        }
    }
    va_end(ap);
    return acc;
}

typedef double (*vf)(int, ...);

int main(void) {
    vf p = vsum;
    double r = p(4, 1, 2.5, 3, 4.25);
    if (r != 10.75) return 1;
    if (r != vsum(4, 1, 2.5, 3, 4.25)) return 2;
    return 0;
}
