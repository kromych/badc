// fnmatch.h -- POSIX filename pattern matching (IEEE Std 1003.1).
//
// The flag values are ABI, not spelling: the BSD-derived libc numbers
// FNM_NOESCAPE 1 and FNM_PATHNAME 2, glibc the other way round, so a
// single set of values would silently swap the two on one of the
// targets. Each branch carries the values its libc compiled against.
//
// macOS and Linux bind the platform `fnmatch`. Windows has none in
// msvcrt, so the call resolves to badc's own implementation, joined to
// the link on demand from `libc/lib/pattern.c`.

#pragma once

#define FNM_NOMATCH 1
#define FNM_NOSYS   (-1)

#ifdef __APPLE__
#define FNM_NOESCAPE    0x01
#define FNM_PATHNAME    0x02
#define FNM_PERIOD      0x04
#define FNM_LEADING_DIR 0x08
#define FNM_CASEFOLD    0x10
#else
#define FNM_PATHNAME    0x01
#define FNM_NOESCAPE    0x02
#define FNM_PERIOD      0x04
#define FNM_LEADING_DIR 0x08
#define FNM_CASEFOLD    0x10
#endif

#define FNM_FILE_NAME  FNM_PATHNAME
#define FNM_IGNORECASE FNM_CASEFOLD

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fnmatch, "_fnmatch")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fnmatch, "fnmatch")
#endif

int fnmatch(const char *pattern, const char *string, int flags);
