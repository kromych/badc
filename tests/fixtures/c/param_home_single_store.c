/* C99 6.5.2.2p4: a parameter is an object with automatic storage whose
 * initial value is its argument's. At -O0 the body seeds that object at
 * the declared width before reading it back, so the prologue's
 * full-register store into the same frame cell has no reader (C99
 * 6.2.4p2) and is not emitted; the cell keeps the size the ABI reserves
 * for it.
 *
 * Two shapes still need the full-register store and are covered here:
 * a parameter whose address escapes and is read back through a wider
 * type, and a variadic callee's register save area, which `va_arg`
 * reads an eightbyte at a time whatever the named parameters' widths.
 *
 * Returns 42 on success; the failing check's 1-based index otherwise. */

#include <stdarg.h>

typedef unsigned char u8;
typedef unsigned short u16;

/* Integer register scalars at four declared widths. `signed char`, not
   plain `char`: the psABI picks that one's signedness, unsigned on
   AArch64 Linux and signed on x86_64 and on Apple's arm64, so a
   negative argument in a plain `char` reads back differently per
   target. */
static long widths(signed char a, short b, int c, long d, u8 e, u16 f) {
    return (long)a + b + c + d + e + f;
}

/* Both register banks, plus a parameter past the integer bank on Win64. */
static double banks(int a, double b, float c, long d, double e) {
    return a + b + (double)c + d + e;
}

/* The address escapes, and the object is read back through a wider
 * type: the whole cell is observed, so the incoming register's bytes
 * must reach it. */
static long escapes(long a) {
    long *p = &a;
    *p += 1;
    return *p;
}

/* The body overwrites the parameter before reading it. */
static int reassigned(int a) {
    a = 7;
    return a;
}

/* A variadic callee reads its unnamed arguments from the register save
 * area at eightbyte granularity. */
static long collect(int n, ...) {
    va_list ap;
    long t = n;
    va_start(ap, n);
    for (int i = 0; i < n; i++) t += va_arg(ap, long);
    va_end(ap);
    return t;
}

/* Nine integer parameters overflow every integer argument bank, so the
 * tail is read where the caller left it rather than from a cell. */
static long overflow(long a, long b, long c, long d, long e, long f, long g,
                     long h, long i) {
    return a + b + c + d + e + f + g + h + i;
}

int main(void) {
    if (widths(-1, -2, -3, -4, 250, 60000) != 60240) return 1;
    if (banks(1, 2.5, 0.5f, 3, 4.25) != 11.25) return 2;
    if (escapes(41) != 42) return 3;
    if (reassigned(1) != 7) return 4;
    if (collect(3, 10L, 20L, 30L) != 63) return 5;
    if (overflow(1, 2, 3, 4, 5, 6, 7, 8, 9) != 45) return 6;
    return 42;
}
