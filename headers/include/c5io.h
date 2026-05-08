// c5io.h -- c5-side reimplementation of formatted output, walking
// the c5 va_list directly.
//
// The c5 va_list is a `long long *` cursor walking 16-byte stack
// slots (see stdarg.h); libc's vprintf / vfprintf expect the host
// platform's native va_list struct, which on macOS arm64 is a
// register-save area + an overflow pointer rather than a flat
// stack walk. Those shapes are incompatible, and bridging them
// per platform is more fragile than just reimplementing the
// formatter on top of c5's own primitives.
//
// What this header provides:
//   c5_vfprintf(fd, fmt, ap)   -- format `fmt` to file descriptor
//                                 `fd`, consuming variadic args from
//                                 the c5 va_list `ap`.
//   c5_vprintf(fmt, ap)        -- shorthand for fd = STDOUT_FILENO.
//
// Conversions: %d (signed decimal), %u (decimal, bits-as-unsigned),
// %x (hex, bits-as-unsigned), %p (0x + 16 hex digits), %c (char),
// %s (NUL-terminated string; (null) for a 0 pointer), %% (literal).
// No widths, flags or precision -- the goal is a small readable
// kernel users can extend.
//
// Building your own printf clone:
//
//   int my_printf(char *fmt, ...) {
//       va_list ap;
//       int n;
//       va_start(ap, fmt);
//       n = c5_vprintf(fmt, ap);
//       va_end(ap);
//       return n;
//   }
//
// Output goes through write(2) -- on Windows that resolves to
// msvcrt!_write, which talks to the same fd table as printf, so the
// stream interleaves cleanly with libc-bound calls in the same
// program.

#pragma once

#include <stdarg.h>
#include <stdlib.h>
#include <unistd.h>

// Format `val` as an unsigned-bit decimal/hex digit run into `buf`
// starting from the right edge. Returns the index of the first
// digit written (so the caller writes `buf + i`, length `end - i`).
// `base` is 10 or 16; non-decimal bases mask off the sign bit each
// step so a negative i64 prints as its bit pattern rather than as
// a signed magnitude.
int c5_emit_digits(char *buf, int end, int val, int base) {
    int i;
    int d;
    i = end;
    buf[i] = 0;
    if (val == 0) {
        i = i - 1;
        buf[i] = '0';
        return i;
    }
    while (val != 0) {
        if (base == 10) {
            d = val % 10;
            val = val / 10;
        } else {
            // Hex: take 4 bits, then logical-shift by masking off
            // the high nibble that arithmetic >> would sign-extend
            // into. 0x0FFFFFFFFFFFFFFF == (1<<60) - 1.
            d = val & 15;
            val = (val >> 4) & 0x0FFFFFFFFFFFFFFF;
        }
        i = i - 1;
        if (d < 10) buf[i] = '0' + d;
        else buf[i] = 'a' + d - 10;
    }
    return i;
}

int c5_emit_int(int fd, int val) {
    char *buf;
    int i;
    int neg;
    int n;
    buf = malloc(32);
    neg = 0;
    if (val < 0) {
        neg = 1;
        val = -val;
    }
    i = c5_emit_digits(buf, 31, val, 10);
    if (neg) {
        i = i - 1;
        buf[i] = '-';
    }
    n = 31 - i;
    write(fd, buf + i, n);
    free(buf);
    return n;
}

int c5_emit_hex(int fd, int val) {
    char *buf;
    int i;
    int n;
    buf = malloc(32);
    i = c5_emit_digits(buf, 31, val, 16);
    n = 31 - i;
    write(fd, buf + i, n);
    free(buf);
    return n;
}

// %p: always 0x + 16 hex digits, zero-padded. Pointers on c5's
// 64-bit targets fit in 16 nibbles; fixed width keeps output
// columns aligned across calls.
int c5_emit_ptr(int fd, int val) {
    char *buf;
    int i;
    int d;
    write(fd, "0x", 2);
    buf = malloc(17);
    buf[16] = 0;
    i = 15;
    while (i >= 0) {
        d = val & 15;
        if (d < 10) buf[i] = '0' + d;
        else buf[i] = 'a' + d - 10;
        val = (val >> 4) & 0x0FFFFFFFFFFFFFFF;
        i = i - 1;
    }
    write(fd, buf, 16);
    free(buf);
    return 18;
}

int c5_emit_str(int fd, char *s) {
    int n;
    if (s == 0) {
        write(fd, "(null)", 6);
        return 6;
    }
    n = 0;
    while (s[n] != 0) n = n + 1;
    write(fd, s, n);
    return n;
}

int c5_vfprintf(int fd, char *fmt, va_list ap) {
    int total;
    int i;
    char c;
    char ch;
    total = 0;
    i = 0;
    while (fmt[i] != 0) {
        c = fmt[i];
        if (c != '%') {
            ch = c;
            write(fd, &ch, 1);
            total = total + 1;
            i = i + 1;
        } else {
            i = i + 1;
            c = fmt[i];
            if (c == 'd') {
                total = total + c5_emit_int(fd, va_arg(ap, int));
                i = i + 1;
            } else if (c == 'u') {
                // %u: print as unsigned decimal. We share the
                // signed-decimal path (c5_emit_int operates on the
                // 32-bit `int` slot's bit pattern); values with the
                // high bit set come out as the negative-equivalent
                // signed decimal rather than the strict unsigned
                // value. Strict %u for full 64-bit values needs
                // working 64-bit unsigned division, which today
                // produces wrong results for high-bit-set inputs --
                // gh #43 tracks the codegen fix.
                total = total + c5_emit_int(fd, va_arg(ap, int));
                i = i + 1;
            } else if (c == 'x') {
                total = total + c5_emit_hex(fd, va_arg(ap, int));
                i = i + 1;
            } else if (c == 'p') {
                total = total + c5_emit_ptr(fd, va_arg(ap, int));
                i = i + 1;
            } else if (c == 'c') {
                ch = va_arg(ap, int);
                write(fd, &ch, 1);
                total = total + 1;
                i = i + 1;
            } else if (c == 's') {
                total = total + c5_emit_str(fd, va_arg(ap, char *));
                i = i + 1;
            } else if (c == '%') {
                ch = '%';
                write(fd, &ch, 1);
                total = total + 1;
                i = i + 1;
            } else if (c == 0) {
                // Trailing '%' with no conversion -- bail.
            } else {
                // Unknown specifier: emit literally. Keeps
                // round-trippable output for stray %something
                // without consuming a va_arg.
                ch = '%';
                write(fd, &ch, 1);
                ch = c;
                write(fd, &ch, 1);
                total = total + 2;
                i = i + 1;
            }
        }
    }
    return total;
}

int c5_vprintf(char *fmt, va_list ap) {
    return c5_vfprintf(STDOUT_FILENO, fmt, ap);
}
