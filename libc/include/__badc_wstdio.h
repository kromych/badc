// __badc_wstdio.h -- the functions of the UCRT's corecrt_wstdio.h, which its
// <stdio.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. Each binds to msvcrt.dll, which exports
// it on both targets, but for these:
// - The twelve C99 formatters and scanners are libc/lib/printf_ext.c's and
//   libc/lib/scanf_ext.c's.
// - _getws comes from ucrtbase.dll on arm64, whose msvcrt.dll lacks it.
// _swprintf and _vswprintf are msvcrt.dll's forms without a count. The
// UCRT's stdio entry points (__stdio_common_*), its _nolock forms and
// _getws_s are ucrtbase.dll's alone and are not declared, nor are the
// forms the UCRT defines inline with no export behind them.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

typedef __WINT_TYPE__ wint_t;
struct __c5_FILE;

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::fgetwc, "fgetwc")
wint_t fgetwc(struct __c5_FILE *_Stream);
#pragma binding(msvcrt::fputwc, "fputwc")
wint_t fputwc(wchar_t _Character, struct __c5_FILE *_Stream);
#pragma binding(msvcrt::getwc, "getwc")
wint_t getwc(struct __c5_FILE *_Stream);
#pragma binding(msvcrt::putwc, "putwc")
wint_t putwc(wchar_t _Character, struct __c5_FILE *_Stream);
#pragma binding(msvcrt::ungetwc, "ungetwc")
wint_t ungetwc(wint_t _Character, struct __c5_FILE *_Stream);
#pragma binding(msvcrt::getwchar, "getwchar")
wint_t getwchar(void);
#pragma binding(msvcrt::putwchar, "putwchar")
wint_t putwchar(wchar_t _Character);
#pragma binding(msvcrt::_fgetwchar, "_fgetwchar")
wint_t _fgetwchar(void);
#pragma binding(msvcrt::_fputwchar, "_fputwchar")
wint_t _fputwchar(wchar_t _Character);
#pragma binding(msvcrt::fgetws, "fgetws")
wchar_t *fgetws(wchar_t *_Buffer, int _BufferCount, struct __c5_FILE *_Stream);
#pragma binding(msvcrt::fputws, "fputws")
int fputws(const wchar_t *_Buffer, struct __c5_FILE *_Stream);
#if defined(__aarch64__)
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::_getws, "_getws")
#else
#pragma binding(msvcrt::_getws, "_getws")
#endif
wchar_t *_getws(wchar_t *_Buffer);
#pragma binding(msvcrt::_putws, "_putws")
int _putws(const wchar_t *_Buffer);

#pragma binding(msvcrt::_wfdopen, "_wfdopen")
struct __c5_FILE *_wfdopen(int _FileHandle, const wchar_t *_Mode);
#pragma binding(msvcrt::_wfopen, "_wfopen")
struct __c5_FILE *_wfopen(const wchar_t *_FileName, const wchar_t *_Mode);
#pragma binding(msvcrt::_wfopen_s, "_wfopen_s")
errno_t _wfopen_s(struct __c5_FILE **_Stream, const wchar_t *_FileName, const wchar_t *_Mode);
#pragma binding(msvcrt::_wfreopen, "_wfreopen")
struct __c5_FILE *_wfreopen(const wchar_t *_FileName, const wchar_t *_Mode,
                            struct __c5_FILE *_OldStream);
#pragma binding(msvcrt::_wfreopen_s, "_wfreopen_s")
errno_t _wfreopen_s(struct __c5_FILE **_Stream, const wchar_t *_FileName, const wchar_t *_Mode,
                    struct __c5_FILE *_OldStream);
#pragma binding(msvcrt::_wfsopen, "_wfsopen")
struct __c5_FILE *_wfsopen(const wchar_t *_FileName, const wchar_t *_Mode, int _ShFlag);
#pragma binding(msvcrt::_wpopen, "_wpopen")
struct __c5_FILE *_wpopen(const wchar_t *_Command, const wchar_t *_Mode);
#pragma binding(msvcrt::_wperror, "_wperror")
void _wperror(const wchar_t *_ErrorMessage);
#pragma binding(msvcrt::_wremove, "_wremove")
int _wremove(const wchar_t *_FileName);
#pragma binding(msvcrt::_wtempnam, "_wtempnam")
wchar_t *_wtempnam(const wchar_t *_Directory, const wchar_t *_FilePrefix);
#pragma binding(msvcrt::_wtmpnam, "_wtmpnam")
wchar_t *_wtmpnam(wchar_t *_Buffer);
#pragma binding(msvcrt::_wtmpnam_s, "_wtmpnam_s")
errno_t _wtmpnam_s(wchar_t *_Buffer, size_t _BufferCount);

int fwprintf(struct __c5_FILE *_Stream, const wchar_t *_Format, ...);
int vfwprintf(struct __c5_FILE *_Stream, const wchar_t *_Format, __builtin_va_list _ArgList);
int wprintf(const wchar_t *_Format, ...);
int vwprintf(const wchar_t *_Format, __builtin_va_list _ArgList);
int swprintf(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
int vswprintf(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
              __builtin_va_list _ArgList);
int fwscanf(struct __c5_FILE *_Stream, const wchar_t *_Format, ...);
int vfwscanf(struct __c5_FILE *_Stream, const wchar_t *_Format, __builtin_va_list _ArgList);
int wscanf(const wchar_t *_Format, ...);
int vwscanf(const wchar_t *_Format, __builtin_va_list _ArgList);
int swscanf(const wchar_t *_Buffer, const wchar_t *_Format, ...);
int vswscanf(const wchar_t *_Buffer, const wchar_t *_Format, __builtin_va_list _ArgList);

#pragma binding(msvcrt::_fwprintf_l, "_fwprintf_l")
int _fwprintf_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_fwprintf_p, "_fwprintf_p")
int _fwprintf_p(struct __c5_FILE *_Stream, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_fwprintf_p_l, "_fwprintf_p_l")
int _fwprintf_p_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::fwprintf_s, "fwprintf_s")
int fwprintf_s(struct __c5_FILE *_Stream, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_fwprintf_s_l, "_fwprintf_s_l")
int _fwprintf_s_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vfwprintf_l, "_vfwprintf_l")
int _vfwprintf_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale,
                 __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vfwprintf_p, "_vfwprintf_p")
int _vfwprintf_p(struct __c5_FILE *_Stream, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vfwprintf_p_l, "_vfwprintf_p_l")
int _vfwprintf_p_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale,
                   __builtin_va_list _ArgList);
#pragma binding(msvcrt::vfwprintf_s, "vfwprintf_s")
int vfwprintf_s(struct __c5_FILE *_Stream, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vfwprintf_s_l, "_vfwprintf_s_l")
int _vfwprintf_s_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale,
                   __builtin_va_list _ArgList);
#pragma binding(msvcrt::_wprintf_l, "_wprintf_l")
int _wprintf_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_wprintf_p, "_wprintf_p")
int _wprintf_p(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_wprintf_p_l, "_wprintf_p_l")
int _wprintf_p_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::wprintf_s, "wprintf_s")
int wprintf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_wprintf_s_l, "_wprintf_s_l")
int _wprintf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vwprintf_l, "_vwprintf_l")
int _vwprintf_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vwprintf_p, "_vwprintf_p")
int _vwprintf_p(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vwprintf_p_l, "_vwprintf_p_l")
int _vwprintf_p_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vwprintf_s, "vwprintf_s")
int vwprintf_s(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vwprintf_s_l, "_vwprintf_s_l")
int _vwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);

#pragma binding(msvcrt::_swprintf, "_swprintf")
int _swprintf(wchar_t *_Buffer, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_vswprintf, "_vswprintf")
int _vswprintf(wchar_t *_Buffer, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_swprintf_c, "_swprintf_c")
int _swprintf_c(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_swprintf_c_l, "_swprintf_c_l")
int _swprintf_c_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                  _locale_t _Locale, ...);
#pragma binding(msvcrt::_swprintf_p_l, "_swprintf_p_l")
int _swprintf_p_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                  _locale_t _Locale, ...);
#pragma binding(msvcrt::swprintf_s, "swprintf_s")
int swprintf_s(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_swprintf_s_l, "_swprintf_s_l")
int _swprintf_s_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                  _locale_t _Locale, ...);
#pragma binding(msvcrt::_vswprintf_c, "_vswprintf_c")
int _vswprintf_c(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                 __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vswprintf_c_l, "_vswprintf_c_l")
int _vswprintf_c_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                   _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vswprintf_l, "_vswprintf_l")
int _vswprintf_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                 _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vswprintf_p_l, "_vswprintf_p_l")
int _vswprintf_p_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                   _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vswprintf_s, "vswprintf_s")
int vswprintf_s(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vswprintf_s_l, "_vswprintf_s_l")
int _vswprintf_s_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                   _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_snwprintf, "_snwprintf")
int _snwprintf(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_snwprintf_l, "_snwprintf_l")
int _snwprintf_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                 _locale_t _Locale, ...);
#pragma binding(msvcrt::_snwprintf_s, "_snwprintf_s")
int _snwprintf_s(wchar_t *_Buffer, size_t _BufferCount, size_t _MaxCount,
                 const wchar_t *_Format, ...);
#pragma binding(msvcrt::_snwprintf_s_l, "_snwprintf_s_l")
int _snwprintf_s_l(wchar_t *_Buffer, size_t _BufferCount, size_t _MaxCount,
                   const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vsnwprintf, "_vsnwprintf")
int _vsnwprintf(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vsnwprintf_l, "_vsnwprintf_l")
int _vsnwprintf_l(wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                  _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vsnwprintf_s, "_vsnwprintf_s")
int _vsnwprintf_s(wchar_t *_Buffer, size_t _BufferCount, size_t _MaxCount,
                  const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vsnwprintf_s_l, "_vsnwprintf_s_l")
int _vsnwprintf_s_l(wchar_t *_Buffer, size_t _BufferCount, size_t _MaxCount,
                    const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_scwprintf, "_scwprintf")
int _scwprintf(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_scwprintf_l, "_scwprintf_l")
int _scwprintf_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_scwprintf_p_l, "_scwprintf_p_l")
int _scwprintf_p_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vscwprintf, "_vscwprintf")
int _vscwprintf(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vscwprintf_l, "_vscwprintf_l")
int _vscwprintf_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_vscwprintf_p_l, "_vscwprintf_p_l")
int _vscwprintf_p_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);

#pragma binding(msvcrt::_fwscanf_l, "_fwscanf_l")
int _fwscanf_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::fwscanf_s, "fwscanf_s")
int fwscanf_s(struct __c5_FILE *_Stream, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_fwscanf_s_l, "_fwscanf_s_l")
int _fwscanf_s_l(struct __c5_FILE *_Stream, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_wscanf_l, "_wscanf_l")
int _wscanf_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::wscanf_s, "wscanf_s")
int wscanf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::_wscanf_s_l, "_wscanf_s_l")
int _wscanf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_swscanf_l, "_swscanf_l")
int _swscanf_l(const wchar_t *_Buffer, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::swscanf_s, "swscanf_s")
int swscanf_s(const wchar_t *_Buffer, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_swscanf_s_l, "_swscanf_s_l")
int _swscanf_s_l(const wchar_t *_Buffer, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_snwscanf, "_snwscanf")
int _snwscanf(const wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_snwscanf_l, "_snwscanf_l")
int _snwscanf_l(const wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                _locale_t _Locale, ...);
#pragma binding(msvcrt::_snwscanf_s, "_snwscanf_s")
int _snwscanf_s(const wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_snwscanf_s_l, "_snwscanf_s_l")
int _snwscanf_s_l(const wchar_t *_Buffer, size_t _BufferCount, const wchar_t *_Format,
                  _locale_t _Locale, ...);

#endif
