// <wchar.h> -- wide-character / wide-string surface (C99 7.24).

#pragma once

// `wchar_t` lives in <stddef.h> (C99 7.17p2); <wchar.h>
// transitively includes it so a source that pulls in only
// `<wchar.h>` still sees the typedef. badc encodes `wchar_t` as
// `int` on the Unix targets and as a 16-bit unit on Windows
// (UTF-16), matching each platform's ABI.
#include <stddef.h>

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::wcslen, "wcslen")
#endif

unsigned long long wcslen(const wchar_t *s);
