// glob.h -- POSIX filename pattern expansion.
//
// Used by chibicc's main.c to expand `-I` search-path arguments
// that include shell-style wildcards. Layout pinned to the
// glibc / Darwin shape so the libc-side writes land at the
// offsets c5 reads.

#pragma once

#include <stddef.h>

#define GLOB_ERR        0x0001
#define GLOB_MARK       0x0002
#define GLOB_NOSORT     0x0004
#define GLOB_DOOFFS     0x0008
#define GLOB_NOCHECK    0x0010
#define GLOB_APPEND     0x0020
#define GLOB_NOESCAPE   0x0040

#define GLOB_NOSPACE    1
#define GLOB_ABORTED    2
#define GLOB_NOMATCH    3

// `gl_pathc` / `gl_offs` are `size_t` per POSIX. The trailing
// pad keeps every platform's private state inside the struct
// when the libc writes through the returned pointer: glibc's
// `glob_t` carries seven extra pointers, Darwin's eight; 96
// bytes covers both.
typedef struct {
    int    gl_pathc;
    char **gl_pathv;
    int    gl_offs;
    char   __pad[96];
} glob_t;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::glob,     "_glob")
#pragma binding(libc::globfree, "_globfree")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::glob,     "glob")
#pragma binding(libc::globfree, "globfree")
#endif

#ifdef _WIN32
// msvcrt has no `glob`; the bringup for chibicc targets macOS /
// Linux first. A Windows port would walk paths via FindFirstFile
// directly.
#endif

int  glob(char *pattern, int flags, void *errfunc, glob_t *pglob);
int  globfree(glob_t *pglob);
