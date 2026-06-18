// locale.h -- locale category selection and numeric formatting
// conventions (C99 7.11).
//
// Category constants are NOT portable across hosts. C99 7.11p1
// specifies the LC_* macro names but the numeric values are
// implementation-defined; each libc picks its own enumeration.
// User code that calls `setlocale(LC_NUMERIC, ...)` must reach
// the host libc with the host's numeric value of `LC_NUMERIC`,
// or the wrong category gets switched (and `localeconv()` then
// returns the wrong decimal separator, etc).
//
//   * macOS Darwin / Windows msvcrt:
//       LC_ALL=0, LC_COLLATE=1, LC_CTYPE=2, LC_MONETARY=3,
//       LC_NUMERIC=4, LC_TIME=5.
//   * Linux (bits/locale.h):
//       LC_CTYPE=0, LC_NUMERIC=1, LC_TIME=2, LC_COLLATE=3,
//       LC_MONETARY=4, LC_MESSAGES=5, LC_ALL=6.
//
// Provide the right enumeration per host.

#pragma once

#if defined(__linux__)
#define LC_CTYPE    0
#define LC_NUMERIC  1
#define LC_TIME     2
#define LC_COLLATE  3
#define LC_MONETARY 4
#define LC_MESSAGES 5
#define LC_ALL      6
#else
#define LC_ALL      0
#define LC_COLLATE  1
#define LC_CTYPE    2
#define LC_MONETARY 3
#define LC_NUMERIC  4
#define LC_TIME     5
#define LC_MIN      LC_ALL
#define LC_MAX      LC_TIME
#endif

// `struct lconv` layout is implementation-defined (C99 7.11.2.1).
// Only `decimal_point` is portably read across hosts; the rest are
// rarely-used currency-formatting fields. Pad the trailing area
// generously so the host libc can write its own larger struct
// without overflowing this typedef.
#ifdef _WIN32
// MSVC layout: the wide (_W_*) currency strings sit between the narrow
// pointers and the trailing int_* sign/precedence chars. localeconv()
// returns the CRT's struct, so the field order must match exactly.
struct lconv {
    char *decimal_point;
    char *thousands_sep;
    char *grouping;
    char *int_curr_symbol;
    char *currency_symbol;
    char *mon_decimal_point;
    char *mon_thousands_sep;
    char *mon_grouping;
    char *positive_sign;
    char *negative_sign;
    char int_frac_digits;
    char frac_digits;
    char p_cs_precedes;
    char p_sep_by_space;
    char n_cs_precedes;
    char n_sep_by_space;
    char p_sign_posn;
    char n_sign_posn;
    unsigned short *_W_decimal_point;
    unsigned short *_W_thousands_sep;
    unsigned short *_W_int_curr_symbol;
    unsigned short *_W_currency_symbol;
    unsigned short *_W_mon_decimal_point;
    unsigned short *_W_mon_thousands_sep;
    unsigned short *_W_positive_sign;
    unsigned short *_W_negative_sign;
    char int_p_cs_precedes;
    char int_n_cs_precedes;
    char int_p_sep_by_space;
    char int_n_sep_by_space;
    char int_p_sign_posn;
    char int_n_sign_posn;
};
#else
struct lconv {
    char *decimal_point;
    char *thousands_sep;
    char *grouping;
    char *int_curr_symbol;
    char *currency_symbol;
    char *mon_decimal_point;
    char *mon_thousands_sep;
    char *mon_grouping;
    char *positive_sign;
    char *negative_sign;
    char int_frac_digits;
    char frac_digits;
    char p_cs_precedes;
    char p_sep_by_space;
    char n_cs_precedes;
    char n_sep_by_space;
    char p_sign_posn;
    char n_sign_posn;
    char int_p_cs_precedes;
    char int_n_cs_precedes;
    char int_p_sep_by_space;
    char int_n_sep_by_space;
    char int_p_sign_posn;
    char int_n_sign_posn;
    unsigned char __pad[64];
};
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setlocale,  "_setlocale")
#pragma binding(libc::localeconv, "_localeconv")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setlocale,  "setlocale")
#pragma binding(libc::localeconv, "localeconv")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::setlocale,  "setlocale")
#pragma binding(msvcrt::localeconv, "localeconv")
#endif

char *setlocale(int category, const char *locale);
struct lconv *localeconv(void);
