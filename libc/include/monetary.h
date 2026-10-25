// monetary.h -- monetary formatting, bound to the C library: glibc's
// strfmon in libc.so.6 and libSystem's. TODO: strfmon_l, with locale_t and
// the POSIX.1-2008 locale objects of <locale.h>.

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
