// sys/select.h -- synchronous I/O multiplexing (POSIX select / pselect),
// with the types and prototypes of glibc's and the macOS SDK's headers.

#pragma once

#include <time.h>

#define FD_SETSIZE   1024
#define FD_SET_BYTES 128             // FD_SETSIZE / 8

// `fd_set` as a fixed 128-byte bitmap, bit `fd` at byte `fd / 8`'s `1 << (fd
// & 7)` on these little-endian targets; the macros below address it as bytes.
// Linux declares it in `unsigned long` words (the kernel's __kernel_fd_set)
// and the macOS SDK in 32-bit words; each gives the record its word's alignment.
#ifdef __linux__
typedef struct {
    unsigned long fds_bits[FD_SETSIZE / (8 * sizeof(unsigned long))];
} fd_set;
#else
typedef struct {
    int fds_bits[FD_SETSIZE / (8 * sizeof(int))];
} fd_set;
#endif

// POSIX defines sigset_t here as <signal.h> does.
#ifndef __BADC_SIGSET_T
#define __BADC_SIGSET_T
#ifdef __APPLE__
typedef unsigned int sigset_t;
#else
typedef struct { unsigned long __val[1024 / (8 * sizeof(unsigned long))]; } sigset_t;
#endif
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::select,  "_select")
#pragma binding(libc::pselect, "_pselect")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::select,  "select")
#pragma binding(libc::pselect, "pselect")
#endif

int select(int nfds, fd_set *restrict readfds, fd_set *restrict writefds,
           fd_set *restrict errorfds, struct timeval *restrict timeout);
int pselect(int nfds, fd_set *restrict readfds, fd_set *restrict writefds,
            fd_set *restrict errorfds, const struct timespec *restrict timeout,
            const sigset_t *restrict sigmask);

// BSD-bitmap macros. `set` points at an `fd_set` or its bytes. The
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
