// C99 7.20.1.3p10 and 7.24.4.1.1p10: strtof and wcstof return HUGE_VALF
// with ERANGE for a value that overflows float, and set ERANGE, as glibc
// and Apple's libc do, for one that underflows to a subnormal or zero; a
// value that rounds to FLT_MAX or is in range leaves errno alone. strtold
// and wcstold convert like strtod.

#include <errno.h>
#include <float.h>
#include <math.h>
#include <stdlib.h>
#include <wchar.h>

struct conversion {
    const char *text;
    const wchar_t *wide;
    float want;
    int range;
};

static const struct conversion cases[] = {
    {"1.5", L"1.5", 1.5f, 0},
    {"1e39", L"1e39", HUGE_VALF, 1},
    {"-1e39", L"-1e39", -HUGE_VALF, 1},
    {"1e-50", L"1e-50", 0.0f, 1},
    {"3.4028235e38", L"3.4028235e38", FLT_MAX, 0},
};

static int converts(const struct conversion *c) {
    char *end = 0;
    wchar_t *wend = 0;
    errno = 0;
    if (strtof(c->text, &end) != c->want || *end || (errno == ERANGE) != c->range)
        return 0;
    errno = 0;
    return wcstof(c->wide, &wend) == c->want && !*wend && (errno == ERANGE) == c->range;
}

int main(void) {
    char *end = 0;
    wchar_t *wend = 0;
    for (unsigned i = 0; i < sizeof cases / sizeof cases[0]; ++i)
        if (!converts(&cases[i]))
            return 1 + (int)i;
    errno = 0;
    float sub = strtof("1e-40", 0);
    if (errno != ERANGE || !(sub > 0 && sub < FLT_MIN))
        return 10;
    if (strtold("0.375z", &end) != 0.375L || *end != 'z')
        return 11;
    if (wcstold(L"-2.5", &wend) != -2.5L || *wend)
        return 12;
    return 0;
}
