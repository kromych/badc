// dirent.h -- POSIX directory iteration.
//
// `DIR` is opaque on every libc; programs only ever pass `DIR *`
// through bound libc routines. The struct is sized to comfortably
// hold whatever shape the platform libc uses internally.

#ifndef _C5_DIRENT_H
#define _C5_DIRENT_H

#include <sys/types.h>

struct __c5_DIR { char __opaque[256]; };
typedef struct __c5_DIR DIR;

// `struct dirent` -- the per-entry shape returned by `readdir`.
// Real layouts vary (BSD: 4-byte d_fileno + len + type + name; glibc:
// 8-byte d_ino + d_off + len + type + name). We expose the fields
// programs actually inspect, plus a wide d_name buffer that covers
// every platform's PATH_MAX.
struct dirent {
    int  d_ino;
    int  d_off;
    int  d_reclen;
    int  d_type;
    char d_name[1024];
};

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
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::opendir,  "opendir")
#pragma binding(libc::readdir,  "readdir")
#pragma binding(libc::closedir, "closedir")
#pragma binding(libc::rewinddir,"rewinddir")
#endif

DIR *opendir(char *path);
struct dirent *readdir(DIR *dir);
int closedir(DIR *dir);
int rewinddir(DIR *dir);

#endif
