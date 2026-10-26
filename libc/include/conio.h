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

// `_getwch`/`_getwche`/`_ungetwch` return `wint_t` (<wchar.h>), the C
// runtime's `unsigned short`, with WEOF 0xFFFF.
int    _getch(void);
int    _getche(void);
wint_t _getwch(void);
wint_t _getwche(void);
int    _putch(int c);
wint_t _putwch(wchar_t c);
int    _ungetch(int c);
wint_t _ungetwch(wint_t c);
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
#pragma binding(msvcrt::_cgetws_s, "_cgetws_s")
errno_t _cgetws_s(wchar_t *_Buffer, size_t _SizeInWords, size_t *_SizeRead);
#pragma binding(msvcrt::_cwprintf_s, "_cwprintf_s")
int _cwprintf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwprintf_s_l, "_cwprintf_s_l")
int _cwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_cwscanf_s, "_cwscanf_s")
int _cwscanf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwscanf_s_l, "_cwscanf_s_l")
int _cwscanf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vcwprintf_s, "_vcwprintf_s")
int _vcwprintf_s(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_s_l, "_vcwprintf_s_l")
int _vcwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);

// Callers historically reached the `_locking` mode constants through
// this header; they live in their CRT home now.
#include <sys/locking.h>
#endif
