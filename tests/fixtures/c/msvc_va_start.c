// MSVC's <vadefs.h> starts a `va_list` with `__va_start`, which the compiler
// lowers: `__va_start(&ap, last)` on x64, `__va_start(&ap, &last, slot size,
// alignment, &last)` on arm64. The list is a cursor over 8-byte slots: the
// first variadic argument follows the named ones, in the register home area
// or on the stack past it. Off the PE targets the unit checks nothing.

#ifdef _WIN32
typedef char *va_list;
void __cdecl __va_start(va_list *, ...);
#if defined(__aarch64__)
#define SLOT(t) ((sizeof(t) + 7) & ~7)
#define VA_START(ap, v) ((void)(__va_start(&ap, &(v), SLOT(v), __alignof(v), &(v))))
#else
#define VA_START(ap, v) ((void)(__va_start(&ap, v)))
#endif
#define VA_ARG(ap, t) (*(t *)((ap += 8) - 8))

static int sum(int n, ...) {
    va_list ap;
    int s = 0;
    VA_START(ap, n);
    while (n--)
        s += VA_ARG(ap, int);
    return s;
}

static long long past_registers(int a, int b, int c, int d, int e, int f, int g,
                                int h, int i, ...) {
    va_list ap;
    VA_START(ap, i);
    long long x = VA_ARG(ap, long long);
    double y = VA_ARG(ap, double);
    return x + (long long)y + a + b + c + d + e + f + g + h + i;
}

static int through_pointer(int n, ...) {
    va_list ap, *p = &ap;
#if defined(__aarch64__)
    __va_start(p, &n, SLOT(n), __alignof(n), &n);
#else
    __va_start(p, n);
#endif
    int tens = VA_ARG(ap, int);
    return tens * 10 + VA_ARG(ap, int);
}

int main(void) {
    if (sum(3, 1, 2, 3) != 6)
        return 1;
    if (past_registers(1, 2, 3, 4, 5, 6, 7, 8, 9, 100LL, 20.0) != 165)
        return 2;
    if (through_pointer(2, 4, 2) != 42)
        return 3;
    return 0;
}
#else
int main(void) { return 0; }
#endif
