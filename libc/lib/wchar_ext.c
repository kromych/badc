// <wchar.h>'s va_list scanners, wcstof and wcstold on the Windows targets,
// which msvcrt.dll does not export. As in libmsvcrt.a, a scanner passes the
// arguments its format stores through to fwscanf or swscanf, which ignore
// the excess ones (C99 7.24.2.2p2). The file compiles to nothing elsewhere;
// the native-link driver offers it like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <wchar.h>

// A format storing through more arguments fails with EINVAL.
#define WX_MAX_STORED 64

#define WX_8(p, i) p[i], p[i + 1], p[i + 2], p[i + 3], p[i + 4], p[i + 5], p[i + 6], p[i + 7]
#define WX_ALL(p)                                                                              \
    WX_8(p, 0), WX_8(p, 8), WX_8(p, 16), WX_8(p, 24), WX_8(p, 32), WX_8(p, 40), WX_8(p, 48),   \
        WX_8(p, 56)

// Conversions storing through an argument: all but %% and %*.
static int stored_args(const wchar_t *f) {
    int n = 0;
    while (*f) {
        if (*f++ != L'%')
            continue;
        if (*f == L'%') {
            ++f;
            continue;
        }
        int store = *f != L'*';
        if (!store)
            ++f;
        while (*f && wcschr(L"0123456789hlLjztIqw", *f))
            ++f;
        if (*f == L'[') {
            ++f;
            if (*f == L'^')
                ++f;
            if (*f == L']')
                ++f;
            while (*f && *f != L']')
                ++f;
        }
        if (*f)
            ++f;
        n += store;
    }
    return n;
}

static int take_args(void **p, const wchar_t *format, va_list ap) {
    int n = stored_args(format);
    if (n > WX_MAX_STORED) {
        errno = EINVAL;
        return 0;
    }
    for (int i = 0; i < WX_MAX_STORED; ++i)
        p[i] = i < n ? va_arg(ap, void *) : NULL;
    return 1;
}

int vfwscanf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    void *p[WX_MAX_STORED];
    if (!take_args(p, format, ap))
        return EOF;
    return fwscanf(stream, format, WX_ALL(p));
}

int vswscanf(const wchar_t *restrict s, const wchar_t *restrict format, va_list ap) {
    void *p[WX_MAX_STORED];
    if (!take_args(p, format, ap))
        return EOF;
    return swscanf(s, format, WX_ALL(p));
}

int vwscanf(const wchar_t *restrict format, va_list ap) {
    return vfwscanf(stdin, format, ap);
}

// C99 7.24.4.1.1p10: a value out of float's range is ERANGE.
float wcstof(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    double d = wcstod(nptr, endptr);
    float f = (float)d;
    if ((isinf(f) && !isinf(d)) || (f == 0 && d != 0))
        errno = ERANGE;
    return f;
}

long double wcstold(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    return wcstod(nptr, endptr);
}

#endif
