// wordexp.h -- shell word expansion, bound to the C library: glibc's calls
// in libc.so.6 and libSystem's. The flag and error numbering differ: glibc
// enumerates both and has WRDE_NOSYS, -1, for X/Open alone; the SDK
// defines macros.

#pragma once

#include <stddef.h>

typedef struct {
    size_t we_wordc;
    char **we_wordv;
    size_t we_offs;
} wordexp_t;

#ifdef __linux__
enum {
    WRDE_DOOFFS = (1 << 0),
    WRDE_APPEND = (1 << 1),
    WRDE_NOCMD = (1 << 2),
    WRDE_REUSE = (1 << 3),
    WRDE_SHOWERR = (1 << 4),
    WRDE_UNDEF = (1 << 5),
    __WRDE_FLAGS = (WRDE_DOOFFS | WRDE_APPEND | WRDE_NOCMD | WRDE_REUSE | WRDE_SHOWERR | WRDE_UNDEF)
};

enum {
#if defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE)
    WRDE_NOSYS = -1,
#endif
    WRDE_NOSPACE = 1,
    WRDE_BADCHAR,
    WRDE_BADVAL,
    WRDE_CMDSUB,
    WRDE_SYNTAX
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wordexp, "wordexp")
#pragma binding(libc::wordfree, "wordfree")
#elif defined(__APPLE__)
#define WRDE_APPEND 0x01
#define WRDE_DOOFFS 0x02
#define WRDE_NOCMD 0x04
#define WRDE_REUSE 0x08
#define WRDE_SHOWERR 0x10
#define WRDE_UNDEF 0x20

#define WRDE_BADCHAR 1
#define WRDE_BADVAL 2
#define WRDE_CMDSUB 3
#define WRDE_NOSPACE 4
#define WRDE_NOSYS 5
#define WRDE_SYNTAX 6

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wordexp, "_wordexp")
#pragma binding(libc::wordfree, "_wordfree")
#endif

int wordexp(const char *restrict words, wordexp_t *restrict pwordexp, int flags);
void wordfree(wordexp_t *pwordexp);
