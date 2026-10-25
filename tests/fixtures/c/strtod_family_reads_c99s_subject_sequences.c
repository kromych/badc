// C99 7.20.1.3 and 7.24.4.1.1: strtod, atof and wcstod read infinities,
// NaNs and hexadecimal significands with a binary exponent, end each subject
// where its longest matching sequence ends, round to the nearest value, and
// set ERANGE for a value that overflows or underflows inexactly; strtof and
// wcstof round once to float, strtold and wcstold read as the target's long
// double. A locale whose decimal point is a comma reads the comma and stops
// at a period.
// snapshot-budget: exempt

#include <errno.h>
#include <locale.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

struct conv_case {
    const char *in;
    int used;
    unsigned long long bits;
    // 1: ERANGE, 0: errno untouched, -1: either, for a value that rounds up
    // to the least normal one (glibc detects tininess before rounding,
    // libSystem after).
    int erange;
};

#define INF 0x7ff0000000000000ULL
// Any NaN.
#define A_NAN (~0ULL)

static const struct conv_case cases[] = {
    {"inf", 3, INF, 0},
    {"-INFINITY", 9, 0xfff0000000000000ULL, 0},
    {"infin", 3, INF, 0},
    {"nan", 3, A_NAN, 0},
    {"NAN(abc_9)x", 10, A_NAN, 0},
    {"nan(", 3, A_NAN, 0},
    {"0x1p3", 5, 0x4020000000000000ULL, 0},
    {"0x1.8p1", 7, 0x4008000000000000ULL, 0},
    {"0X.8P1", 6, 0x3ff0000000000000ULL, 0},
    {"0x1p", 3, 0x3ff0000000000000ULL, 0},
    {"0x", 1, 0, 0},
    {"0xg", 1, 0, 0},
    {" \t+0x10", 7, 0x4030000000000000ULL, 0},
    {"-0x1p-1074", 10, 0x8000000000000001ULL, 0},
    {"0x1p-1076", 9, 0, 1},
    {"0x1.8p-1074", 11, 0x2, 1},
    {"0x1.fffffffffffff8p-1023", 24, 0x0010000000000000ULL, -1},
    {"0x0.fffffffffffff8p-1022", 24, 0x0010000000000000ULL, -1},
    {"0x1.ffffffffffffe8p-1023", 24, 0x000fffffffffffffULL, 1},
    {"0x1p1023", 8, 0x7fe0000000000000ULL, 0},
    {"0x1p1024", 8, INF, 1},
    {"0x1.0000000000000801p0", 22, 0x3ff0000000000001ULL, 0},
    {"0x123456789abcdef0123p0", 23, 0x44723456789abcdfULL, 0},
    {"1e400", 5, INF, 1},
    {"1e-400", 6, 0, 1},
    {"2.5e-324", 8, 1, 1},
    {"2.4e-324", 8, 0, 1},
    {"2.2250738585072014e-308", 23, 0x0010000000000000ULL, 0},
    {"2.2250738585072012e-308", 23, 0x0010000000000000ULL, -1},
    {"1.7976931348623157e308", 22, 0x7fefffffffffffffULL, 0},
    {"0.1", 3, 0x3fb999999999999aULL, 0},
    {"  -12.5e3x", 9, 0xc0c86a0000000000ULL, 0},
    {"1,5", 1, 0x3ff0000000000000ULL, 0},
    {"0e999999", 8, 0, 0},
    {"e5", 0, 0, 0},
    {"", 0, 0, 0},
};

static int same(double v, unsigned long long bits) {
    unsigned long long b;
    memcpy(&b, &v, sizeof b);
    return bits == A_NAN ? v != v : b == bits;
}

// strtod, wcstod and atof over `c`: 0, or which one disagrees.
static int check(const struct conv_case *c) {
    wchar_t w[32], *wend;
    char *end;
    mbstowcs(w, c->in, 32);
    for (int way = 0; way < 3; ++way) {
        double v;
        int used = c->used;
        errno = 0;
        if (way == 0) {
            v = strtod(c->in, &end);
            used = (int)(end - c->in);
        } else if (way == 1) {
            v = wcstod(w, &wend);
            used = (int)(wend - w);
        } else {
            v = atof(c->in);
        }
        int e = errno == ERANGE;
        if (!same(v, c->bits) || used != c->used || (way < 2 && c->erange >= 0 && e != c->erange))
            return way + 1;
    }
    return 0;
}

static int floats(void) {
    float f;
    char *end;
    wchar_t *wend;
    errno = 0;
    f = strtof("1.00000005960464477539062500001", NULL);
    if (f != 0x1.000002p0f || errno)
        return 1;
    f = strtof("nan", NULL);
    if (f == f || strtof("0x1.8p1", NULL) != 3.0f || strtof("-inf", NULL) != -INFINITY)
        return 2;
    if (strtof("3.40282347e+38", NULL) != 3.40282347e+38f)
        return 3;
    errno = 0;
    if (strtof("1e39", NULL) != (float)INFINITY || errno != ERANGE)
        return 4;
    errno = 0;
    if (strtof("1e-50", NULL) != 0 || errno != ERANGE)
        return 5;
    if (strtof("0x1.fffffep-127", NULL) != 0x1p-126f || strtold("0x1.8p1x", &end) != 3.0L ||
        *end != 'x')
        return 7;
    f = wcstof(L"0x1p-149x", &wend);
    if (f != 0x1p-149f || *wend != L'x' || wcstold(L"0x1p3", NULL) != 8.0L)
        return 6;
    return 0;
}

// Under the first locale named here that the C library has, with a comma
// for its decimal point.
static int comma(void) {
    static const char *names[] = {"de_DE.UTF-8", "de_DE", "German_Germany.1252", "German"};
    char *end;
    int r = 0;
    for (unsigned i = 0; i < sizeof names / sizeof *names; ++i) {
        if (!setlocale(LC_NUMERIC, names[i]))
            continue;
        if (*localeconv()->decimal_point == ',') {
            if (strtod("1,5", &end) != 1.5 || *end)
                r = 1;
            else if (strtod("1.5", &end) != 1.0 || *end != '.')
                r = 2;
            else if (strtod("0x1,8p1", &end) != 3.0 || *end || wcstod(L"2,25", NULL) != 2.25)
                r = 3;
        }
        break;
    }
    setlocale(LC_NUMERIC, "C");
    return r;
}

int main(void) {
    int r;
    for (unsigned i = 0; i < sizeof cases / sizeof cases[0]; ++i)
        if ((r = check(&cases[i])))
            return (int)i * 4 + r;
    if ((r = floats()))
        return 200 + r;
    if ((r = comma()))
        return 220 + r;
    return 0;
}
