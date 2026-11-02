// <locale.h>'s _wcreate_locale on the Windows targets, which ucrtbase.dll
// exports and msvcrt.dll does not: the name converts through the ANSI code
// page, the one the UCRT's _create_locale converts from, and msvcrt.dll's
// _create_locale makes the locale, so the msvcrt _l functions and
// _free_locale take it. Elsewhere the file is empty; the link offers it like
// an archive member.

#ifdef _WIN32

#include <locale.h>
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

#endif
