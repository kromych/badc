// strtod, strtof, strtold, atof and the wide wcstod, wcstof and wcstold on
// the Windows targets (C99 7.20.1.2, 7.20.1.3, 7.24.4.1.1). msvcrt.dll's
// strtod and wcstod read no infinity, NaN or hexadecimal form and round
// 2.5e-324 to zero, and it exports no float or long double form. Each
// converts a hexadecimal subject here and any other through ucrtbase.dll's
// _strtod_l, _strtof_l, _wcstod_l or _wcstof_l in a locale whose LC_NUMERIC
// is msvcrt's, and sets msvcrt's errno; `long double` is `double` there.
// Elsewhere the file is empty; the link offers it like an archive member.

#ifdef _WIN32

#include <ctype.h>
#include <errno.h>
#include <float.h>
#include <locale.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <wctype.h>

#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::__c5_ucrt_create_locale, "_create_locale")
#pragma binding(ucrtbase::__c5_ucrt_strtod_l, "_strtod_l")
#pragma binding(ucrtbase::__c5_ucrt_strtof_l, "_strtof_l")
#pragma binding(ucrtbase::__c5_ucrt_wcstod_l, "_wcstod_l")
#pragma binding(ucrtbase::__c5_ucrt_wcstof_l, "_wcstof_l")
void *__c5_ucrt_create_locale(int category, const char *locale);
double __c5_ucrt_strtod_l(const char *s, char **end, void *locale);
float __c5_ucrt_strtof_l(const char *s, char **end, void *locale);
double __c5_ucrt_wcstod_l(const wchar_t *s, wchar_t **end, void *locale);
float __c5_ucrt_wcstof_l(const wchar_t *s, wchar_t **end, void *locale);

// ucrtbase's locale for each LC_NUMERIC name msvcrt's setlocale reports,
// made once and kept for the process.
struct numeric {
    struct numeric *next;
    void *locale;
    char name[];
};

static void *numeric_locale(const char *name) {
    static struct numeric *known;
    struct numeric *head = __atomic_load_n(&known, __ATOMIC_ACQUIRE);
    for (struct numeric *e = head; e; e = e->next)
        if (!strcmp(e->name, name))
            return e->locale;
    size_t len = strlen(name) + 1;
    struct numeric *e = malloc(sizeof *e + len);
    if (!e)
        return NULL;
    memcpy(e->name, name, len);
    e->locale = __c5_ucrt_create_locale(LC_NUMERIC, name);
    e->next = head;
    while (!__atomic_compare_exchange_n(&known, &e->next, e, 0, __ATOMIC_ACQ_REL,
                                        __ATOMIC_ACQUIRE))
        ;
    return e->locale;
}

static void *locale(void) {
    if (*localeconv()->decimal_point == '.')
        return numeric_locale("C");
    return numeric_locale(setlocale(LC_NUMERIC, NULL));
}

static unsigned at(const void *s, int wide, size_t i) {
    return wide ? (unsigned)((const wchar_t *)s)[i] : ((const unsigned char *)s)[i];
}

static unsigned lower(unsigned c) {
    return c >= 'A' && c <= 'Z' ? c - 'A' + 'a' : c;
}

static int hexdigit(unsigned c) {
    c = lower(c);
    return c >= '0' && c <= '9' ? (int)(c - '0') : c >= 'a' && c <= 'f' ? (int)(c - 'a' + 10) : -1;
}

static int space(const void *s, int wide, size_t i) {
    return wide ? iswspace((wint_t)at(s, wide, i)) : isspace((int)at(s, wide, i));
}

// q * 2^e as a double, for q below 2^53 and e at or above -1074.
static double scaled(unsigned long long q, long e) {
    int t = 63;
    unsigned long long b = q;
    double v;
    if (!q)
        return 0;
    while (!(q >> t))
        --t;
    if (e + t >= -1022)
        b = (unsigned long long)(e + t + 1023) << 52 | ((q << (52 - t)) & ((1ULL << 52) - 1));
    memcpy(&v, &b, sizeof v);
    return v;
}

// The hexadecimal significand and binary exponent at `s`, past its 0x,
// rounded to nearest even at `bits` bits, the least at exponent `lsb_min` or
// above and the greatest finite exponent `emax`. The units read go through
// *n, and *range is set for an overflow or an inexact subnormal or zero.
static double hex(const void *s, int wide, unsigned point, int bits, long lsb_min, long emax,
                  size_t *n, int *range) {
    unsigned long long m = 0, q;
    long e = 0;
    int sticky = 0, frac = 0, d;
    size_t i = 0;
    for (;; ++i) {
        unsigned c = at(s, wide, i);
        if (c == point && !frac) {
            frac = 1;
            continue;
        }
        if ((d = hexdigit(c)) < 0)
            break;
        if (m >> 60) {
            sticky |= d != 0;
            e += frac ? 0 : 4;
        } else {
            m = m * 16 + (unsigned)d;
            e -= frac ? 4 : 0;
        }
    }
    if (lower(at(s, wide, i)) == 'p') {
        size_t j = i + 1;
        int neg = at(s, wide, j) == '-';
        j += neg || at(s, wide, j) == '+';
        long x = 0;
        if (at(s, wide, j) - '0' < 10) {
            for (; at(s, wide, j) - '0' < 10; ++j)
                x = x < 100000 ? x * 10 + (long)(at(s, wide, j) - '0') : x;
            e += neg ? -x : x;
            i = j;
        }
    }
    *n = i;
    *range = 0;
    if (!m)
        return 0;
    int top = 63;
    while (!(m >> top))
        --top;
    long lsb = e + top - (bits - 1) > lsb_min ? e + top - (bits - 1) : lsb_min, shift = lsb - e;
    int inexact = sticky;
    if (shift <= 0) {
        q = m << -shift;
    } else if (shift >= 64) {
        q = shift == 64 && (m > 1ULL << 63 || (m == 1ULL << 63 && sticky));
        inexact = 1;
    } else {
        unsigned long long rem = m & ((1ULL << shift) - 1), half = 1ULL << (shift - 1);
        q = m >> shift;
        q += rem > half || (rem == half && (sticky || (q & 1)));
        inexact |= rem != 0;
    }
    if (q >> bits) {
        q >>= 1;
        ++lsb;
    }
    if (lsb + bits - 1 > emax) {
        *range = 1;
        return HUGE_VAL;
    }
    *range = inexact && !(q >> (bits - 1));
    return scaled(q, lsb);
}

// C99 7.20.1.3p10: the `n` units ucrtbase read at `s` are a finite decimal
// subject with a nonzero significand whose value `mag` overflows, or
// underflows below `min` to a subnormal or zero: ERANGE.
static void range(const void *s, int wide, size_t n, double mag, double min) {
    size_t i = 0;
    if (!isinf(mag) && mag >= min)
        return;
    while (i < n && space(s, wide, i))
        ++i;
    i += i < n && (at(s, wide, i) == '+' || at(s, wide, i) == '-');
    if (i == n || lower(at(s, wide, i)) == 'i' || lower(at(s, wide, i)) == 'n')
        return;
    for (; i < n && lower(at(s, wide, i)) != 'e'; ++i)
        if (at(s, wide, i) - '1' < 9) {
            errno = ERANGE;
            return;
        }
}

// The subject at `s`, a float's value when `is_float`; the units read go
// through *used. ucrtbase gives a hexadecimal subject whose rounding carries
// from the subnormal into the normal range a wrong exponent
// (0x1.fffffffffffff8p-1023 reads as 0x1p-1019), so that form converts here.
static double convert(const void *s, int wide, int is_float, size_t *used) {
    unsigned point = (unsigned char)*localeconv()->decimal_point;
    size_t i = 0, n;
    while (space(s, wide, i))
        ++i;
    int neg = at(s, wide, i) == '-', r;
    i += neg || at(s, wide, i) == '+';
    if (at(s, wide, i) == '0' && lower(at(s, wide, i + 1)) == 'x' &&
        (hexdigit(at(s, wide, i + 2)) >= 0 ||
         (at(s, wide, i + 2) == point && hexdigit(at(s, wide, i + 3)) >= 0))) {
        const void *digits = wide ? (const void *)((const wchar_t *)s + i + 2)
                                  : (const void *)((const char *)s + i + 2);
        double v = is_float ? hex(digits, wide, point, 24, -149, 127, &n, &r)
                            : hex(digits, wide, point, 53, -1074, 1023, &n, &r);
        if (r)
            errno = ERANGE;
        *used = i + 2 + n;
        return neg ? -v : v;
    }
    void *loc = locale();
    double v;
    if (wide) {
        wchar_t *e;
        v = is_float ? __c5_ucrt_wcstof_l(s, &e, loc) : __c5_ucrt_wcstod_l(s, &e, loc);
        n = (size_t)(e - (const wchar_t *)s);
    } else {
        char *e;
        v = is_float ? __c5_ucrt_strtof_l(s, &e, loc) : __c5_ucrt_strtod_l(s, &e, loc);
        n = (size_t)(e - (const char *)s);
    }
    range(s, wide, n, fabs(v), is_float ? FLT_MIN : DBL_MIN);
    *used = n;
    return v;
}

double strtod(const char *nptr, char **endptr) {
    size_t n;
    double v = convert(nptr, 0, 0, &n);
    if (endptr)
        *endptr = (char *)nptr + n;
    return v;
}

float strtof(const char *restrict nptr, char **restrict endptr) {
    size_t n;
    float v = (float)convert(nptr, 0, 1, &n);
    if (endptr)
        *endptr = (char *)nptr + n;
    return v;
}

long double strtold(const char *restrict nptr, char **restrict endptr) {
    return strtod(nptr, endptr);
}

double atof(const char *nptr) {
    return strtod(nptr, NULL);
}

double wcstod(const wchar_t *nptr, wchar_t **endptr) {
    size_t n;
    double v = convert(nptr, 1, 0, &n);
    if (endptr)
        *endptr = (wchar_t *)nptr + n;
    return v;
}

float wcstof(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    size_t n;
    float v = (float)convert(nptr, 1, 1, &n);
    if (endptr)
        *endptr = (wchar_t *)nptr + n;
    return v;
}

long double wcstold(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    return wcstod(nptr, endptr);
}

#endif
