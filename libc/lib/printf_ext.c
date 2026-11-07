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
// INFINITY prints "i.nf", "%#.0f" of -INFINITY prints "-.inf"). C99
// 7.19.6.1p6 gives # meaning only through the decimal point of a finite
// number and its p9 has the 0 flag not affect an infinity or a NaN, so
// those two flags are deleted from the directive's own text in a copy of
// the format: ucrtbase then formats the whole call itself -- width, sign
// flags, %n, the return count, truncation, the locale's decimal point and
// even the "(ind)" suffix of a NaN are all its own words. Directives the
// walk does not model stop it and keep the edits found so far, so nothing
// that ucrtbase understands is ever held back from ucrtbase.

#define FMT_LEFT 1
#define FMT_SIGN 2
#define FMT_SPACE 4
#define FMT_HASH 8
#define FMT_ZERO 16

enum { LEN_NONE, LEN_HH, LEN_H, LEN_L, LEN_LL, LEN_J, LEN_Z, LEN_T, LEN_CAP_L };

enum { ARG_INT, ARG_UINT, ARG_LONG, ARG_ULONG, ARG_LLONG, ARG_ULLONG, ARG_INTMAX,
       ARG_UINTMAX, ARG_SIZE, ARG_PTRDIFF, ARG_PTR, ARG_DOUBLE };

typedef struct {
    int flags, width, precision, len, conv;
    size_t flags_end;
} directive;

static int fmt_at(const void *format, int wide, size_t i) {
    return wide ? (int)((const wchar_t *)format)[i] : (int)((const char *)format)[i];
}

static void fmt_put(void *format, int wide, size_t i, int c) {
    if (wide)
        ((wchar_t *)format)[i] = (wchar_t)c;
    else
        ((char *)format)[i] = (char)c;
}

static int nonfinite(double v) {
    unsigned long long bits;
    memcpy(&bits, &v, sizeof bits);
    return ((bits >> 52) & 0x7ffULL) == 0x7ffULL;
}

// Reads one directive: "%", flags, width, precision, length modifier,
// conversion. A star width or precision is reported as -2. Returns the index
// just past the directive, or 0 for anything this pass does not model
// (positional arguments, an unknown conversion, a truncated spec).
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
            d->flags |= FMT_ZERO;
        else
            break;
        k++;
    }
    d->flags_end = k;
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
// the next directive's argument. A long double is 8 bytes on both PE targets
// (__SIZEOF_LONG_DOUBLE__ 8), so an L float reads as a double. An L
// conversion of anything else is not modeled: the caller stops there.
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
        case LEN_CAP_L: return -1;
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
        case LEN_CAP_L: return -1;
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

// The edited format, or NULL. The copy is made only for a format that
// carries # at all, and only when a float directive whose argument is an
// infinity or a NaN is found; a directive the walk does not model (an
// unknown conversion or length modifier, a positional %) stops the walk and
// keeps the edits found so far -- the real conversion below still runs over
// the whole format with the original arguments, so only the word of an
// infinity or a NaN changes.
static void *edit_format(const void *format, int wide, va_list ap) {
    va_list rest;
    size_t flen = wide ? wcslen((const wchar_t *)format) : strlen((const char *)format);
    size_t unit = wide ? sizeof(wchar_t) : 1;
    void *copy = malloc((flen + 1) * unit);
    size_t i = 0, o = 0;
    int edited = 0;
    if (copy == NULL)
        return NULL;
    va_copy(rest, ap);
    for (;;) {
        int c = fmt_at(format, wide, i);
        directive d;
        size_t end, j;
        int kind;
        if (c == 0)
            break;
        if (c != '%') {
            fmt_put(copy, wide, o++, c);
            i++;
            continue;
        }
        if (fmt_at(format, wide, i + 1) == '%') {
            fmt_put(copy, wide, o++, c);
            fmt_put(copy, wide, o++, '%');
            i += 2;
            continue;
        }
        end = parse_directive(format, wide, i, &d);
        kind = end == 0 ? -1 : arg_kind(d.conv, d.len);
        if (kind < 0)
            break;
        if (d.width == -2)
            (void)va_arg(rest, int);
        if (d.precision == -2)
            (void)va_arg(rest, int);
        if (kind == ARG_DOUBLE) {
            double v = va_arg(rest, double);
            if (nonfinite(v)) {
                // The directive loses its # and its 0 flag; nothing else
                // about it is ours to touch.
                edited = 1;
                for (j = i; j < end; j++) {
                    int fc = fmt_at(format, wide, j);
                    if (j > i && j < d.flags_end && (fc == '#' || fc == '0'))
                        continue;
                    fmt_put(copy, wide, o++, fc);
                }
                i = end;
                continue;
            }
        } else {
            take_arg(&rest, kind);
        }
        for (j = i; j < end; j++)
            fmt_put(copy, wide, o++, fmt_at(format, wide, j));
        i = end;
    }
    va_end(rest);
    if (!edited) {
        free(copy);
        return NULL;
    }
    while (i < flen)
        fmt_put(copy, wide, o++, fmt_at(format, wide, i++));
    fmt_put(copy, wide, o, 0);
    return copy;
}

int vsnprintf(char *restrict s, size_t n, const char *restrict format, va_list ap) {
    char *edited = strchr(format, '#') ? edit_format(format, 0, ap) : NULL;
    int r = __c5_ucrt_vsprintf(STANDARD, s, n, edited ? edited : format, locale(), ap);
    free(edited);
    return r;
}

int vsprintf(char *restrict s, const char *restrict format, va_list ap) {
    char *edited = strchr(format, '#') ? edit_format(format, 0, ap) : NULL;
    int r = __c5_ucrt_vsprintf(STANDARD, s, (size_t)-1, edited ? edited : format, locale(), ap);
    free(edited);
    return r;
}

int vfprintf(FILE *restrict stream, const char *restrict format, va_list ap) {
    char local[512], *buf = local;
    char *edited = strchr(format, '#') ? edit_format(format, 0, ap) : NULL;
    const char *f = edited ? edited : format;
    va_list again;
    int n;
    va_copy(again, ap);
    n = __c5_ucrt_vsprintf(STANDARD, local, sizeof local, f, locale(), ap);
    if (n >= (int)sizeof local && (buf = malloc((size_t)n + 1)))
        n = __c5_ucrt_vsprintf(STANDARD, buf, (size_t)n + 1, f, locale(), again);
    va_end(again);
    free(edited);
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
    wchar_t *edited = wcschr(format, '#') ? edit_format(format, 1, ap) : NULL;
    int r = __c5_ucrt_vswprintf(STANDARD, s, n, edited ? edited : format, locale(), ap);
    free(edited);
    return r >= 0 && (size_t)r >= n ? -1 : r;
}

// fputws stops at a null character, which fputwc writes; the loop covers
// embedded L'\0' the way the C library's vfwprintf is expected to.
static int write_wide(FILE *restrict stream, const wchar_t *restrict buf, int n) {
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
    return n;
}

int vfwprintf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    wchar_t local[256], *buf = local;
    wchar_t *edited = wcschr(format, '#') ? edit_format(format, 1, ap) : NULL;
    const wchar_t *f = edited ? edited : format;
    va_list again;
    int n;
    va_copy(again, ap);
    n = __c5_ucrt_vswprintf(STANDARD, local, 256, f, locale(), ap);
    if (n >= 256 && (buf = malloc(((size_t)n + 1) * sizeof *buf)))
        n = __c5_ucrt_vswprintf(STANDARD, buf, (size_t)n + 1, f, locale(), again);
    va_end(again);
    free(edited);
    if (!buf)
        return -1;
    if (n > 0)
        n = write_wide(stream, buf, n);
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
