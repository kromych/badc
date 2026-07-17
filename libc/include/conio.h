#pragma once
// MSVC CRT direct-console I/O (`_getch` family). These entry points
// live in msvcrt.dll; the underscore-prefixed names are the spellings
// the CRT exports.
#ifdef _WIN32
// `wchar_t` (<stddef.h>) and `wint_t` (<wchar.h>) back the wide
// console entry points below.
#include <stddef.h>
#include <wchar.h>
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_getch,    "_getch")
#pragma binding(msvcrt::_getche,   "_getche")
#pragma binding(msvcrt::_getwch,   "_getwch")
#pragma binding(msvcrt::_getwche,  "_getwche")
#pragma binding(msvcrt::_putch,    "_putch")
#pragma binding(msvcrt::_putwch,   "_putwch")
#pragma binding(msvcrt::_ungetch,  "_ungetch")
#pragma binding(msvcrt::_ungetwch, "_ungetwch")
#pragma binding(msvcrt::_kbhit,    "_kbhit")

// `_getwch`/`_getwche`/`_ungetwch` return `wint_t`; badc encodes that
// as `int` (<wchar.h>), wide enough for any `wchar_t` plus `WEOF`.
int    _getch(void);
int    _getche(void);
wint_t _getwch(void);
wint_t _getwche(void);
int    _putch(int c);
wint_t _putwch(wchar_t c);
int    _ungetch(int c);
wint_t _ungetwch(wint_t c);
int    _kbhit(void);

// Callers historically reached the `_locking` mode constants through
// this header; they live in their CRT home now.
#include <sys/locking.h>
#endif
