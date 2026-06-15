// sys/statvfs.h -- filesystem statistics (POSIX statvfs/fstatvfs).
//
// `struct statvfs` is declared in <sys/stat.h>; the buffer is opaque to
// c5 here, matching the plain stat() convention.

#pragma once

#if defined(__APPLE__) || defined(__linux__)
// Mount-flag bits reported in statvfs::f_flag (POSIX). Same values on
// macOS and Linux.
#define ST_RDONLY 1
#define ST_NOSUID 2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::statvfs,  "_statvfs")
#pragma binding(libc::fstatvfs, "_fstatvfs")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::statvfs,  "statvfs")
#pragma binding(libc::fstatvfs, "fstatvfs")
#endif

int statvfs(char *path, char *buf);
int fstatvfs(int fd, char *buf);
#endif
