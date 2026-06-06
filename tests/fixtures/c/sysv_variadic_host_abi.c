// System V AMD64 host variadic ABI (Linux x86_64): a variadic c5
// callee receives its named and variadic arguments in the standard
// argument-register banks (integer rdi.. + FP xmm0..) and the
// callee prologue spills a register save area (System V AMD64 ABI
// 3.5.7). `va_start` initialises the `__va_list_tag` offsets and
// pointers; `va_arg` walks the gp area, fp area, then the overflow
// area, selecting the area by the argument's type (the typed
// `va_arg(ap, T)` descriptor). The caller passes the XMM-argument
// count in `al`.
//
// This fixture exercises the three save-area regions and the two
// type classes at once:
//   * two named integer parameters (gp_offset starts at 16),
//   * mixed integer / double variadic arguments,
//   * more than six integer arguments so the gp area fills and the
//     remainder rides the overflow area.
//
// On a non-x86_64 host the cross-arch parity sweep byte-checks the
// emitted ELF; the runtime check lands on a Linux x86_64 box. Every
// other target keeps the cursor / stack va_list, so the typed
// descriptor is ignored there and the result is identical.

#include <stdarg.h>

static long mix(int a, int b, ...) {
    va_list ap;
    va_start(ap, b);
    // a + b named, then ten variadic: alternating long / double.
    long total = a + b;
    int i;
    for (i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            total += va_arg(ap, long);
        } else {
            total += (long) va_arg(ap, double);
        }
    }
    va_end(ap);
    return total;
}

static double fsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = 0;
    int i;
    for (i = 0; i < n; i++) {
        s += va_arg(ap, double);
    }
    va_end(ap);
    return s;
}

int main(void) {
    // named 1 + 2 = 3; variadic longs at even i: 1 + 3 + 5 + 7 + 9 = 25;
    // variadic doubles at odd i: 2 + 4 + 6 + 8 + 10 = 30; total 58.
    long m = mix(1, 2,
                 1L, 2.0, 3L, 4.0, 5L, 6.0, 7L, 8.0, 9L, 10.0);
    if (m != 58) {
        return 1;
    }
    // Eight FP arguments fill xmm0..xmm7; the ninth rides the
    // overflow area. 1.0 + ... + 9.0 = 45.0.
    double f = fsum(9, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0);
    if (f != 45.0) {
        return 2;
    }
    return 0;
}
