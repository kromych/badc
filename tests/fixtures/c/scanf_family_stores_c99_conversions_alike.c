// C99 7.19.6.2 and 7.24.2.2: sscanf, vsscanf, fscanf, vfscanf, swscanf,
// vswscanf and fwscanf read each input below alike, return the count it
// names and store exactly the bytes of the object the length modifier
// names: %hh one byte, floating input with infinities, NaNs and hexadecimal
// constants, %a, %F and the scanset, %c without skipping white space. A
// wide function's %s stores multibyte characters, %ls wide ones in either
// family, %p reads what printf's %p writes, and a stream keeps the
// character that ends a field.
// snapshot-budget: exempt

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

struct scan_case {
    const char *in, *fmt;
    int count;
    // Bytes stored; -4 and -8 for a float and a double NaN.
    int size;
    const char *bytes;
};

static const struct scan_case cases[] = {
    {"-12", "%hhd", 1, 1, "\xf4"},
    {"200", "%hhu", 1, 1, "\xc8"},
    {"abc", "abc%hhn", 0, 1, "\x03"},
    {"-7", "%hd", 1, 2, "\xf9\xff"},
    {"0x1f", "%i", 1, 4, "\x1f\0\0\0"},
    {"017", "%i", 1, 4, "\x0f\0\0\0"},
    {"0x1f", "%x", 1, 4, "\x1f\0\0\0"},
    {"777", "%o", 1, 4, "\xff\x01\0\0"},
    {"12345", "%3d", 1, 4, "\x7b\0\0\0"},
    {"123456789012", "%lld", 1, 8, "\x14\x1a\x99\xbe\x1c\0\0\0"},
    {"5", "%zu", 1, (int)sizeof(size_t), "\x05\0\0\0\0\0\0\0"},
    {"-5", "%jd", 1, 8, "\xfb\xff\xff\xff\xff\xff\xff\xff"},
    {"inf", "%lf", 1, 8, "\0\0\0\0\0\0\xf0\x7f"},
    {"-INFINITY", "%f", 1, 4, "\0\0\x80\xff"},
    {"nan", "%lf", 1, -8, ""},
    {"NAN(1_x)", "%f", 1, -4, ""},
    {"0x1p3", "%lf", 1, 8, "\0\0\0\0\0\0\x20\x40"},
    {"0x1.8p1", "%f", 1, 4, "\0\0\x40\x40"},
    {"1.5", "%a", 1, 4, "\0\0\xc0\x3f"},
    {"-2.5", "%F", 1, 4, "\0\0\x20\xc0"},
    {"0x.8", "%A", 1, 4, "\0\0\0\x3f"},
    {"1e-1", "%le", 1, 8, "\x9a\x99\x99\x99\x99\x99\xb9\x3f"},
    {"4.9e-324", "%lg", 1, 8, "\x01\0\0\0\0\0\0\0"},
    {"1.2.3", "%lf", 1, 8, "\x33\x33\x33\x33\x33\x33\xf3\x3f"},
    {"]ab-", "%[]a-]", 1, 3, "]a"},
    {"abc-def", "%[^-]", 1, 4, "abc"},
    {"xyz", "%2c", 1, 2, "xy"},
    {"x y", "x%c", 1, 1, " "},
    {"ab", "%*c%c", 1, 1, "b"},
    {"abc def", "%s", 1, 4, "abc"},
    {"abcdef", "%3s", 1, 4, "abc"},
    {"  42", "%d", 1, 4, "\x2a\0\0\0"},
    {"%5", "%%%d", 1, 4, "\x05\0\0\0"},
    {"", "%d", EOF, 0, ""},
    {"   ", "%d", EOF, 0, ""},
    {"x", "%d", 0, 0, ""},
    {"-", "%d", 0, 0, ""},
    {".", "%lf", 0, 0, ""},
};

static int v_string(const char *s, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsscanf(s, fmt, ap);
    va_end(ap);
    return r;
}

static int v_stream(FILE *f, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfscanf(f, fmt, ap);
    va_end(ap);
    return r;
}

static int v_wide(const wchar_t *s, const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vswscanf(s, fmt, ap);
    va_end(ap);
    return r;
}

// Each entry point once over `c`: 0, or the first that disagrees, from 1.
static int check(const struct scan_case *c) {
    wchar_t win[32], wfmt[32];
    mbstowcs(win, c->in, 32);
    mbstowcs(wfmt, c->fmt, 32);
    for (int way = 0; way < 7; ++way) {
        unsigned char got[16];
        FILE *f = way == 2 || way == 3 || way == 6 ? tmpfile() : NULL;
        int r = 0;
        memset(got, 0xAA, sizeof got);
        if (f && way == 6)
            fputws(win, f);
        else if (f)
            fputs(c->in, f);
        if (f)
            rewind(f);
        switch (way) {
        case 0: r = sscanf(c->in, c->fmt, got); break;
        case 1: r = v_string(c->in, c->fmt, got); break;
        case 2: r = fscanf(f, c->fmt, got); break;
        case 3: r = v_stream(f, c->fmt, got); break;
        case 4: r = swscanf(win, wfmt, got); break;
        case 5: r = v_wide(win, wfmt, got); break;
        case 6: r = fwscanf(f, wfmt, got); break;
        }
        if (f)
            fclose(f);
        float fl;
        double d;
        memcpy(&fl, got, sizeof fl);
        memcpy(&d, got, sizeof d);
        int n = c->size < 0 ? -c->size : c->size;
        int stored = c->size == -4 ? fl != fl : c->size == -8 ? d != d
                                                              : !memcmp(got, c->bytes, (size_t)n);
        // glibc's wide %s and %[ store a second null character.
        int past = got[n] == 0xAA || (way >= 4 && n && !got[n - 1] && !got[n]);
        if (r != c->count || !stored || !past)
            return way + 1;
    }
    return 0;
}

int main(void) {
    for (unsigned i = 0; i < sizeof cases / sizeof cases[0]; ++i)
        if (check(&cases[i]))
            return (int)i + 1;
    int x = 0, n = 0;
    void *p = NULL;
    char buf[32];
    wchar_t wbuf[8], wc = 0;
    sprintf(buf, "%p", (void *)&x);
    if (sscanf(buf, "%p", &p) != 1 || p != (void *)&x)
        return 100;
    if (sscanf("  42  ", "%d%n", &x, &n) != 1 || x != 42 || n != 4)
        return 101;
    if (sscanf("abc q", "%ls %lc", wbuf, &wc) != 2 || wcscmp(wbuf, L"abc") || wc != L'q')
        return 102;
    if (swscanf(L"abc q", L"%ls %lc", wbuf, &wc) != 2 || wcscmp(wbuf, L"abc") || wc != L'q')
        return 103;
    double d = 0;
    if (sscanf("12 abc 3.5", "%d %3s %lf", &x, buf, &d) != 3 || x != 12 || strcmp(buf, "abc") ||
        d != 3.5)
        return 104;
    FILE *f = tmpfile();
    if (!f || fputs("12abc", f) < 0)
        return 105;
    rewind(f);
    if (fscanf(f, "%d", &x) != 1 || x != 12 || getc(f) != 'a')
        return 106;
    fclose(f);
    return 0;
}
