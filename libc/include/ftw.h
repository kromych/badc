// ftw.h -- POSIX file-tree walk. `ftw` and the XSI `nftw` recurse a
// directory tree and call `fn` for each entry with the entry path, its
// `struct stat` and a type flag, and for nftw its position.

#pragma once

#include <sys/stat.h>

// The callback's typeflag values and nftw's flags, as each C library numbers
// them: glibc and mingw-w64 alike, the macOS SDK its own way.
#ifdef __APPLE__
#define FTW_F   0 /* regular file */
#define FTW_D   1 /* directory */
#define FTW_DNR 2 /* directory that cannot be read */
#define FTW_DP  3 /* directory whose subdirectories have been visited */
#define FTW_NS  4 /* stat failed */
#define FTW_SL  5 /* symbolic link */
#define FTW_SLN 6 /* symbolic link naming no file */
#define FTW_PHYS  0x01
#define FTW_MOUNT 0x02
#define FTW_DEPTH 0x04
#define FTW_CHDIR 0x08
#else
#define FTW_F   0
#define FTW_D   1
#define FTW_DNR 2
#define FTW_NS  3
#define FTW_SL  4
#define FTW_DP  5
#define FTW_SLN 6
#define FTW_PHYS  1
#define FTW_MOUNT 2
#define FTW_CHDIR 4
#define FTW_DEPTH 8
#endif

// nftw's position of an entry: the offset of its name in the path passed,
// and its depth below the root.
struct FTW {
    int base;
    int level;
};

#ifdef __APPLE__
#pragma binding(libc::ftw, "_ftw")
#pragma binding(libc::nftw, "_nftw")
#endif
#ifdef __linux__
#pragma binding(libc::ftw, "ftw")
#pragma binding(libc::nftw, "nftw")
#endif

int ftw(const char *path,
        int (*fn)(const char *fpath, const struct stat *sb, int typeflag),
        int nopenfd);
#if defined(__APPLE__) || defined(__linux__)
int nftw(const char *path,
         int (*fn)(const char *fpath, const struct stat *sb, int typeflag, struct FTW *ftwbuf),
         int fd_limit, int flags);
#endif
