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

// Error numbers. The low set (1-34, excluding the EAGAIN / EDEADLK
// swap) matches Linux and macOS; everything else diverges by target.
// Programs gate behavior on `#ifdef E<name>` and compare `errno`
// against these values, so the value must match the host -- a wrong or
// missing number makes such a comparison silently fail.
#define EPERM   1
#define ENOENT  2
#define ESRCH   3
#define EINTR   4
#define EIO     5
#define ENXIO   6
#define E2BIG   7
#define ENOEXEC 8
#define EBADF   9
#define ECHILD  10
#define ENOMEM  12
#define EACCES  13
#define EFAULT  14
#define ENOTBLK 15
#define EBUSY   16
#define EEXIST  17
#define EXDEV   18
#define ENODEV  19
#define ENOTDIR 20
#define EISDIR  21
#define EINVAL  22
#define ENFILE  23
#define EMFILE  24
#define ENOTTY  25
#define ETXTBSY 26
#define EFBIG   27
#define ENOSPC  28
#define ESPIPE  29
#define EROFS   30
#define EMLINK  31
#define EPIPE   32
#define EDOM    33
#define ERANGE  34

// Numbers that diverge between targets. macOS uses the BSD numbering;
// Linux values also serve as the Windows fallback (msvcrt programs reach
// for socket errors through WSAGetLastError rather than errno).
#ifdef __APPLE__
#define EDEADLK         11
#define EAGAIN          35
#define EINPROGRESS     36
#define EALREADY        37
#define ENOTSOCK        38
#define EDESTADDRREQ    39
#define EMSGSIZE        40
#define EPROTOTYPE      41
#define ENOPROTOOPT     42
#define EPROTONOSUPPORT 43
#define EAFNOSUPPORT    47
#define EADDRINUSE      48
#define EADDRNOTAVAIL   49
#define ENETDOWN        50
#define ENETUNREACH     51
#define ENETRESET       52
#define ECONNABORTED    53
#define ECONNRESET      54
#define ENOBUFS         55
#define EISCONN         56
#define ENOTCONN        57
#define ESHUTDOWN       58
#define ETOOMANYREFS    59
#define ETIMEDOUT       60
#define ECONNREFUSED    61
#define ELOOP           62
#define ENAMETOOLONG    63
#define EHOSTDOWN       64
#define EHOSTUNREACH    65
#define ENOTEMPTY       66
#define EUSERS          68
#define EDQUOT          69
#define ESTALE          70
#define ENOLCK          77
#define ENOSYS          78
#define EOVERFLOW       84
#define EOPNOTSUPP      102
#else
#define EAGAIN          11
#define EDEADLK         35
#define ENAMETOOLONG    36
#define ENOLCK          37
#define ENOSYS          38
#define ENOTEMPTY       39
#define ELOOP           40
#define EOVERFLOW       75
#define EUSERS          87
#define ENOTSOCK        88
#define EDESTADDRREQ    89
#define EMSGSIZE        90
#define EPROTOTYPE      91
#define ENOPROTOOPT     92
#define EPROTONOSUPPORT 93
#define EOPNOTSUPP      95
#define EAFNOSUPPORT    97
#define EADDRINUSE      98
#define EADDRNOTAVAIL   99
#define ENETDOWN        100
#define ENETUNREACH     101
#define ENETRESET       102
#define ECONNABORTED    103
#define ECONNRESET      104
#define ENOBUFS         105
#define EISCONN         106
#define ENOTCONN        107
#define ESHUTDOWN       108
#define ETOOMANYREFS    109
#define ETIMEDOUT       110
#define ECONNREFUSED    111
#define EHOSTDOWN       112
#define EHOSTUNREACH    113
#define EALREADY        114
#define EINPROGRESS     115
#define ESTALE          116
#define EDQUOT          122
#endif

#define ENOTSUP     EOPNOTSUPP
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
