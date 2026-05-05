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

struct stat {
    int st_dev;
    int st_ino;
    int st_nlink;
    int st_mode;
    int st_uid;
    int st_gid;
    int st_rdev;
    int st_size;
    int st_blksize;
    int st_blocks;
    int st_atime;
    int st_atimensec;
    int st_mtime;
    int st_mtimensec;
    int st_ctime;
    int st_ctimensec;
    int __pad1;
    int __pad2;
};

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
struct statfs {
    int f_bsize;
    int f_iosize;
    int f_blocks;
    int f_bfree;
    int f_bavail;
    int f_files;
    int f_ffree;
    int f_fsid_a;
    int f_fsid_b;
    int f_owner;
    int f_type;
    int f_flags;
    int f_fssubtype;
    char f_fstypename[16];
    char f_mntonname[1024];
    char f_mntfromname[1024];
    int f_flags_ext;
    char f_reserved[32];
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
