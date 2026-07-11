// sys/stat.h -- file metadata: `struct stat` + the
// `S_IS<TYPE>(m)` mode-test macros + `S_I<RWX><USR/GRP/OTH>` mode
// bits.
//
// `struct stat` has different layouts on different libcs (BSD vs
// Linux vs Win32), but for c5's purposes we just need a struct
// large enough that `stat(path, &buf)` writes into a buffer
// without overrunning. Programs read individual fields by name;
// the offsets here mirror the macOS / Linux-x86_64 layout (which
// happen to align). Real-world cross-platform code that wants
// pixel-perfect parsing should call libc's `fstatat` and unpack
// manually.
#pragma once

// `struct timespec` for the nanosecond timestamp fields below.
#include <time.h>

// `struct stat` is a write-target for libc's `stat`/`lstat`/
// `fstat` family. Field offsets differ wildly across platforms
// and are NOT just sizes -- libc fills bytes at specific
// offsets, so a c5 program reading `buf.st_size` only gets the
// right value if our declaration matches the actual on-platform
// layout byte-for-byte. Each known target also matches the
// platform `sizeof(struct stat)` exactly (144 on macOS and Linux
// x86_64, 128 on Linux aarch64) so `sizeof`, by-value copies and
// arrays interoperate; the generic fallback keeps a margin since
// the real size is unknown there.
//
// macOS Darwin (after _DARWIN_FEATURE_64_BIT_INODE, the default
// since 10.5):
//
//   offset  type        field
//   ------  ----------  ------
//   0       u32         st_dev
//   4       u16         st_mode
//   6       u16         st_nlink
//   8       u64         st_ino
//   16      u32         st_uid
//   20      u32         st_gid
//   24      u32         st_rdev
//   32      timespec    st_atimespec     (16 bytes)
//   48      timespec    st_mtimespec     (16 bytes)
//   64      timespec    st_ctimespec     (16 bytes)
//   80      timespec    st_birthtimespec (16 bytes)
//   96      i64         st_size
//   104     i64         st_blocks
//   112     u32         st_blksize
//   116     u32         st_flags
//   120     u32         st_gen
//   124     i32         st_lspare
//   128     i64[2]      st_qspare        (16 bytes)
//
// 144 bytes total.
//
// Linux's `struct stat` matches the same field names but
// uses smaller types for some IDs and skips birthtime; programs
// that only read `st_mode` / `st_size` / `st_mtime` see the same
// values either way because those fields land at compatible
// offsets. The padding here is wide enough for both layouts.
//
// Win32 msvcrt's `_stat64` is laid out differently again (FILE
// times instead of POSIX times); programs needing it should
// call the `_stat64` family directly.
//
// c5 supports real 16-bit `short` (and `unsigned short`) via
// `Op::Lh` / `Op::Lhu` / `Op::Sh`, so the per-platform stat
// struct now uses `short st_mode; short st_nlink;` directly --
// reading those fields lands on the right libc bytes without any
// dword splitting / mask ceremony.
#ifdef __APPLE__
struct stat {
    int             st_dev;            /* offset  0, 4 bytes */
    unsigned short  st_mode;           /* offset  4, 2 bytes */
    unsigned short  st_nlink;          /* offset  6, 2 bytes */
    long            st_ino;            /* offset  8, 8 bytes */
    int             st_uid;            /* offset 16, 4 bytes */
    int             st_gid;            /* offset 20, 4 bytes */
    int             st_rdev;           /* offset 24, 4 bytes */
    int             __pad28;           /* offset 28, 4 bytes */
    // The nanosecond timestamp fields, named both as a timespec
    // (st_atimespec, BSD) and as the historical flat tv_sec / tv_nsec
    // pair (st_atime / st_atimensec). The union overlays the two views
    // at the same 16-byte offset.
    union {
        struct timespec st_atimespec; /* offset 32 */
        struct { long st_atime; long st_atimensec; };
    };
    union {
        struct timespec st_mtimespec; /* offset 48 */
        struct { long st_mtime; long st_mtimensec; };
    };
    union {
        struct timespec st_ctimespec; /* offset 64 */
        struct { long st_ctime; long st_ctimensec; };
    };
    union {
        struct timespec st_birthtimespec; /* offset 80 */
        struct { long st_birthtime; long st_birthtimensec; };
    };
    long            st_size;           /* offset 96, 8 bytes */
    long            st_blocks;         /* offset 104, 8 bytes */
    int             st_blksize;        /* offset 112, 4 bytes */
    int             st_flags;          /* offset 116, 4 bytes */
    int             st_gen;            /* offset 120, 4 bytes */
    int             st_lspare;         /* offset 124, 4 bytes */
    long            st_qspare0;        /* offset 128, 8 bytes */
    long            st_qspare1;        /* offset 136, 8 bytes */
};
#elif defined(__linux__) && defined(__x86_64__)
// Linux x86_64 layout. See bits/struct_stat.h:
// dev, ino, nlink each 8 bytes; mode/uid/gid 4 bytes; rdev,
// size, blksize, blocks each 8 bytes; three timespec slots;
// trailing __unused[3] longs. 144 bytes total.
struct stat {
    long st_dev;             /* offset   0, 8 bytes */
    long st_ino;             /* offset   8, 8 bytes */
    long st_nlink;           /* offset  16, 8 bytes */
    int  st_mode;            /* offset  24, 4 bytes */
    int  st_uid;             /* offset  28, 4 bytes */
    int  st_gid;             /* offset  32, 4 bytes */
    int  __pad0;             /* offset  36, 4 bytes */
    long st_rdev;            /* offset  40, 8 bytes */
    long st_size;            /* offset  48, 8 bytes */
    long st_blksize;         /* offset  56, 8 bytes */
    long st_blocks;          /* offset  64, 8 bytes */
    union {
        struct timespec st_atim; /* offset  72 */
        struct { long st_atime; long st_atimensec; };
    };
    union {
        struct timespec st_mtim; /* offset  88 */
        struct { long st_mtime; long st_mtimensec; };
    };
    union {
        struct timespec st_ctim; /* offset 104 */
        struct { long st_ctime; long st_ctimensec; };
    };
    long __unused0;          /* offset 120 */
    long __unused1;          /* offset 128 */
    long __unused2;          /* offset 136, struct ends at 144 */
};
#elif defined(__linux__) && defined(__aarch64__)
// Linux aarch64 layout. mode/nlink/uid/gid all 4 bytes
// after a pair of 8-byte dev/ino. blksize is 4 bytes here. 128
// bytes total.
struct stat {
    long st_dev;             /* offset   0, 8 bytes */
    long st_ino;             /* offset   8, 8 bytes */
    int  st_mode;            /* offset  16, 4 bytes */
    int  st_nlink;           /* offset  20, 4 bytes */
    int  st_uid;             /* offset  24, 4 bytes */
    int  st_gid;             /* offset  28, 4 bytes */
    long st_rdev;            /* offset  32, 8 bytes */
    long __pad1;             /* offset  40, 8 bytes */
    long st_size;            /* offset  48, 8 bytes */
    int  st_blksize;         /* offset  56, 4 bytes */
    int  __pad2;             /* offset  60, 4 bytes */
    long st_blocks;          /* offset  64, 8 bytes */
    union {
        struct timespec st_atim; /* offset  72 */
        struct { long st_atime; long st_atimensec; };
    };
    union {
        struct timespec st_mtim; /* offset  88 */
        struct { long st_mtime; long st_mtimensec; };
    };
    union {
        struct timespec st_ctim; /* offset 104 */
        struct { long st_ctime; long st_ctimensec; };
    };
    int  __unused0;          /* offset 120 */
    int  __unused1;          /* offset 124, struct ends at 128 */
};
#else
// Generic / fallback: matches Linux x86_64. 8-byte fields
// throughout for safety.
struct stat {
    long st_dev;
    long st_ino;
    long st_nlink;
    long st_mode;
    long st_uid;
    long st_gid;
    long st_rdev;
    long st_size;
    long st_blksize;
    long st_blocks;
    union {
        struct timespec st_atim;
        struct { long st_atime; long st_atimensec; };
    };
    union {
        struct timespec st_mtim;
        struct { long st_mtime; long st_mtimensec; };
    };
    union {
        struct timespec st_ctim;
        struct { long st_ctime; long st_ctimensec; };
    };
    char __pad[128];
};
#endif

// Mode bits
#define S_IFMT  0170000
#define S_IFREG 0100000
#define S_IFDIR 0040000
#define S_IFLNK 0120000
#define S_IFBLK 0060000
#define S_IFCHR 0020000
#define S_IFIFO 0010000
#define S_IFSOCK 0140000

#define S_ISREG(m)  (((m) & S_IFMT) == S_IFREG)
#define S_ISDIR(m)  (((m) & S_IFMT) == S_IFDIR)
#define S_ISLNK(m)  (((m) & S_IFMT) == S_IFLNK)
#define S_ISBLK(m)  (((m) & S_IFMT) == S_IFBLK)
#define S_ISCHR(m)  (((m) & S_IFMT) == S_IFCHR)
#define S_ISFIFO(m) (((m) & S_IFMT) == S_IFIFO)
#define S_ISSOCK(m) (((m) & S_IFMT) == S_IFSOCK)

#define S_IRUSR 0400
#define S_IWUSR 0200
#define S_IXUSR 0100
#define S_IRGRP 040
#define S_IWGRP 020
#define S_IXGRP 010
#define S_IROTH 04
#define S_IWOTH 02
#define S_IXOTH 01
#define S_IRWXU 0700
#define S_IRWXG 070
#define S_IRWXO 07
#define S_ISUID 04000
#define S_ISGID 02000
#define S_ISVTX 01000

// utimensat(2) special nanosecond values (C11 / POSIX.1-2008).
#define UTIME_NOW  ((1L << 30) - 1L)
#define UTIME_OMIT ((1L << 30) - 2L)

// statfs / statvfs -- filesystem-level metadata. The real layout
// differs across platforms; this opaque buffer is wide enough for
// every common shape so libc can write into it. SQLite reads
// f_bsize after a statfs to size scratch buffers; the offset of
// f_bsize varies, so we expose typedefs that cover the union of
// known layouts.
// `struct statfs` is the libc filesystem-info shape that
// `statfs(2)` / `fstatfs(2)` write into. The kernel fills it, so the
// member layout must match the host's: programs read f_bsize, f_flags,
// f_fsid, f_fstypename and the like by name. A trailing pad keeps the
// caller's frame safe if the platform struct is larger than the named
// fields (see fixtures/c/libc_struct_buf_size.c).

// Filesystem id: a pair of ints on both macOS and Linux.
typedef struct { int val[2]; } fsid_t;

#ifdef __APPLE__
// Darwin layout (sys/mount.h): f_bsize is a 32-bit unit at offset 0 and
// the block/inode counts are 64-bit, so the all-`long` shape used
// elsewhere would misplace every field past f_iosize.
struct statfs {
    unsigned int       f_bsize;      /* 0   */
    int                f_iosize;     /* 4   */
    unsigned long long f_blocks;     /* 8   */
    unsigned long long f_bfree;      /* 16  */
    unsigned long long f_bavail;     /* 24  */
    unsigned long long f_files;      /* 32  */
    unsigned long long f_ffree;      /* 40  */
    fsid_t             f_fsid;       /* 48  */
    unsigned int       f_owner;      /* 56  */
    unsigned int       f_type;       /* 60  */
    unsigned int       f_flags;      /* 64  */
    unsigned int       f_fssubtype;  /* 68  */
    char               f_fstypename[16];   /* 72   */
    char               f_mntonname[1024];  /* 88   */
    char               f_mntfromname[1024];/* 1112 */
    unsigned int       f_flags_ext;        /* 2136 */
    unsigned int       f_reserved[7];      /* 2140; total 2168 */
};
#elif defined(__linux__)
// glibc Linux layout (LP64: aarch64/x86_64), sizeof 120. The kernel fills
// this, so member order and widths are read by offset; f_fsid carries an
// __val[2] pair (unlike the macOS fsid_t whose member is .val).
struct statfs {
    long          f_type;    /* 0   */
    long          f_bsize;   /* 8   */
    unsigned long f_blocks;  /* 16  */
    unsigned long f_bfree;   /* 24  */
    unsigned long f_bavail;  /* 32  */
    unsigned long f_files;   /* 40  */
    unsigned long f_ffree;   /* 48  */
    struct { int __val[2]; } f_fsid;  /* 56  */
    long          f_namelen; /* 64  */
    long          f_frsize;  /* 72  */
    long          f_flags;   /* 80  */
    long          f_spare[4];/* 88; total 120 */
};
#else
// Windows and other non-POSIX targets have no statfs(2); the name is
// defined only so references resolve.
struct statfs {
    long f_type;
    long f_bsize;
    long f_blocks;
    long f_bfree;
    long f_bavail;
    long f_files;
    long f_ffree;
    long f_flags;
};
#endif

struct statvfs {
    int f_bsize;
    int f_frsize;
    int f_blocks;
    int f_bfree;
    int f_bavail;
    int f_files;
    int f_ffree;
    int f_favail;
    int f_fsid;
    int f_flag;
    int f_namemax;
    char f_pad[64];
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::statfs,  "_statfs")
#pragma binding(libc::fstatfs, "_fstatfs")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::statfs,  "statfs")
#pragma binding(libc::fstatfs, "fstatfs")
#endif

#ifndef _WIN32
int statfs(const char *path, struct statfs *buf);
int fstatfs(int fd, struct statfs *buf);
#endif

#ifdef _WIN32
// Windows CRT large-file stat. `struct _stati64` carries a 64-bit st_size;
// msvcrt exposes the ANSI (`_stati64`) and wide (`_wstati64`) forms.
struct _stati64 {
    unsigned int   st_dev;
    unsigned short st_ino;
    unsigned short st_mode;
    short          st_nlink;
    short          st_uid;
    short          st_gid;
    unsigned int   st_rdev;
    long long      st_size;
    long long      st_atime;
    long long      st_mtime;
    long long      st_ctime;
};
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_stati64,  "_stati64")
#pragma binding(msvcrt::_wstati64, "_wstati64")
#pragma binding(msvcrt::_fstati64, "_fstati64")
int _stati64(const char *path, struct _stati64 *buf);
int _wstati64(const unsigned short *path, struct _stati64 *buf);
int _fstati64(int fd, struct _stati64 *buf);
#endif
