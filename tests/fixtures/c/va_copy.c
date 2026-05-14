// Locks C99 7.15.1.2 -- `va_copy(dst, src)` initialises `dst`
// to the same position in the variadic list as `src`. With
// c5's `va_list` defined as a plain cursor, the copy is a
// pointer assignment that yields an independent walker over
// the same arguments.
//
// The fixture verifies that a single walk through a copy
// observes the same values as the original cursor would. That
// is the exact shape tinycc's preprocessor reaches for when a
// macro-expansion error path needs to re-read the varargs.

#include <stdarg.h>

static int sum_via_copy(int count, ...) {
    va_list a;
    va_list b;
    va_start(a, count);
    va_copy(b, a);
    int s = 0;
    int i = 0;
    while (i < count) {
        s = s + va_arg(b, int);
        i = i + 1;
    }
    va_end(b);
    va_end(a);
    return s;
}

int main(void) {
    if (sum_via_copy(4, 10, 20, 30, 40) != 100) return 11;
    return 0;
}
