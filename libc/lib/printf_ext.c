// The printf family of <stdio.h> and <wchar.h> on Windows (C99 7.19.6.1,
// 7.24.2.1): msvcrt.dll's prints 1.#INF / -1.#IND, ignores %hh, rounds %a to
// six digits and a halfway %.0f away from zero. Each formats through
// ucrtbase.dll's __stdio_common_vsprintf or __stdio_common_vswprintf under
// their standard options, and a stream takes the result in one write.
// Elsewhere the file is empty; the link offers it like an archive member.

#ifdef _WIN32

#include <math.h>
#include <stdarg.h>
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

// C99 7.19.6.1p8: the `#` flag shapes finite values only, while the UCRT
// writes `%#.0e` of an infinity as `i.nf`. The format, of `wide` units,
// with the `#` taken off each floating conversion whose argument is an
// infinity or a NaN, reading the arguments as the conversions consume them;
// `format` itself when there is none, NULL when out of memory.
static const void *finite_sharp(const void *format, int wide, va_list ap) {
    const unsigned char *n8 = format;
    const wchar_t *n16 = format;
#define AT(i) (wide ? (unsigned)n16[i] : (unsigned)n8[i])
#define IN(set, c) ((c) && (c) < 128 && strchr(set, (int)(c)))
    va_list a;
    va_copy(a, ap);
    size_t drops[16], ndrops = 0, len = 0;
    for (size_t i = 0; AT(i); i++) {
        if (AT(i) != '%')
            continue;
        size_t sharp = 0, k = i + 1;
        for (; IN("-+ #0", AT(k)); k++)
            sharp = AT(k) == '#' ? k : sharp;
        for (; AT(k) == '*' || AT(k) == '.' || (AT(k) >= '0' && AT(k) <= '9'); k++)
            if (AT(k) == '*')
                (void)va_arg(a, int);
        int big = 0;
        for (; IN("hljztLIw36", AT(k)); k++)
            big |= AT(k) == 'l' || AT(k) == 'j' || AT(k) == 'z' || AT(k) == 't' || AT(k) == 'I';
        unsigned c = AT(k);
        if (IN("eEfFgGaA", c)) {
            if (!isfinite(va_arg(a, double)) && sharp && ndrops < 16)
                drops[ndrops++] = sharp;
        } else if (IN("diouxX", c)) {
            if (big)
                (void)va_arg(a, long long);
            else
                (void)va_arg(a, int);
        } else if (IN("cC", c)) {
            (void)va_arg(a, int);
        } else if (c && c != '%') {
            (void)va_arg(a, void *);
        }
        i = c ? k : k - 1;
    }
    va_end(a);
    if (!ndrops)
        return format;
    while (AT(len))
        len++;
    size_t unit = wide ? sizeof(wchar_t) : 1, at = 0;
    unsigned char *out = malloc((len + 1) * unit);
    for (size_t i = 0, d = 0; out && i <= len; i++) {
        if (d < ndrops && drops[d] == i) {
            d++;
            continue;
        }
        memcpy(out + at++ * unit, wide ? (const void *)(n16 + i) : (const void *)(n8 + i), unit);
    }
    return out;
#undef AT
#undef IN
}

int vsnprintf(char *restrict s, size_t n, const char *restrict format, va_list ap) {
    const char *f = finite_sharp(format, 0, ap);
    int r = f ? __c5_ucrt_vsprintf(STANDARD, s, n, f, locale(), ap) : -1;
    if (f != format)
        free((void *)f);
    return r;
}

int vsprintf(char *restrict s, const char *restrict format, va_list ap) {
    return vsnprintf(s, (size_t)-1, format, ap);
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
    const wchar_t *f = finite_sharp(format, 1, ap);
    int r = f ? __c5_ucrt_vswprintf(STANDARD, s, n, f, locale(), ap) : -1;
    if (f != format)
        free((void *)f);
    return r >= 0 && (size_t)r >= n ? -1 : r;
}

int vfwprintf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    wchar_t local[256], *buf = local;
    const wchar_t *f = finite_sharp(format, 1, ap);
    if (!f)
        return -1;
    va_list again;
    va_copy(again, ap);
    int n = __c5_ucrt_vswprintf(STANDARD, local, 256, f, locale(), ap);
    if (n >= 256 && (buf = malloc(((size_t)n + 1) * sizeof *buf)))
        n = __c5_ucrt_vswprintf(STANDARD, buf, (size_t)n + 1, f, locale(), again);
    va_end(again);
    if (f != format)
        free((void *)f);
    if (!buf)
        return -1;
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
