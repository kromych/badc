// <wchar.h> -- wide-character / wide-string surface (C99 7.24).

#pragma once

// `wchar_t` lives in <stddef.h> (C99 7.17p2); <wchar.h>
// transitively includes it so a source that pulls in only
// `<wchar.h>` still sees the typedef. badc encodes `wchar_t` as
// `int` on the Unix targets and as a 16-bit unit on Windows
// (UTF-16), matching each platform's ABI.
#include <stddef.h>

// `wint_t` holds any `wchar_t` value plus `WEOF` (C99 7.24.1). It is a
// 4-byte integer on the supported Unix targets.
typedef int wint_t;
#define WEOF ((wint_t)-1)

// Conversion state for the restartable multibyte functions (C99
// 7.24.1). The contents are opaque; the host libc reads only the bytes
// it wrote, so an oversized zeroed buffer is safe across libcs.
typedef struct { unsigned char __opaque[128]; } mbstate_t;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wcslen,   "_wcslen")
#pragma binding(libc::wcscmp,   "_wcscmp")
#pragma binding(libc::wcsncmp,  "_wcsncmp")
#pragma binding(libc::wcschr,   "_wcschr")
#pragma binding(libc::wcsrchr,  "_wcsrchr")
#pragma binding(libc::wcscpy,   "_wcscpy")
#pragma binding(libc::wcsncpy,  "_wcsncpy")
#pragma binding(libc::wcscat,   "_wcscat")
#pragma binding(libc::wcstol,   "_wcstol")
#pragma binding(libc::wcstoul,  "_wcstoul")
#pragma binding(libc::wcstod,   "_wcstod")
#pragma binding(libc::wcstok,   "_wcstok")
#pragma binding(libc::wmemchr,  "_wmemchr")
#pragma binding(libc::wmemcmp,  "_wmemcmp")
#pragma binding(libc::wmemcpy,  "_wmemcpy")
#pragma binding(libc::wmemmove, "_wmemmove")
#pragma binding(libc::wmemset,  "_wmemset")
#pragma binding(libc::mbrtowc,  "_mbrtowc")
#pragma binding(libc::wcrtomb,  "_wcrtomb")
#pragma binding(libc::wcsrtombs, "_wcsrtombs")
#pragma binding(libc::mbsrtowcs, "_mbsrtowcs")
#pragma binding(libc::btowc,    "_btowc")
#pragma binding(libc::wctob,    "_wctob")
#pragma binding(libc::wcscoll,  "_wcscoll")
#pragma binding(libc::wcsxfrm,  "_wcsxfrm")
#pragma binding(libc::wcsftime, "_wcsftime")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wcslen,   "wcslen")
#pragma binding(libc::wcscmp,   "wcscmp")
#pragma binding(libc::wcsncmp,  "wcsncmp")
#pragma binding(libc::wcschr,   "wcschr")
#pragma binding(libc::wcsrchr,  "wcsrchr")
#pragma binding(libc::wcscpy,   "wcscpy")
#pragma binding(libc::wcsncpy,  "wcsncpy")
#pragma binding(libc::wcscat,   "wcscat")
#pragma binding(libc::wcstol,   "wcstol")
#pragma binding(libc::wcstoul,  "wcstoul")
#pragma binding(libc::wcstod,   "wcstod")
#pragma binding(libc::wcstok,   "wcstok")
#pragma binding(libc::wmemchr,  "wmemchr")
#pragma binding(libc::wmemcmp,  "wmemcmp")
#pragma binding(libc::wmemcpy,  "wmemcpy")
#pragma binding(libc::wmemmove, "wmemmove")
#pragma binding(libc::wmemset,  "wmemset")
#pragma binding(libc::mbrtowc,  "mbrtowc")
#pragma binding(libc::wcrtomb,  "wcrtomb")
#pragma binding(libc::wcsrtombs, "wcsrtombs")
#pragma binding(libc::mbsrtowcs, "mbsrtowcs")
#pragma binding(libc::btowc,    "btowc")
#pragma binding(libc::wctob,    "wctob")
#pragma binding(libc::wcscoll,  "wcscoll")
#pragma binding(libc::wcsxfrm,  "wcsxfrm")
#pragma binding(libc::wcsftime, "wcsftime")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::wcslen, "wcslen")
#pragma binding(msvcrt::wcscmp, "wcscmp")
#pragma binding(msvcrt::wcsncmp, "wcsncmp")
#pragma binding(msvcrt::wcschr, "wcschr")
#pragma binding(msvcrt::wcsrchr, "wcsrchr")
#pragma binding(msvcrt::wcscpy, "wcscpy")
#pragma binding(msvcrt::wcsncpy, "wcsncpy")
#pragma binding(msvcrt::wcscat, "wcscat")
#pragma binding(msvcrt::wcstol, "wcstol")
#pragma binding(msvcrt::wcstoul, "wcstoul")
#pragma binding(msvcrt::wcstod, "wcstod")
#pragma binding(msvcrt::wcstok, "wcstok")
#pragma binding(msvcrt::wcsicmp, "_wcsicmp")
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::wcstok_s, "wcstok_s")
int wcsicmp(const wchar_t *a, const wchar_t *b);
wchar_t *wcstok_s(wchar_t *str, const wchar_t *delim, wchar_t **context);
#pragma binding(ucrtbase::wcscpy_s, "wcscpy_s")
int wcscpy_s(wchar_t *dst, size_t count, const wchar_t *src);
#pragma binding(ucrtbase::wcsncpy_s, "wcsncpy_s")
int wcsncpy_s(wchar_t *dst, size_t dstsz, const wchar_t *src, size_t count);
#pragma binding(ucrtbase::wcscat_s, "wcscat_s")
int wcscat_s(wchar_t *dst, size_t dstsz, const wchar_t *src);
#pragma binding(msvcrt::wcscoll,  "wcscoll")
#pragma binding(msvcrt::wcsxfrm,  "wcsxfrm")
#pragma binding(msvcrt::wcsftime, "wcsftime")
#pragma binding(msvcrt::wcsrtombs, "wcsrtombs")
#pragma binding(msvcrt::mbsrtowcs, "mbsrtowcs")

// Neither msvcrt.dll nor ucrtbase.dll exports the C99 wide-array
// functions (7.24.4.4 / 7.24.4.5), count-based swprintf (7.24.2.3), or
// wcsnlen_s; the Microsoft SDK defines them inline over the exported
// primitives _vsnwprintf and wcsnlen. Mirror that so a reference
// resolves without a separate support library.
#include <stdarg.h>
#pragma binding(msvcrt::_vsnwprintf, "_vsnwprintf")
#pragma binding(msvcrt::wcsnlen,     "wcsnlen")
int _vsnwprintf(wchar_t *buffer, size_t count, const wchar_t *format, va_list ap);
size_t wcsnlen(const wchar_t *s, size_t maxlen);
static inline int swprintf(wchar_t *buffer, size_t count, const wchar_t *format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = _vsnwprintf(buffer, count, format, ap);
    va_end(ap);
    return r;
}
static inline size_t wcsnlen_s(const wchar_t *s, size_t n) {
    return s ? wcsnlen(s, n) : 0;
}
static inline wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n) {
    for (; n; --n, ++s)
        if (*s == c)
            return (wchar_t *)s;
    return (wchar_t *)0;
}
static inline int wmemcmp(const wchar_t *a, const wchar_t *b, size_t n) {
    for (; n; --n, ++a, ++b)
        if (*a != *b)
            return *a < *b ? -1 : 1;
    return 0;
}
static inline wchar_t *wmemcpy(wchar_t *d, const wchar_t *s, size_t n) {
    for (size_t i = 0; i < n; ++i)
        d[i] = s[i];
    return d;
}
static inline wchar_t *wmemmove(wchar_t *d, const wchar_t *s, size_t n) {
    if (d < s)
        for (size_t i = 0; i < n; ++i)
            d[i] = s[i];
    else
        for (size_t i = n; i; --i)
            d[i - 1] = s[i - 1];
    return d;
}
static inline wchar_t *wmemset(wchar_t *d, wchar_t c, size_t n) {
    for (size_t i = 0; i < n; ++i)
        d[i] = c;
    return d;
}
#endif

// Wide-string handling (C99 7.24.4). `size_t` comes from <stddef.h>.
unsigned long long wcslen(const wchar_t *s);
int wcscmp(const wchar_t *s1, const wchar_t *s2);
int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wcschr(const wchar_t *s, wchar_t c);
wchar_t *wcsrchr(const wchar_t *s, wchar_t c);
wchar_t *wcscpy(wchar_t *dest, const wchar_t *src);
wchar_t *wcsncpy(wchar_t *dest, const wchar_t *src, size_t n);
wchar_t *wcscat(wchar_t *dest, const wchar_t *src);

// Wide-character array handling (C99 7.24.4.4). On Windows these have
// inline definitions in the target block above, since no system CRT
// exports them.
#ifndef _WIN32
wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n);
int wmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemcpy(wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemmove(wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemset(wchar_t *s, wchar_t c, size_t n);
#endif

// Wide-string numeric conversion (C99 7.24.4.1).
long wcstol(const wchar_t *nptr, wchar_t **endptr, int base);
unsigned long wcstoul(const wchar_t *nptr, wchar_t **endptr, int base);
double wcstod(const wchar_t *nptr, wchar_t **endptr);
wchar_t *wcstok(wchar_t *s, const wchar_t *delim, wchar_t **ptr);

// Restartable multibyte / wide conversion (C99 7.24.6.3).
unsigned long mbrtowc(wchar_t *pwc, const char *s, unsigned long n, mbstate_t *ps);
unsigned long wcrtomb(char *s, wchar_t wc, mbstate_t *ps);
unsigned long wcsrtombs(char *dst, const wchar_t **src, unsigned long len, mbstate_t *ps);
// C95 7.24.6.4.1: the multibyte->wide reverse of wcsrtombs.
unsigned long mbsrtowcs(wchar_t *dst, const char **src, unsigned long len, mbstate_t *ps);

// Single-byte / wide-character conversion (C99 7.24.6.1).
wint_t btowc(int c);
int wctob(wint_t c);

// Locale-dependent wide-string collation (C99 7.24.4.4.2, 7.24.4.5.1).
int wcscoll(const wchar_t *s1, const wchar_t *s2);
size_t wcsxfrm(wchar_t *s1, const wchar_t *s2, size_t n);

// Wide-character time formatting (C99 7.24.5.1). `struct tm` comes from
// <time.h>; a pointer to it needs only the tag here.
struct tm;
size_t wcsftime(wchar_t *s, size_t maxsize, const wchar_t *format,
                const struct tm *timeptr);
