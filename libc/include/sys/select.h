// sys/select.h -- select(2) multiplexer.
//
// Per-target binding for select(). On Windows the symbol lives in
// ws2_32.dll (alongside the rest of the socket surface); on POSIX
// it's plain libc.
//
// `fd_set` is a bitmap on POSIX (BSD layout: bit `fd` set in
// position `fd / 8`'s `1 << (fd & 7)`). c5 callers can either
// declare their own buffer (`char rfds[FD_SET_BYTES];`) or malloc
// `FD_SET_BYTES` and pass it through to select; the macros below
// flip / test bits without caring about the platform's actual
// `struct fd_set` layout, which varies (macOS uses `__int32_t`
// words, Linux uses `long int` words). Windows wraps an array of
// socket handles instead of a bitmap, so these macros are
// POSIX-only -- a Windows user would need a different shape.

#pragma once

#define FD_SETSIZE   1024
#define FD_SET_BYTES 128             // FD_SETSIZE / 8

// `fd_set` as a fixed 128-byte bitmap. Programs that declare an `fd_set`
// object and pass its address to select / the macros below get the right
// size; the internal word type is irrelevant since the macros address it as
// bytes.
typedef struct {
    unsigned char fds_bits[FD_SET_BYTES];
} fd_set;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::select, "_select")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::select, "select")
#endif

#ifdef _WIN32
#pragma dylib(ws2_32, "ws2_32.dll")
#pragma binding(ws2_32::select, "select")
#endif

int select(int nfds, char *rfds, char *wfds, char *efds, char *timeout);

// BSD-bitmap macros. `set` is `char *` / `unsigned char *`. The
// `do { ... } while (0)` wrapping makes the assignment forms
// behave like single statements inside `if` / `while` etc.
#define FD_ZERO(set) do { \
    unsigned char *__p = (unsigned char *)(set); \
    int __i = 0; \
    while (__i < FD_SET_BYTES) { __p[__i] = 0; __i = __i + 1; } \
} while (0)

#define FD_SET(fd, set) do { \
    unsigned char *__p = (unsigned char *)(set); \
    __p[(fd) / 8] = __p[(fd) / 8] | (1 << ((fd) & 7)); \
} while (0)

#define FD_CLR(fd, set) do { \
    unsigned char *__p = (unsigned char *)(set); \
    __p[(fd) / 8] = __p[(fd) / 8] & ~(1 << ((fd) & 7)); \
} while (0)

#define FD_ISSET(fd, set) \
    (((unsigned char *)(set))[(fd) / 8] & (1 << ((fd) & 7)))
