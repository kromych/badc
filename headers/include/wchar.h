// <wchar.h> -- wide-character / wide-string surface (C99 7.24).

#pragma once

// `wchar_t` lives in <stddef.h> (C99 7.17p2); <wchar.h>
// transitively includes it so a source that pulls in only
// `<wchar.h>` still sees the typedef. badc encodes `wchar_t`
// as plain `int` matching the Linux / macOS ABI; Windows
// stores wide characters in 16-bit slots and uses `WCHAR`
// from <windows.h> for that path.
#include <stddef.h>

#ifdef _WIN32
#pragma binding(msvcrt::wcslen, "wcslen")
#endif

unsigned long long wcslen(const unsigned short *s);
