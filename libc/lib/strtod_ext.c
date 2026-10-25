// strtof, strtold, wcstof and wcstold on the Windows targets, where
// msvcrt.dll exports only strtod and wcstod: each converts through those,
// `long double` being `double` there. The file compiles to nothing
// elsewhere; the native-link driver offers it like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <float.h>
#include <math.h>
#include <stdlib.h>
#include <wchar.h>

// C99 7.20.1.3p10: a value that overflows float is ERANGE, and so, as with
// the Linux and macOS C libraries, is one that underflows to a subnormal or
// zero.
static float narrow(double d) {
    float f = (float)d;
    if ((isinf(f) && !isinf(d)) || (d != 0 && fabsf(f) < FLT_MIN))
        errno = ERANGE;
    return f;
}

float strtof(const char *restrict nptr, char **restrict endptr) {
    return narrow(strtod(nptr, endptr));
}

long double strtold(const char *restrict nptr, char **restrict endptr) {
    return strtod(nptr, endptr);
}

float wcstof(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    return narrow(wcstod(nptr, endptr));
}

long double wcstold(const wchar_t *restrict nptr, wchar_t **restrict endptr) {
    return wcstod(nptr, endptr);
}

#endif
