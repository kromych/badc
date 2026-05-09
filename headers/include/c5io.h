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

// Buffer-mode counterparts of c5_emit_*. They append to `buf` at
// `*cursor`, capping at `size - 1` (leaving room for a trailing
// NUL), but ALWAYS advance `*cursor` so the final value reflects
// the would-have-been-written length per snprintf semantics.
// Pass `size <= 0` to skip writes entirely (length-only mode).
int c5_buf_putc(char *buf, int size, int *cursor, int c) {
    if (size > 0 && *cursor + 1 < size) buf[*cursor] = (char)c;
    *cursor = *cursor + 1;
    return 1;
}

int c5_buf_puts(char *buf, int size, int *cursor, char *s) {
    int n;
    if (s == 0) s = "(null)";
    n = 0;
    while (s[n] != 0) {
        c5_buf_putc(buf, size, cursor, s[n]);
        n = n + 1;
    }
    return n;
}

// snprintf-shaped buffer formatter walking c5's `va_list`
// directly. Recognises a useful subset of C99's printf format:
//
//   * Conversions: d, u, x, X, p, c, s, %.
//   * Flags: '-' (left-align), '0' (zero-pad).
//   * Width: literal digits or '*' (read int from va_list).
//   * Precision: '.<digits>' or '.*' (read int from va_list).
//     For %s precision is the maximum chars to copy. For %d/%x
//     precision (when set) becomes the minimum-digit width with
//     '0' fill, ignoring the '0' flag.
//   * Length modifiers (`l`, `ll`, `h`, `hh`, `z`, `j`, `t`):
//     parsed and ignored -- c5's `int` value already covers the
//     ranges these widen / narrow.
//
// Float specifiers (%f, %e, %g) and the rare %n / %a aren't
// implemented and emit literally; sqlite's own
// `sqlite3_vmprintf` covers the rich-formatter use cases in
// c5-compiled code.
//
// Returns the number of bytes that would have been written (=
// the strlen of the unbounded result), matching libc vsnprintf:
// callers compare against `size` to detect truncation.
int c5_vsnprintf(char *buf, int size, char *fmt, va_list ap) {
    int cursor;
    int i;
    int j;
    int val;
    int neg;
    int d;
    int width;
    int prec;
    int has_prec;
    int left_align;
    int zero_pad;
    int len;
    int pad_amt;
    char c;
    char tmp[32];
    char *str;
    cursor = 0;
    i = 0;
    while (fmt[i] != 0) {
        c = fmt[i];
        if (c != '%') {
            c5_buf_putc(buf, size, &cursor, c);
            i = i + 1;
            continue;
        }
        // Parse %[flags][width][.prec][length]<conversion>.
        i = i + 1;
        left_align = 0;
        zero_pad = 0;
        // Flags. Only '-' and '0' are honoured; '+', ' ', '#'
        // are accepted but ignored (no sign-display, no
        // alternate form).
        while (fmt[i] == '-' || fmt[i] == '0' || fmt[i] == '+'
                || fmt[i] == ' ' || fmt[i] == '#') {
            if (fmt[i] == '-') left_align = 1;
            else if (fmt[i] == '0') zero_pad = 1;
            i = i + 1;
        }
        // Width.
        width = 0;
        if (fmt[i] == '*') {
            width = va_arg(ap, int);
            if (width < 0) { left_align = 1; width = -width; }
            i = i + 1;
        } else {
            while (fmt[i] >= '0' && fmt[i] <= '9') {
                width = width * 10 + (fmt[i] - '0');
                i = i + 1;
            }
        }
        // Precision.
        prec = 0;
        has_prec = 0;
        if (fmt[i] == '.') {
            has_prec = 1;
            i = i + 1;
            if (fmt[i] == '*') {
                prec = va_arg(ap, int);
                if (prec < 0) { has_prec = 0; prec = 0; }
                i = i + 1;
            } else {
                while (fmt[i] >= '0' && fmt[i] <= '9') {
                    prec = prec * 10 + (fmt[i] - '0');
                    i = i + 1;
                }
            }
        }
        // Length modifiers -- consume and ignore. c5 keeps every
        // integer-shaped value in an 8-byte slot, so the length
        // wouldn't change which va_arg we pull.
        while (fmt[i] == 'l' || fmt[i] == 'h' || fmt[i] == 'z'
                || fmt[i] == 'j' || fmt[i] == 't') {
            i = i + 1;
        }
        c = fmt[i];
        if (c == 'd') {
            val = va_arg(ap, int);
            neg = 0;
            if (val < 0) { neg = 1; val = -val; }
            j = c5_emit_digits(tmp, 31, val, 10);
            len = 31 - j;
            if (neg) len = len + 1;
            // Zero-pad to precision (if set) overrides space-pad
            // to width below; precision is min digits.
            int min_digits = has_prec ? prec : 0;
            int extra_zeros = 0;
            if (len - (neg ? 1 : 0) < min_digits) {
                extra_zeros = min_digits - (len - (neg ? 1 : 0));
                len = len + extra_zeros;
            }
            pad_amt = width > len ? width - len : 0;
            // Right-pad with spaces if left-aligned, else
            // pad-left with space (or '0' if zero_pad and no
            // explicit precision).
            char pad_ch = (zero_pad && !has_prec && !left_align) ? '0' : ' ';
            if (!left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, pad_ch);
                    pad_amt = pad_amt - 1;
                }
            }
            if (neg) c5_buf_putc(buf, size, &cursor, '-');
            while (extra_zeros > 0) {
                c5_buf_putc(buf, size, &cursor, '0');
                extra_zeros = extra_zeros - 1;
            }
            while (j < 31) {
                c5_buf_putc(buf, size, &cursor, tmp[j]);
                j = j + 1;
            }
            if (left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            i = i + 1;
        } else if (c == 'u' || c == 'x' || c == 'X') {
            val = va_arg(ap, int);
            j = c5_emit_digits(tmp, 31, val, c == 'u' ? 10 : 16);
            len = 31 - j;
            int min_digits = has_prec ? prec : 0;
            int extra_zeros = 0;
            if (len < min_digits) {
                extra_zeros = min_digits - len;
                len = len + extra_zeros;
            }
            pad_amt = width > len ? width - len : 0;
            char pad_ch = (zero_pad && !has_prec && !left_align) ? '0' : ' ';
            if (!left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, pad_ch);
                    pad_amt = pad_amt - 1;
                }
            }
            while (extra_zeros > 0) {
                c5_buf_putc(buf, size, &cursor, '0');
                extra_zeros = extra_zeros - 1;
            }
            while (j < 31) {
                c5_buf_putc(buf, size, &cursor, tmp[j]);
                j = j + 1;
            }
            if (left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            i = i + 1;
        } else if (c == 'p') {
            val = va_arg(ap, int);
            c5_buf_putc(buf, size, &cursor, '0');
            c5_buf_putc(buf, size, &cursor, 'x');
            j = 15;
            while (j >= 0) {
                d = (val >> (j * 4)) & 15;
                if (d < 10) c5_buf_putc(buf, size, &cursor, '0' + d);
                else c5_buf_putc(buf, size, &cursor, 'a' + d - 10);
                j = j - 1;
            }
            i = i + 1;
        } else if (c == 'c') {
            int ch_val = va_arg(ap, int);
            pad_amt = width > 1 ? width - 1 : 0;
            if (!left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            c5_buf_putc(buf, size, &cursor, ch_val);
            if (left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            i = i + 1;
        } else if (c == 's') {
            str = va_arg(ap, char *);
            if (str == 0) str = "(null)";
            // Compute display length. Precision caps for %s.
            len = 0;
            while (str[len] != 0) len = len + 1;
            if (has_prec && prec < len) len = prec;
            pad_amt = width > len ? width - len : 0;
            if (!left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            j = 0;
            while (j < len) {
                c5_buf_putc(buf, size, &cursor, str[j]);
                j = j + 1;
            }
            if (left_align) {
                while (pad_amt > 0) {
                    c5_buf_putc(buf, size, &cursor, ' ');
                    pad_amt = pad_amt - 1;
                }
            }
            i = i + 1;
        } else if (c == '%') {
            c5_buf_putc(buf, size, &cursor, '%');
            i = i + 1;
        } else if (c == 0) {
            // Trailing '%' -- bail without consuming a va_arg.
        } else {
            // Unimplemented specifier (e.g. %f, %e, %g, %n) --
            // emit the raw `%<spec>` for round-trippability and
            // skip the va_arg we don't know how to consume. The
            // caller's arg list will be off by one for that
            // conversion, but the alternative (silent va_arg
            // shift) is worse: it'd corrupt every subsequent
            // conversion in the same fmt.
            c5_buf_putc(buf, size, &cursor, '%');
            c5_buf_putc(buf, size, &cursor, c);
            i = i + 1;
        }
    }
    // NUL-terminate within capacity. snprintf says: if size > 0,
    // the output is always NUL-terminated, possibly truncated.
    if (size > 0) {
        if (cursor < size) buf[cursor] = 0;
        else buf[size - 1] = 0;
    }
    return cursor;
}
