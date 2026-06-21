// <wctype.h> -- wide-character classification and mapping (C99 7.25).

#pragma once

// `wint_t` and `WEOF` mirror <wchar.h> (C99 7.25.1). A repeated
// same-type typedef is harmless when both headers are included.
typedef int wint_t;
#ifndef WEOF
#define WEOF ((wint_t)-1)
#endif

// `wctype_t`/`wctrans_t` hold the opaque property and mapping handles
// returned by wctype()/wctrans(). The width matches the host because
// the value is passed back to the libc iswctype()/towctrans().
#ifdef __APPLE__
typedef unsigned long wctype_t;
typedef int wctrans_t;
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
