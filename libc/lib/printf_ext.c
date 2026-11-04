// The printf family of <stdio.h> and <wchar.h> on Windows (C99 7.19.6.1,
// 7.24.2.1): msvcrt.dll's prints 1.#INF / -1.#IND, ignores %hh, rounds %a to
// six digits and a halfway %.0f away from zero. Each formats through
// ucrtbase.dll's __stdio_common_vsprintf or __stdio_common_vswprintf under
// their standard options, and a stream takes the result in one write.
// Elsewhere the file is empty; the link offers it like an archive member.

#ifdef _WIN32

#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::__c5_ucrt_vsprintf, "__stdio_common_vsprintf")
#pragma binding(ucrtbase::__c5_ucrt_vswprintf, "__stdio_common_vswprintf")
#pragma binding(ucrtbase::__c5_ucrt_set_printf_count_output, "_set_printf_count_output")
int __c5_ucrt_vsprintf(unsigned long long options, char *buf, size_t n, const char *format,
                       void *locale, va_list ap);
int __c5_ucrt_vswprintf(unsigned long long options, wchar_t *buf, size_t n,
                        const wchar_t *format, void *locale, va_list ap);
int __c5_ucrt_set_printf_count_output(int enable);
void *__c5_ucrt_numeric_locale(void);
void __c5_lock_stream(FILE *stream);
void __c5_unlock_stream(FILE *stream);

// _CRT_INTERNAL_PRINTF_STANDARD_SNPRINTF_BEHAVIOR | _STANDARD_ROUNDING.
#define STANDARD ((1ULL << 1) | (1ULL << 5))

// ucrtbase refuses %n until a program asks for it; C99 7.19.6.1p8 has it.
static void *locale(void) {
    static int counting;
    if (!__atomic_load_n(&counting, __ATOMIC_ACQUIRE)) {
        __c5_ucrt_set_printf_count_output(1);
        __atomic_store_n(&counting, 1, __ATOMIC_RELEASE);
    }
    return __c5_ucrt_numeric_locale();
}

// An infinity or a NaN whose conversion carries the # flag comes out
// mangled: ucrtbase inserts a decimal point into the word ("%#.0e" of
// INFINITY prints "i.nf", "%#.0f" of -INFINITY prints "-.inf", "%#.0a" of
// -INFINITY prints "-0x.inf"). C99 7.19.6.1p8 has the # flag not affect an
// infinity or a NaN. The value is therefore fixed in the conversion and not
// in the text: the format is walked, and only a directive that would mangle
// is replaced by the C99 word, padded to its own field width. Every other
// directive reaches ucrtbase unchanged, so %s arguments, return values,
// embedded NULs, %n counts, truncation and the locale's decimal point stay
// what the C library prints, and a format with nothing to fix costs a walk
// over its directives and no extra conversion.

#define FMT_LEFT 1
#define FMT_SIGN 2
#define FMT_SPACE 4
#define FMT_HASH 8

enum { LEN_NONE, LEN_HH, LEN_H, LEN_L, LEN_LL, LEN_J, LEN_Z, LEN_T, LEN_CAP_L };

enum { ARG_INT, ARG_UINT, ARG_LONG, ARG_ULONG, ARG_LLONG, ARG_ULLONG, ARG_INTMAX,
       ARG_UINTMAX, ARG_SIZE, ARG_PTRDIFF, ARG_PTR, ARG_DOUBLE };

typedef struct {
    int flags, width, precision, len, conv;
} directive;

// Text under construction. `len` always counts what the conversion would
// write, even past `cap`, because that is what the snprintf family returns.
typedef struct {
    void *buf;
    size_t cap, len;
    int wide;
} sink;

static int fmt_at(const void *format, int wide, size_t i) {
    return wide ? (int)((const wchar_t *)format)[i] : (int)((const char *)format)[i];
}

static void sink_put(sink *out, const void *src, size_t n) {
    if (out->buf != NULL && out->len < out->cap) {
        size_t room = out->cap - out->len;
        size_t take = n < room ? n : room;
        if (out->wide)
            wmemcpy((wchar_t *)out->buf + out->len, (const wchar_t *)src, take);
        else
            memcpy((char *)out->buf + out->len, src, take);
    }
    out->len += n;
}

static void sink_fill(sink *out, int c, size_t n) {
    char narrow[32];
    wchar_t wide[32];
    size_t i;
    memset(narrow, c, sizeof narrow);
    for (i = 0; i < sizeof wide / sizeof *wide; i++)
        wide[i] = (wchar_t)c;
    while (n > 0) {
        size_t k = n < 32 ? n : 32;
        sink_put(out, out->wide ? (const void *)wide : (const void *)narrow, k);
        n -= k;
    }
}

// Reads one directive: "%", flags, width, precision, length modifier,
// conversion. A star width or precision is reported as -2. Returns the index
// just past the directive, or 0 for anything this pass does not model
// (positional arguments, an unknown conversion, a truncated spec), which
// leaves the whole call with ucrtbase.
static size_t parse_directive(const void *format, int wide, size_t i, directive *d) {
    size_t k = i + 1;
    int c;
    d->flags = 0;
    d->width = -1;
    d->precision = -1;
    d->len = LEN_NONE;
    d->conv = 0;
    for (;;) {
        c = fmt_at(format, wide, k);
        if (c == '-')
            d->flags |= FMT_LEFT;
        else if (c == '+')
            d->flags |= FMT_SIGN;
        else if (c == ' ')
            d->flags |= FMT_SPACE;
        else if (c == '#')
            d->flags |= FMT_HASH;
        else if (c == '0')
            ;
        else
            break;
        k++;
    }
    if (c == '*') {
        d->width = -2;
        k++;
    } else if (c >= '0' && c <= '9') {
        int w = 0;
        while ((c = fmt_at(format, wide, k)) >= '0' && c <= '9') {
            w = w * 10 + (c - '0');
            k++;
        }
        d->width = w;
    }
    if (c == '$')
        return 0;
    if (fmt_at(format, wide, k) == '.') {
        k++;
        c = fmt_at(format, wide, k);
        if (c == '*') {
            d->precision = -2;
            k++;
        } else {
            int p = 0;
            while ((c = fmt_at(format, wide, k)) >= '0' && c <= '9') {
                p = p * 10 + (c - '0');
                k++;
            }
            d->precision = p;
        }
    }
    c = fmt_at(format, wide, k);
    if (c == 'h') {
        k++;
        d->len = fmt_at(format, wide, k) == 'h' ? LEN_HH : LEN_H;
        if (d->len == LEN_HH)
            k++;
    } else if (c == 'l') {
        k++;
        d->len = fmt_at(format, wide, k) == 'l' ? LEN_LL : LEN_L;
        if (d->len == LEN_LL)
            k++;
    } else if (c == 'j') {
        d->len = LEN_J;
        k++;
    } else if (c == 'z') {
        d->len = LEN_Z;
        k++;
    } else if (c == 't') {
        d->len = LEN_T;
        k++;
    } else if (c == 'L') {
        d->len = LEN_CAP_L;
        k++;
    }
    c = fmt_at(format, wide, k);
    if (c == 0 || c == '%')
        return 0;
    d->conv = c;
    return k + 1;
}

// The type a conversion takes from the variable arguments. Only the floats
// are read for their value; the rest are stepped over to keep the cursor on
// the next directive's argument.
static int arg_kind(int conv, int len) {
    switch (conv) {
    case 'd':
    case 'i':
        switch (len) {
        case LEN_L: return ARG_LONG;
        case LEN_LL: return ARG_LLONG;
        case LEN_J: return ARG_INTMAX;
        case LEN_Z: return ARG_SIZE;
        case LEN_T: return ARG_PTRDIFF;
        default: return ARG_INT;
        }
    case 'o':
    case 'u':
    case 'x':
    case 'X':
        switch (len) {
        case LEN_L: return ARG_ULONG;
        case LEN_LL: return ARG_ULLONG;
        case LEN_J: return ARG_UINTMAX;
        case LEN_Z: return ARG_SIZE;
        case LEN_T: return ARG_UINTMAX;
        default: return ARG_UINT;
        }
    case 'c': return ARG_INT;
    case 's':
    case 'p':
    case 'n': return ARG_PTR;
    case 'a':
    case 'A':
    case 'e':
    case 'E':
    case 'f':
    case 'F':
    case 'g':
    case 'G': return ARG_DOUBLE;
    default: return -1;
    }
}

static void take_arg(va_list *ap, int kind) {
    switch (kind) {
    case ARG_INT: (void)va_arg(*ap, int); break;
    case ARG_UINT: (void)va_arg(*ap, unsigned); break;
    case ARG_LONG: (void)va_arg(*ap, long); break;
    case ARG_ULONG: (void)va_arg(*ap, unsigned long); break;
    case ARG_LLONG: (void)va_arg(*ap, long long); break;
    case ARG_ULLONG: (void)va_arg(*ap, unsigned long long); break;
    case ARG_INTMAX: (void)va_arg(*ap, intmax_t); break;
    case ARG_UINTMAX: (void)va_arg(*ap, uintmax_t); break;
    case ARG_SIZE: (void)va_arg(*ap, size_t); break;
    case ARG_PTRDIFF: (void)va_arg(*ap, ptrdiff_t); break;
    case ARG_PTR: (void)va_arg(*ap, void *); break;
    case ARG_DOUBLE: (void)va_arg(*ap, double); break;
    }
}

// %n takes the count this conversion has produced so far, not the count a
// segment handed to ucrtbase on its own would have produced.
static void store_count(va_list *ap, int len, size_t count) {
    switch (len) {
    case LEN_HH: *va_arg(*ap, signed char *) = (signed char)count; break;
    case LEN_H: *va_arg(*ap, short *) = (short)count; break;
    case LEN_L: *va_arg(*ap, long *) = (long)count; break;
    case LEN_LL: *va_arg(*ap, long long *) = (long long)count; break;
    case LEN_J: *va_arg(*ap, intmax_t *) = (intmax_t)count; break;
    case LEN_Z: *va_arg(*ap, size_t *) = count; break;
    case LEN_T: *va_arg(*ap, ptrdiff_t *) = (ptrdiff_t)count; break;
    default: *va_arg(*ap, int *) = (int)count; break;
    }
}

static int nonfinite(double v) {
    unsigned long long bits;
    memcpy(&bits, &v, sizeof bits);
    return ((bits >> 52) & 0x7ffULL) == 0x7ffULL;
}

// Hands [from, to) of the format to ucrtbase as a format string of its own.
// The range starts and ends on a directive boundary, so the arguments it
// takes are exactly the ones the walk has reached.
static int append_segment(sink *out, const void *format, int wide, va_list ap, size_t from,
                          size_t to) {
    size_t n = to - from;
    if (wide) {
        const wchar_t *f = (const wchar_t *)format;
        wchar_t *seg = malloc((n + 1) * sizeof *seg), *text;
        va_list first, second;
        int len;
        if (seg == NULL)
            return 0;
        wmemcpy(seg, f + from, n);
        seg[n] = 0;
        va_copy(first, ap);
        len = __c5_ucrt_vswprintf(STANDARD, NULL, 0, seg, locale(), first);
        va_end(first);
        if (len < 0) {
            free(seg);
            return 0;
        }
        text = malloc(((size_t)len + 1) * sizeof *text);
        if (text == NULL) {
            free(seg);
            return 0;
        }
        va_copy(second, ap);
        if (__c5_ucrt_vswprintf(STANDARD, text, (size_t)len + 1, seg, locale(), second) != len) {
            va_end(second);
            free(seg);
            free(text);
            return 0;
        }
        va_end(second);
        sink_put(out, text, (size_t)len);
        free(seg);
        free(text);
        return 1;
    } else {
        const char *f = (const char *)format;
        char *seg = malloc(n + 1), *text;
        va_list first, second;
        int len;
        if (seg == NULL)
            return 0;
        memcpy(seg, f + from, n);
        seg[n] = 0;
        va_copy(first, ap);
        len = __c5_ucrt_vsprintf(STANDARD, NULL, 0, seg, locale(), first);
        va_end(first);
        if (len < 0) {
            free(seg);
            return 0;
        }
        text = malloc((size_t)len + 1);
        if (text == NULL) {
            free(seg);
            return 0;
        }
        va_copy(second, ap);
        if (__c5_ucrt_vsprintf(STANDARD, text, (size_t)len + 1, seg, locale(), second) != len) {
            va_end(second);
            free(seg);
            free(text);
            return 0;
        }
        va_end(second);
        sink_put(out, text, (size_t)len);
        free(seg);
        free(text);
        return 1;
    }
}

// The C99 word for the value: "[-]inf" / "[-]nan", the letters following the
// case of the conversion, the sign from the value or from the + and space
// flags, the field width padded with spaces on the side the - flag asks for.
static void emit_word(sink *out, int conv, int flags, int width, double value) {
    unsigned long long bits;
    char word[4];
    size_t n = 0, pad = 0;
    int negative, nan, upper, sign;

    memcpy(&bits, &value, sizeof bits);
    negative = (int)(bits >> 63);
    nan = (bits & 0x000fffffffffffffULL) != 0;
    upper = conv == 'A' || conv == 'E' || conv == 'F' || conv == 'G';
    sign = negative ? '-' : (flags & FMT_SIGN) ? '+' : (flags & FMT_SPACE) ? ' ' : 0;
    if (sign)
        word[n++] = (char)sign;
    word[n++] = (char)(upper ? (nan ? 'N' : 'I') : (nan ? 'n' : 'i'));
    word[n++] = (char)(upper ? (nan ? 'A' : 'N') : (nan ? 'a' : 'n'));
    word[n++] = (char)(upper ? (nan ? 'N' : 'F') : (nan ? 'n' : 'f'));
    if (width > 0 && (size_t)width > n)
        pad = (size_t)width - n;
    if (!(flags & FMT_LEFT))
        sink_fill(out, ' ', pad);
    if (out->wide) {
        wchar_t text[4];
        size_t i;
        for (i = 0; i < n; i++)
            text[i] = (wchar_t)word[i];
        sink_put(out, text, n);
    } else {
        sink_put(out, word, n);
    }
    if (flags & FMT_LEFT)
        sink_fill(out, ' ', pad);
}

// Cheap test that keeps the common format on a single ucrtbase conversion:
// walk the directives, and report 1 only when a float conversion carrying #
// receives an infinity or a NaN. A directive this pass does not model, and a
// long double, report 0 so the caller stays with ucrtbase.
static int needs_fix(const void *format, int wide, va_list ap) {
    va_list rest;
    size_t i = 0;
    int found = 0;
    va_copy(rest, ap);
    for (;;) {
        int c = fmt_at(format, wide, i);
        directive d;
        size_t end;
        int kind;
        if (c == 0)
            break;
        if (c != '%') {
            i++;
            continue;
        }
        if (fmt_at(format, wide, i + 1) == '%') {
            i += 2;
            continue;
        }
        end = parse_directive(format, wide, i, &d);
        if (end == 0)
            break;
        kind = arg_kind(d.conv, d.len);
        if (kind < 0 || d.len == LEN_CAP_L)
            break;
        if (d.width == -2)
            take_arg(&rest, ARG_INT);
        if (d.precision == -2)
            take_arg(&rest, ARG_INT);
        if (kind == ARG_DOUBLE) {
            double v = va_arg(rest, double);
            if ((d.flags & FMT_HASH) && nonfinite(v)) {
                found = 1;
                break;
            }
        } else {
            take_arg(&rest, kind);
        }
        i = end;
    }
    va_end(rest);
    return found;
}

// Writes the format with each mangling directive replaced by its word. The
// ranges between such directives still go to ucrtbase, so only the word is
// spelled here. Returns 0 when a directive is outside what the walk models;
// the caller then falls back to one plain ucrtbase conversion.
static int format_directives(sink *out, const void *format, int wide, va_list ap) {
    va_list rest, seg;
    size_t i = 0, seg_start = 0;
    int ok = 1;
    va_copy(rest, ap);
    va_copy(seg, ap);
    for (;;) {
        int c = fmt_at(format, wide, i);
        directive d;
        size_t end;
        int kind, width;
        if (c == 0)
            break;
        if (c != '%') {
            i++;
            continue;
        }
        if (fmt_at(format, wide, i + 1) == '%') {
            i += 2;
            continue;
        }
        end = parse_directive(format, wide, i, &d);
        kind = end == 0 ? -1 : arg_kind(d.conv, d.len);
        if (kind < 0 || d.len == LEN_CAP_L) {
            ok = 0;
            break;
        }
        width = d.width;
        if (width == -2) {
            int w = va_arg(rest, int);
            if (w < 0) {
                d.flags |= FMT_LEFT;
                w = -w;
            }
            width = w;
        }
        if (d.precision == -2)
            (void)va_arg(rest, int);
        if (kind == ARG_DOUBLE) {
            double v = va_arg(rest, double);
            if ((d.flags & FMT_HASH) && nonfinite(v)) {
                if (seg_start < i && !append_segment(out, format, wide, seg, seg_start, i)) {
                    ok = 0;
                    break;
                }
                emit_word(out, d.conv, d.flags, width, v);
                va_end(seg);
                va_copy(seg, rest);
                seg_start = end;
            }
        } else if (d.conv == 'n') {
            // A %n counts every character the call has produced, so it
            // cannot sit inside a segment ucrtbase converts on its own.
            if (seg_start < i && !append_segment(out, format, wide, seg, seg_start, i)) {
                ok = 0;
                break;
            }
            store_count(&rest, d.len, out->len);
            va_end(seg);
            va_copy(seg, rest);
            seg_start = end;
        } else {
            take_arg(&rest, kind);
        }
        i = end;
    }
    if (ok && seg_start < i && !append_segment(out, format, wide, seg, seg_start, i))
        ok = 0;
    va_end(seg);
    va_end(rest);
    return ok;
}

int vsnprintf(char *restrict s, size_t n, const char *restrict format, va_list ap) {
    sink out;
    out.buf = s;
    out.cap = n ? n - 1 : 0;
    out.len = 0;
    out.wide = 0;
    if (needs_fix(format, 0, ap)) {
        va_list copy;
        va_copy(copy, ap);
        if (format_directives(&out, format, 0, copy)) {
            va_end(copy);
            if (n)
                s[out.len < n ? out.len : n - 1] = 0;
            return (int)out.len;
        }
        va_end(copy);
    }
    return __c5_ucrt_vsprintf(STANDARD, s, n, format, locale(), ap);
}

int vsprintf(char *restrict s, const char *restrict format, va_list ap) {
    sink out;
    out.buf = s;
    out.cap = (size_t)-1;
    out.len = 0;
    out.wide = 0;
    if (needs_fix(format, 0, ap)) {
        va_list copy;
        va_copy(copy, ap);
        if (format_directives(&out, format, 0, copy)) {
            va_end(copy);
            s[out.len] = 0;
            return (int)out.len;
        }
        va_end(copy);
    }
    return __c5_ucrt_vsprintf(STANDARD, s, (size_t)-1, format, locale(), ap);
}

int vfprintf(FILE *restrict stream, const char *restrict format, va_list ap) {
    char local[512], *buf = local;
    va_list again;
    va_copy(again, ap);
    int n = vsnprintf(local, sizeof local, format, ap);
    if (n >= (int)sizeof local && (buf = malloc((size_t)n + 1)))
        n = vsnprintf(buf, (size_t)n + 1, format, again);
    va_end(again);
    if (!buf)
        return -1;
    if (n > 0 && fwrite(buf, 1, (size_t)n, stream) != (size_t)n)
        n = -1;
    if (buf != local)
        free(buf);
    return n;
}

int vprintf(const char *restrict format, va_list ap) {
    return vfprintf(stdout, format, ap);
}

// C99 7.24.2.7: negative when n or more wide characters were asked for.
int vswprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format, va_list ap) {
    sink out;
    out.buf = s;
    out.cap = n ? n - 1 : 0;
    out.len = 0;
    out.wide = 1;
    if (needs_fix(format, 1, ap)) {
        va_list copy;
        va_copy(copy, ap);
        if (format_directives(&out, format, 1, copy)) {
            va_end(copy);
            if (n)
                s[out.len < n ? out.len : n - 1] = 0;
            return n > 0 && out.len < n ? (int)out.len : -1;
        }
        va_end(copy);
    }
    {
        int r = __c5_ucrt_vswprintf(STANDARD, s, n, format, locale(), ap);
        return r >= 0 && (size_t)r >= n ? -1 : r;
    }
}

int vfwprintf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    wchar_t local[256], *buf = local;
    int n;
    if (needs_fix(format, 1, ap)) {
        // Two passes: one to count, one into a buffer that fits. Windows
        // va_list is a by-value cursor, so the second starts from the same
        // argument list.
        sink count = {NULL, 0, 0, 1};
        sink text;
        va_list first, second;
        va_copy(first, ap);
        if (!format_directives(&count, format, 1, first)) {
            va_end(first);
            return -1;
        }
        va_end(first);
        buf = malloc((count.len + 1) * sizeof *buf);
        if (buf == NULL)
            return -1;
        text.buf = buf;
        text.cap = count.len + 1;
        text.len = 0;
        text.wide = 1;
        va_copy(second, ap);
        if (!format_directives(&text, format, 1, second)) {
            va_end(second);
            free(buf);
            return -1;
        }
        va_end(second);
        n = (int)text.len;
    } else {
        va_list again;
        va_copy(again, ap);
        n = __c5_ucrt_vswprintf(STANDARD, local, 256, format, locale(), ap);
        if (n >= 256 && (buf = malloc(((size_t)n + 1) * sizeof *buf)))
            n = __c5_ucrt_vswprintf(STANDARD, buf, (size_t)n + 1, format, locale(), again);
        va_end(again);
        if (!buf)
            return -1;
    }
    if (n < 0)
        return n;
    buf[n] = 0;
    // fputws stops at a null character, which fputwc writes.
    __c5_lock_stream(stream);
    for (int i = 0; i < n;) {
        size_t len = wcslen(buf + i);
        if ((len && fputws(buf + i, stream) < 0) ||
            ((i += (int)len) < n && fputwc(buf[i++], stream) == WEOF)) {
            n = -1;
            break;
        }
    }
    __c5_unlock_stream(stream);
    if (buf != local)
        free(buf);
    return n;
}

int vwprintf(const wchar_t *restrict format, va_list ap) {
    return vfwprintf(stdout, format, ap);
}

int printf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfprintf(stdout, fmt, ap);
    va_end(ap);
    return r;
}

int fprintf(FILE *stream, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfprintf(stream, fmt, ap);
    va_end(ap);
    return r;
}

int sprintf(char *buf, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsprintf(buf, fmt, ap);
    va_end(ap);
    return r;
}

int snprintf(char *buf, size_t size, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return r;
}

int wprintf(const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfwprintf(stdout, fmt, ap);
    va_end(ap);
    return r;
}

int fwprintf(FILE *restrict stream, const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vfwprintf(stream, format, ap);
    va_end(ap);
    return r;
}

int swprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vswprintf(s, n, format, ap);
    va_end(ap);
    return r;
}

#endif
