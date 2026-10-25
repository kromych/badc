// The formatted input functions of <stdio.h> and <wchar.h> on the Windows
// targets (C99 7.19.6.2, 7.24.2.2). msvcrt.dll's scanners store an int
// through %hh, read no infinity, NaN or hexadecimal floating input, know no
// %a or %F, and store wide characters through a wide function's %s; it
// exports no vfscanf, vscanf or vsscanf. One scanner here reads strings and
// streams of either width; floating input converts through strtof, strtod
// and strtold. Elsewhere the file is empty; the link offers it like an
// archive member.

#ifdef _WIN32

#include <ctype.h>
#include <limits.h>
#include <locale.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <wctype.h>

void __c5_lock_stream(FILE *stream);
void __c5_unlock_stream(FILE *stream);

// A stream, or a string of narrow or `wide` characters; `count` characters
// read so far, for %n.
struct input {
    FILE *f;
    const unsigned char *s;
    const wchar_t *ws;
    int wide;
    size_t count;
};

static int get(struct input *in) {
    int c;
    if (in->f && in->wide) {
        wint_t w = fgetwc(in->f);
        c = w == WEOF ? EOF : (int)w;
    } else if (in->f)
        c = getc(in->f);
    else if (in->wide)
        c = *in->ws ? (int)*in->ws++ : EOF;
    else
        c = *in->s ? *in->s++ : EOF;
    in->count += c != EOF;
    return c;
}

static void unget(struct input *in, int c) {
    if (c == EOF)
        return;
    --in->count;
    if (in->f && in->wide)
        ungetwc((wint_t)c, in->f);
    else if (in->f)
        ungetc(c, in->f);
    else if (in->wide)
        --in->ws;
    else
        --in->s;
}

// The next character of a field with `*left` characters to go, EOF past them.
static int next(struct input *in, size_t *left) {
    if (!*left)
        return EOF;
    --*left;
    return get(in);
}

static int space(const struct input *in, int c) {
    return c != EOF && (in->wide ? iswspace((wint_t)c) : isspace(c));
}

static void skip_spaces(struct input *in) {
    int c;
    while (space(in, c = get(in)))
        ;
    unget(in, c);
}

static int digit(int c) {
    if (c >= '0' && c <= '9')
        return c - '0';
    if (c >= 'a' && c <= 'z')
        return c - 'a' + 10;
    if (c >= 'A' && c <= 'Z')
        return c - 'A' + 10;
    return 99;
}

static int lower(int c) {
    return c >= 'A' && c <= 'Z' ? c - 'A' + 'a' : c;
}

// strtoll's or strtoull's subject sequence in `base` (0: by its prefix) and
// value, as C99 7.20.1.4 has them. 0 when the field holds no such sequence.
static int scan_int(struct input *in, size_t width, int base, int is_signed,
                    unsigned long long *v) {
    unsigned long long acc = 0;
    int neg = 0, digits = 0, over = 0, c = next(in, &width);
    if (c == '+' || c == '-') {
        neg = c == '-';
        c = next(in, &width);
    }
    if ((base == 0 || base == 16) && c == '0') {
        c = next(in, &width);
        if (lower(c) == 'x') {
            base = 16;
            c = next(in, &width);
        } else {
            digits = 1;
            base = base ? base : 8;
        }
    }
    base = base ? base : 10;
    for (int d; (d = digit(c)) < base; c = next(in, &width)) {
        digits = 1;
        if (acc > (ULLONG_MAX - (unsigned)d) / (unsigned)base)
            over = 1;
        else
            acc = acc * (unsigned)base + (unsigned)d;
    }
    unget(in, c);
    if (is_signed) {
        unsigned long long limit = neg ? (unsigned long long)LLONG_MAX + 1 : LLONG_MAX;
        if (over || acc > limit)
            acc = limit;
    } else if (over) {
        acc = ULLONG_MAX;
        neg = 0;
    }
    *v = neg ? 0 - acc : acc;
    return digits;
}

struct text {
    char *p;
    size_t len, cap;
    char local[64];
};

static int put(struct text *t, int c) {
    if (t->len == t->cap) {
        char *p = t->p == t->local ? malloc(t->cap * 2) : realloc(t->p, t->cap * 2);
        if (!p)
            return 0;
        if (t->p == t->local)
            memcpy(p, t->local, t->len);
        t->p = p;
        t->cap *= 2;
    }
    t->p[t->len++] = (char)c;
    return 1;
}

// strtod's subject sequence (C99 7.20.1.3p3), with the decimal point
// `point`, into `t`. 0 when the field holds no complete one.
static int scan_float(struct input *in, size_t width, struct text *t, int point) {
    int c = next(in, &width), digits = 0, hex = 0, ok = 1;
    if (c == '+' || c == '-') {
        ok &= put(t, c);
        c = next(in, &width);
    }
    if (lower(c) == 'i' || lower(c) == 'n') {
        const char *word = lower(c) == 'i' ? "infinity" : "nan";
        size_t k = 0;
        for (; word[k] && lower(c) == word[k]; ++k, c = next(in, &width))
            ok &= put(t, c);
        int whole = k == 3 || k == 8;
        if (whole && *word == 'n' && c == '(') {
            do {
                ok &= put(t, c);
                c = next(in, &width);
            } while (c == '_' || digit(c) < 36);
            whole = c == ')';
            if (whole) {
                ok &= put(t, c);
                c = next(in, &width);
            }
        }
        unget(in, c);
        return whole && ok;
    }
    if (c == '0') {
        ok &= put(t, c);
        c = next(in, &width);
        hex = lower(c) == 'x';
        digits = !hex;
        if (hex) {
            ok &= put(t, c);
            c = next(in, &width);
        }
    }
    for (int frac = 0;; c = next(in, &width)) {
        if (digit(c) < (hex ? 16 : 10))
            digits = 1;
        else if (c == point && !frac)
            frac = 1;
        else
            break;
        ok &= put(t, c);
    }
    if (digits && lower(c) == (hex ? 'p' : 'e')) {
        ok &= put(t, c);
        c = next(in, &width);
        if (c == '+' || c == '-') {
            ok &= put(t, c);
            c = next(in, &width);
        }
        for (digits = 0; digit(c) < 10; c = next(in, &width)) {
            digits = 1;
            ok &= put(t, c);
        }
    }
    unget(in, c);
    return digits && ok;
}

struct format {
    const unsigned char *s;
    const wchar_t *ws;
};

static unsigned at(struct format f, size_t i) {
    return f.ws ? (unsigned)f.ws[i] : f.s[i];
}

// The scanlist from `a` (past the '[') to the closing ']' at `b`, ranges
// written lo-hi as msvcrt and glibc read them.
static int in_set(struct format f, size_t a, size_t b, int c) {
    int neg = at(f, a) == '^', found = 0;
    for (size_t k = a + neg; k < b; ++k) {
        unsigned lo = at(f, k);
        if (k + 2 < b && at(f, k + 1) == '-' && lo <= at(f, k + 2)) {
            found |= (unsigned)c >= lo && (unsigned)c <= at(f, k + 2);
            k += 2;
        } else
            found |= (unsigned)c == lo;
    }
    return found != neg;
}

// %c, %s and %[: the characters of the field, stored through `p` unless it
// is NULL, converted to the destination's width by mbrtowc or wcrtomb.
static int scan_chars(struct input *in, size_t width, unsigned conv, struct format f,
                      size_t set, size_t set_end, void *p, int wdest) {
    char *np = p;
    wchar_t *wp = p;
    mbstate_t st;
    size_t n = 0, want = width;
    int c;
    memset(&st, 0, sizeof st);
    while ((c = next(in, &width)) != EOF) {
        if (conv == 's' ? space(in, c) : conv == '[' && !in_set(f, set, set_end, c)) {
            unget(in, c);
            break;
        }
        ++n;
        if (!p)
            continue;
        if (in->wide == wdest) {
            if (wdest)
                *wp++ = (wchar_t)c;
            else
                *np++ = (char)c;
        } else if (wdest) {
            char b = (char)c;
            size_t r = mbrtowc(wp, &b, 1, &st);
            if (r == (size_t)-1)
                return 0;
            wp += r != (size_t)-2;
        } else {
            size_t r = wcrtomb(np, (wchar_t)c, &st);
            if (r == (size_t)-1)
                return 0;
            np += r;
        }
    }
    if (!n || (conv == 'c' && n != want))
        return 0;
    if (p && conv != 'c') {
        if (wdest)
            *wp = 0;
        else
            *np = 0;
    }
    return 1;
}

static void store_int(void *p, size_t size, unsigned long long v) {
    if (size == 1)
        *(signed char *)p = (signed char)v;
    else if (size == sizeof(short))
        *(short *)p = (short)v;
    else if (size == sizeof(int))
        *(int *)p = (int)v;
    else
        *(long long *)p = (long long)v;
}

// The directives of `format` against `in`: the assignment count, or EOF for
// an input failure before the first conversion.
static int scan(struct input *in, const void *format, va_list ap) {
    struct format f = {in->wide ? NULL : format, in->wide ? format : NULL};
    int point = (unsigned char)*localeconv()->decimal_point;
    int assigned = 0, converted = 0, c;
    size_t i = 0;
    while (at(f, i)) {
        unsigned d = at(f, i++);
        if (space(in, (int)d)) {
            skip_spaces(in);
            continue;
        }
        if (d != '%' || at(f, i) == '%') {
            if (d == '%') {
                ++i;
                skip_spaces(in);
            }
            if ((c = get(in)) == (int)d)
                continue;
            unget(in, c);
            return c == EOF && !converted ? EOF : assigned;
        }
        int suppress = at(f, i) == '*';
        size_t width = 0, isize = sizeof(int);
        int fkind = 0, wdest = 0;
        for (i += suppress; at(f, i) >= '0' && at(f, i) <= '9'; ++i)
            width = width * 10 + (at(f, i) - '0');
        switch (at(f, i)) {
        case 'h':
            isize = at(f, i + 1) == 'h' ? (++i, 1) : sizeof(short);
            ++i;
            break;
        case 'l':
            isize = at(f, i + 1) == 'l' ? (++i, sizeof(long long)) : sizeof(long);
            fkind = wdest = 1;
            ++i;
            break;
        case 'L':
        case 'q':
        case 'j':
            isize = sizeof(long long);
            fkind = at(f, i++) == 'L' ? 2 : 1;
            break;
        case 'z':
        case 't':
            isize = sizeof(size_t);
            ++i;
            break;
        case 'I':
            if (at(f, i + 1) == '6' && at(f, i + 2) == '4')
                isize = 8, i += 2;
            else if (at(f, i + 1) == '3' && at(f, i + 2) == '2')
                isize = 4, i += 2;
            else
                isize = sizeof(size_t);
            ++i;
            break;
        }
        unsigned conv = at(f, i);
        if (!conv)
            break;
        ++i;
        if (conv == 'S' || conv == 'C') {
            wdest = 1;
            conv = conv == 'S' ? 's' : 'c';
        }
        if (conv == 'n') {
            if (!suppress)
                store_int(va_arg(ap, void *), isize, in->count);
            ++converted;
            continue;
        }
        size_t set = i, set_end = i;
        if (conv == '[') {
            i += at(f, i) == '^';
            i += at(f, i) == ']';
            while (at(f, i) && at(f, i) != ']')
                ++i;
            set_end = i;
            i += at(f, i) == ']';
        } else if (conv != 'c')
            skip_spaces(in);
        if ((c = get(in)) == EOF)
            return converted ? assigned : EOF;
        unget(in, c);
        width = width ? width : conv == 'c' ? 1 : SIZE_MAX;
        void *p = suppress ? NULL : va_arg(ap, void *);
        int ok;
        unsigned long long v;
        struct text t;
        switch (conv) {
        case 'd':
        case 'i':
        case 'o':
        case 'u':
        case 'x':
        case 'X':
        case 'p':
            ok = scan_int(in, width, conv == 'd' || conv == 'u' ? 10 : conv == 'i' ? 0 : conv == 'o' ? 8 : 16,
                          conv == 'd' || conv == 'i', &v);
            if (ok && p && conv == 'p')
                *(void **)p = (void *)(uintptr_t)v;
            else if (ok && p)
                store_int(p, isize, v);
            break;
        case 'a':
        case 'A':
        case 'e':
        case 'E':
        case 'f':
        case 'F':
        case 'g':
        case 'G':
            t.p = t.local;
            t.len = 0;
            t.cap = sizeof t.local;
            ok = scan_float(in, width, &t, point) && put(&t, 0);
            if (ok && p && fkind == 0)
                *(float *)p = strtof(t.p, NULL);
            else if (ok && p && fkind == 1)
                *(double *)p = strtod(t.p, NULL);
            else if (ok && p)
                *(long double *)p = strtold(t.p, NULL);
            if (t.p != t.local)
                free(t.p);
            break;
        case 'c':
        case 's':
        case '[':
            ok = scan_chars(in, width, conv, f, set, set_end, p, wdest);
            break;
        default:
            ok = 0;
            break;
        }
        if (!ok)
            return assigned;
        ++converted;
        assigned += p != NULL;
    }
    return assigned;
}

// C11 7.21.2p8: the stream's lock is held across the call.
int vfscanf(FILE *restrict stream, const char *restrict format, va_list ap) {
    struct input in = {stream, NULL, NULL, 0, 0};
    __c5_lock_stream(stream);
    int r = scan(&in, format, ap);
    __c5_unlock_stream(stream);
    return r;
}

int vscanf(const char *restrict format, va_list ap) {
    return vfscanf(stdin, format, ap);
}

int vsscanf(const char *restrict s, const char *restrict format, va_list ap) {
    struct input in = {NULL, (const unsigned char *)s, NULL, 0, 0};
    return scan(&in, format, ap);
}

int fscanf(FILE *stream, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfscanf(stream, fmt, ap);
    va_end(ap);
    return r;
}

int scanf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfscanf(stdin, fmt, ap);
    va_end(ap);
    return r;
}

int sscanf(const char *src, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsscanf(src, fmt, ap);
    va_end(ap);
    return r;
}

int vfwscanf(FILE *restrict stream, const wchar_t *restrict format, va_list ap) {
    struct input in = {stream, NULL, NULL, 1, 0};
    __c5_lock_stream(stream);
    int r = scan(&in, format, ap);
    __c5_unlock_stream(stream);
    return r;
}

int vwscanf(const wchar_t *restrict format, va_list ap) {
    return vfwscanf(stdin, format, ap);
}

int vswscanf(const wchar_t *restrict s, const wchar_t *restrict format, va_list ap) {
    struct input in = {NULL, NULL, s, 1, 0};
    return scan(&in, format, ap);
}

int fwscanf(FILE *restrict stream, const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vfwscanf(stream, format, ap);
    va_end(ap);
    return r;
}

int wscanf(const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vfwscanf(stdin, format, ap);
    va_end(ap);
    return r;
}

int swscanf(const wchar_t *restrict s, const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vswscanf(s, format, ap);
    va_end(ap);
    return r;
}

#endif
