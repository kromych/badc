#pragma once
// MSVC CRT direct-console I/O (`_getch` family). These entry points
// live in msvcrt.dll; the underscore-prefixed names are the spellings
// the CRT exports.
#ifdef _WIN32
// `wint_t` (<wchar.h>) backs the wide console entry points.
#include <stddef.h>
#include <wchar.h>
#include <__badc_wconio.h>
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_getch,    "_getch")
#pragma binding(msvcrt::_getche,   "_getche")
#pragma binding(msvcrt::_putch,    "_putch")
#pragma binding(msvcrt::_ungetch,  "_ungetch")
#pragma binding(msvcrt::_kbhit,    "_kbhit")

int    _getch(void);
int    _getche(void);
int    _putch(int c);
int    _ungetch(int c);
int    _kbhit(void);

#include <corecrt.h>
// The bounds-checked forms <tchar.h>'s _s mappings reach, with mingw-w64's
// prototypes (sec_api/*_s.h); msvcrt.dll exports each on both targets.
#pragma binding(msvcrt::_cgets_s, "_cgets_s")
errno_t _cgets_s(char *_Buffer, size_t _Size, size_t *_SizeRead);
#pragma binding(msvcrt::_cprintf_s, "_cprintf_s")
int _cprintf_s(const char *_Format, ...);
#pragma binding(msvcrt::_cprintf_s_l, "_cprintf_s_l")
int _cprintf_s_l(const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_cscanf_s, "_cscanf_s")
int _cscanf_s(const char *_Format, ...);
#pragma binding(msvcrt::_cscanf_s_l, "_cscanf_s_l")
int _cscanf_s_l(const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vcprintf_s, "_vcprintf_s")
int _vcprintf_s(const char *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcprintf_s_l, "_vcprintf_s_l")
int _vcprintf_s_l(const char *_Format, _locale_t _Locale, __builtin_va_list _ArgList);

// Callers historically reached the `_locking` mode constants through
// this header; they live in their CRT home now.
#include <sys/locking.h>
#endif
