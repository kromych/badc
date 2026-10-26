// xlocale.h -- the macOS SDK's extended locale interface: the _l form of
// each locale-dependent function of <ctype.h>, <wctype.h>, <inttypes.h>,
// <regex.h>, <stdio.h>, <stdlib.h>, <string.h>, <time.h> and <wchar.h> the
// POSIX headers do not declare, with localeconv_l, querylocale and
// _c_locale, bound to libSystem. It includes those headers, whose POSIX
// forms and <locale.h>'s locale objects it extends.
#pragma once

#ifdef __APPLE__
#include <ctype.h>
#include <inttypes.h>
#include <locale.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <wchar.h>
#include <wctype.h>

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(data libc::_c_locale, "__c_locale")
#pragma binding(libc::digittoint_l, "_digittoint_l")
#pragma binding(libc::ishexnumber_l, "_ishexnumber_l")
#pragma binding(libc::isideogram_l, "_isideogram_l")
#pragma binding(libc::isnumber_l, "_isnumber_l")
#pragma binding(libc::isphonogram_l, "_isphonogram_l")
#pragma binding(libc::isrune_l, "_isrune_l")
#pragma binding(libc::isspecial_l, "_isspecial_l")
#pragma binding(libc::iswhexnumber_l, "_iswhexnumber_l")
#pragma binding(libc::iswideogram_l, "_iswideogram_l")
#pragma binding(libc::iswnumber_l, "_iswnumber_l")
#pragma binding(libc::iswphonogram_l, "_iswphonogram_l")
#pragma binding(libc::iswrune_l, "_iswrune_l")
#pragma binding(libc::iswspecial_l, "_iswspecial_l")
#pragma binding(libc::nextwctype_l, "_nextwctype_l")
#pragma binding(libc::strtoimax_l, "_strtoimax_l")
#pragma binding(libc::strtoumax_l, "_strtoumax_l")
#pragma binding(libc::wcstoimax_l, "_wcstoimax_l")
#pragma binding(libc::wcstoumax_l, "_wcstoumax_l")
#pragma binding(libc::regcomp_l, "_regcomp_l")
#pragma binding(libc::regncomp_l, "_regncomp_l")
#pragma binding(libc::regwcomp_l, "_regwcomp_l")
#pragma binding(libc::asprintf_l, "_asprintf_l")
#pragma binding(libc::dprintf_l, "_dprintf_l")
#pragma binding(libc::fprintf_l, "_fprintf_l")
#pragma binding(libc::fscanf_l, "_fscanf_l")
#pragma binding(libc::printf_l, "_printf_l")
#pragma binding(libc::scanf_l, "_scanf_l")
#pragma binding(libc::snprintf_l, "_snprintf_l")
#pragma binding(libc::sprintf_l, "_sprintf_l")
#pragma binding(libc::sscanf_l, "_sscanf_l")
#pragma binding(libc::vasprintf_l, "_vasprintf_l")
#pragma binding(libc::vdprintf_l, "_vdprintf_l")
#pragma binding(libc::vfprintf_l, "_vfprintf_l")
#pragma binding(libc::vfscanf_l, "_vfscanf_l")
#pragma binding(libc::vprintf_l, "_vprintf_l")
#pragma binding(libc::vscanf_l, "_vscanf_l")
#pragma binding(libc::vsnprintf_l, "_vsnprintf_l")
#pragma binding(libc::vsprintf_l, "_vsprintf_l")
#pragma binding(libc::vsscanf_l, "_vsscanf_l")
#pragma binding(libc::atof_l, "_atof_l")
#pragma binding(libc::atoi_l, "_atoi_l")
#pragma binding(libc::atol_l, "_atol_l")
#pragma binding(libc::atoll_l, "_atoll_l")
#pragma binding(libc::mblen_l, "_mblen_l")
#pragma binding(libc::mbstowcs_l, "_mbstowcs_l")
#pragma binding(libc::mbtowc_l, "_mbtowc_l")
#pragma binding(libc::strtod_l, "_strtod_l")
#pragma binding(libc::strtof_l, "_strtof_l")
#pragma binding(libc::strtol_l, "_strtol_l")
#pragma binding(libc::strtold_l, "_strtold_l")
#pragma binding(libc::strtoll_l, "_strtoll_l")
#pragma binding(libc::strtoq_l, "_strtoq_l")
#pragma binding(libc::strtoul_l, "_strtoul_l")
#pragma binding(libc::strtoull_l, "_strtoull_l")
#pragma binding(libc::strtouq_l, "_strtouq_l")
#pragma binding(libc::wcstombs_l, "_wcstombs_l")
#pragma binding(libc::wctomb_l, "_wctomb_l")
#pragma binding(libc::strcasestr_l, "_strcasestr_l")
#pragma binding(libc::strptime_l, "_strptime_l")
#pragma binding(libc::btowc_l, "_btowc_l")
#pragma binding(libc::fgetwc_l, "_fgetwc_l")
#pragma binding(libc::fgetwln_l, "_fgetwln_l")
#pragma binding(libc::fgetws_l, "_fgetws_l")
#pragma binding(libc::fputwc_l, "_fputwc_l")
#pragma binding(libc::fputws_l, "_fputws_l")
#pragma binding(libc::fwprintf_l, "_fwprintf_l")
#pragma binding(libc::fwscanf_l, "_fwscanf_l")
#pragma binding(libc::getwc_l, "_getwc_l")
#pragma binding(libc::getwchar_l, "_getwchar_l")
#pragma binding(libc::mbrlen_l, "_mbrlen_l")
#pragma binding(libc::mbrtowc_l, "_mbrtowc_l")
#pragma binding(libc::mbsinit_l, "_mbsinit_l")
#pragma binding(libc::mbsnrtowcs_l, "_mbsnrtowcs_l")
#pragma binding(libc::mbsrtowcs_l, "_mbsrtowcs_l")
#pragma binding(libc::putwc_l, "_putwc_l")
#pragma binding(libc::putwchar_l, "_putwchar_l")
#pragma binding(libc::swprintf_l, "_swprintf_l")
#pragma binding(libc::swscanf_l, "_swscanf_l")
#pragma binding(libc::ungetwc_l, "_ungetwc_l")
#pragma binding(libc::vfwprintf_l, "_vfwprintf_l")
#pragma binding(libc::vfwscanf_l, "_vfwscanf_l")
#pragma binding(libc::vswprintf_l, "_vswprintf_l")
#pragma binding(libc::vswscanf_l, "_vswscanf_l")
#pragma binding(libc::vwprintf_l, "_vwprintf_l")
#pragma binding(libc::vwscanf_l, "_vwscanf_l")
#pragma binding(libc::wcrtomb_l, "_wcrtomb_l")
#pragma binding(libc::wcsftime_l, "_wcsftime_l")
#pragma binding(libc::wcsnrtombs_l, "_wcsnrtombs_l")
#pragma binding(libc::wcsrtombs_l, "_wcsrtombs_l")
#pragma binding(libc::wcstod_l, "_wcstod_l")
#pragma binding(libc::wcstof_l, "_wcstof_l")
#pragma binding(libc::wcstol_l, "_wcstol_l")
#pragma binding(libc::wcstold_l, "_wcstold_l")
#pragma binding(libc::wcstoll_l, "_wcstoll_l")
#pragma binding(libc::wcstoul_l, "_wcstoul_l")
#pragma binding(libc::wcstoull_l, "_wcstoull_l")
#pragma binding(libc::wcswidth_l, "_wcswidth_l")
#pragma binding(libc::wctob_l, "_wctob_l")
#pragma binding(libc::wcwidth_l, "_wcwidth_l")
#pragma binding(libc::wprintf_l, "_wprintf_l")
#pragma binding(libc::wscanf_l, "_wscanf_l")
#pragma binding(libc::localeconv_l, "_localeconv_l")
#pragma binding(libc::querylocale, "_querylocale")

extern const locale_t _c_locale;
int digittoint_l(int, locale_t);
int ishexnumber_l(int, locale_t);
int isideogram_l(int, locale_t);
int isnumber_l(int, locale_t);
int isphonogram_l(int, locale_t);
int isrune_l(int, locale_t);
int isspecial_l(int, locale_t);
int iswhexnumber_l(wint_t, locale_t);
int iswideogram_l(wint_t, locale_t);
int iswnumber_l(wint_t, locale_t);
int iswphonogram_l(wint_t, locale_t);
int iswrune_l(wint_t, locale_t);
int iswspecial_l(wint_t, locale_t);
wint_t nextwctype_l(wint_t, wctype_t, locale_t);
intmax_t strtoimax_l(const char *restrict, char **restrict, int, locale_t);
uintmax_t strtoumax_l(const char *restrict, char **restrict, int, locale_t);
intmax_t wcstoimax_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
uintmax_t wcstoumax_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
int regcomp_l(regex_t *restrict, const char *restrict, int, locale_t);
int regncomp_l(regex_t *restrict, const char *restrict, size_t, int, locale_t);
int regwcomp_l(regex_t *restrict, const wchar_t *restrict, int, locale_t);
int asprintf_l(char **restrict, locale_t, const char *restrict, ...);
int dprintf_l(int, locale_t, const char *restrict, ...);
int fprintf_l(FILE *restrict, locale_t, const char *restrict, ...);
int fscanf_l(FILE *restrict, locale_t, const char *restrict, ...);
int printf_l(locale_t, const char *restrict, ...);
int scanf_l(locale_t, const char *restrict, ...);
int snprintf_l(char *restrict, size_t, locale_t, const char *restrict, ...);
int sprintf_l(char *restrict, locale_t, const char *restrict, ...);
int sscanf_l(const char *restrict, locale_t, const char *restrict, ...);
int vasprintf_l(char **restrict, locale_t, const char *restrict, __builtin_va_list);
int vdprintf_l(int, locale_t, const char *restrict, __builtin_va_list);
int vfprintf_l(FILE *restrict, locale_t, const char *restrict, __builtin_va_list);
int vfscanf_l(FILE *restrict, locale_t, const char *restrict, __builtin_va_list);
int vprintf_l(locale_t, const char *restrict, __builtin_va_list);
int vscanf_l(locale_t, const char *restrict, __builtin_va_list);
int vsnprintf_l(char *restrict, size_t, locale_t, const char *restrict, __builtin_va_list);
int vsprintf_l(char *restrict, locale_t, const char *restrict, __builtin_va_list);
int vsscanf_l(const char *restrict, locale_t, const char *restrict, __builtin_va_list);
double atof_l(const char *, locale_t);
int atoi_l(const char *, locale_t);
long atol_l(const char *, locale_t);
long long atoll_l(const char *, locale_t);
int mblen_l(const char *, size_t, locale_t);
size_t mbstowcs_l(wchar_t *restrict, const char *restrict, size_t, locale_t);
int mbtowc_l(wchar_t *restrict, const char *restrict, size_t, locale_t);
double strtod_l(const char *, char **, locale_t);
float strtof_l(const char *, char **, locale_t);
long strtol_l(const char *, char **, int, locale_t);
long double strtold_l(const char *, char **, locale_t);
long long strtoll_l(const char *, char **, int, locale_t);
long long strtoq_l(const char *, char **, int, locale_t);
unsigned long strtoul_l(const char *, char **, int, locale_t);
unsigned long long strtoull_l(const char *, char **, int, locale_t);
unsigned long long strtouq_l(const char *, char **, int, locale_t);
size_t wcstombs_l(char *, const wchar_t *restrict, size_t, locale_t);
int wctomb_l(char *, wchar_t, locale_t);
char *strcasestr_l(const char *, const char *, locale_t);
char *strptime_l(const char *restrict, const char *restrict, struct tm *restrict, locale_t);
wint_t btowc_l(int, locale_t);
wint_t fgetwc_l(FILE *, locale_t);
wchar_t *fgetwln_l(FILE *restrict, size_t *, locale_t);
wchar_t *fgetws_l(wchar_t *restrict, int, FILE *restrict, locale_t);
wint_t fputwc_l(wchar_t, FILE *, locale_t);
int fputws_l(const wchar_t *restrict, FILE *restrict, locale_t);
int fwprintf_l(FILE *restrict, locale_t, const wchar_t *restrict, ...);
int fwscanf_l(FILE *restrict, locale_t, const wchar_t *restrict, ...);
wint_t getwc_l(FILE *, locale_t);
wint_t getwchar_l(locale_t);
size_t mbrlen_l(const char *restrict, size_t, mbstate_t *restrict, locale_t);
size_t mbrtowc_l(wchar_t *restrict, const char *restrict, size_t, mbstate_t *restrict, locale_t);
int mbsinit_l(const mbstate_t *, locale_t);
size_t mbsnrtowcs_l(wchar_t *restrict, const char **restrict, size_t, size_t, mbstate_t *restrict, locale_t);
size_t mbsrtowcs_l(wchar_t *restrict, const char **restrict, size_t, mbstate_t *restrict, locale_t);
wint_t putwc_l(wchar_t, FILE *, locale_t);
wint_t putwchar_l(wchar_t, locale_t);
int swprintf_l(wchar_t *restrict, size_t, locale_t, const wchar_t *restrict, ...);
int swscanf_l(const wchar_t *restrict, locale_t, const wchar_t *restrict, ...);
wint_t ungetwc_l(wint_t, FILE *, locale_t);
int vfwprintf_l(FILE *restrict, locale_t, const wchar_t *restrict, __builtin_va_list);
int vfwscanf_l(FILE *restrict, locale_t, const wchar_t *restrict, __builtin_va_list);
int vswprintf_l(wchar_t *restrict, size_t, locale_t, const wchar_t *restrict, __builtin_va_list);
int vswscanf_l(const wchar_t *restrict, locale_t, const wchar_t *restrict, __builtin_va_list);
int vwprintf_l(locale_t, const wchar_t *restrict, __builtin_va_list);
int vwscanf_l(locale_t, const wchar_t *restrict, __builtin_va_list);
size_t wcrtomb_l(char *restrict, wchar_t, mbstate_t *restrict, locale_t);
size_t wcsftime_l(wchar_t *restrict, size_t, const wchar_t *restrict, const struct tm *restrict, locale_t);
size_t wcsnrtombs_l(char *restrict, const wchar_t **restrict, size_t, size_t, mbstate_t *restrict, locale_t);
size_t wcsrtombs_l(char *restrict, const wchar_t **restrict, size_t, mbstate_t *restrict, locale_t);
double wcstod_l(const wchar_t *restrict, wchar_t **restrict, locale_t);
float wcstof_l(const wchar_t *restrict, wchar_t **restrict, locale_t);
long wcstol_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
long double wcstold_l(const wchar_t *restrict, wchar_t **restrict, locale_t);
long long wcstoll_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
unsigned long wcstoul_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
unsigned long long wcstoull_l(const wchar_t *restrict, wchar_t **restrict, int, locale_t);
int wcswidth_l(const wchar_t *, size_t, locale_t);
int wctob_l(wint_t, locale_t);
int wcwidth_l(wchar_t, locale_t);
int wprintf_l(locale_t, const wchar_t *restrict, ...);
int wscanf_l(locale_t, const wchar_t *restrict, ...);
struct lconv *localeconv_l(locale_t);
const char *querylocale(int, locale_t);
#endif
