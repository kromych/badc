/* The feature-test macros: a program selects the names the headers declare by
** defining them ahead of any header (POSIX.1-2024 2.2.1), and the C library
** derives the rest by the rules of the GNU C library's <features.h>, at the
** 2.17 interface badc declares (`__GLIBC_MINOR__`). On Linux every bundled C
** library header is entered after this one. badc defines `__STRICT_ANSI__`
** under `--gnu` whatever the dialect, so the defaults do not depend on it. */
#pragma once

#ifdef _GNU_SOURCE
#undef _ISOC95_SOURCE
#define _ISOC95_SOURCE 1
#undef _ISOC99_SOURCE
#define _ISOC99_SOURCE 1
#undef _ISOC11_SOURCE
#define _ISOC11_SOURCE 1
#undef _POSIX_SOURCE
#define _POSIX_SOURCE 1
#undef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 200809L
#undef _XOPEN_SOURCE
#define _XOPEN_SOURCE 700
#undef _XOPEN_SOURCE_EXTENDED
#define _XOPEN_SOURCE_EXTENDED 1
#undef _LARGEFILE64_SOURCE
#define _LARGEFILE64_SOURCE 1
#undef _DEFAULT_SOURCE
#define _DEFAULT_SOURCE 1
#undef _ATFILE_SOURCE
#define _ATFILE_SOURCE 1
#endif

/* Nothing requested but `_DEFAULT_SOURCE`: the defaults. */
#if defined(_DEFAULT_SOURCE) ||                                                \
    (!defined(_ISOC99_SOURCE) && !defined(_ISOC11_SOURCE) &&                    \
     !defined(_POSIX_SOURCE) && !defined(_POSIX_C_SOURCE) && !defined(_XOPEN_SOURCE))
#undef _DEFAULT_SOURCE
#define _DEFAULT_SOURCE 1
#endif

/* No POSIX level requested: the one the X/Open level implies, or the latest. */
#if !defined(_POSIX_SOURCE) && !defined(_POSIX_C_SOURCE)
#define _POSIX_SOURCE 1
#if defined(_XOPEN_SOURCE) && (_XOPEN_SOURCE - 0) < 500
#define _POSIX_C_SOURCE 2
#elif defined(_XOPEN_SOURCE) && (_XOPEN_SOURCE - 0) < 600
#define _POSIX_C_SOURCE 199506L
#elif defined(_XOPEN_SOURCE) && (_XOPEN_SOURCE - 0) < 700
#define _POSIX_C_SOURCE 200112L
#else
#define _POSIX_C_SOURCE 200809L
#endif
#endif
