// mbctype.h -- the multibyte code page and byte classes of mingw-w64's
// mbctype.h for msvcrt.dll, which exports each function on both Windows
// targets. __p__mbctype and __p__mbcasemap, which libmsvcrt.a defines over
// msvcrt's data exports, are defined in libc/lib/mbctype_ext.c.

#pragma once

#ifdef _WIN32

#include <corecrt.h>
#include <ctype.h>

#pragma dylib(msvcrt, "msvcrt.dll")

unsigned char *__p__mbctype(void);
#define _mbctype (__p__mbctype())
unsigned char *__p__mbcasemap(void);
#define _mbcasemap (__p__mbcasemap())

#define _MS 0x01
#define _MP 0x02
#define _M1 0x04
#define _M2 0x08

#define _SBUP 0x10
#define _SBLOW 0x20

#define _MBC_SINGLE 0
#define _MBC_LEAD 1
#define _MBC_TRAIL 2
#define _MBC_ILLEGAL (-1)

#define _KANJI_CP 932

#define _MB_CP_SBCS 0
#define _MB_CP_OEM -2
#define _MB_CP_ANSI -3
#define _MB_CP_LOCALE -4

#ifndef _MBCTYPE_DEFINED
#define _MBCTYPE_DEFINED
#pragma binding(msvcrt::_setmbcp, "_setmbcp")
int _setmbcp(int _CodePage);
#pragma binding(msvcrt::_getmbcp, "_getmbcp")
int _getmbcp(void);
#pragma binding(msvcrt::_ismbbkalnum, "_ismbbkalnum")
int _ismbbkalnum(unsigned int _C);
#pragma binding(msvcrt::_ismbbkalnum_l, "_ismbbkalnum_l")
int _ismbbkalnum_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbkana, "_ismbbkana")
int _ismbbkana(unsigned int _C);
#pragma binding(msvcrt::_ismbbkana_l, "_ismbbkana_l")
int _ismbbkana_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbkpunct, "_ismbbkpunct")
int _ismbbkpunct(unsigned int _C);
#pragma binding(msvcrt::_ismbbkpunct_l, "_ismbbkpunct_l")
int _ismbbkpunct_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbkprint, "_ismbbkprint")
int _ismbbkprint(unsigned int _C);
#pragma binding(msvcrt::_ismbbkprint_l, "_ismbbkprint_l")
int _ismbbkprint_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbalpha, "_ismbbalpha")
int _ismbbalpha(unsigned int _C);
#pragma binding(msvcrt::_ismbbalpha_l, "_ismbbalpha_l")
int _ismbbalpha_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbpunct, "_ismbbpunct")
int _ismbbpunct(unsigned int _C);
#pragma binding(msvcrt::_ismbbpunct_l, "_ismbbpunct_l")
int _ismbbpunct_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbalnum, "_ismbbalnum")
int _ismbbalnum(unsigned int _C);
#pragma binding(msvcrt::_ismbbalnum_l, "_ismbbalnum_l")
int _ismbbalnum_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbprint, "_ismbbprint")
int _ismbbprint(unsigned int _C);
#pragma binding(msvcrt::_ismbbprint_l, "_ismbbprint_l")
int _ismbbprint_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbgraph, "_ismbbgraph")
int _ismbbgraph(unsigned int _C);
#pragma binding(msvcrt::_ismbbgraph_l, "_ismbbgraph_l")
int _ismbbgraph_l(unsigned int _C, _locale_t _Locale);
#ifndef _MBLEADTRAIL_DEFINED
#define _MBLEADTRAIL_DEFINED
#pragma binding(msvcrt::_ismbblead, "_ismbblead")
int _ismbblead(unsigned int _C);
#pragma binding(msvcrt::_ismbblead_l, "_ismbblead_l")
int _ismbblead_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbtrail, "_ismbbtrail")
int _ismbbtrail(unsigned int _C);
#pragma binding(msvcrt::_ismbbtrail_l, "_ismbbtrail_l")
int _ismbbtrail_l(unsigned int _C, _locale_t _Locale);
#pragma binding(msvcrt::_ismbslead, "_ismbslead")
int _ismbslead(const unsigned char *_Str, const unsigned char *_Pos);
#pragma binding(msvcrt::_ismbslead_l, "_ismbslead_l")
int _ismbslead_l(const unsigned char *_Str, const unsigned char *_Pos, _locale_t _Locale);
#pragma binding(msvcrt::_ismbstrail, "_ismbstrail")
int _ismbstrail(const unsigned char *_Str, const unsigned char *_Pos);
#pragma binding(msvcrt::_ismbstrail_l, "_ismbstrail_l")
int _ismbstrail_l(const unsigned char *_Str, const unsigned char *_Pos, _locale_t _Locale);
#endif
#endif

#pragma binding(msvcrt::_mbccpy, "_mbccpy")
void _mbccpy(unsigned char *dest, const unsigned char *src);
#pragma binding(msvcrt::_mbccpy_l, "_mbccpy_l")
void _mbccpy_l(unsigned char *dest, const unsigned char *src, _locale_t locale);

#endif
