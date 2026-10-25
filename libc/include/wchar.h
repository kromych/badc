// <wchar.h> -- wide-character / wide-string surface (C99 7.24).

#pragma once

// `wchar_t` lives in <stddef.h> (C99 7.17p2); <wchar.h>
// transitively includes it so a source that pulls in only
// `<wchar.h>` still sees the typedef. badc encodes `wchar_t` as
// `int` on the Unix targets, as a 16-bit unit on Windows (UTF-16),
// and as a 16-bit unit anywhere under `-fshort-wchar`.
#include <stddef.h>

// `wint_t` holds any `wchar_t` value plus `WEOF` (C99 7.24.1): `int` on
// the Unix targets, and on Windows the C runtime's `unsigned short`, whose
// WEOF is 0xFFFF.
typedef __WINT_TYPE__ wint_t;
#ifdef _WIN32
#define WEOF ((wint_t)0xFFFF)
#else
#define WEOF ((wint_t)-1)
#endif

// Conversion state for the restartable multibyte functions (C99
// 7.24.1). The contents are opaque; the host libc reads only the bytes
// it wrote, so an oversized zeroed buffer is safe across libcs.
typedef struct { unsigned char __opaque[128]; } mbstate_t;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wcslen,   "_wcslen")
#pragma binding(libc::wcscmp,   "_wcscmp")
#pragma binding(libc::wcsncmp,  "_wcsncmp")
#pragma binding(libc::wcschr,   "_wcschr")
#pragma binding(libc::wcsrchr,  "_wcsrchr")
#pragma binding(libc::wcscpy,   "_wcscpy")
#pragma binding(libc::wcsncpy,  "_wcsncpy")
#pragma binding(libc::wcscat,   "_wcscat")
#pragma binding(libc::wcstol,   "_wcstol")
#pragma binding(libc::wcstoul,  "_wcstoul")
#pragma binding(libc::wcstod,   "_wcstod")
#pragma binding(libc::wcstok,   "_wcstok")
#pragma binding(libc::wmemchr,  "_wmemchr")
#pragma binding(libc::wmemcmp,  "_wmemcmp")
#pragma binding(libc::wmemcpy,  "_wmemcpy")
#pragma binding(libc::wmemmove, "_wmemmove")
#pragma binding(libc::wmemset,  "_wmemset")
#pragma binding(libc::mbrtowc,  "_mbrtowc")
#pragma binding(libc::wcrtomb,  "_wcrtomb")
#pragma binding(libc::wcsrtombs, "_wcsrtombs")
#pragma binding(libc::wcwidth,  "_wcwidth")
#pragma binding(libc::wcswidth, "_wcswidth")
#pragma binding(libc::mbsrtowcs, "_mbsrtowcs")
#pragma binding(libc::btowc,    "_btowc")
#pragma binding(libc::wctob,    "_wctob")
#pragma binding(libc::wcscoll,  "_wcscoll")
#pragma binding(libc::wcsxfrm,  "_wcsxfrm")
#pragma binding(libc::wcsftime, "_wcsftime")
#pragma binding(libc::fwprintf,  "_fwprintf")
#pragma binding(libc::swprintf,  "_swprintf")
#pragma binding(libc::vfwprintf, "_vfwprintf")
#pragma binding(libc::vswprintf, "_vswprintf")
#pragma binding(libc::vwprintf,  "_vwprintf")
#pragma binding(libc::wprintf,   "_wprintf")
#pragma binding(libc::fgetwc,    "_fgetwc")
#pragma binding(libc::fgetws,    "_fgetws")
#pragma binding(libc::fputwc,    "_fputwc")
#pragma binding(libc::fputws,    "_fputws")
#pragma binding(libc::fwide,     "_fwide")
#pragma binding(libc::getwc,     "_getwc")
#pragma binding(libc::getwchar,  "_getwchar")
#pragma binding(libc::putwc,     "_putwc")
#pragma binding(libc::putwchar,  "_putwchar")
#pragma binding(libc::ungetwc,   "_ungetwc")
#pragma binding(libc::wcstof,    "_wcstof")
#pragma binding(libc::wcstold,   "_wcstold")
#pragma binding(libc::wcstoll,   "_wcstoll")
#pragma binding(libc::wcstoull,  "_wcstoull")
#pragma binding(libc::wcsncat,   "_wcsncat")
#pragma binding(libc::wcscspn,   "_wcscspn")
#pragma binding(libc::wcspbrk,   "_wcspbrk")
#pragma binding(libc::wcsspn,    "_wcsspn")
#pragma binding(libc::wcsstr,    "_wcsstr")
#pragma binding(libc::mbrlen,    "_mbrlen")
#pragma binding(libc::mbsinit,   "_mbsinit")
#pragma binding(libc::fwscanf,   "_fwscanf")
#pragma binding(libc::swscanf,   "_swscanf")
#pragma binding(libc::wscanf,    "_wscanf")
#pragma binding(libc::vfwscanf,  "_vfwscanf")
#pragma binding(libc::vswscanf,  "_vswscanf")
#pragma binding(libc::vwscanf,   "_vwscanf")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wcslen,   "wcslen")
#pragma binding(libc::wcscmp,   "wcscmp")
#pragma binding(libc::wcsncmp,  "wcsncmp")
#pragma binding(libc::wcschr,   "wcschr")
#pragma binding(libc::wcsrchr,  "wcsrchr")
#pragma binding(libc::wcscpy,   "wcscpy")
#pragma binding(libc::wcsncpy,  "wcsncpy")
#pragma binding(libc::wcscat,   "wcscat")
#pragma binding(libc::wcstol,   "wcstol")
#pragma binding(libc::wcstoul,  "wcstoul")
#pragma binding(libc::wcstod,   "wcstod")
#pragma binding(libc::wcstok,   "wcstok")
#pragma binding(libc::wmemchr,  "wmemchr")
#pragma binding(libc::wmemcmp,  "wmemcmp")
#pragma binding(libc::wmemcpy,  "wmemcpy")
#pragma binding(libc::wmemmove, "wmemmove")
#pragma binding(libc::wmemset,  "wmemset")
#pragma binding(libc::mbrtowc,  "mbrtowc")
#pragma binding(libc::wcrtomb,  "wcrtomb")
#pragma binding(libc::wcsrtombs, "wcsrtombs")
#pragma binding(libc::wcwidth,  "wcwidth")
#pragma binding(libc::wcswidth, "wcswidth")
#pragma binding(libc::mbsrtowcs, "mbsrtowcs")
#pragma binding(libc::btowc,    "btowc")
#pragma binding(libc::wctob,    "wctob")
#pragma binding(libc::wcscoll,  "wcscoll")
#pragma binding(libc::wcsxfrm,  "wcsxfrm")
#pragma binding(libc::wcsftime, "wcsftime")
#pragma binding(libc::fwprintf,  "fwprintf")
#pragma binding(libc::swprintf,  "swprintf")
#pragma binding(libc::vfwprintf, "vfwprintf")
#pragma binding(libc::vswprintf, "vswprintf")
#pragma binding(libc::vwprintf,  "vwprintf")
#pragma binding(libc::wprintf,   "wprintf")
#pragma binding(libc::fgetwc,    "fgetwc")
#pragma binding(libc::fgetws,    "fgetws")
#pragma binding(libc::fputwc,    "fputwc")
#pragma binding(libc::fputws,    "fputws")
#pragma binding(libc::fwide,     "fwide")
#pragma binding(libc::getwc,     "getwc")
#pragma binding(libc::getwchar,  "getwchar")
#pragma binding(libc::putwc,     "putwc")
#pragma binding(libc::putwchar,  "putwchar")
#pragma binding(libc::ungetwc,   "ungetwc")
#pragma binding(libc::wcstof,    "wcstof")
#pragma binding(libc::wcstold,   "wcstold")
#pragma binding(libc::wcstoll,   "wcstoll")
#pragma binding(libc::wcstoull,  "wcstoull")
#pragma binding(libc::wcsncat,   "wcsncat")
#pragma binding(libc::wcscspn,   "wcscspn")
#pragma binding(libc::wcspbrk,   "wcspbrk")
#pragma binding(libc::wcsspn,    "wcsspn")
#pragma binding(libc::wcsstr,    "wcsstr")
#pragma binding(libc::mbrlen,    "mbrlen")
#pragma binding(libc::mbsinit,   "mbsinit")
// The C99 scanners glibc's <wchar.h> selects through C17; its C23 and
// _GNU_SOURCE ones, __isoc23_*, also read the 0b prefix and %b.
#pragma binding(libc::fwscanf,   "__isoc99_fwscanf")
#pragma binding(libc::swscanf,   "__isoc99_swscanf")
#pragma binding(libc::wscanf,    "__isoc99_wscanf")
#pragma binding(libc::vfwscanf,  "__isoc99_vfwscanf")
#pragma binding(libc::vswscanf,  "__isoc99_vswscanf")
#pragma binding(libc::vwscanf,   "__isoc99_vwscanf")
#endif

// <stdio.h>'s FILE; the prototypes below need only its tag.
struct __c5_FILE;

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::wcslen, "wcslen")
#pragma binding(msvcrt::wcscmp, "wcscmp")
#pragma binding(msvcrt::wcsncmp, "wcsncmp")
#pragma binding(msvcrt::wcschr, "wcschr")
#pragma binding(msvcrt::wcsrchr, "wcsrchr")
#pragma binding(msvcrt::wcscpy, "wcscpy")
#pragma binding(msvcrt::wcsncpy, "wcsncpy")
#pragma binding(msvcrt::wcscat, "wcscat")
#pragma binding(msvcrt::wcstol, "wcstol")
#pragma binding(msvcrt::wcstoul, "wcstoul")
#pragma binding(msvcrt::wcstod, "wcstod")
#pragma binding(msvcrt::wcstok, "wcstok")
#pragma binding(msvcrt::wcsicmp, "_wcsicmp")
#pragma binding(msvcrt::_wcsicmp, "_wcsicmp")
#pragma binding(msvcrt::_wcsnicmp, "_wcsnicmp")
#pragma binding(msvcrt::_wopen, "_wopen")
#pragma binding(msvcrt::_itow,    "_itow")
#pragma binding(msvcrt::_ltow,    "_ltow")
#pragma binding(msvcrt::_ultow,   "_ultow")
#pragma binding(msvcrt::_i64tow,  "_i64tow")
#pragma binding(msvcrt::_ui64tow, "_ui64tow")
#pragma binding(msvcrt::_vscwprintf, "_vscwprintf")
#pragma binding(msvcrt::fgetwc,   "fgetwc")
#pragma binding(msvcrt::fputwc,   "fputwc")
#pragma binding(msvcrt::getwc,    "getwc")
#pragma binding(msvcrt::putwc,    "putwc")
#pragma binding(msvcrt::ungetwc,  "ungetwc")
#pragma binding(msvcrt::getwchar, "getwchar")
#pragma binding(msvcrt::putwchar, "putwchar")
#pragma binding(msvcrt::fgetws,   "fgetws")
#pragma binding(msvcrt::fputws,   "fputws")
#pragma binding(msvcrt::fwprintf,  "fwprintf")
#pragma binding(msvcrt::vfwprintf, "vfwprintf")
#pragma binding(msvcrt::vwprintf,  "vwprintf")
#pragma binding(msvcrt::wprintf,   "wprintf")
#pragma binding(msvcrt::wcsncat,  "wcsncat")
#pragma binding(msvcrt::wcscspn,  "wcscspn")
#pragma binding(msvcrt::wcspbrk,  "wcspbrk")
#pragma binding(msvcrt::wcsspn,   "wcsspn")
#pragma binding(msvcrt::wcsstr,   "wcsstr")
#pragma binding(msvcrt::mbrlen,   "mbrlen")
// msvcrt.dll spells wcstoll / wcstoull as it spells strtoll / strtoull.
#pragma binding(msvcrt::wcstoll,  "_wcstoi64")
#pragma binding(msvcrt::wcstoull, "_wcstoui64")
wchar_t *_itow(int value, wchar_t *dst, int radix);
wchar_t *_ltow(long value, wchar_t *dst, int radix);
wchar_t *_ultow(unsigned long value, wchar_t *dst, int radix);
wchar_t *_i64tow(long long value, wchar_t *dst, int radix);
wchar_t *_ui64tow(unsigned long long value, wchar_t *dst, int radix);
int _vscwprintf(const wchar_t *format, __builtin_va_list ap);
int _wcsicmp(const wchar_t *a, const wchar_t *b);
int _wcsnicmp(const wchar_t *a, const wchar_t *b, size_t n);
int _wopen(const wchar_t *path, int oflag, ...);
#pragma binding(msvcrt::wcstok_s, "wcstok_s")
int wcsicmp(const wchar_t *a, const wchar_t *b);
wchar_t *wcstok_s(wchar_t *str, const wchar_t *delim, wchar_t **context);
#pragma binding(msvcrt::wcscpy_s, "wcscpy_s")
int wcscpy_s(wchar_t *dst, size_t count, const wchar_t *src);
#pragma binding(msvcrt::wcsncpy_s, "wcsncpy_s")
int wcsncpy_s(wchar_t *dst, size_t dstsz, const wchar_t *src, size_t count);
#pragma binding(msvcrt::wcscat_s, "wcscat_s")
int wcscat_s(wchar_t *dst, size_t dstsz, const wchar_t *src);
#pragma binding(msvcrt::wcscoll,  "wcscoll")
#pragma binding(msvcrt::wcsxfrm,  "wcsxfrm")
#pragma binding(msvcrt::wcsftime, "wcsftime")
#pragma binding(msvcrt::wcsrtombs, "wcsrtombs")
#pragma binding(msvcrt::mbsrtowcs, "mbsrtowcs")
#pragma binding(msvcrt::mbrtowc,   "mbrtowc")
#pragma binding(msvcrt::wcrtomb,   "wcrtomb")
#pragma binding(msvcrt::btowc,     "btowc")
#pragma binding(msvcrt::wctob,     "wctob")

// Neither msvcrt.dll nor ucrtbase.dll exports the C99 wide-array
// functions (7.24.4.4 / 7.24.4.5) or wcsnlen_s, and msvcrt.dll's swprintf
// and vswprintf take no count; the Microsoft SDK defines the first inline
// over the exported primitives, and libmsvcrt.a defines swprintf and
// vswprintf over _vsnwprintf, ending the text at the count's last element
// and returning a negative value when it does not fit (C99 7.24.2.3).
// mingw-w64 defines fwide as a request granted, msvcrt streams having no
// orientation, and mbsinit over msvcrt's int-sized conversion state.
#include <stdarg.h>
#pragma binding(msvcrt::_vsnwprintf, "_vsnwprintf")
#pragma binding(msvcrt::wcsnlen,     "wcsnlen")
int _vsnwprintf(wchar_t *buffer, size_t count, const wchar_t *format, va_list ap);
size_t wcsnlen(const wchar_t *s, size_t maxlen);
static inline int vswprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format,
                            va_list ap) {
    if (n == 0)
        return -1;
    int r = _vsnwprintf(s, n - 1, format, ap);
    if (r < 0 || (size_t)r == n - 1)
        s[n - 1] = 0;
    return r;
}
static inline int swprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format, ...) {
    va_list ap;
    va_start(ap, format);
    int r = vswprintf(s, n, format, ap);
    va_end(ap);
    return r;
}
static inline int fwide(struct __c5_FILE *stream, int mode) {
    (void)stream;
    return mode;
}
static inline int mbsinit(const mbstate_t *ps) {
    return !ps || !(ps->__opaque[0] | ps->__opaque[1] | ps->__opaque[2] | ps->__opaque[3]);
}
#include <corecrt.h>
struct tm;
// The bounds-checked forms <tchar.h>'s _s mappings reach, with mingw-w64's
// prototypes (sec_api/*_s.h); msvcrt.dll exports each on both targets.
#pragma binding(msvcrt::wprintf_s, "wprintf_s")
int wprintf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::fwprintf_s, "fwprintf_s")
int fwprintf_s(struct __c5_FILE *_File, const wchar_t *_Format, ...);
#pragma binding(msvcrt::swprintf_s, "swprintf_s")
int swprintf_s(wchar_t *_DstBuf, size_t _DstSize, const wchar_t *_Format, ...);
#pragma binding(msvcrt::vwprintf_s, "vwprintf_s")
int vwprintf_s(const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vfwprintf_s, "vfwprintf_s")
int vfwprintf_s(struct __c5_FILE *_File, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vswprintf_s, "vswprintf_s")
int vswprintf_s(wchar_t *_DstBuf, size_t _DstSize, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_snwprintf_s, "_snwprintf_s")
int _snwprintf_s(wchar_t *_DstBuf, size_t _DstSize, size_t _MaxCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_vsnwprintf_s, "_vsnwprintf_s")
int _vsnwprintf_s(wchar_t *_DstBuf, size_t _DstSize, size_t _MaxCount, const wchar_t *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_wprintf_s_l, "_wprintf_s_l")
int _wprintf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vwprintf_s_l, "_vwprintf_s_l")
int _vwprintf_s_l(const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_fwprintf_s_l, "_fwprintf_s_l")
int _fwprintf_s_l(struct __c5_FILE *_File, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vfwprintf_s_l, "_vfwprintf_s_l")
int _vfwprintf_s_l(struct __c5_FILE *_File, const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_swprintf_s_l, "_swprintf_s_l")
int _swprintf_s_l(wchar_t *_DstBuf, size_t _DstSize, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vswprintf_s_l, "_vswprintf_s_l")
int _vswprintf_s_l(wchar_t *_DstBuf, size_t _DstSize, const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_snwprintf_s_l, "_snwprintf_s_l")
int _snwprintf_s_l(wchar_t *_DstBuf, size_t _DstSize, size_t _MaxCount, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vsnwprintf_s_l, "_vsnwprintf_s_l")
int _vsnwprintf_s_l(wchar_t *_DstBuf, size_t _DstSize, size_t _MaxCount, const wchar_t *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::wscanf_s, "wscanf_s")
int wscanf_s(const wchar_t *_Format, ...);
#pragma binding(msvcrt::fwscanf_s, "fwscanf_s")
int fwscanf_s(struct __c5_FILE *_File, const wchar_t *_Format, ...);
#pragma binding(msvcrt::swscanf_s, "swscanf_s")
int swscanf_s(const wchar_t *_Src, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_snwscanf_s, "_snwscanf_s")
int _snwscanf_s(const wchar_t *_Src, size_t _MaxCount, const wchar_t *_Format, ...);
#pragma binding(msvcrt::_wscanf_s_l, "_wscanf_s_l")
int _wscanf_s_l(const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_fwscanf_s_l, "_fwscanf_s_l")
int _fwscanf_s_l(struct __c5_FILE *_File, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_swscanf_s_l, "_swscanf_s_l")
int _swscanf_s_l(const wchar_t *_Src, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_snwscanf_s_l, "_snwscanf_s_l")
int _snwscanf_s_l(const wchar_t *_Src, size_t _MaxCount, const wchar_t *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_wfopen_s, "_wfopen_s")
errno_t _wfopen_s(struct __c5_FILE **_File, const wchar_t *_Filename, const wchar_t *_Mode);
#pragma binding(msvcrt::_wtmpnam_s, "_wtmpnam_s")
errno_t _wtmpnam_s(wchar_t *_DstBuf, size_t _SizeInWords);
#pragma binding(msvcrt::__wcserror_s, "__wcserror_s")
errno_t __wcserror_s(wchar_t *_Buffer, size_t _SizeInWords, const wchar_t *_ErrMsg);
#pragma binding(msvcrt::_wcserror_s, "_wcserror_s")
errno_t _wcserror_s(wchar_t *_Buf, size_t _SizeInWords, int _ErrNum);
#pragma binding(msvcrt::_wcsnset_s, "_wcsnset_s")
errno_t _wcsnset_s(wchar_t *_Dst, size_t _DstSizeInWords, wchar_t _Val, size_t _MaxCount);
#pragma binding(msvcrt::_wcsset_s, "_wcsset_s")
errno_t _wcsset_s(wchar_t *_Str, size_t _SizeInWords, wchar_t _Val);
#pragma binding(msvcrt::_wcslwr_s, "_wcslwr_s")
errno_t _wcslwr_s(wchar_t *_Str, size_t _SizeInWords);
#pragma binding(msvcrt::_wcslwr_s_l, "_wcslwr_s_l")
errno_t _wcslwr_s_l(wchar_t *_Str, size_t _SizeInWords, _locale_t _Locale);
#pragma binding(msvcrt::_wcsupr_s, "_wcsupr_s")
errno_t _wcsupr_s(wchar_t *_Str, size_t _Size);
#pragma binding(msvcrt::_wcsupr_s_l, "_wcsupr_s_l")
errno_t _wcsupr_s_l(wchar_t *_Str, size_t _Size, _locale_t _Locale);
#pragma binding(msvcrt::wcsncat_s, "wcsncat_s")
errno_t wcsncat_s(wchar_t *_Dst, size_t _DstSizeInChars, const wchar_t *_Src, size_t _MaxCount);
#pragma binding(msvcrt::_wasctime_s, "_wasctime_s")
errno_t _wasctime_s(wchar_t *_Buf, size_t _SizeInWords, const struct tm *_Tm);
#pragma binding(msvcrt::_wctime32_s, "_wctime32_s")
errno_t _wctime32_s(wchar_t *_Buf, size_t _SizeInWords, const __time32_t *_Time);
#pragma binding(msvcrt::_wctime64_s, "_wctime64_s")
errno_t _wctime64_s(wchar_t *_Buf, size_t _SizeInWords, const __time64_t *_Time);
#pragma binding(msvcrt::_wstrdate_s, "_wstrdate_s")
errno_t _wstrdate_s(wchar_t *_Buf, size_t _SizeInWords);
#pragma binding(msvcrt::_wstrtime_s, "_wstrtime_s")
errno_t _wstrtime_s(wchar_t *_Buf, size_t _SizeInWords);
#pragma binding(msvcrt::_waccess_s, "_waccess_s")
errno_t _waccess_s(const wchar_t *_Filename, int _AccessMode);
#pragma binding(msvcrt::_wmktemp_s, "_wmktemp_s")
errno_t _wmktemp_s(wchar_t *_TemplateName, size_t _SizeInWords);
#pragma binding(msvcrt::_itow_s, "_itow_s")
errno_t _itow_s(int _Val, wchar_t *_DstBuf, size_t _SizeInWords, int _Radix);
#pragma binding(msvcrt::_ltow_s, "_ltow_s")
errno_t _ltow_s(long _Val, wchar_t *_DstBuf, size_t _SizeInWords, int _Radix);
#pragma binding(msvcrt::_ultow_s, "_ultow_s")
errno_t _ultow_s(unsigned long _Val, wchar_t *_DstBuf, size_t _SizeInWords, int _Radix);
#pragma binding(msvcrt::_i64tow_s, "_i64tow_s")
errno_t _i64tow_s(long long _Val, wchar_t *_DstBuf, size_t _SizeInWords, int _Radix);
#pragma binding(msvcrt::_ui64tow_s, "_ui64tow_s")
errno_t _ui64tow_s(unsigned long long _Val, wchar_t *_DstBuf, size_t _SizeInWords, int _Radix);
#pragma binding(msvcrt::_wgetenv_s, "_wgetenv_s")
errno_t _wgetenv_s(size_t *_ReturnSize, wchar_t *_DstBuf, size_t _DstSizeInWords, const wchar_t *_VarName);
#pragma binding(msvcrt::_wmakepath_s, "_wmakepath_s")
errno_t _wmakepath_s(wchar_t *_PathResult, size_t _SizeInWords, const wchar_t *_Drive, const wchar_t *_Dir, const wchar_t *_Filename, const wchar_t *_Ext);
#pragma binding(msvcrt::_wsearchenv_s, "_wsearchenv_s")
errno_t _wsearchenv_s(const wchar_t *_Filename, const wchar_t *_EnvVar, wchar_t *_ResultPath, size_t _SizeInWords);
#pragma binding(msvcrt::_wsplitpath_s, "_wsplitpath_s")
errno_t _wsplitpath_s(const wchar_t *_FullPath, wchar_t *_Drive, size_t _DriveSizeInWords, wchar_t *_Dir, size_t _DirSizeInWords, wchar_t *_Filename, size_t _FilenameSizeInWords, wchar_t *_Ext, size_t _ExtSizeInWords);
// mingw-w64 binds _wctime_s to _wctime64_s, time_t being 64-bit.
#pragma binding(msvcrt::_wctime_s, "_wctime64_s")
errno_t _wctime_s(wchar_t *_Buffer, size_t _SizeInWords, const __time64_t *_Time);
static inline size_t wcsnlen_s(const wchar_t *s, size_t n) {
    return s ? wcsnlen(s, n) : 0;
}
static inline wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n) {
    for (; n; --n, ++s)
        if (*s == c)
            return (wchar_t *)s;
    return (wchar_t *)0;
}
static inline int wmemcmp(const wchar_t *a, const wchar_t *b, size_t n) {
    for (; n; --n, ++a, ++b)
        if (*a != *b)
            return *a < *b ? -1 : 1;
    return 0;
}
static inline wchar_t *wmemcpy(wchar_t *d, const wchar_t *s, size_t n) {
    for (size_t i = 0; i < n; ++i)
        d[i] = s[i];
    return d;
}
static inline wchar_t *wmemmove(wchar_t *d, const wchar_t *s, size_t n) {
    if (d < s)
        for (size_t i = 0; i < n; ++i)
            d[i] = s[i];
    else
        for (size_t i = n; i; --i)
            d[i - 1] = s[i - 1];
    return d;
}
static inline wchar_t *wmemset(wchar_t *d, wchar_t c, size_t n) {
    for (size_t i = 0; i < n; ++i)
        d[i] = c;
    return d;
}
#endif

// Formatted wide-character input/output (C99 7.24.2). On Windows swprintf
// and vswprintf are the definitions above, and libc/lib/scanf_ext.c defines
// the six scanners.
int fwprintf(struct __c5_FILE *restrict stream, const wchar_t *restrict format, ...);
int fwscanf(struct __c5_FILE *restrict stream, const wchar_t *restrict format, ...);
int swscanf(const wchar_t *restrict s, const wchar_t *restrict format, ...);
int vfwprintf(struct __c5_FILE *restrict stream, const wchar_t *restrict format,
              __builtin_va_list arg);
int vfwscanf(struct __c5_FILE *restrict stream, const wchar_t *restrict format,
             __builtin_va_list arg);
int vswscanf(const wchar_t *restrict s, const wchar_t *restrict format, __builtin_va_list arg);
int vwprintf(const wchar_t *restrict format, __builtin_va_list arg);
int vwscanf(const wchar_t *restrict format, __builtin_va_list arg);
int wprintf(const wchar_t *restrict format, ...);
int wscanf(const wchar_t *restrict format, ...);
#ifndef _WIN32
int swprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format, ...);
int vswprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format,
              __builtin_va_list arg);
#endif

// Wide-character input/output (C99 7.24.3). On Windows fwide is the
// definition above.
wint_t fgetwc(struct __c5_FILE *stream);
wchar_t *fgetws(wchar_t *restrict s, int n, struct __c5_FILE *restrict stream);
wint_t fputwc(wchar_t c, struct __c5_FILE *stream);
int fputws(const wchar_t *restrict s, struct __c5_FILE *restrict stream);
#ifndef _WIN32
int fwide(struct __c5_FILE *stream, int mode);
#endif
wint_t getwc(struct __c5_FILE *stream);
wint_t getwchar(void);
wint_t putwc(wchar_t c, struct __c5_FILE *stream);
wint_t putwchar(wchar_t c);
wint_t ungetwc(wint_t c, struct __c5_FILE *stream);

// Wide-string handling (C99 7.24.4). `size_t` comes from <stddef.h>.
size_t wcslen(const wchar_t *s);
int wcscmp(const wchar_t *s1, const wchar_t *s2);
int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wcschr(const wchar_t *s, wchar_t c);
wchar_t *wcsrchr(const wchar_t *s, wchar_t c);
wchar_t *wcscpy(wchar_t *dest, const wchar_t *src);
wchar_t *wcsncpy(wchar_t *dest, const wchar_t *src, size_t n);
wchar_t *wcscat(wchar_t *dest, const wchar_t *src);
wchar_t *wcsncat(wchar_t *restrict s1, const wchar_t *restrict s2, size_t n);
size_t wcscspn(const wchar_t *s1, const wchar_t *s2);
wchar_t *wcspbrk(const wchar_t *s1, const wchar_t *s2);
size_t wcsspn(const wchar_t *s1, const wchar_t *s2);
wchar_t *wcsstr(const wchar_t *s1, const wchar_t *s2);

// Wide-character array handling (C99 7.24.4.4). On Windows these have
// inline definitions in the target block above, since no system CRT
// exports them.
#ifndef _WIN32
wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n);
int wmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemcpy(wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemmove(wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemset(wchar_t *s, wchar_t c, size_t n);
#endif

// Wide-string numeric conversion (C99 7.24.4.1).
long wcstol(const wchar_t *nptr, wchar_t **endptr, int base);
unsigned long wcstoul(const wchar_t *nptr, wchar_t **endptr, int base);
long long wcstoll(const wchar_t *restrict nptr, wchar_t **restrict endptr, int base);
unsigned long long wcstoull(const wchar_t *restrict nptr, wchar_t **restrict endptr, int base);
double wcstod(const wchar_t *nptr, wchar_t **endptr);
float wcstof(const wchar_t *restrict nptr, wchar_t **restrict endptr);
long double wcstold(const wchar_t *restrict nptr, wchar_t **restrict endptr);
wchar_t *wcstok(wchar_t *s, const wchar_t *delim, wchar_t **ptr);

// Conversion state (C99 7.24.6.2; on Windows the definition above) and
// restartable multibyte / wide conversion (C99 7.24.6.3).
#ifndef _WIN32
int mbsinit(const mbstate_t *ps);
#endif
size_t mbrlen(const char *restrict s, size_t n, mbstate_t *restrict ps);
size_t mbrtowc(wchar_t *pwc, const char *s, size_t n, mbstate_t *ps);
size_t wcrtomb(char *s, wchar_t wc, mbstate_t *ps);
size_t wcsrtombs(char *dst, const wchar_t **src, size_t len, mbstate_t *ps);
// C95 7.24.6.4.1: the multibyte->wide reverse of wcsrtombs.
size_t mbsrtowcs(wchar_t *dst, const char **src, size_t len, mbstate_t *ps);

// Single-byte / wide-character conversion (C99 7.24.6.1).
wint_t btowc(int c);
int wctob(wint_t c);

#ifndef _WIN32
// POSIX column width of a wide character, and of the first n characters
// of a wide string: -1 for a non-printing character. Not in C99; the
// Windows C runtime has no equivalent.
int wcwidth(wchar_t wc);
int wcswidth(const wchar_t *s, size_t n);
#endif

// Locale-dependent wide-string collation (C99 7.24.4.4.2, 7.24.4.5.1).
int wcscoll(const wchar_t *s1, const wchar_t *s2);
size_t wcsxfrm(wchar_t *s1, const wchar_t *s2, size_t n);

// Wide-character time formatting (C99 7.24.5.1). `struct tm` comes from
// <time.h>; a pointer to it needs only the tag here.
struct tm;
size_t wcsftime(wchar_t *s, size_t maxsize, const wchar_t *format,
                const struct tm *timeptr);

#if defined(__APPLE__) || defined(__linux__)
#ifndef __BADC_LOCALE_T
#define __BADC_LOCALE_T
#ifdef __APPLE__
typedef struct _xlocale *locale_t;
#else
typedef struct __locale_struct *locale_t;
#endif
#endif
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wcscasecmp_l, "_wcscasecmp_l")
#pragma binding(libc::wcsncasecmp_l, "_wcsncasecmp_l")
#pragma binding(libc::wcscoll_l, "_wcscoll_l")
#pragma binding(libc::wcsxfrm_l, "_wcsxfrm_l")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wcscasecmp_l, "wcscasecmp_l")
#pragma binding(libc::wcsncasecmp_l, "wcsncasecmp_l")
#pragma binding(libc::wcscoll_l, "wcscoll_l")
#pragma binding(libc::wcsxfrm_l, "wcsxfrm_l")
#endif
int wcscasecmp_l(const wchar_t *ws1, const wchar_t *ws2, locale_t locale);
int wcsncasecmp_l(const wchar_t *ws1, const wchar_t *ws2, size_t n, locale_t locale);
int wcscoll_l(const wchar_t *ws1, const wchar_t *ws2, locale_t locale);
size_t wcsxfrm_l(wchar_t *restrict ws1, const wchar_t *restrict ws2, size_t n,
                 locale_t locale);
#endif
