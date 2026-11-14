// ctype.h -- character classification and case folding.
//
// Every function here returns an `int` (truthy / falsy for the
// `is*` predicates, the converted code point for tolower / toupper).
// The argument is an `int` so callers can pass the raw `char` byte
// or `EOF` (-1) without sign-extension concerns -- libc's
// implementations on every target we ship to are tolerant of the
// wider input.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::isspace,  "_isspace")
#pragma binding(libc::isdigit,  "_isdigit")
#pragma binding(libc::isalpha,  "_isalpha")
#pragma binding(libc::isalnum,  "_isalnum")
#pragma binding(libc::isxdigit, "_isxdigit")
#pragma binding(libc::isprint,  "_isprint")
#pragma binding(libc::isgraph,  "_isgraph")
#pragma binding(libc::ispunct,  "_ispunct")
#pragma binding(libc::iscntrl,  "_iscntrl")
#pragma binding(libc::islower,  "_islower")
#pragma binding(libc::isupper,  "_isupper")
#pragma binding(libc::tolower,  "_tolower")
#pragma binding(libc::toupper,  "_toupper")
#pragma binding(libc::isblank,  "_isblank")
#pragma binding(libc::isascii,  "_isascii")
#pragma binding(libc::toascii,  "_toascii")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::isspace,  "isspace")
#pragma binding(libc::isdigit,  "isdigit")
#pragma binding(libc::isalpha,  "isalpha")
#pragma binding(libc::isalnum,  "isalnum")
#pragma binding(libc::isxdigit, "isxdigit")
#pragma binding(libc::isprint,  "isprint")
#pragma binding(libc::isgraph,  "isgraph")
#pragma binding(libc::ispunct,  "ispunct")
#pragma binding(libc::iscntrl,  "iscntrl")
#pragma binding(libc::islower,  "islower")
#pragma binding(libc::isupper,  "isupper")
#pragma binding(libc::tolower,  "tolower")
#pragma binding(libc::toupper,  "toupper")
#pragma binding(libc::isblank,  "isblank")
#pragma binding(libc::isascii,  "isascii")
#pragma binding(libc::toascii,  "toascii")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::isspace,  "isspace")
#pragma binding(msvcrt::isdigit,  "isdigit")
#pragma binding(msvcrt::isalpha,  "isalpha")
#pragma binding(msvcrt::isalnum,  "isalnum")
#pragma binding(msvcrt::isxdigit, "isxdigit")
#pragma binding(msvcrt::isprint,  "isprint")
#pragma binding(msvcrt::isgraph,  "isgraph")
#pragma binding(msvcrt::ispunct,  "ispunct")
#pragma binding(msvcrt::iscntrl,  "iscntrl")
#pragma binding(msvcrt::islower,  "islower")
#pragma binding(msvcrt::isupper,  "isupper")
#pragma binding(msvcrt::tolower,  "tolower")
#pragma binding(msvcrt::toupper,  "toupper")
// msvcrt exports the XSI pair under reserved names and has no `isblank`;
// `ctype_ext.c` supplies it.
#pragma binding(msvcrt::isascii,  "__isascii")
#pragma binding(msvcrt::toascii,  "__toascii")
#pragma binding(msvcrt::_isctype,   "_isctype")
#pragma binding(msvcrt::_isctype_l, "_isctype_l")
#include <corecrt.h>
#include <__badc_wctype.h>
#define _UPPER    0x1
#define _LOWER    0x2
#define _DIGIT    0x4
#define _SPACE    0x8
#define _PUNCT    0x10
#define _CONTROL  0x20
#define _BLANK    0x40
#define _HEX      0x80
#define _LEADBYTE 0x8000
#define _ALPHA    (0x0100 | _UPPER | _LOWER)
int _isctype(int c, int type);
int _isctype_l(int c, int type, _locale_t locale);
#endif

int isspace(int c);
int isdigit(int c);
int isalpha(int c);
int isalnum(int c);
int isxdigit(int c);
int isprint(int c);
int isgraph(int c);
int ispunct(int c);
int iscntrl(int c);
int islower(int c);
int isupper(int c);
int tolower(int c);
int toupper(int c);
// C99 7.4.1.3.
int isblank(int c);
// XSI: whether `c` is a 7-bit value, and `c` reduced to one. Each macro
// evaluates its argument once, as C17 7.1.4 requires of a macro form.
int isascii(int c);
int toascii(int c);
#define isascii(c) (((unsigned)(c)) < 128)
#define toascii(c) ((int)((unsigned)(c) & 0x7f))

#if defined(__APPLE__) || defined(__linux__)
// POSIX.1-2008 classification and case mapping in a given locale.
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
#pragma binding(libc::isalnum_l, "_isalnum_l")
#pragma binding(libc::isalpha_l, "_isalpha_l")
#pragma binding(libc::isblank_l, "_isblank_l")
#pragma binding(libc::iscntrl_l, "_iscntrl_l")
#pragma binding(libc::isdigit_l, "_isdigit_l")
#pragma binding(libc::isgraph_l, "_isgraph_l")
#pragma binding(libc::islower_l, "_islower_l")
#pragma binding(libc::isprint_l, "_isprint_l")
#pragma binding(libc::ispunct_l, "_ispunct_l")
#pragma binding(libc::isspace_l, "_isspace_l")
#pragma binding(libc::isupper_l, "_isupper_l")
#pragma binding(libc::isxdigit_l, "_isxdigit_l")
#pragma binding(libc::tolower_l, "_tolower_l")
#pragma binding(libc::toupper_l, "_toupper_l")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::isalnum_l, "isalnum_l")
#pragma binding(libc::isalpha_l, "isalpha_l")
#pragma binding(libc::isblank_l, "isblank_l")
#pragma binding(libc::iscntrl_l, "iscntrl_l")
#pragma binding(libc::isdigit_l, "isdigit_l")
#pragma binding(libc::isgraph_l, "isgraph_l")
#pragma binding(libc::islower_l, "islower_l")
#pragma binding(libc::isprint_l, "isprint_l")
#pragma binding(libc::ispunct_l, "ispunct_l")
#pragma binding(libc::isspace_l, "isspace_l")
#pragma binding(libc::isupper_l, "isupper_l")
#pragma binding(libc::isxdigit_l, "isxdigit_l")
#pragma binding(libc::tolower_l, "tolower_l")
#pragma binding(libc::toupper_l, "toupper_l")
#endif
int isalnum_l(int c, locale_t locale);
int isalpha_l(int c, locale_t locale);
int isblank_l(int c, locale_t locale);
int iscntrl_l(int c, locale_t locale);
int isdigit_l(int c, locale_t locale);
int isgraph_l(int c, locale_t locale);
int islower_l(int c, locale_t locale);
int isprint_l(int c, locale_t locale);
int ispunct_l(int c, locale_t locale);
int isspace_l(int c, locale_t locale);
int isupper_l(int c, locale_t locale);
int isxdigit_l(int c, locale_t locale);
int tolower_l(int c, locale_t locale);
int toupper_l(int c, locale_t locale);
#endif
