// __badc_ucrt_stdio.h -- the UCRT's stdio entry points, which the inline
// formatters and scanners of its <stdio.h> and <wchar.h> call, and the
// standard-stream accessor its stdin, stdout and stderr expand to. Each is
// ucrtbase.dll's alone; badc's own stdio is msvcrt.dll's, and these let an
// object compiled against the UCRT's headers link. Prototypes as the UCRT's
// corecrt_stdio.h and corecrt_wstdio.h give them.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

struct __c5_FILE;

#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::__acrt_iob_func, "__acrt_iob_func")
struct __c5_FILE *__acrt_iob_func(unsigned _Index);
#pragma binding(ucrtbase::__stdio_common_vfprintf, "__stdio_common_vfprintf")
int __stdio_common_vfprintf(unsigned long long _Options, struct __c5_FILE *_Stream, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfprintf_s, "__stdio_common_vfprintf_s")
int __stdio_common_vfprintf_s(unsigned long long _Options, struct __c5_FILE *_Stream, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfprintf_p, "__stdio_common_vfprintf_p")
int __stdio_common_vfprintf_p(unsigned long long _Options, struct __c5_FILE *_Stream, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfscanf, "__stdio_common_vfscanf")
int __stdio_common_vfscanf(unsigned long long _Options, struct __c5_FILE *_Stream, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsprintf, "__stdio_common_vsprintf")
int __stdio_common_vsprintf(unsigned long long _Options, char *_Buffer, __SIZE_TYPE__ _BufferCount, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsprintf_s, "__stdio_common_vsprintf_s")
int __stdio_common_vsprintf_s(unsigned long long _Options, char *_Buffer, __SIZE_TYPE__ _BufferCount, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsprintf_p, "__stdio_common_vsprintf_p")
int __stdio_common_vsprintf_p(unsigned long long _Options, char *_Buffer, __SIZE_TYPE__ _BufferCount, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsnprintf_s, "__stdio_common_vsnprintf_s")
int __stdio_common_vsnprintf_s(unsigned long long _Options, char *_Buffer, __SIZE_TYPE__ _BufferCount, __SIZE_TYPE__ _MaxCount,
    char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsscanf, "__stdio_common_vsscanf")
int __stdio_common_vsscanf(unsigned long long _Options, char const *_Buffer, __SIZE_TYPE__ _BufferCount, char const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfwprintf, "__stdio_common_vfwprintf")
int __stdio_common_vfwprintf(unsigned long long _Options, struct __c5_FILE *_Stream, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfwprintf_s, "__stdio_common_vfwprintf_s")
int __stdio_common_vfwprintf_s(unsigned long long _Options, struct __c5_FILE *_Stream, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfwprintf_p, "__stdio_common_vfwprintf_p")
int __stdio_common_vfwprintf_p(unsigned long long _Options, struct __c5_FILE *_Stream, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vfwscanf, "__stdio_common_vfwscanf")
int __stdio_common_vfwscanf(unsigned long long _Options, struct __c5_FILE *_Stream, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vswprintf, "__stdio_common_vswprintf")
int __stdio_common_vswprintf(unsigned long long _Options, wchar_t *_Buffer, __SIZE_TYPE__ _BufferCount, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vswprintf_s, "__stdio_common_vswprintf_s")
int __stdio_common_vswprintf_s(unsigned long long _Options, wchar_t *_Buffer, __SIZE_TYPE__ _BufferCount, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vswprintf_p, "__stdio_common_vswprintf_p")
int __stdio_common_vswprintf_p(unsigned long long _Options, wchar_t *_Buffer, __SIZE_TYPE__ _BufferCount, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vsnwprintf_s, "__stdio_common_vsnwprintf_s")
int __stdio_common_vsnwprintf_s(unsigned long long _Options, wchar_t *_Buffer, __SIZE_TYPE__ _BufferCount, __SIZE_TYPE__ _MaxCount,
    wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(ucrtbase::__stdio_common_vswscanf, "__stdio_common_vswscanf")
int __stdio_common_vswscanf(unsigned long long _Options, wchar_t const *_Buffer, __SIZE_TYPE__ _BufferCount, wchar_t const *_Format,
    _locale_t _Locale, __builtin_va_list _ArgList);

#endif
