// __badc_wtime.h -- the functions of the UCRT's corecrt_wtime.h, which its
// <time.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. msvcrt.dll exports each on both
// targets; _wctime takes the 64-bit time_t, and _wctime_s binds to
// _wctime64_s, as mingw-w64 binds it.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

struct tm;

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_wasctime, "_wasctime")
wchar_t *_wasctime(const struct tm *_Tm);
#pragma binding(msvcrt::_wasctime_s, "_wasctime_s")
errno_t _wasctime_s(wchar_t *_Buffer, size_t _SizeInWords, const struct tm *_Tm);
#pragma binding(msvcrt::wcsftime, "wcsftime")
size_t wcsftime(wchar_t *_Buffer, size_t _SizeInWords, const wchar_t *_Format,
                const struct tm *_Tm);
#pragma binding(msvcrt::_wcsftime_l, "_wcsftime_l")
size_t _wcsftime_l(wchar_t *_Buffer, size_t _SizeInWords, const wchar_t *_Format,
                   const struct tm *_Tm, _locale_t _Locale);
#pragma binding(msvcrt::_wctime, "_wctime")
wchar_t *_wctime(const __time64_t *_Time);
#pragma binding(msvcrt::_wctime32, "_wctime32")
wchar_t *_wctime32(const __time32_t *_Time);
#pragma binding(msvcrt::_wctime32_s, "_wctime32_s")
errno_t _wctime32_s(wchar_t *_Buffer, size_t _SizeInWords, const __time32_t *_Time);
#pragma binding(msvcrt::_wctime64, "_wctime64")
wchar_t *_wctime64(const __time64_t *_Time);
#pragma binding(msvcrt::_wctime64_s, "_wctime64_s")
errno_t _wctime64_s(wchar_t *_Buffer, size_t _SizeInWords, const __time64_t *_Time);
#pragma binding(msvcrt::_wctime_s, "_wctime64_s")
errno_t _wctime_s(wchar_t *_Buffer, size_t _SizeInWords, const __time64_t *_Time);
#pragma binding(msvcrt::_wstrdate, "_wstrdate")
wchar_t *_wstrdate(wchar_t *_Buffer);
#pragma binding(msvcrt::_wstrdate_s, "_wstrdate_s")
errno_t _wstrdate_s(wchar_t *_Buffer, size_t _SizeInWords);
#pragma binding(msvcrt::_wstrtime, "_wstrtime")
wchar_t *_wstrtime(wchar_t *_Buffer);
#pragma binding(msvcrt::_wstrtime_s, "_wstrtime_s")
errno_t _wstrtime_s(wchar_t *_Buffer, size_t _SizeInWords);

#endif
