// ftw.h -- POSIX file-tree walk. `ftw` recurses a directory tree and
// calls `fn` for each entry with the entry path, its `struct stat`, and a
// type flag. The legacy `ftw` (vs `nftw`) is enough for callers that only
// need the path.

#pragma once

#include <sys/stat.h>

// `typeflag` values passed to the callback.
#define FTW_F   0 /* regular file */
#define FTW_D   1 /* directory */
#define FTW_DNR 2 /* directory that cannot be read */
#define FTW_NS  3 /* stat failed */
#define FTW_SL  4 /* symbolic link */

#ifdef __APPLE__
#pragma binding(libc::ftw, "_ftw")
#endif
#ifdef __linux__
#pragma binding(libc::ftw, "ftw")
#endif

int ftw(const char *path,
        int (*fn)(const char *fpath, const struct stat *sb, int typeflag),
        int nopenfd);
