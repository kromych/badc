// <wctype.h> -- wide-character classification and mapping (C99 7.25).

#pragma once

// `wint_t` and `WEOF` mirror <wchar.h> (C99 7.25.1). A repeated
// same-type typedef is harmless when both headers are included.
typedef __WINT_TYPE__ wint_t;
#ifndef WEOF
#ifdef _WIN32
#define WEOF ((wint_t)0xFFFF)
#else
#define WEOF ((wint_t)-1)
#endif
#endif

// `wctype_t`/`wctrans_t` hold the opaque property and mapping handles
// returned by wctype()/wctrans(). The width matches the host because
// the value is passed back to the libc iswctype()/towctrans(); the
// Windows C runtimes return both as `unsigned short`.
#ifdef __APPLE__
typedef unsigned long wctype_t;
typedef int wctrans_t;
#elif defined(_WIN32)
typedef unsigned short wctype_t;
typedef unsigned short wctrans_t;
#else
typedef unsigned long wctype_t;
typedef const int *wctrans_t;
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::iswalnum,  "_iswalnum")
#pragma binding(libc::iswalpha,  "_iswalpha")
#pragma binding(libc::iswblank,  "_iswblank")
#pragma binding(libc::iswcntrl,  "_iswcntrl")
#pragma binding(libc::iswdigit,  "_iswdigit")
#pragma binding(libc::iswgraph,  "_iswgraph")
#pragma binding(libc::iswlower,  "_iswlower")
#pragma binding(libc::iswprint,  "_iswprint")
#pragma binding(libc::iswpunct,  "_iswpunct")
#pragma binding(libc::iswspace,  "_iswspace")
#pragma binding(libc::iswupper,  "_iswupper")
#pragma binding(libc::iswxdigit, "_iswxdigit")
#pragma binding(libc::iswctype,  "_iswctype")
#pragma binding(libc::wctype,    "_wctype")
#pragma binding(libc::towlower,  "_towlower")
#pragma binding(libc::towupper,  "_towupper")
#pragma binding(libc::towctrans, "_towctrans")
#pragma binding(libc::wctrans,   "_wctrans")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::iswalnum,  "iswalnum")
#pragma binding(libc::iswalpha,  "iswalpha")
#pragma binding(libc::iswblank,  "iswblank")
#pragma binding(libc::iswcntrl,  "iswcntrl")
#pragma binding(libc::iswdigit,  "iswdigit")
#pragma binding(libc::iswgraph,  "iswgraph")
#pragma binding(libc::iswlower,  "iswlower")
#pragma binding(libc::iswprint,  "iswprint")
#pragma binding(libc::iswpunct,  "iswpunct")
#pragma binding(libc::iswspace,  "iswspace")
#pragma binding(libc::iswupper,  "iswupper")
#pragma binding(libc::iswxdigit, "iswxdigit")
#pragma binding(libc::iswctype,  "iswctype")
#pragma binding(libc::wctype,    "wctype")
#pragma binding(libc::towlower,  "towlower")
#pragma binding(libc::towupper,  "towupper")
#pragma binding(libc::towctrans, "towctrans")
#pragma binding(libc::wctrans,   "wctrans")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::iswalnum,  "iswalnum")
#pragma binding(msvcrt::iswalpha,  "iswalpha")
#pragma binding(msvcrt::iswcntrl,  "iswcntrl")
#pragma binding(msvcrt::iswdigit,  "iswdigit")
#pragma binding(msvcrt::iswgraph,  "iswgraph")
#pragma binding(msvcrt::iswlower,  "iswlower")
#pragma binding(msvcrt::iswprint,  "iswprint")
#pragma binding(msvcrt::iswpunct,  "iswpunct")
#pragma binding(msvcrt::iswspace,  "iswspace")
#pragma binding(msvcrt::iswupper,  "iswupper")
#pragma binding(msvcrt::iswxdigit, "iswxdigit")
#pragma binding(msvcrt::towlower,  "towlower")
#pragma binding(msvcrt::towupper,  "towupper")
#pragma binding(msvcrt::iswctype,  "iswctype")
// msvcrt.dll exports neither iswblank nor the property and mapping
// lookups; ucrtbase.dll does, with msvcrt's class bits.
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::iswblank,  "iswblank")
#pragma binding(ucrtbase::wctype,    "wctype")
#pragma binding(ucrtbase::wctrans,   "wctrans")
#pragma binding(ucrtbase::towctrans, "towctrans")
#endif

// Classification (C99 7.25.2.1). Each returns nonzero when `wc` belongs
// to the named class in the current locale.
int iswalnum(wint_t wc);
int iswalpha(wint_t wc);
int iswblank(wint_t wc);
int iswcntrl(wint_t wc);
int iswdigit(wint_t wc);
int iswgraph(wint_t wc);
int iswlower(wint_t wc);
int iswprint(wint_t wc);
int iswpunct(wint_t wc);
int iswspace(wint_t wc);
int iswupper(wint_t wc);
int iswxdigit(wint_t wc);

// Extensible classification (C99 7.25.2.2).
int iswctype(wint_t wc, wctype_t desc);
wctype_t wctype(const char *property);

// Case mapping (C99 7.25.3.1) and extensible mapping (C99 7.25.3.2).
wint_t towlower(wint_t wc);
wint_t towupper(wint_t wc);
wint_t towctrans(wint_t wc, wctrans_t desc);
wctrans_t wctrans(const char *property);

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
#pragma binding(libc::iswalnum_l, "_iswalnum_l")
#pragma binding(libc::iswalpha_l, "_iswalpha_l")
#pragma binding(libc::iswblank_l, "_iswblank_l")
#pragma binding(libc::iswcntrl_l, "_iswcntrl_l")
#pragma binding(libc::iswdigit_l, "_iswdigit_l")
#pragma binding(libc::iswgraph_l, "_iswgraph_l")
#pragma binding(libc::iswlower_l, "_iswlower_l")
#pragma binding(libc::iswprint_l, "_iswprint_l")
#pragma binding(libc::iswpunct_l, "_iswpunct_l")
#pragma binding(libc::iswspace_l, "_iswspace_l")
#pragma binding(libc::iswupper_l, "_iswupper_l")
#pragma binding(libc::iswxdigit_l, "_iswxdigit_l")
#pragma binding(libc::iswctype_l, "_iswctype_l")
#pragma binding(libc::towctrans_l, "_towctrans_l")
#pragma binding(libc::towlower_l, "_towlower_l")
#pragma binding(libc::towupper_l, "_towupper_l")
#pragma binding(libc::wctrans_l, "_wctrans_l")
#pragma binding(libc::wctype_l, "_wctype_l")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::iswalnum_l, "iswalnum_l")
#pragma binding(libc::iswalpha_l, "iswalpha_l")
#pragma binding(libc::iswblank_l, "iswblank_l")
#pragma binding(libc::iswcntrl_l, "iswcntrl_l")
#pragma binding(libc::iswdigit_l, "iswdigit_l")
#pragma binding(libc::iswgraph_l, "iswgraph_l")
#pragma binding(libc::iswlower_l, "iswlower_l")
#pragma binding(libc::iswprint_l, "iswprint_l")
#pragma binding(libc::iswpunct_l, "iswpunct_l")
#pragma binding(libc::iswspace_l, "iswspace_l")
#pragma binding(libc::iswupper_l, "iswupper_l")
#pragma binding(libc::iswxdigit_l, "iswxdigit_l")
#pragma binding(libc::iswctype_l, "iswctype_l")
#pragma binding(libc::towctrans_l, "towctrans_l")
#pragma binding(libc::towlower_l, "towlower_l")
#pragma binding(libc::towupper_l, "towupper_l")
#pragma binding(libc::wctrans_l, "wctrans_l")
#pragma binding(libc::wctype_l, "wctype_l")
#endif
int iswalnum_l(wint_t wc, locale_t locale);
int iswalpha_l(wint_t wc, locale_t locale);
int iswblank_l(wint_t wc, locale_t locale);
int iswcntrl_l(wint_t wc, locale_t locale);
int iswdigit_l(wint_t wc, locale_t locale);
int iswgraph_l(wint_t wc, locale_t locale);
int iswlower_l(wint_t wc, locale_t locale);
int iswprint_l(wint_t wc, locale_t locale);
int iswpunct_l(wint_t wc, locale_t locale);
int iswspace_l(wint_t wc, locale_t locale);
int iswupper_l(wint_t wc, locale_t locale);
int iswxdigit_l(wint_t wc, locale_t locale);
int iswctype_l(wint_t wc, wctype_t charclass, locale_t locale);
wint_t towctrans_l(wint_t wc, wctrans_t desc, locale_t locale);
wint_t towlower_l(wint_t wc, locale_t locale);
wint_t towupper_l(wint_t wc, locale_t locale);
wctrans_t wctrans_l(const char *charclass, locale_t locale);
wctype_t wctype_l(const char *property, locale_t locale);
#endif
