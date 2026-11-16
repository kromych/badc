// glob.h -- POSIX glob(3) pathname pattern expansion: glob_t in the C
// library's layout, its GLOB_* flags and error values, glob(), and
// globfree().

#pragma once

#include <stddef.h>

struct dirent;
struct stat;

#ifdef __APPLE__
typedef struct {
    size_t gl_pathc;
    int gl_matchc;
    size_t gl_offs;
    int gl_flags;
    char **gl_pathv;
    union {
        int (*gl_errfunc)(const char *, int);
        void *gl_errblk;
    };
    void (*gl_closedir)(void *);
    struct dirent *(*gl_readdir)(void *);
    void *(*gl_opendir)(const char *);
    int (*gl_lstat)(const char *, struct stat *);
    int (*gl_stat)(const char *, struct stat *);
} glob_t;

#define GLOB_APPEND     0x0001
#define GLOB_DOOFFS     0x0002
#define GLOB_ERR        0x0004
#define GLOB_MARK       0x0008
#define GLOB_NOCHECK    0x0010
#define GLOB_NOSORT     0x0020
#define GLOB_ALTDIRFUNC 0x0040
#define GLOB_BRACE      0x0080
#define GLOB_MAGCHAR    0x0100
#define GLOB_NOMAGIC    0x0200
#define GLOB_QUOTE      0x0400
#define GLOB_TILDE      0x0800
#define GLOB_LIMIT      0x1000
#define GLOB_NOESCAPE   0x2000
#define GLOB_MAXPATH    GLOB_LIMIT

#define GLOB_NOSPACE (-1)
#define GLOB_ABORTED (-2)
#define GLOB_NOMATCH (-3)
#define GLOB_NOSYS   (-4)

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::glob,     "_glob")
#pragma binding(libc::globfree, "_globfree")
#else
typedef struct {
    size_t gl_pathc;
    char **gl_pathv;
    size_t gl_offs;
    int gl_flags;
    void (*gl_closedir)(void *);
    struct dirent *(*gl_readdir)(void *);
    void *(*gl_opendir)(const char *);
    int (*gl_lstat)(const char *restrict, struct stat *restrict);
    int (*gl_stat)(const char *restrict, struct stat *restrict);
} glob_t;

#define GLOB_ERR         (1 << 0)
#define GLOB_MARK        (1 << 1)
#define GLOB_NOSORT      (1 << 2)
#define GLOB_DOOFFS      (1 << 3)
#define GLOB_NOCHECK     (1 << 4)
#define GLOB_APPEND      (1 << 5)
#define GLOB_NOESCAPE    (1 << 6)
#define GLOB_PERIOD      (1 << 7)
#define GLOB_MAGCHAR     (1 << 8)
#define GLOB_ALTDIRFUNC  (1 << 9)
#define GLOB_BRACE       (1 << 10)
#define GLOB_NOMAGIC     (1 << 11)
#define GLOB_TILDE       (1 << 12)
#define GLOB_ONLYDIR     (1 << 13)
#define GLOB_TILDE_CHECK (1 << 14)

#define GLOB_NOSPACE 1
#define GLOB_ABORTED 2
#define GLOB_NOMATCH 3
#define GLOB_NOSYS   4

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::glob,     "glob")
#pragma binding(libc::globfree, "globfree")
#endif
#define GLOB_ABEND GLOB_ABORTED

int glob(const char *restrict pattern, int flags,
         int (*errfunc)(const char *epath, int eerrno), glob_t *restrict pglob);
void globfree(glob_t *pglob);
