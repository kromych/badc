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
#pragma binding(msvcrt::_isctype,   "_isctype")
#pragma binding(msvcrt::_isctype_l, "_isctype_l")
#pragma binding(msvcrt::isleadbyte, "isleadbyte")
#pragma binding(msvcrt::_isleadbyte_l, "_isleadbyte_l")
#include <corecrt.h>
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
int isleadbyte(int c);
int _isleadbyte_l(int c, _locale_t locale);
#endif

// isascii: the C macro form; no libc symbol.
#define isascii(c) (((unsigned)(c)) < 128)
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
// C99 7.4.1.3: blank is space or horizontal tab in the C locale.
static inline int isblank(int c) {
    return c == 0x20 || c == 0x09;
}

// XSI (SVID / X/Open): reduce a value to 7-bit ASCII. A pure computation,
// so provided inline rather than bound to a libc symbol.
static inline int toascii(int c) {
    return c & 0x7f;
}
