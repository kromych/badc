// sys/statvfs.h -- file system information (POSIX): struct statvfs in the
// C library's layout, the ST_* f_flag bits, statvfs(), and fstatvfs().

#pragma once

#if defined(__APPLE__) || defined(__linux__)
#include <sys/types.h>

#ifdef __APPLE__
struct statvfs {
    unsigned long f_bsize;
    unsigned long f_frsize;
    fsblkcnt_t f_blocks;
    fsblkcnt_t f_bfree;
    fsblkcnt_t f_bavail;
    fsfilcnt_t f_files;
    fsfilcnt_t f_ffree;
    fsfilcnt_t f_favail;
    unsigned long f_fsid;
    unsigned long f_flag;
    unsigned long f_namemax;
};

#define ST_RDONLY 0x00000001
#define ST_NOSUID 0x00000002

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::statvfs,  "_statvfs")
#pragma binding(libc::fstatvfs, "_fstatvfs")
#else
// glibc's LP64 layout.
struct statvfs {
    unsigned long f_bsize;
    unsigned long f_frsize;
    fsblkcnt_t f_blocks;
    fsblkcnt_t f_bfree;
    fsblkcnt_t f_bavail;
    fsfilcnt_t f_files;
    fsfilcnt_t f_ffree;
    fsfilcnt_t f_favail;
    unsigned long f_fsid;
    unsigned long f_flag;
    unsigned long f_namemax;
    unsigned int f_type;
    int __f_spare[5];
};

#define ST_RDONLY 1
#define ST_NOSUID 2
#ifdef _GNU_SOURCE
#define ST_NODEV       4
#define ST_NOEXEC      8
#define ST_SYNCHRONOUS 16
#define ST_MANDLOCK    64
#define ST_WRITE       128
#define ST_APPEND      256
#define ST_IMMUTABLE   512
#define ST_NOATIME     1024
#define ST_NODIRATIME  2048
#define ST_RELATIME    4096
#define ST_NOSYMFOLLOW 8192
#endif

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::statvfs,  "statvfs")
#pragma binding(libc::fstatvfs, "fstatvfs")
#endif

int statvfs(const char *restrict path, struct statvfs *restrict buf);
int fstatvfs(int fd, struct statvfs *buf);
#endif
