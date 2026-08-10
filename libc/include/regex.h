// regex.h -- POSIX.2 regular expressions (IEEE Std 1003.1).
//
// `regex_t` is written by the libc that compiled the pattern, and
// `regmatch_t` is read back by the program, so both are ABI. The
// BSD-derived libc keeps `re_nsub` at offset 8 of a 32-byte struct and
// makes `regoff_t` 64-bit; glibc keeps it at offset 48 of a 64-byte one
// with a 32-bit `regoff_t`. REG_NEWLINE and REG_NOSUB are likewise
// swapped between the two. Each branch carries its own libc's shape;
// the private members exist only to place `re_nsub` and to size the
// object, and are not part of the interface.
//
// macOS and Linux bind the platform routines. Windows has none in
// msvcrt, so the calls resolve to badc's own engine, joined to the link
// on demand from `libc/lib/pattern.c`; that engine's supported subset
// is documented there.

#pragma once

#include <stddef.h>

#ifdef __APPLE__

typedef long long regoff_t;

typedef struct {
    int re_magic;
    size_t re_nsub;
    const char *re_endp;
    void *re_g;
} regex_t;

#define REG_BASIC    0000
#define REG_EXTENDED 0001
#define REG_ICASE    0002
#define REG_NOSUB    0004
#define REG_NEWLINE  0010
#define REG_NOSPEC   0020
#define REG_PEND     0040
#define REG_LITERAL  REG_NOSPEC

#define REG_NOTBOL   00001
#define REG_NOTEOL   00002
#define REG_STARTEND 00004

#define REG_EMPTY  14
#define REG_ASSERT 15
#define REG_INVARG 16
#define REG_ILLSEQ 17

#elif defined(__linux__)

typedef int regoff_t;

typedef struct {
    void *__buffer;
    unsigned long __allocated;
    unsigned long __used;
    unsigned long __syntax;
    char *__fastmap;
    char *__translate;
    size_t re_nsub;
    unsigned int __bits;
} regex_t;

#define REG_EXTENDED 1
#define REG_ICASE    2
#define REG_NEWLINE  4
#define REG_NOSUB    8

#define REG_NOTBOL   1
#define REG_NOTEOL   2
#define REG_STARTEND 4

#define REG_EEND    14
#define REG_ESIZE   15
#define REG_ERPAREN 16

#else

// badc's own engine. `__prog` holds the compiled pattern.
typedef int regoff_t;

typedef struct {
    void *__prog;
    size_t re_nsub;
} regex_t;

#define REG_EXTENDED 1
#define REG_ICASE    2
#define REG_NEWLINE  4
#define REG_NOSUB    8

#define REG_NOTBOL   1
#define REG_NOTEOL   2
#define REG_STARTEND 4

#endif

typedef struct {
    regoff_t rm_so;
    regoff_t rm_eo;
} regmatch_t;

#define REG_ENOSYS   (-1)
#define REG_NOMATCH   1
#define REG_BADPAT    2
#define REG_ECOLLATE  3
#define REG_ECTYPE    4
#define REG_EESCAPE   5
#define REG_ESUBREG   6
#define REG_EBRACK    7
#define REG_EPAREN    8
#define REG_EBRACE    9
#define REG_BADBR    10
#define REG_ERANGE   11
#define REG_ESPACE   12
#define REG_BADRPT   13

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::regcomp,  "_regcomp")
#pragma binding(libc::regexec,  "_regexec")
#pragma binding(libc::regerror, "_regerror")
#pragma binding(libc::regfree,  "_regfree")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::regcomp,  "regcomp")
#pragma binding(libc::regexec,  "regexec")
#pragma binding(libc::regerror, "regerror")
#pragma binding(libc::regfree,  "regfree")
#endif

int regcomp(regex_t *preg, const char *pattern, int cflags);
int regexec(const regex_t *preg, const char *string, size_t nmatch,
            regmatch_t *pmatch, int eflags);
size_t regerror(int errcode, const regex_t *preg, char *errbuf, size_t errbuf_size);
void regfree(regex_t *preg);
