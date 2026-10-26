// C99 7.24.2 and 7.24.3: wide text is formatted into a buffer and a file and
// scanned back from both, directly and through va_list, and read and written
// a character and a line at a time with a pushback. The 7.24.4 searches and
// conversions and 7.24.6 mbrlen / mbsinit run beside them. Only %d, %ls,
// %lc and %lf, which every target's C library reads alike, are used; no
// standard stream is touched, so the stream orientation of a host process
// running the program in place is unchanged.

#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <wchar.h>

static int vformat(wchar_t *buf, size_t n, const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vswprintf(buf, n, fmt, ap);
    va_end(ap);
    return r;
}

static int vscan(const wchar_t *src, const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vswscanf(src, fmt, ap);
    va_end(ap);
    return r;
}

static int vfile_print(FILE *f, const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfwprintf(f, fmt, ap);
    va_end(ap);
    return r;
}

static int vfile_scan(FILE *f, const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfwscanf(f, fmt, ap);
    va_end(ap);
    return r;
}

static int buffers(void) {
    wchar_t buf[32];
    wchar_t word[8];
    int i = 0, j = 0;
    double d = 0;
    if (swprintf(buf, 32, L"%d-%ls-%lc", 42, L"ab", (wint_t)L'z') != 7 || wcscmp(buf, L"42-ab-z"))
        return 1;
    if (swprintf(buf, 4, L"%d", 12345) >= 0 || vformat(buf, 4, L"%d", 123) != 3 || wcscmp(buf, L"123"))
        return 2;
    if (vformat(buf, 32, L"%ls=%d", L"key", -7) != 6 || wcscmp(buf, L"key=-7"))
        return 3;
    if (swscanf(L"17 abc 2.5", L"%d %3ls %lf", &i, word, &d) != 3 || i != 17 || wcscmp(word, L"abc") ||
        d != 2.5)
        return 4;
    if (vscan(L"x 9 -3", L"x %d %d", &i, &j) != 2 || i != 9 || j != -3)
        return 5;
    return 0;
}

static int file(void) {
    FILE *f = tmpfile();
    wchar_t line[16];
    wchar_t word[8];
    int n = 0, m = 0;
    if (!f)
        return 10;
    if (fwide(f, 0) != 0 || fwide(f, 1) <= 0)
        return 11;
    if (fwprintf(f, L"%d %ls\n", 7, L"seven") != 8 || vfile_print(f, L"%d;", 8) != 2)
        return 12;
    if (fputwc(L'x', f) != L'x' || putwc(L'y', f) != L'y' || fputws(L"z\n", f) < 0)
        return 13;
    rewind(f);
    if (fwscanf(f, L"%d %5ls", &n, word) != 2 || n != 7 || wcscmp(word, L"seven"))
        return 14;
    if (fgetwc(f) != L'\n' || vfile_scan(f, L"%d;", &m) != 1 || m != 8)
        return 15;
    if (getwc(f) != L'x' || ungetwc(L'x', f) != L'x')
        return 16;
    if (!fgetws(line, 16, f) || wcscmp(line, L"xyz\n") || fgetwc(f) != WEOF || !feof(f))
        return 17;
    fclose(f);
    return 0;
}

static int strings_and_conversions(void) {
    static const wchar_t text[] = L"key=value; more";
    wchar_t buf[16] = L"ab";
    wchar_t *end = 0;
    mbstate_t st = {0};
    if (wcsncat(buf, L"cdef", 2) != buf || wcscmp(buf, L"abcd"))
        return 20;
    if (wcscspn(text, L"=;") != 3 || wcsspn(text, L"aeky") != 3)
        return 21;
    if (wcspbrk(text, L";=") != text + 3 || wcsstr(text, L"more") != text + 11 || wcsstr(text, L"x"))
        return 22;
    if (wcstoll(L"-9000000000", &end, 10) != -9000000000LL || *end)
        return 23;
    if (wcstoull(L"18446744073709551615", 0, 10) != ULLONG_MAX)
        return 24;
    if (wcstof(L"2.5x", &end) != 2.5f || *end != L'x' || wcstold(L"0.25", 0) != 0.25L)
        return 25;
    if (!mbsinit(&st) || !mbsinit(0) || mbrlen("a", 1, &st) != 1 || mbrlen("", 1, &st) != 0)
        return 26;
    return 0;
}

int main(void) {
    int r;
    if ((r = buffers()) || (r = file()) || (r = strings_and_conversions()))
        return r;
    return 0;
}
