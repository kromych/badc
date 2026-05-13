// <wchar.h> -- minimal wide-character / wide-string surface.
//
// c5 doesn't expose `wchar_t` as a built-in; sources that need
// the 16-bit element type use `WCHAR` from <windows.h> on
// Windows targets. The declarations below cover the wide-string
// functions the bundled demos (`demos/nt_loader`) call; expand
// as needed.

#pragma once

#ifdef _WIN32
#pragma binding(msvcrt::wcslen, "wcslen")
#endif

unsigned long long wcslen(const unsigned short *s);
