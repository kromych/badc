// errno.h -- access to the per-thread errno value.
//
// On every modern target `errno` is actually a TLS reference: the
// real symbol is a function that returns a pointer to the thread's
// errno slot. The c5 surface exposes `errno_location()` which
// returns a `int *`; the user dereferences it as `*errno_location()`
// to read or write. The `errno` macro below resolves to that pattern,
// so portable C code that writes `if (errno == EINVAL) ...` works.

#pragma once

#define errno (*errno_location())

// Common error numbers. Linux / macOS / Windows differ on a few
// values, but the names below are universal. We expose the most
// portable shape -- programs that branch on specific values
// should ifdef per platform anyway.
#define EPERM   1
#define ENOENT  2
#define EINTR   4
#define EIO     5
#define EBADF   9
#define EAGAIN  11
#define ENOMEM  12
#define EACCES  13
#define EFAULT  14
#define EBUSY   16
#define EEXIST  17
#define ENODEV  19
#define ENOTDIR 20
#define EISDIR  21
#define EINVAL  22
#define ENFILE  23
#define EMFILE  24
#define ENOSPC  28
#define ESPIPE  29
#define EROFS   30
#define EPIPE   32
#define EDOM    33
#define ERANGE  34
#define ECHILD  10
#define ESRCH   3
#define ENXIO   6
#define E2BIG   7
#define ENOEXEC 8
#define EMLINK  31
#define EFBIG   27
#define ENOTBLK 15
#define EXDEV   18
#define ETXTBSY 26
#define ENAMETOOLONG 36
#define ENOLCK  37
#define ENOSYS  38
#define ENOTEMPTY 39
#define ELOOP   40
#define EOVERFLOW 75
#define EOPNOTSUPP 95
#define ENOTSUP    95
#define ETIMEDOUT 110
#define ECONNRESET 104
#define ECONNREFUSED 111
#define ENOTCONN 107
#define EINPROGRESS 115
#define EHOSTUNREACH 113
#define ENOBUFS 105
#define EADDRINUSE 98
#define ENETUNREACH 101
#define EWOULDBLOCK EAGAIN

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::errno_location, "___error")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::errno_location, "__errno_location")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::errno_location, "_errno")
#endif

int *errno_location();
