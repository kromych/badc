// A 16-byte aggregate passed by value as a named parameter of a
// variadic function. AAPCS64 6.4.1 / System V AMD64 3.2.3: the named
// parameters follow the standard register convention (the struct rides
// two integer registers) and the variadic tail follows the platform
// variadic ABI. The callee must read the struct from its registers, not
// as a caller-supplied address. A real-world shape is a small struct
// argument before a `printf`-style format and its variadic tail.

#include <stdio.h>
#include <stdarg.h>

struct loc {
    int lineno, col, end_lineno, end_col;
};

__attribute__((noinline)) static long
warn(void *c, struct loc l, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int extra = va_arg(ap, int);
    va_end(ap);
    long sum = (long) (size_t) c + l.lineno + l.col + l.end_lineno + l.end_col
               + (long) fmt[0] + extra;
    return sum;
}

int main(void) {
    struct loc l = {10, 20, 30, 40};
    long r = warn((void *) 0, l, "h", 99);
    // 0 + 10 + 20 + 30 + 40 + 'h'(104) + 99 = 303
    if (r != 303) {
        printf("FAIL r=%ld\n", r);
        return 1;
    }
    printf("ok r=%ld\n", r);
    return 0;
}
