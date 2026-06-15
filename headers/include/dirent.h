// dirent.h -- POSIX directory iteration.
//
// `DIR` is opaque on every libc; programs only ever pass `DIR *`
// through bound libc routines. The struct is sized to comfortably
// hold whatever shape the platform libc uses internally.

#ifndef _C5_DIRENT_H
#define _C5_DIRENT_H

// On Windows, sqlite's bundled shell.c rolls its own DIR / dirent
// implementation on top of FindFirstFile / FindNextFile. The
// roll-your-own struct has Windows-flavoured fields
// (`d_attributes`) that don't appear on POSIX, so we skip the
// POSIX layout here and let shell.c's `#if defined(_WIN32) &&
// defined(_MSC_VER)` block define everything itself. Programs
// that include `<dirent.h>` on Windows for the function decls
// alone get the empty-but-flagged-included header.
#ifdef _WIN32
#endif

#ifndef _WIN32

#include <sys/types.h>

struct __c5_DIR { char __opaque[256]; };
typedef struct __c5_DIR DIR;

// `struct dirent` -- the per-entry shape returned by `readdir`. The
// field layout up to d_name must match the platform libc byte-for-byte,
// since libc writes into the buffer it returns and programs read d_name
// at its real offset. macOS (64-bit inode) places d_name at offset 21;
// glibc at offset 19.
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
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::opendir,  "opendir")
#pragma binding(libc::readdir,  "readdir")
#pragma binding(libc::closedir, "closedir")
#pragma binding(libc::rewinddir,"rewinddir")
#pragma binding(libc::fdopendir,"fdopendir")
#endif

DIR *opendir(char *path);
// POSIX: open a directory stream on an already-open descriptor.
DIR *fdopendir(int fd);
struct dirent *readdir(DIR *dir);
int closedir(DIR *dir);
int rewinddir(DIR *dir);

#endif /* !_WIN32 */

#endif
