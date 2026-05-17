// locale.h -- locale category selection and numeric formatting
// conventions (C99 7.11).
//
// Values match every supported host's <locale.h>:
//   * macOS / Linux glibc / Linux musl: LC_ALL=0, LC_COLLATE=1,
//     LC_CTYPE=2, LC_MONETARY=3, LC_NUMERIC=4, LC_TIME=5,
//     LC_MESSAGES=6.
//   * Windows msvcrt: LC_ALL=0, LC_COLLATE=1, LC_CTYPE=2,
//     LC_MONETARY=3, LC_NUMERIC=4, LC_TIME=5. No LC_MESSAGES.
// The shared subset matches, so the constants line up across all
// hosts without per-target conditionals.

#pragma once

#define LC_ALL      0
#define LC_COLLATE  1
#define LC_CTYPE    2
#define LC_MONETARY 3
#define LC_NUMERIC  4
#define LC_TIME     5

// `struct lconv` layout is implementation-defined (C99 7.11.2.1).
// Only `decimal_point` is portably read across hosts; the rest are
// rarely-used currency-formatting fields. Pad the trailing area
// generously so the host libc can write its own larger struct
// without overflowing this typedef.
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
