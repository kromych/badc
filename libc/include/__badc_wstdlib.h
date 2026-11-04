// __badc_wstdlib.h -- the functions of the UCRT's corecrt_wstdlib.h, which
// its <stdlib.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. Each binds to msvcrt.dll, which exports
// it on both targets, but for these:
// - The C99 wcstod, wcstof and wcstold are libc/lib/strtod_ext.c's.
// - The long long forms bind to the 64-bit entries, as strtoll does, and
//   _wcstold_l to _wcstod_l, `long double` being `double`.
// - _wcstof_l is libc/lib/locale_ext.c's: ucrtbase.dll's takes its own
//   locale objects, not the msvcrt.dll _locale_t.
// ucrtbase.dll alone exports _wdupenv_s, which is not declared.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_itow, "_itow")
wchar_t *_itow(int _Value, wchar_t *_Buffer, int _Radix);
#pragma binding(msvcrt::_ltow, "_ltow")
wchar_t *_ltow(long _Value, wchar_t *_Buffer, int _Radix);
#pragma binding(msvcrt::_ultow, "_ultow")
wchar_t *_ultow(unsigned long _Value, wchar_t *_Buffer, int _Radix);
#pragma binding(msvcrt::_i64tow, "_i64tow")
wchar_t *_i64tow(long long _Value, wchar_t *_Buffer, int _Radix);
#pragma binding(msvcrt::_ui64tow, "_ui64tow")
wchar_t *_ui64tow(unsigned long long _Value, wchar_t *_Buffer, int _Radix);
#pragma binding(msvcrt::_itow_s, "_itow_s")
errno_t _itow_s(int _Value, wchar_t *_Buffer, size_t _BufferCount, int _Radix);
#pragma binding(msvcrt::_ltow_s, "_ltow_s")
errno_t _ltow_s(long _Value, wchar_t *_Buffer, size_t _BufferCount, int _Radix);
#pragma binding(msvcrt::_ultow_s, "_ultow_s")
errno_t _ultow_s(unsigned long _Value, wchar_t *_Buffer, size_t _BufferCount, int _Radix);
#pragma binding(msvcrt::_i64tow_s, "_i64tow_s")
errno_t _i64tow_s(long long _Value, wchar_t *_Buffer, size_t _BufferCount, int _Radix);
#pragma binding(msvcrt::_ui64tow_s, "_ui64tow_s")
errno_t _ui64tow_s(unsigned long long _Value, wchar_t *_Buffer, size_t _BufferCount, int _Radix);

double wcstod(const wchar_t *_String, wchar_t **_EndPtr);
float wcstof(const wchar_t *_String, wchar_t **_EndPtr);
long double wcstold(const wchar_t *_String, wchar_t **_EndPtr);
#pragma binding(msvcrt::wcstol, "wcstol")
long wcstol(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);
#pragma binding(msvcrt::wcstoul, "wcstoul")
unsigned long wcstoul(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);
#pragma binding(msvcrt::wcstoll, "_wcstoi64")
long long wcstoll(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);
#pragma binding(msvcrt::wcstoull, "_wcstoui64")
unsigned long long wcstoull(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);
#pragma binding(msvcrt::_wcstoi64, "_wcstoi64")
long long _wcstoi64(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);
#pragma binding(msvcrt::_wcstoui64, "_wcstoui64")
unsigned long long _wcstoui64(const wchar_t *_String, wchar_t **_EndPtr, int _Radix);

#pragma binding(msvcrt::_wcstod_l, "_wcstod_l")
double _wcstod_l(const wchar_t *_String, wchar_t **_EndPtr, _locale_t _Locale);
#pragma binding(msvcrt::_wcstold_l, "_wcstod_l")
long double _wcstold_l(const wchar_t *_String, wchar_t **_EndPtr, _locale_t _Locale);
float _wcstof_l(const wchar_t *_String, wchar_t **_EndPtr, _locale_t _Locale);
#pragma binding(msvcrt::_wcstol_l, "_wcstol_l")
long _wcstol_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix, _locale_t _Locale);
#pragma binding(msvcrt::_wcstoul_l, "_wcstoul_l")
unsigned long _wcstoul_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix, _locale_t _Locale);
#pragma binding(msvcrt::_wcstoi64_l, "_wcstoi64_l")
long long _wcstoi64_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix, _locale_t _Locale);
#pragma binding(msvcrt::_wcstoll_l, "_wcstoi64_l")
long long _wcstoll_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix, _locale_t _Locale);
#pragma binding(msvcrt::_wcstoui64_l, "_wcstoui64_l")
unsigned long long _wcstoui64_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix,
                                _locale_t _Locale);
#pragma binding(msvcrt::_wcstoull_l, "_wcstoui64_l")
unsigned long long _wcstoull_l(const wchar_t *_String, wchar_t **_EndPtr, int _Radix,
                               _locale_t _Locale);

#pragma binding(msvcrt::_wtof, "_wtof")
double _wtof(const wchar_t *_String);
#pragma binding(msvcrt::_wtof_l, "_wtof_l")
double _wtof_l(const wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::_wtoi, "_wtoi")
int _wtoi(const wchar_t *_String);
#pragma binding(msvcrt::_wtoi_l, "_wtoi_l")
int _wtoi_l(const wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::_wtol, "_wtol")
long _wtol(const wchar_t *_String);
#pragma binding(msvcrt::_wtol_l, "_wtol_l")
long _wtol_l(const wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::_wtoi64, "_wtoi64")
long long _wtoi64(const wchar_t *_String);
#pragma binding(msvcrt::_wtoi64_l, "_wtoi64_l")
long long _wtoi64_l(const wchar_t *_String, _locale_t _Locale);
#pragma binding(msvcrt::_wtoll, "_wtoi64")
long long _wtoll(const wchar_t *_String);
#pragma binding(msvcrt::_wtoll_l, "_wtoi64_l")
long long _wtoll_l(const wchar_t *_String, _locale_t _Locale);

#pragma binding(msvcrt::_wfullpath, "_wfullpath")
wchar_t *_wfullpath(wchar_t *_Buffer, const wchar_t *_Path, size_t _BufferCount);
#pragma binding(msvcrt::_wmakepath, "_wmakepath")
void _wmakepath(wchar_t *_Buffer, const wchar_t *_Drive, const wchar_t *_Dir,
                const wchar_t *_Filename, const wchar_t *_Ext);
#pragma binding(msvcrt::_wmakepath_s, "_wmakepath_s")
errno_t _wmakepath_s(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Drive,
                     const wchar_t *_Dir, const wchar_t *_Filename, const wchar_t *_Ext);
#pragma binding(msvcrt::_wsplitpath, "_wsplitpath")
void _wsplitpath(const wchar_t *_FullPath, wchar_t *_Drive, wchar_t *_Dir, wchar_t *_Filename,
                 wchar_t *_Ext);
#pragma binding(msvcrt::_wsplitpath_s, "_wsplitpath_s")
errno_t _wsplitpath_s(const wchar_t *_FullPath, wchar_t *_Drive, size_t _DriveCount,
                      wchar_t *_Dir, size_t _DirCount, wchar_t *_Filename,
                      size_t _FilenameCount, wchar_t *_Ext, size_t _ExtCount);
#pragma binding(msvcrt::_wperror, "_wperror")
void _wperror(const wchar_t *_ErrorMessage);
#pragma binding(msvcrt::_wgetenv, "_wgetenv")
wchar_t *_wgetenv(const wchar_t *_VarName);
#pragma binding(msvcrt::_wgetenv_s, "_wgetenv_s")
errno_t _wgetenv_s(size_t *_RequiredCount, wchar_t *_Buffer, size_t _BufferCount,
                   const wchar_t *_VarName);
#pragma binding(msvcrt::_wputenv, "_wputenv")
int _wputenv(const wchar_t *_EnvString);
#pragma binding(msvcrt::_wputenv_s, "_wputenv_s")
errno_t _wputenv_s(const wchar_t *_Name, const wchar_t *_Value);
#pragma binding(msvcrt::_wsearchenv, "_wsearchenv")
void _wsearchenv(const wchar_t *_Filename, const wchar_t *_VarName, wchar_t *_Buffer);
#pragma binding(msvcrt::_wsearchenv_s, "_wsearchenv_s")
errno_t _wsearchenv_s(const wchar_t *_Filename, const wchar_t *_VarName, wchar_t *_Buffer,
                      size_t _BufferCount);
#pragma binding(msvcrt::_wsystem, "_wsystem")
int _wsystem(const wchar_t *_Command);

#endif
