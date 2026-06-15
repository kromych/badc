// fts.h -- file-hierarchy traversal (fts_open / fts_read / fts_close).
//
// Only the surface a recursive directory walk reaches is provided:
// fts_open with an option mask, fts_read returning one FTSENT per
// visited node, and fts_close. `FTS` is opaque (used only through a
// pointer). `FTSENT` is laid out per target because the BSD (macOS)
// and glibc layouts differ -- the four fields callers read
// (fts_info, fts_path, fts_pathlen, fts_statp) are placed at the
// offsets the platform header uses, verified with offsetof; the
// surrounding members are reserved as padding. The FTS_* option and
// node-type constants share values across both targets.

#pragma once

#include <sys/types.h>
#include <sys/stat.h>

// fts_open option mask.
#define FTS_PHYSICAL 0x0010
#define FTS_NOCHDIR  0x0004
#define FTS_NOSTAT   0x0008

// fts_info node-type codes.
#define FTS_D   1
#define FTS_DP  6
#define FTS_DNR 4
#define FTS_ERR 7
#define FTS_NS  10

typedef struct _fts FTS;

#ifdef __APPLE__
// BSD layout: sizeof 112, fts_path@48, fts_pathlen@64, fts_info@88,
// fts_statp@96.
typedef struct _ftsent {
    char _r0[48];
    char *fts_path;
    char _r1[8];
    unsigned short fts_pathlen;
    char _r2[22];
    unsigned short fts_info;
    char _r3[6];
    struct stat *fts_statp;
    char _r4[8];
} FTSENT;
#elif defined(__aarch64__)
// glibc aarch64 layout: sizeof 120, fts_path@48, fts_pathlen@64,
// fts_info@94, fts_statp@104.
typedef struct _ftsent {
    char _r0[48];
    char *fts_path;
    char _r1[8];
    unsigned short fts_pathlen;
    char _r2[28];
    unsigned short fts_info;
    char _r3[8];
    struct stat *fts_statp;
    char _r4[8];
} FTSENT;
#else
// glibc x86_64 layout: sizeof 120, fts_path@48, fts_pathlen@64,
// fts_info@98, fts_statp@104.
typedef struct _ftsent {
    char _r0[48];
    char *fts_path;
    char _r1[8];
    unsigned short fts_pathlen;
    char _r2[32];
    unsigned short fts_info;
    char _r3[4];
    struct stat *fts_statp;
    char _r4[8];
} FTSENT;
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fts_open,  "_fts_open")
#pragma binding(libc::fts_read,  "_fts_read")
#pragma binding(libc::fts_close, "_fts_close")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fts_open,  "fts_open")
#pragma binding(libc::fts_read,  "fts_read")
#pragma binding(libc::fts_close, "fts_close")
#endif

FTS *fts_open(char **path_argv, int options, void *compar);
FTSENT *fts_read(FTS *ftsp);
int fts_close(FTS *ftsp);
