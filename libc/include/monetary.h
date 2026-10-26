// monetary.h -- monetary formatting, bound to the C library: glibc's
// strfmon and strfmon_l in libc.so.6 and libSystem's.

#pragma once

#include <sys/types.h> // size_t, ssize_t

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::strfmon, "strfmon")
#elif defined(__APPLE__)
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::strfmon, "_strfmon")
#endif

ssize_t strfmon(char *restrict s, size_t maxsize, const char *restrict format, ...);

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
#pragma binding(libc::strfmon_l, "_strfmon_l")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::strfmon_l, "strfmon_l")
#endif
ssize_t strfmon_l(char *restrict s, size_t maxsize, locale_t locale,
                  const char *restrict format, ...);
#endif
