// <locale.h>'s _wcreate_locale and <stdlib.h>'s _strtof_l on the Windows
// targets, which ucrtbase.dll exports and msvcrt.dll does not, over
// msvcrt.dll's locale objects. For _wcreate_locale the name converts through
// the ANSI code page, the one the UCRT's _create_locale converts from, and
// msvcrt.dll's _create_locale makes the locale, so the msvcrt _l functions
// and _free_locale take it. Elsewhere the file is empty; the link offers it
// like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <float.h>
#include <locale.h>
#include <math.h>
#include <stdlib.h>
#include <windows.h>

_locale_t _wcreate_locale(int category, const wchar_t *locale) {
    if (!locale)
        return _create_locale(category, NULL);
    int n = WideCharToMultiByte(CP_ACP, 0, locale, -1, NULL, 0, NULL, NULL);
    char *name = n > 0 ? malloc((size_t)n) : NULL;
    _locale_t result = NULL;
    if (name && WideCharToMultiByte(CP_ACP, 0, locale, -1, name, n, NULL, NULL) == n)
        result = _create_locale(category, name);
    free(name);
    return result;
}

// As mingw-w64's runtime defines it: the locale's _strtod_l rounded to
// float, ERANGE outside float's range (C99 7.20.1.3p10) where the double
// is finite.
float _strtof_l(const char *nptr, char **endptr, _locale_t locale) {
    double v = _strtod_l(nptr, endptr, locale), m = fabs(v);
    if ((m > FLT_MAX && m <= DBL_MAX) || (m > 0 && m < FLT_MIN))
        errno = ERANGE;
    return (float)v;
}

#endif
