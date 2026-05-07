// sys/stat.h -- file metadata: `struct stat` + the
// `S_IS<TYPE>(m)` mode-test macros + `S_I<RWX><USR/GRP/OTH>` mode
// bits.
//
// `struct stat` has different layouts on different libcs (BSD vs
// glibc vs Win32), but for c5's purposes we just need a struct
// large enough that `stat(path, &buf)` writes into a buffer
// without overrunning. Programs read individual fields by name;
// the offsets here mirror the macOS / glibc-x86_64 layout (which
// happen to align). Real-world cross-platform code that wants
// pixel-perfect parsing should call libc's `fstatat` and unpack
// manually.
#ifndef _C5_SYS_STAT_H
#define _C5_SYS_STAT_H

// `struct stat` is a write-target for libc's `stat`/`lstat`/
// `fstat` family. Field offsets differ wildly across platforms
// and are NOT just sizes -- libc fills bytes at specific
// offsets, so a c5 program reading `buf.st_size` only gets the
// right value if our declaration matches the actual on-platform
// layout byte-for-byte.
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
// Linux glibc's `struct stat` matches the same field names but
// uses smaller types for some IDs and skips birthtime; programs
// that only read `st_mode` / `st_size` / `st_mtime` see the same
// values either way because those fields land at compatible
// offsets. The padding here is wide enough for both layouts.
//
// Win32 msvcrt's `_stat64` is laid out differently again (FILE
// times instead of POSIX times); programs needing it should
// call the `_stat64` family directly.
//
// c5 has no `unsigned short`, so we declare 16-bit fields as
// `int` and split the dword they share into `__split_lo`/
// `__split_hi` halves where the layout requires it. Reading the
// individual halves needs explicit masking; user code mostly
// reads `st_mode`, `st_size`, and the `st_*time` slots, all of
// which land at the documented offsets.
// c5 doesn't have a `short` type with native 16-bit packing;
// `short` collapses onto `int` (4 bytes), so a `short st_mode;
// short st_nlink;` declaration shifts every later field 4
// bytes off. To keep the layout pixel-perfect we cover Apple's
// `mode_t st_mode; nlink_t st_nlink;` 4-byte gap with a single
// `int st_mode` -- reading `buf.st_mode` then yields a 32-bit
// word whose low 16 bits are `mode_t` (mode bits + file type)
// and high 16 bits are `nlink_t`. The `S_ISFOO(m)` macros and
// the standard `m & 0777` permission-bit access only look at
// the low 16 bits, which gives them the right values.
#ifdef __APPLE__
struct stat {
    int    st_dev;            /* offset  0, 4 bytes */
    int    st_mode;           /* offset  4, 4 bytes (mode | nlink) */
    long   st_ino;            /* offset  8, 8 bytes */
    int    st_uid;            /* offset 16, 4 bytes */
    int    st_gid;            /* offset 20, 4 bytes */
    int    st_rdev;           /* offset 24, 4 bytes */
    int    __pad28;           /* offset 28, 4 bytes */
    long   st_atime;          /* offset 32, 8 bytes (timespec.tv_sec)  */
    long   st_atimensec;      /* offset 40, 8 bytes (timespec.tv_nsec) */
    long   st_mtime;          /* offset 48 */
    long   st_mtimensec;      /* offset 56 */
    long   st_ctime;          /* offset 64 */
    long   st_ctimensec;      /* offset 72 */
    long   st_birthtime;      /* offset 80 */
    long   st_birthtimensec;  /* offset 88 */
    long   st_size;           /* offset 96, 8 bytes */
    long   st_blocks;         /* offset 104, 8 bytes */
    int    st_blksize;        /* offset 112, 4 bytes */
    int    st_flags;          /* offset 116, 4 bytes */
    int    st_gen;            /* offset 120, 4 bytes */
    int    st_lspare;         /* offset 124, 4 bytes */
    long   st_qspare0;        /* offset 128, 8 bytes */
    long   st_qspare1;        /* offset 136, 8 bytes */
    /* `st_nlink` proper is darwin's bytes 6-7, packed into the
    ** 4-byte word that c5 names `st_mode` above. sqlite only
    ** reads it inside `verifyDbFile` (warns if 0 or > 1, returns
    ** void) -- so a separate slot in the trailing pad gives the
    ** field name something to compile against without disturbing
    ** the on-the-wire layout. The value read here is whatever
    ** `osFstat` left in the trailing region (typically 0 for a
    ** freshly zero'd buffer); the resulting "file unlinked while
    ** open" warning is silent unless the caller has wired up
    ** `sqlite3_log`. */
    int    st_nlink;          /* offset 144, off-layout placeholder */
    char   __pad[124];        /* room for any future / Linux-larger layout */
};
#elif defined(__linux__) && defined(__x86_64__)
// Linux glibc x86_64 layout. See bits/struct_stat.h:
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
    long st_atime;           /* offset  72, timespec.tv_sec */
    long st_atimensec;       /* offset  80 */
    long st_mtime;           /* offset  88 */
    long st_mtimensec;       /* offset  96 */
    long st_ctime;           /* offset 104 */
    long st_ctimensec;       /* offset 112 */
    long __unused0;          /* offset 120 */
    long __unused1;          /* offset 128 */
    long __unused2;          /* offset 136 */
    char __pad[64];
};
#elif defined(__linux__) && defined(__aarch64__)
// Linux glibc aarch64 layout. mode/nlink/uid/gid all 4 bytes
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
    long st_atime;           /* offset  72 */
    long st_atimensec;       /* offset  80 */
    long st_mtime;           /* offset  88 */
    long st_mtimensec;       /* offset  96 */
    long st_ctime;           /* offset 104 */
    long st_ctimensec;       /* offset 112 */
    int  __unused0;          /* offset 120 */
    int  __unused1;          /* offset 124 */
    char __pad[64];
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
    long st_atime;
    long st_atimensec;
    long st_mtime;
    long st_mtimensec;
    long st_ctime;
    long st_ctimensec;
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

// statfs / statvfs -- filesystem-level metadata. The real layout
// differs across platforms; this opaque buffer is wide enough for
// every common shape so libc can write into it. SQLite reads
// f_bsize after a statfs to size scratch buffers; the offset of
// f_bsize varies, so we expose typedefs that cover the union of
// known layouts.
// `struct statfs` is the libc filesystem-info shape that
// `statfs(2)` / `fstatfs(2)` write into. Field layouts vary
// across libc flavors but in practice all add up to ~4 KiB
// (path components dominate). Our buffer reserves 4096
// bytes via a trailing `__pad[]` so every known platform
// fits without further header surgery -- the overflow class
// would otherwise stomp the saved frame pointer of the
// caller (see fixtures/c/libc_struct_buf_size.c).
struct statfs {
    long f_bsize;
    long f_iosize;
    long f_blocks;
    long f_bfree;
    long f_bavail;
    long f_files;
    long f_ffree;
    long f_fsid_a;
    long f_fsid_b;
    long f_owner;
    long f_type;
    long f_flags;
    long f_fssubtype;
    char f_fstypename[16];
    char f_mntonname[1024];
    char f_mntfromname[1024];
    long f_flags_ext;
    char __pad[2048];
};

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

int statfs(char *path, struct statfs *buf);
int fstatfs(int fd, struct statfs *buf);

#endif
