// <stdio.h>'s and <wchar.h>'s va_list scanners on the Windows targets, which
// msvcrt.dll does not export: as in libmsvcrt.a, each passes the arguments
// its format stores through to fscanf, fwscanf or swscanf, which ignore the
// excess (C99 7.19.6.2p2). Elsewhere the file is empty; the link offers it
// like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

// A format storing through more arguments fails with EINVAL.
#define VS_MAX_STORED 64

#define VS_8(p, i) p[i], p[i + 1], p[i + 2], p[i + 3], p[i + 4], p[i + 5], p[i + 6], p[i + 7]
#define VS_ALL(p)                                                                              \
    VS_8(p, 0), VS_8(p, 8), VS_8(p, 16), VS_8(p, 24), VS_8(p, 32), VS_8(p, 40), VS_8(p, 48),   \
        VS_8(p, 56)

// Conversions storing through an argument, all but %% and %*, in a format of
// `unit`-byte characters.
static int stored_args(const void *format, size_t unit) {
    const unsigned char *b = format;
    const wchar_t *w = format;
    int n = 0;
    size_t i = 0;
#define VS_AT(k) (unit == 1 ? (unsigned)b[k] : (unsigned)w[k])
    while (VS_AT(i)) {
        if (VS_AT(i++) != '%')
            continue;
        if (VS_AT(i) == '%') {
            ++i;
            continue;
        }
        int store = VS_AT(i) != '*';
        if (!store)
            ++i;
        while (VS_AT(i) && VS_AT(i) < 128 && strchr("0123456789hlLjztIqw", (int)VS_AT(i)))
            ++i;
        if (VS_AT(i) == '[') {
            ++i;
            if (VS_AT(i) == '^')
                ++i;
            if (VS_AT(i) == ']')
                ++i;
            while (VS_AT(i) && VS_AT(i) != ']')
                ++i;
        }
        if (VS_AT(i))
            ++i;
        n += store;
    }
#undef VS_AT
    return n;
}

static int take_args(void **p, const void *format, size_t unit, va_list ap) {
    int n = stored_args(format, unit);
    if (n > VS_MAX_STORED) {
        errno = EINVAL;
        return 0;
    }
    for (int i = 0; i < VS_MAX_STORED; ++i)
        p[i] = i < n ? va_arg(ap, void *) : NULL;
    return 1;
}

int vfscanf(FILE *restrict stream, const char *restrict format, va_list ap) {
    void *p[VS_MAX_STORED];
    if (!take_args(p, format, 1, ap))
        return EOF;
    return fscanf(stream, format, VS_ALL(p));
}

int vscanf(const char *restrict format, va_list ap) {
    return vfscanf(stdin, format, ap);
}

int vfwscanf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    void *p[VS_MAX_STORED];
    if (!take_args(p, format, sizeof(wchar_t), ap))
        return EOF;
    return fwscanf(stream, format, VS_ALL(p));
}

int vswscanf(const wchar_t *restrict s, const wchar_t *restrict format, va_list ap) {
    void *p[VS_MAX_STORED];
    if (!take_args(p, format, sizeof(wchar_t), ap))
        return EOF;
    return swscanf(s, format, VS_ALL(p));
}

int vwscanf(const wchar_t *restrict format, va_list ap) {
    return vfwscanf(stdin, format, ap);
}

#endif
