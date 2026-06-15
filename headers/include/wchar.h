// <wchar.h> -- wide-character / wide-string surface (C99 7.24).

#pragma once

// `wchar_t` lives in <stddef.h> (C99 7.17p2); <wchar.h>
// transitively includes it so a source that pulls in only
// `<wchar.h>` still sees the typedef. badc encodes `wchar_t` as
// `int` on the Unix targets and as a 16-bit unit on Windows
// (UTF-16), matching each platform's ABI.
#include <stddef.h>

// `wint_t` holds any `wchar_t` value plus `WEOF` (C99 7.24.1). It is a
// 4-byte integer on the supported Unix targets.
typedef int wint_t;
#define WEOF ((wint_t)-1)

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::wcslen, "wcslen")
#pragma binding(msvcrt::wcscmp, "wcscmp")
#pragma binding(msvcrt::wcsncmp, "wcsncmp")
#pragma binding(msvcrt::wcschr, "wcschr")
#pragma binding(msvcrt::wcsrchr, "wcsrchr")
#pragma binding(msvcrt::wcscpy, "wcscpy")
#pragma binding(msvcrt::wcsncpy, "wcsncpy")
#pragma binding(msvcrt::wcscat, "wcscat")
#pragma binding(msvcrt::wcstol, "wcstol")
#pragma binding(msvcrt::wcstoul, "wcstoul")
#pragma binding(msvcrt::wcstod, "wcstod")
#endif

// Wide-string handling (C99 7.24.4). `size_t` comes from <stddef.h>.
unsigned long long wcslen(const wchar_t *s);
int wcscmp(const wchar_t *s1, const wchar_t *s2);
int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wcschr(const wchar_t *s, wchar_t c);
wchar_t *wcsrchr(const wchar_t *s, wchar_t c);
wchar_t *wcscpy(wchar_t *dest, const wchar_t *src);
wchar_t *wcsncpy(wchar_t *dest, const wchar_t *src, size_t n);
wchar_t *wcscat(wchar_t *dest, const wchar_t *src);

// Wide-string numeric conversion (C99 7.24.4.1).
long wcstol(const wchar_t *nptr, wchar_t **endptr, int base);
unsigned long wcstoul(const wchar_t *nptr, wchar_t **endptr, int base);
double wcstod(const wchar_t *nptr, wchar_t **endptr);
