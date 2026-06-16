// Vectored I/O (POSIX.1). `struct iovec` plus readv / writev.

#pragma once

#include <stddef.h>
#include <sys/types.h>

struct iovec {
    void *iov_base;
    size_t iov_len;
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::readv,  "_readv")
#pragma binding(libc::writev, "_writev")
#pragma binding(libc::preadv, "_preadv")
#pragma binding(libc::pwritev,"_pwritev")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::readv,  "readv")
#pragma binding(libc::writev, "writev")
#pragma binding(libc::preadv, "preadv")
#pragma binding(libc::pwritev,"pwritev")
#endif

ssize_t readv(int fd, const struct iovec *iov, int iovcnt);
ssize_t writev(int fd, const struct iovec *iov, int iovcnt);
// Positioned vectored I/O (POSIX): like readv/writev at `offset`.
ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, long offset);
ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt, long offset);
