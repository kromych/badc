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

#define F_GETFD  1
#define F_SETFD  2
#define F_GETFL  3
#define F_SETFL  4
#define F_GETLK  5
#define F_SETLK  6
#define F_SETLKW 7
#define FD_CLOEXEC 1

#define F_RDLCK 0
#define F_WRLCK 1
#define F_UNLCK 2

// `struct flock` is the F_GETLK/F_SETLK/F_SETLKW arg for
// `fcntl`. Per-platform layouts differ:
//
//   macOS Darwin           : `off_t l_start, l_len; pid_t l_pid;
//                             short l_type, l_whence;` -> 24 bytes
//   Linux glibc / aarch64  : same layout, 32 bytes (8-byte aligned
//                             trailing field).
//
// c5 ints are 4 bytes so a 5-int declaration came out at 20 bytes
// and `fcntl(..., F_SETLK, &fl)` overran by 4-12 bytes -- enough
// to clobber the saved frame pointer / link register and SIGBUS
// the caller's epilogue. Reserve 64 bytes via a trailing
// `__pad[]` so every known layout fits without further header
// surgery.
struct flock {
    long l_start;
    long l_len;
    int l_pid;
    short l_type;
    short l_whence;
    char __pad[64];
};

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
