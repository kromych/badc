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
#pragma binding(libc::bcmp,        "_bcmp")
#pragma binding(libc::bcopy,       "_bcopy")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::strcasecmp,  "strcasecmp")
#pragma binding(libc::strncasecmp, "strncasecmp")
#pragma binding(libc::bzero,       "bzero")
#pragma binding(libc::bcmp,        "bcmp")
#pragma binding(libc::bcopy,       "bcopy")
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
// The legacy memory routines POSIX.1-2001 kept in <strings.h> and
// marked obsolescent in favour of <string.h>'s memset / memcmp /
// memmove. Still exported by both C libraries, so source that predates
// the replacement keeps building.
void bzero(void *s, unsigned long n);
int bcmp(const void *a, const void *b, unsigned long n);
void bcopy(const void *src, void *dst, unsigned long n);
#endif
