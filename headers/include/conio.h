#pragma once
// MSVC CRT direct-console I/O (`_getch` family) plus the `_locking`
// mode constants. These entry points live in msvcrt.dll; the
// underscore-prefixed names are the spellings the CRT exports.
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

// `_locking` mode argument (MSVC <sys/locking.h>). Values pinned by
// the CRT.
#define _LK_UNLCK 0
#define _LK_LOCK  1
#define _LK_NBLCK 2
#define _LK_RLCK  3
#define _LK_NBRLCK 4
#endif
