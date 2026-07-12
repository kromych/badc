// strings.h -- POSIX case-insensitive string compare helpers.
//
// Distinct from `<string.h>`: the POSIX `<strings.h>` header
// houses the locale-aware case-folding routines. Layout follows
// the binding-by-target pattern used elsewhere under headers/.

#pragma once

#include <stddef.h>

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::strcasecmp,  "_strcasecmp")
#pragma binding(libc::strncasecmp, "_strncasecmp")
#pragma binding(libc::bzero,       "_bzero")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::strcasecmp,  "strcasecmp")
#pragma binding(libc::strncasecmp, "strncasecmp")
#pragma binding(libc::bzero,       "bzero")
#endif

#ifdef _WIN32
// msvcrt spells the case-folding compares with a leading
// underscore; the portable c5-side name resolves to the
// MSVC entry point.
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::strcasecmp,  "_stricmp")
#pragma binding(msvcrt::strncasecmp, "_strnicmp")
#endif

int strcasecmp(char *a, char *b);
int strncasecmp(char *a, char *b, int n);
#if defined(__APPLE__) || defined(__linux__)
// Legacy zero-fill (POSIX, marked obsolescent in favor of memset).
void bzero(void *s, unsigned long n);
#endif
