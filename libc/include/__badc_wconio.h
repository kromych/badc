// __badc_wconio.h -- the functions of the UCRT's corecrt_wconio.h, which its
// <conio.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. msvcrt.dll exports each on both
// targets. The UCRT's console entry points (__conio_common_*) and _nolock
// forms are ucrtbase.dll's alone, and its _vcwscanf forms have no export;
// none of them is declared.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

typedef __WINT_TYPE__ wint_t;

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_getwch, "_getwch")
wint_t _getwch(void);
#pragma binding(msvcrt::_getwche, "_getwche")
wint_t _getwche(void);
#pragma binding(msvcrt::_putwch, "_putwch")
wint_t _putwch(wchar_t _Character);
#pragma binding(msvcrt::_ungetwch, "_ungetwch")
wint_t _ungetwch(wint_t _Character);
#pragma binding(msvcrt::_cgetws_s, "_cgetws_s")
errno_t _cgetws_s(wchar_t *_Buffer, size_t _BufferCount, size_t *_SizeRead);
#pragma binding(msvcrt::_cputws, "_cputws")
int _cputws(const wchar_t *_Buffer);
#pragma binding(msvcrt::_cwprintf, "_cwprintf")
int _cwprintf(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwprintf_l, "_cwprintf_l")
int _cwprintf_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_cwprintf_p, "_cwprintf_p")
int _cwprintf_p(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwprintf_p_l, "_cwprintf_p_l")
int _cwprintf_p_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_cwprintf_s, "_cwprintf_s")
int _cwprintf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwprintf_s_l, "_cwprintf_s_l")
int _cwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vcwprintf, "_vcwprintf")
int _vcwprintf(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_l, "_vcwprintf_l")
int _vcwprintf_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_p, "_vcwprintf_p")
int _vcwprintf_p(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_p_l, "_vcwprintf_p_l")
int _vcwprintf_p_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_s, "_vcwprintf_s")
int _vcwprintf_s(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vcwprintf_s_l, "_vcwprintf_s_l")
int _vcwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_cwscanf, "_cwscanf")
int _cwscanf(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwscanf_l, "_cwscanf_l")
int _cwscanf_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_cwscanf_s, "_cwscanf_s")
int _cwscanf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_cwscanf_s_l, "_cwscanf_s_l")
int _cwscanf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);

#endif
