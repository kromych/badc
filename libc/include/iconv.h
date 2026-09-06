// iconv.h -- XSI character-set conversion (POSIX 7.24.2).
//
// `iconv_t` is an opaque handle. Where the routines live differs:
// glibc keeps them in libc, macOS in libiconv.

#pragma once

#include <stddef.h>

typedef void *iconv_t;

#ifdef __APPLE__
#pragma dylib(libiconv, "/usr/lib/libiconv.2.dylib")
#pragma binding(libiconv::iconv_open,  "_iconv_open")
#pragma binding(libiconv::iconv,       "_iconv")
#pragma binding(libiconv::iconv_close, "_iconv_close")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::iconv_open,  "iconv_open")
#pragma binding(libc::iconv,       "iconv")
#pragma binding(libc::iconv_close, "iconv_close")
#endif

#if defined(__APPLE__) || defined(__linux__)
// Open a descriptor converting from `fromcode` to `tocode`; returns
// (iconv_t)-1 on failure.
iconv_t iconv_open(const char *tocode, const char *fromcode);
// Convert, advancing both cursors and shrinking both counts. Returns
// the number of irreversible conversions, or (size_t)-1 on failure.
size_t iconv(iconv_t cd, char **inbuf, size_t *inbytesleft,
             char **outbuf, size_t *outbytesleft);
int iconv_close(iconv_t cd);
#endif
