// dirent.h -- POSIX directory iteration.
//
// `DIR` is opaque on every libc; programs only ever pass `DIR *`
// through bound libc routines. The struct is sized to comfortably
// hold whatever shape the platform libc uses internally.

#pragma once

#ifdef _WIN32
// mingw-w64's directory stream, which libc/lib/dirent_ext.c defines over
// FindFirstFileA. Under msvc_compat.h's `_MSC_VER` the header declares
// nothing, as cl ships none, so a program built as MSVC keeps its own DIR
// and opendir.
#ifndef _MSC_VER
struct dirent {
    long d_ino;              /* always 0 */
    unsigned short d_reclen; /* always 0 */
    unsigned short d_namlen; /* the length of d_name */
    char d_name[260];
};
typedef struct __c5_DIR DIR;
DIR *opendir(const char *name);
struct dirent *readdir(DIR *dir);
int closedir(DIR *dir);
void rewinddir(DIR *dir);
long telldir(DIR *dir);
void seekdir(DIR *dir, long loc);
#endif
#else

#include <sys/types.h>

struct __c5_DIR { char __opaque[256]; };
typedef struct __c5_DIR DIR;

// `struct dirent` -- the per-entry shape returned by `readdir`. The
// field layout up to d_name must match the platform libc byte-for-byte,
// since libc writes into the buffer it returns and programs read d_name
// at its real offset. macOS (64-bit inode) places d_name at offset 21;
// Linux at offset 19.
#ifdef __APPLE__
struct dirent {
    unsigned long  d_ino;     /* offset  0 */
    unsigned long  d_seekoff; /* offset  8 */
    unsigned short d_reclen;  /* offset 16 */
    unsigned short d_namlen;  /* offset 18 */
    unsigned char  d_type;    /* offset 20 */
    char d_name[1024];        /* offset 21 */
};
#else
struct dirent {
    unsigned long  d_ino;     /* offset  0 */
    long           d_off;     /* offset  8 */
    unsigned short d_reclen;  /* offset 16 */
    unsigned char  d_type;    /* offset 18 */
    char d_name[1024];        /* offset 19 */
};
#endif

#define DT_UNKNOWN 0
#define DT_FIFO    1
#define DT_CHR     2
#define DT_DIR     4
#define DT_BLK     6
#define DT_REG     8
#define DT_LNK    10
#define DT_SOCK   12

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::opendir,  "_opendir")
#pragma binding(libc::readdir,  "_readdir")
#pragma binding(libc::closedir, "_closedir")
#pragma binding(libc::rewinddir,"_rewinddir")
#pragma binding(libc::fdopendir,"_fdopendir")
#pragma binding(libc::dirfd,    "_dirfd")
#pragma binding(libc::telldir,  "_telldir")
#pragma binding(libc::seekdir,  "_seekdir")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::opendir,  "opendir")
#pragma binding(libc::readdir,  "readdir")
#pragma binding(libc::closedir, "closedir")
#pragma binding(libc::rewinddir,"rewinddir")
#pragma binding(libc::fdopendir,"fdopendir")
#pragma binding(libc::dirfd,    "dirfd")
#pragma binding(libc::telldir,  "telldir")
#pragma binding(libc::seekdir,  "seekdir")
#endif

DIR *opendir(char *path);
// POSIX: open a directory stream on an already-open descriptor.
DIR *fdopendir(int fd);
struct dirent *readdir(DIR *dir);
int closedir(DIR *dir);
void rewinddir(DIR *dir);
// POSIX: the file descriptor backing an open directory stream.
int dirfd(DIR *dir);
// POSIX: the current position of a directory stream, and a seek back to
// a position a prior telldir returned.
long telldir(DIR *dir);
void seekdir(DIR *dir, long loc);

#endif /* !_WIN32 */
