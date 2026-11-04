// __badc_wstring.h -- the wide-string functions of the UCRT's
// corecrt_wstring.h and vcruntime_string.h, which its <string.h> and
// <wchar.h> both include, with its prototypes; mingw-w64's <string.h> and
// <wchar.h> declare them too. msvcrt.dll exports each on both targets. The
// oldnames.lib spellings (`wcsdup`, `wcsicmp`, ...) bind to the underscored
// entries.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::wcscat_s, "wcscat_s")
errno_t wcscat_s(wchar_t *_Destination, rsize_t _SizeInWords, const wchar_t *_Source);
#pragma binding(msvcrt::wcscpy_s, "wcscpy_s")
errno_t wcscpy_s(wchar_t *_Destination, rsize_t _SizeInWords, const wchar_t *_Source);
#pragma binding(msvcrt::wcsncat_s, "wcsncat_s")
errno_t wcsncat_s(wchar_t *_Destination, rsize_t _SizeInWords, const wchar_t *_Source,
                  rsize_t _MaxCount);
#pragma binding(msvcrt::wcsncpy_s, "wcsncpy_s")
errno_t wcsncpy_s(wchar_t *_Destination, rsize_t _SizeInWords, const wchar_t *_Source,
                  rsize_t _MaxCount);
#pragma binding(msvcrt::wcstok_s, "wcstok_s")
wchar_t *wcstok_s(wchar_t *_String, const wchar_t *_Delimiter, wchar_t **_Context);
#pragma binding(msvcrt::_wcsdup, "_wcsdup")
wchar_t *_wcsdup(const wchar_t *_String);
#pragma binding(msvcrt::wcscat, "wcscat")
wchar_t *wcscat(wchar_t *_Destination, const wchar_t *_Source);
#pragma binding(msvcrt::wcscmp, "wcscmp")
int wcscmp(const wchar_t *_String1, const wchar_t *_String2);
#pragma binding(msvcrt::wcscpy, "wcscpy")
wchar_t *wcscpy(wchar_t *_Destination, const wchar_t *_Source);
#pragma binding(msvcrt::wcscspn, "wcscspn")
size_t wcscspn(const wchar_t *_String, const wchar_t *_Control);
#pragma binding(msvcrt::wcslen, "wcslen")
size_t wcslen(const wchar_t *_String);
#pragma binding(msvcrt::wcsnlen, "wcsnlen")
size_t wcsnlen(const wchar_t *_Source, size_t _MaxCount);
static inline size_t wcsnlen_s(const wchar_t *_Source, size_t _MaxCount) {
    return _Source ? wcsnlen(_Source, _MaxCount) : 0;
}
#pragma binding(msvcrt::wcsncat, "wcsncat")
wchar_t *wcsncat(wchar_t *_Destination, const wchar_t *_Source, size_t _Count);
#pragma binding(msvcrt::wcsncmp, "wcsncmp")
int wcsncmp(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount);
#pragma binding(msvcrt::wcsncpy, "wcsncpy")
wchar_t *wcsncpy(wchar_t *_Destination, const wchar_t *_Source, size_t _Count);
#pragma binding(msvcrt::wcspbrk, "wcspbrk")
wchar_t *wcspbrk(const wchar_t *_String, const wchar_t *_Control);
#pragma binding(msvcrt::wcsspn, "wcsspn")
size_t wcsspn(const wchar_t *_String, const wchar_t *_Control);
// C99's wcstok and the two-argument `_wcstok` are libc/lib/string_ext.c's,
// as the UCRT has them: msvcrt.dll's `wcstok` export is the two-argument
// form. The UCRT and mingw-w64 spell `wcstok` as `_wcstok` for C under
// _CRT_NON_CONFORMING_WCSTOK.
#ifndef wcstok
wchar_t *wcstok(wchar_t *_String, const wchar_t *_Delimiter, wchar_t **_Context);
#endif
wchar_t *_wcstok(wchar_t *_String, const wchar_t *_Delimiter);
#ifdef _CRT_NON_CONFORMING_WCSTOK
#define wcstok _wcstok
#endif
#pragma binding(msvcrt::_wcserror, "_wcserror")
wchar_t *_wcserror(int _ErrorNumber);
#pragma binding(msvcrt::_wcserror_s, "_wcserror_s")
errno_t _wcserror_s(wchar_t *_Buffer, size_t _SizeInWords, int _ErrorNumber);
#pragma binding(msvcrt::__wcserror, "__wcserror")
wchar_t *__wcserror(const wchar_t *_String);
#pragma binding(msvcrt::__wcserror_s, "__wcserror_s")
errno_t __wcserror_s(wchar_t *_Buffer, size_t _SizeInWords, const wchar_t *_ErrorMessage);
#pragma binding(msvcrt::_wcsicmp, "_wcsicmp")
int _wcsicmp(const wchar_t *_String1, const wchar_t *_String2);
#pragma binding(msvcrt::_wcsicmp_l, "_wcsicmp_l")
int _wcsicmp_l(const wchar_t *_String1, const wchar_t *_String2, _locale_t _Locale);
#pragma binding(msvcrt::_wcsnicmp, "_wcsnicmp")
int _wcsnicmp(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount);
#pragma binding(msvcrt::_wcsnicmp_l, "_wcsnicmp_l")
int _wcsnicmp_l(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount,
                _locale_t _Locale);
#pragma binding(msvcrt::_wcsnset_s, "_wcsnset_s")
errno_t _wcsnset_s(wchar_t *_Destination, size_t _SizeInWords, wchar_t _Value, size_t _MaxCount);
#pragma binding(msvcrt::_wcsnset, "_wcsnset")
wchar_t *_wcsnset(wchar_t *_String, wchar_t _Value, size_t _MaxCount);
#pragma binding(msvcrt::_wcsrev, "_wcsrev")
wchar_t *_wcsrev(wchar_t *_String);
#pragma binding(msvcrt::_wcsset_s, "_wcsset_s")
errno_t _wcsset_s(wchar_t *_Destination, size_t _SizeInWords, wchar_t _Value);
#pragma binding(msvcrt::_wcsset, "_wcsset")
wchar_t *_wcsset(wchar_t *_String, wchar_t _Value);
#pragma binding(msvcrt::_wcslwr_s, "_wcslwr_s")
errno_t _wcslwr_s(wchar_t *_String, size_t _SizeInWords);
#pragma binding(msvcrt::_wcslwr, "_wcslwr")
wchar_t *_wcslwr(wchar_t *_String);
#pragma binding(msvcrt::_wcslwr_s_l, "_wcslwr_s_l")
errno_t _wcslwr_s_l(wchar_t *_String, size_t _SizeInWords, _locale_t _Locale);
#pragma binding(msvcrt::_wcslwr_l, "_wcslwr_l")
wchar_t *_wcslwr_l(wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::_wcsupr_s, "_wcsupr_s")
errno_t _wcsupr_s(wchar_t *_String, size_t _Size);
#pragma binding(msvcrt::_wcsupr, "_wcsupr")
wchar_t *_wcsupr(wchar_t *_String);
#pragma binding(msvcrt::_wcsupr_s_l, "_wcsupr_s_l")
errno_t _wcsupr_s_l(wchar_t *_String, size_t _Size, _locale_t _Locale);
#pragma binding(msvcrt::_wcsupr_l, "_wcsupr_l")
wchar_t *_wcsupr_l(wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::wcsxfrm, "wcsxfrm")
size_t wcsxfrm(wchar_t *_Destination, const wchar_t *_Source, size_t _MaxCount);
#pragma binding(msvcrt::_wcsxfrm_l, "_wcsxfrm_l")
size_t _wcsxfrm_l(wchar_t *_Destination, const wchar_t *_Source, size_t _MaxCount,
                  _locale_t _Locale);
#pragma binding(msvcrt::wcscoll, "wcscoll")
int wcscoll(const wchar_t *_String1, const wchar_t *_String2);
#pragma binding(msvcrt::_wcscoll_l, "_wcscoll_l")
int _wcscoll_l(const wchar_t *_String1, const wchar_t *_String2, _locale_t _Locale);
#pragma binding(msvcrt::_wcsicoll, "_wcsicoll")
int _wcsicoll(const wchar_t *_String1, const wchar_t *_String2);
#pragma binding(msvcrt::_wcsicoll_l, "_wcsicoll_l")
int _wcsicoll_l(const wchar_t *_String1, const wchar_t *_String2, _locale_t _Locale);
#pragma binding(msvcrt::_wcsncoll, "_wcsncoll")
int _wcsncoll(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount);
#pragma binding(msvcrt::_wcsncoll_l, "_wcsncoll_l")
int _wcsncoll_l(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount,
                _locale_t _Locale);
#pragma binding(msvcrt::_wcsnicoll, "_wcsnicoll")
int _wcsnicoll(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount);
#pragma binding(msvcrt::_wcsnicoll_l, "_wcsnicoll_l")
int _wcsnicoll_l(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount,
                 _locale_t _Locale);
#pragma binding(msvcrt::wcschr, "wcschr")
wchar_t *wcschr(const wchar_t *_Str, wchar_t _Ch);
#pragma binding(msvcrt::wcsrchr, "wcsrchr")
wchar_t *wcsrchr(const wchar_t *_Str, wchar_t _Ch);
#pragma binding(msvcrt::wcsstr, "wcsstr")
wchar_t *wcsstr(const wchar_t *_Str, const wchar_t *_SubStr);
#pragma binding(msvcrt::wcsdup, "_wcsdup")
wchar_t *wcsdup(const wchar_t *_String);
#define wcswcs wcsstr
#pragma binding(msvcrt::wcsicmp, "_wcsicmp")
int wcsicmp(const wchar_t *_String1, const wchar_t *_String2);
#pragma binding(msvcrt::wcsnicmp, "_wcsnicmp")
int wcsnicmp(const wchar_t *_String1, const wchar_t *_String2, size_t _MaxCount);
#pragma binding(msvcrt::wcsnset, "_wcsnset")
wchar_t *wcsnset(wchar_t *_String, wchar_t _Value, size_t _MaxCount);
#pragma binding(msvcrt::wcsrev, "_wcsrev")
wchar_t *wcsrev(wchar_t *_String);
#pragma binding(msvcrt::wcsset, "_wcsset")
wchar_t *wcsset(wchar_t *_String, wchar_t _Value);
#pragma binding(msvcrt::wcslwr, "_wcslwr")
wchar_t *wcslwr(wchar_t *_String);
#pragma binding(msvcrt::wcsupr, "_wcsupr")
wchar_t *wcsupr(wchar_t *_String);
#pragma binding(msvcrt::wcsicoll, "_wcsicoll")
int wcsicoll(const wchar_t *_String1, const wchar_t *_String2);

#endif
