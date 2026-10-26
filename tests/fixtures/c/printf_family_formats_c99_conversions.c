// C99 7.19.6.1 and 7.24.2.1: snprintf, sprintf, fprintf and their va_list
// and wide forms format an infinity as inf, a quiet NaN as nan, %hh through
// a char, %a in hexadecimal, a halfway %.0f to the even neighbor, %.20f
// exactly and a two-digit exponent; snprintf returns the untruncated length
// and swprintf a negative one for an output that does not fit. A locale
// whose decimal point is a comma prints the comma.
// snapshot-budget: exempt

#include <locale.h>
#include <math.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

static char buf[160];

static int v_string(char *b, size_t n, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsnprintf(b, n, fmt, ap);
    va_end(ap);
    return r;
}

// `want` as snprintf's output and length, and through vsnprintf.
#define EXPECT(code, want, ...)                                                                \
    do {                                                                                       \
        int r = snprintf(buf, sizeof buf, __VA_ARGS__);                                        \
        if (r != (int)strlen(want) || strcmp(buf, want))                                       \
            return code;                                                                       \
        if (v_string(buf, sizeof buf, __VA_ARGS__) != r || strcmp(buf, want))                  \
            return code + 1;                                                                   \
    } while (0)

static int narrow(void) {
    volatile double zero = 0.0;
    int n = 0;
    EXPECT(10, "inf -inf INF", "%f %f %F", 1.0 / zero, -1.0 / zero, 1.0 / zero);
    // A NaN with its sign bit clear, whatever the target's default NaN.
    EXPECT(12, "nan NAN", "%f %F", fabs(zero / zero), fabs(zero / zero));
    EXPECT(14, "44 44 4464", "%hhd %hhu %hd", 300, 300, 70000);
    EXPECT(16, "0x1.800p+0 0X1.8P+0 0x1.55p-2", "%.3a %.1A %.2a", 1.5, 1.5, 1.0 / 3);
    EXPECT(18, "0 2 2 -2", "%.0f %.0f %.0f %.0f", 0.5, 1.5, 2.5, -2.5);
    EXPECT(20, "0.10000000000000000555", "%.20f", 0.1);
    EXPECT(22, "1.500000e+00 1.000000E-300 1e-05 1E+100", "%e %E %g %G", 1.5, 1e-300, 1e-5,
           1e100);
    EXPECT(24, "5 -6 7 -1 ff", "%zu %jd %td %lld %llx", (size_t)5, (intmax_t)-6, (ptrdiff_t)7,
           -1LL, 255LL);
    EXPECT(26, "  3.1|2.500   |+5| 6", "%5.1f|%-8.3f|%+d|% d", 3.14159, 2.5, 5, 6);
    EXPECT(28, "0xff 010 3. 1.00000", "%#x %#o %#.0f %#g", 255, 8, 3.0, 1.0);
    EXPECT(30, "wide q xy", "%ls %lc %.2s", L"wide", (wint_t)L'q', "xyz");
    EXPECT(32, "-00001.500 42    |", "%010.3f %-6d|", -1.5, 42);
    EXPECT(34, "99999999999999991611392 1e+06 0.10000000000000001", "%.30g %g %.17g", 1e23,
           1000000.0, 0.1);
    if (snprintf(buf, sizeof buf, "abc%n%c", &n, 'd') != 4 || n != 3 || strcmp(buf, "abcd"))
        return 40;
    char small[4];
    if (snprintf(small, sizeof small, "%s", "abcdef") != 6 || strcmp(small, "abc"))
        return 41;
    if (snprintf(NULL, 0, "%d", 12345) != 5 || sprintf(buf, "%c%c", 'a', 0) != 2 || buf[1])
        return 42;
    FILE *f = tmpfile();
    if (!f || fprintf(f, "%.1f|%hhd", 2.25, 513) != 5)
        return 43;
    rewind(f);
    if (!fgets(buf, sizeof buf, f) || strcmp(buf, "2.2|1"))
        return 44;
    fclose(f);
    return 0;
}

static int wide(void) {
    volatile double zero = 0.0;
    wchar_t w[64], small[4];
    if (swprintf(w, 64, L"%s|%ls|%c|%lc|%hhd|%.1f", "nar", L"wid", 'c', (wint_t)L'w', 300,
                 1.0 / zero) != 18 ||
        wcscmp(w, L"nar|wid|c|w|44|inf"))
        return 50;
    if (swprintf(small, 4, L"%ls", L"abcdef") >= 0)
        return 51;
    FILE *f = tmpfile();
    if (!f || fwprintf(f, L"%ls %d", L"x", 7) != 3)
        return 52;
    rewind(f);
    if (!fgetws(w, 64, f) || wcscmp(w, L"x 7"))
        return 53;
    fclose(f);
    return 0;
}

// Under the first locale named here that the C library has, with a comma
// for its decimal point.
static int comma(void) {
    static const char *names[] = {"de_DE.UTF-8", "de_DE", "German_Germany.1252", "German"};
    int r = 0;
    for (unsigned i = 0; i < sizeof names / sizeof *names; ++i) {
        if (!setlocale(LC_NUMERIC, names[i]))
            continue;
        if (*localeconv()->decimal_point == ',' &&
            (snprintf(buf, sizeof buf, "%.1f %g", 1.5, 0.25) != 8 || strcmp(buf, "1,5 0,25")))
            r = 60;
        break;
    }
    setlocale(LC_NUMERIC, "C");
    return r;
}

int main(void) {
    int r;
    if ((r = narrow()) || (r = wide()) || (r = comma()))
        return r;
    return 0;
}
