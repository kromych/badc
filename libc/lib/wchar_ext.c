// <wchar.h>'s wcstof and wcstold on the Windows targets, which msvcrt.dll
// does not export; they convert through its wcstod, `long double` being
// `double` there. The file compiles to nothing elsewhere; the native-link
// driver offers it like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <math.h>
#include <wchar.h>

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
