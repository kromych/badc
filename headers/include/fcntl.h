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
#endif
#ifdef __linux__
#define O_CREAT      0100
#define O_EXCL       0200
#define O_NOCTTY     0400
#define O_TRUNC      01000
#define O_APPEND     02000
#define O_NONBLOCK   04000
#define O_DIRECTORY  0200000
#define O_CLOEXEC    02000000
#define O_NOFOLLOW   0400000
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
#endif

// Most fcntl command numbers are stable across Linux glibc and
// macOS Darwin. The advisory-lock trio (`F_GETLK` / `F_SETLK` /
// `F_SETLKW`) is the one that diverges:
//   * Linux glibc:  F_GETLK=5,  F_SETLK=6,  F_SETLKW=7
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

// `F_RDLCK` / `F_WRLCK` / `F_UNLCK` are the lock-type values
// stored in `struct flock::l_type`. Their numeric values also
// differ across platforms:
//   * Linux glibc:  F_RDLCK=0, F_WRLCK=1, F_UNLCK=2
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
//   Linux glibc  : short l_type, short l_whence, off_t l_start,
//                  off_t l_len, pid_t l_pid;
//                  -> l_type at offset 0.
//
// c5 has no native 16-bit short; we widen to int (4 bytes) but
// keep field offsets pixel-perfect so libc's fcntl reads the
// l_type byte at the spot it expects. Trailing __pad[] keeps the
// struct large enough that any extra trailing field libc writes
// can't overflow the caller's frame.
#ifdef __APPLE__
struct flock {
    long l_start;     /* offset  0 */
    long l_len;       /* offset  8 */
    int  l_pid;       /* offset 16 */
    int  l_type;      /* offset 20, low 16 bits = short l_type */
    int  l_whence;    /* offset 24, low 16 bits = short l_whence */
    char __pad[64];
};
#else
struct flock {
    int  l_type;      /* offset  0, low 16 bits */
    int  l_whence;    /* offset  4, low 16 bits */
    long l_start;     /* offset  8 */
    long l_len;       /* offset 16 */
    int  l_pid;       /* offset 24 */
    char __pad[64];
};
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fcntl, "_fcntl")
int fcntl(int fd, int cmd, ...);
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fcntl, "fcntl")
int fcntl(int fd, int cmd, int arg);
#endif
