// fcntl.h -- file control flags (subset) + the fcntl() syscall.
//
// `open()` itself is bound in <unistd.h>, where POSIX puts it;
// pulling fcntl in only when you need the flags keeps the binding
// sets terse. fcntl() lives here too so callers that want to flip
// O_NONBLOCK on a fd don't need to fish through dlsym.

#pragma once

#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR   2

// Common open(2) flags. Values mirror the macOS / Linux Posix
// numerics. Both kernels read these as bitmasks; the per-arch
// numerics happen to match closely enough for c5 to use a single
// set. Programs that need exotic flags should consult their
// platform's <fcntl.h>.
#ifdef __APPLE__
#define O_CREAT      0x0200
#define O_EXCL       0x0800
#define O_NOCTTY     0x20000
#define O_TRUNC      0x0400
#define O_APPEND     0x0008
#define O_NONBLOCK   0x0004
#define O_DIRECTORY  0x100000
#define O_CLOEXEC    0x1000000
#define O_NOFOLLOW   0x0100
#define O_ACCMODE    0x0003
#endif
#ifdef __linux__
// splice() flags.
#define SPLICE_F_MOVE     1
#define SPLICE_F_NONBLOCK 2
#define SPLICE_F_MORE     4
#define SPLICE_F_GIFT     8
#define O_CREAT      0100
#define O_EXCL       0200
#define O_NOCTTY     0400
#define O_TRUNC      01000
#define O_APPEND     02000
#define O_NONBLOCK   04000
#define O_ASYNC      020000
#define FASYNC       O_ASYNC
#define O_CLOEXEC    02000000
#define O_ACCMODE    0003
#define O_NOATIME    01000000
// O_DIRECT / O_DIRECTORY / O_NOFOLLOW use different bits per Linux
// architecture (the aarch64 uapi rearranges them relative to the
// asm-generic values x86-64 keeps). O_LARGEFILE is 0 on both 64-bit
// targets (large offsets are native).
#define O_LARGEFILE  0
#if defined(__aarch64__)
#define O_DIRECT     0200000
#define O_DIRECTORY  040000
#define O_NOFOLLOW   0100000
#else
#define O_DIRECT     040000
#define O_DIRECTORY  0200000
#define O_NOFOLLOW   0400000
#endif
// Synchronous I/O (asm-generic/fcntl.h): O_SYNC = __O_SYNC | O_DSYNC,
// with __O_SYNC = 04000000. __O_SYNC is never used on its own.
#define O_DSYNC      010000
#define O_SYNC       04010000
// memfd file sealing (linux/fcntl.h): F_ADD_SEALS / F_GET_SEALS apply and
// query the seal bitmask on a memfd_create() descriptor.
#define F_LINUX_SPECIFIC_BASE 1024
#define F_ADD_SEALS  (F_LINUX_SPECIFIC_BASE + 9)
#define F_GET_SEALS  (F_LINUX_SPECIFIC_BASE + 10)
#define F_SEAL_SEAL         0x0001
#define F_SEAL_SHRINK       0x0002
#define F_SEAL_GROW         0x0004
#define F_SEAL_WRITE        0x0008
#define F_SEAL_FUTURE_WRITE 0x0010
#endif
#ifdef _WIN32
#define O_CREAT      0x0100
#define O_EXCL       0x0400
#define O_NOCTTY     0
#define O_TRUNC      0x0200
#define O_APPEND     0x0008
#define O_NONBLOCK   0
#define O_DIRECTORY  0
#define O_CLOEXEC    0
#define O_NOFOLLOW   0
#define O_NOINHERIT  0x0080
// Windows CRT open() flags (ucrt corecrt_io.h), exposed under the
// underscore-less O_* names. _open/_sopen and the temporary, text and
// binary modes require these exact values.
#define O_RANDOM      0x0010
#define O_SEQUENTIAL  0x0020
#define O_TEMPORARY   0x0040
#define O_SHORT_LIVED 0x1000
#define O_OBTAIN_DIR  0x2000
#define O_TEXT        0x4000
#define O_BINARY      0x8000
#define O_RAW         O_BINARY
#define O_WTEXT       0x10000
#define O_U16TEXT     0x20000
#define O_U8TEXT      0x40000
#define _O_RDONLY     O_RDONLY
#define _O_WRONLY     O_WRONLY
#define _O_RDWR       O_RDWR
#define _O_APPEND     O_APPEND
#define _O_RANDOM     O_RANDOM
#define _O_SEQUENTIAL O_SEQUENTIAL
#define _O_TEMPORARY  O_TEMPORARY
#define _O_NOINHERIT  O_NOINHERIT
#define _O_CREAT      O_CREAT
#define _O_TRUNC      O_TRUNC
#define _O_EXCL       O_EXCL
#define _O_SHORT_LIVED O_SHORT_LIVED
#define _O_OBTAIN_DIR O_OBTAIN_DIR
#define _O_TEXT       O_TEXT
#define _O_BINARY     O_BINARY
#define _O_RAW        O_RAW
#define _O_WTEXT      O_WTEXT
#define _O_U16TEXT    O_U16TEXT
#define _O_U8TEXT     O_U8TEXT
#endif

// Most fcntl command numbers are stable across Linux and
// macOS Darwin. The advisory-lock trio (`F_GETLK` / `F_SETLK` /
// `F_SETLKW`) is the one that diverges:
//   * Linux:        F_GETLK=5,  F_SETLK=6,  F_SETLKW=7
//   * macOS Darwin: F_GETLK=7,  F_SETLK=8,  F_SETLKW=9
// sqlite's unix VFS calls `fcntl(fd, F_SETLK, &flock)` to grab
// shared/exclusive byte-range locks; using the Linux numbers on
// macOS lands on `F_GETPATH` etc., which fcntl rejects with EBADF
// and sqlite surfaces as "disk I/O error (10)" on every prepared
// statement.
#define F_GETFD  1
#define F_SETFD  2
#define F_GETFL  3
#define F_SETFL  4
#ifdef __APPLE__
#define F_GETLK  7
#define F_SETLK  8
#define F_SETLKW 9
#else
#define F_GETLK  5
#define F_SETLK  6
#define F_SETLKW 7
#endif
#define FD_CLOEXEC 1
#ifdef __APPLE__
// Darwin-only fcntl command: flush buffered data to permanent storage.
#define F_FULLFSYNC 51
#endif

// `F_RDLCK` / `F_WRLCK` / `F_UNLCK` are the lock-type values
// stored in `struct flock::l_type`. Their numeric values also
// differ across platforms:
//   * Linux:        F_RDLCK=0, F_WRLCK=1, F_UNLCK=2
//   * macOS Darwin: F_RDLCK=1, F_WRLCK=3, F_UNLCK=2
// (Darwin matches BSD; Linux follows historical SysV.)
#ifdef __APPLE__
#define F_RDLCK 1
#define F_WRLCK 3
#define F_UNLCK 2
#else
#define F_RDLCK 0
#define F_WRLCK 1
#define F_UNLCK 2
#endif

// `struct flock` is the F_GETLK/F_SETLK/F_SETLKW arg for
// `fcntl`. Per-platform layouts differ in *field order*, not
// just sizes:
//
//   macOS Darwin : off_t l_start, off_t l_len, pid_t l_pid,
//                  short l_type, short l_whence;
//                  -> l_type at offset 20.
//   Linux        : short l_type, short l_whence, off_t l_start,
//                  off_t l_len, pid_t l_pid;
//                  -> l_type at offset 0.
//
// Both layouts use real 16-bit `short` for l_type / l_whence;
// c5 supports `Ty::Short` natively (`Op::Lh` / `Op::Sh` 2-byte
// memory ops) so the struct shape now lines up with libc.
// Trailing __pad[] keeps the struct large enough that any extra
// trailing field libc writes can't overflow the caller's frame.
#ifdef __APPLE__
struct flock {
    long  l_start;     /* offset  0 */
    long  l_len;       /* offset  8 */
    int   l_pid;       /* offset 16 */
    short l_type;      /* offset 20 */
    short l_whence;    /* offset 22 */
    char  __pad[64];
};
#else
struct flock {
    short l_type;      /* offset  0 */
    short l_whence;    /* offset  2 */
    /* Linux inserts 4 bytes of padding so off_t l_start is 8-aligned. */
    int   __pad0;      /* offset  4 */
    long  l_start;     /* offset  8 */
    long  l_len;       /* offset 16 */
    int   l_pid;       /* offset 24 */
    char  __pad[64];
};
#endif

// Flags for the *at file-operation family (POSIX). The values reach the
// host libc, so each target uses its own numbering.
#ifdef __APPLE__
#define AT_FDCWD            (-2)
#define AT_EACCESS          0x0010
#define AT_SYMLINK_NOFOLLOW 0x0020
#define AT_SYMLINK_FOLLOW   0x0040
#define AT_REMOVEDIR        0x0080
#elif defined(__linux__)
#define AT_FDCWD            (-100)
#define AT_SYMLINK_NOFOLLOW 0x0100
#define AT_REMOVEDIR        0x0200
#define AT_EACCESS          0x0200
#define AT_SYMLINK_FOLLOW   0x0400
#define AT_EMPTY_PATH       0x1000
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fcntl, "_fcntl")
#pragma binding(libc::openat, "_openat")
int fcntl(int fd, int cmd, ...);
// Open relative to `dirfd` (or AT_FDCWD). The optional `mode` applies
// when O_CREAT is set (POSIX).
int openat(int dirfd, const char *path, int flags, ...);
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fcntl, "fcntl")
#pragma binding(libc::openat, "openat")
#pragma binding(libc::splice, "splice")
#pragma binding(libc::posix_fadvise, "posix_fadvise")
#pragma binding(libc::posix_fallocate, "posix_fallocate")
#pragma binding(libc::fallocate, "fallocate")
#pragma binding(libc::sync_file_range, "sync_file_range")
int fcntl(int fd, int cmd, ...);
int openat(int dirfd, const char *path, int flags, ...);
// Move data between two descriptors, one of which must be a pipe; the
// `off_*` parameters are in/out file offsets or null.
long splice(int fd_in, long *off_in, int fd_out, long *off_out,
            unsigned long len, unsigned int flags);
// Advise the kernel about a file region's expected access pattern, and
// reserve backing store for a region (POSIX). The advice values are shared
// by the LP64 targets (aarch64 / x86-64 do not renumber DONTNEED/NOREUSE).
#define POSIX_FADV_NORMAL     0
#define POSIX_FADV_RANDOM     1
#define POSIX_FADV_SEQUENTIAL 2
#define POSIX_FADV_WILLNEED   3
#define POSIX_FADV_DONTNEED   4
#define POSIX_FADV_NOREUSE    5
int posix_fadvise(int fd, long offset, long len, int advice);
int posix_fallocate(int fd, long offset, long len);
// Manipulate a file's allocated disk space (Linux); `mode` selects the
// FALLOC_FL_* operation from <linux/falloc.h>.
int fallocate(int fd, int mode, long offset, long len);
// Flush a file range to disk (Linux). The flag bits select the
// wait-before / write / wait-after phases.
#define SYNC_FILE_RANGE_WAIT_BEFORE 1
#define SYNC_FILE_RANGE_WRITE       2
#define SYNC_FILE_RANGE_WAIT_AFTER  4
int sync_file_range(int fd, long long offset, long long nbytes, unsigned int flags);
#endif
