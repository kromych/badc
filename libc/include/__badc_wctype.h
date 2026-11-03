// __badc_wctype.h -- the functions of the UCRT's corecrt_wctype.h, which its
// <ctype.h>, <wctype.h> and <wchar.h> include, with its prototypes;
// mingw-w64 declares them in those headers too. Each binds to msvcrt.dll,
// which exports it on both targets, but iswblank, which comes from
// ucrtbase.dll with msvcrt's class bits. ucrtbase.dll alone exports
// _iswblank_l, __iswcsym, __iswcsymf, _iswcsym_l and _iswcsymf_l, which are
// not declared.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

typedef __WINT_TYPE__ wint_t;
typedef unsigned short wctype_t;

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::iswalnum, "iswalnum")
int iswalnum(wint_t _C);
#pragma binding(msvcrt::iswalpha, "iswalpha")
int iswalpha(wint_t _C);
#pragma binding(msvcrt::iswascii, "iswascii")
int iswascii(wint_t _C);
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::iswblank, "iswblank")
int iswblank(wint_t _C);
#pragma binding(msvcrt::iswcntrl, "iswcntrl")
int iswcntrl(wint_t _C);
#pragma binding(msvcrt::iswdigit, "iswdigit")
int iswdigit(wint_t _C);
#pragma binding(msvcrt::iswgraph, "iswgraph")
int iswgraph(wint_t _C);
#pragma binding(msvcrt::iswlower, "iswlower")
int iswlower(wint_t _C);
#pragma binding(msvcrt::iswprint, "iswprint")
int iswprint(wint_t _C);
#pragma binding(msvcrt::iswpunct, "iswpunct")
int iswpunct(wint_t _C);
#pragma binding(msvcrt::iswspace, "iswspace")
int iswspace(wint_t _C);
#pragma binding(msvcrt::iswupper, "iswupper")
int iswupper(wint_t _C);
#pragma binding(msvcrt::iswxdigit, "iswxdigit")
int iswxdigit(wint_t _C);
#pragma binding(msvcrt::iswctype, "iswctype")
int iswctype(wint_t _C, wctype_t _Type);
#pragma binding(msvcrt::is_wctype, "is_wctype")
int is_wctype(wint_t _C, wctype_t _Type);
#pragma binding(msvcrt::towlower, "towlower")
wint_t towlower(wint_t _C);
#pragma binding(msvcrt::towupper, "towupper")
wint_t towupper(wint_t _C);

#pragma binding(msvcrt::_iswalnum_l, "_iswalnum_l")
int _iswalnum_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswalpha_l, "_iswalpha_l")
int _iswalpha_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswcntrl_l, "_iswcntrl_l")
int _iswcntrl_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswdigit_l, "_iswdigit_l")
int _iswdigit_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswgraph_l, "_iswgraph_l")
int _iswgraph_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswlower_l, "_iswlower_l")
int _iswlower_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswprint_l, "_iswprint_l")
int _iswprint_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswpunct_l, "_iswpunct_l")
int _iswpunct_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswspace_l, "_iswspace_l")
int _iswspace_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswupper_l, "_iswupper_l")
int _iswupper_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswxdigit_l, "_iswxdigit_l")
int _iswxdigit_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_iswctype_l, "_iswctype_l")
int _iswctype_l(wint_t _C, wctype_t _Type, _locale_t _Locale);
#pragma binding(msvcrt::_towlower_l, "_towlower_l")
wint_t _towlower_l(wint_t _C, _locale_t _Locale);
#pragma binding(msvcrt::_towupper_l, "_towupper_l")
wint_t _towupper_l(wint_t _C, _locale_t _Locale);

#pragma binding(msvcrt::isleadbyte, "isleadbyte")
int isleadbyte(int _C);
#pragma binding(msvcrt::_isleadbyte_l, "_isleadbyte_l")
int _isleadbyte_l(int _C, _locale_t _Locale);
#pragma binding(msvcrt::__pctype_func, "__pctype_func")
const unsigned short *__pctype_func(void);
#pragma binding(msvcrt::__pwctype_func, "__pwctype_func")
const wctype_t *__pwctype_func(void);

#endif
