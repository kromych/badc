// The printf family of <stdio.h> and <wchar.h> on Windows (C99 7.19.6.1,
// 7.24.2.1): msvcrt.dll's prints 1.#INF / -1.#IND, ignores %hh, rounds %a to
// six digits and a halfway %.0f away from zero. Each formats through
// ucrtbase.dll's __stdio_common_vsprintf or __stdio_common_vswprintf under
// their standard options, and a stream takes the result in one write.
// Elsewhere the file is empty; the link offers it like an archive member.

#ifdef _WIN32

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

// An infinity or a NaN whose conversion carries the # flag with an empty
// fraction comes out mangled: ucrtbase inserts a decimal point into the word
// ("%#.0e" of INFINITY prints "i.nf", "%#.0f" of -INFINITY prints "-.inf",
// "%#.0a" of -INFINITY prints "-0x.inf") and marks an indeterminate NaN with
// "(ind)". C99 7.19.6.1p8 converts them to "[-]inf" or "[-]infinity" /
// "[-]nan" or "[-]NAN", and the # flag only affects finite values, so the
// words are rewritten in place. Every rewrite shrinks the text, which is why
// the pass cannot overflow a caller's buffer.
static void fix_nonfinite_narrow(char *s) {
    static const struct { const char *from, *to; } words[] = {
        // The hex-prefixed forms first, so their ".inf" is not rewritten into
        // "0xinf": the hex prefix has no infinity or NaN spelling of its own.
        {"0x.inf", "inf"}, {"0X.INF", "INF"},
        {"0x.nan", "nan"}, {"0X.NAN", "NAN"},
        {"i.nf", "inf"}, {"I.NF", "INF"},
        {"n.an", "nan"}, {"N.AN", "NAN"},
        {"-.inf", "-inf"}, {"-.INF", "-INF"},
        {"-.nan", "-nan"}, {"-.NAN", "-NAN"},
    };
    for (size_t k = 0; k < sizeof words / sizeof *words; k++) {
        size_t from = strlen(words[k].from), to = strlen(words[k].to);
        for (char *p = strstr(s, words[k].from); p; p = strstr(p + to, words[k].from)) {
            memmove(p + to, p + from, strlen(p + from) + 1);
            memcpy(p, words[k].to, to);
        }
    }
    // The indeterminate mark only ever follows a NaN word.
    for (const char *nan = "nan"; ; nan = "NAN") {
        for (char *p = strstr(s, nan); p; p = strstr(p + 3, nan)) {
            char *tail = p + 3;
            if ((tail[0] == '(') &&
                (strncmp(tail, "(ind)", 5) == 0 || strncmp(tail, "(IND)", 5) == 0))
                memmove(tail, tail + 5, strlen(tail + 5) + 1);
        }
        if (nan[0] == 'N')
            break;
    }
}

static void fix_nonfinite_wide(wchar_t *s) {
    static const struct { const wchar_t *from, *to; } words[] = {
        {L"0x.inf", L"inf"}, {L"0X.INF", L"INF"},
        {L"0x.nan", L"nan"}, {L"0X.NAN", L"NAN"},
        {L"i.nf", L"inf"}, {L"I.NF", L"INF"},
        {L"n.an", L"nan"}, {L"N.AN", L"NAN"},
        {L"-.inf", L"-inf"}, {L"-.INF", L"-INF"},
        {L"-.nan", L"-nan"}, {L"-.NAN", L"-NAN"},
    };
    for (size_t k = 0; k < sizeof words / sizeof *words; k++) {
        size_t from = wcslen(words[k].from), to = wcslen(words[k].to);
        for (wchar_t *p = wcsstr(s, words[k].from); p; p = wcsstr(p + to, words[k].from)) {
            wmemmove(p + to, p + from, wcslen(p + from) + 1);
            wmemcpy(p, words[k].to, to);
        }
    }
    for (const wchar_t *nan = L"nan"; ; nan = L"NAN") {
        for (wchar_t *p = wcsstr(s, nan); p; p = wcsstr(p + 3, nan)) {
            wchar_t *tail = p + 3;
            if ((tail[0] == L'(') &&
                (wcsncmp(tail, L"(ind)", 5) == 0 || wcsncmp(tail, L"(IND)", 5) == 0))
                wmemmove(tail, tail + 5, wcslen(tail + 5) + 1);
        }
        if (nan[0] == L'N')
            break;
    }
}

int vsnprintf(char *restrict s, size_t n, const char *restrict format, va_list ap) {
    int r = __c5_ucrt_vsprintf(STANDARD, s, n, format, locale(), ap);
    // A truncated conversion keeps the would-be length; a fitted one reports
    // the corrected word count.
    if (r > 0 && s != NULL && (size_t)r < n) {
        fix_nonfinite_narrow(s);
        r = (int)strlen(s);
    }
    return r;
}

int vsprintf(char *restrict s, const char *restrict format, va_list ap) {
    int r = __c5_ucrt_vsprintf(STANDARD, s, (size_t)-1, format, locale(), ap);
    if (r > 0) {
        fix_nonfinite_narrow(s);
        r = (int)strlen(s);
    }
    return r;
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
    int r = __c5_ucrt_vswprintf(STANDARD, s, n, format, locale(), ap);
    // A fitted conversion reports the corrected word count; a truncated one
    // keeps the raw would-be length, which still asks for -1 here.
    if (r > 0 && s != NULL && (size_t)r < n) {
        fix_nonfinite_wide(s);
        r = (int)wcslen(s);
    }
    return r >= 0 && (size_t)r >= n ? -1 : r;
}

int vfwprintf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    wchar_t local[256], *buf = local;
    va_list again;
    va_copy(again, ap);
    int n = __c5_ucrt_vswprintf(STANDARD, local, 256, format, locale(), ap);
    if (n > 0 && n < 256) {
        fix_nonfinite_wide(local);
        n = (int)wcslen(local);
    }
    if (n >= 256 && (buf = malloc(((size_t)n + 1) * sizeof *buf)))
        n = __c5_ucrt_vswprintf(STANDARD, buf, (size_t)n + 1, format, locale(), again);
    if (n > 0 && buf != local) {
        fix_nonfinite_wide(buf);
        n = (int)wcslen(buf);
    }
    va_end(again);
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
