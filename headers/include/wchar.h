// <wchar.h> -- wide-character / wide-string surface.
//
// c5 does not provide a `wchar_t` typedef. Sources that need
// the 16-bit element type use `WCHAR` from <windows.h>.

#pragma once

#ifdef _WIN32
#pragma binding(msvcrt::wcslen, "wcslen")
#endif

unsigned long long wcslen(const unsigned short *s);
