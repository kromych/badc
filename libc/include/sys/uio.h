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
#pragma binding(libc::preadv2, "preadv2")
#pragma binding(libc::pwritev2,"pwritev2")
#pragma binding(libc::process_vm_readv,  "process_vm_readv")
#pragma binding(libc::process_vm_writev, "process_vm_writev")
#endif

ssize_t readv(int fd, const struct iovec *iov, int iovcnt);
ssize_t writev(int fd, const struct iovec *iov, int iovcnt);
// Positioned vectored I/O (POSIX): like readv/writev at `offset`.
ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, long offset);
ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt, long offset);
#ifdef __linux__
// Positioned vectored I/O with a flags word (Linux).
ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt, long offset, int flags);
ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, long offset, int flags);
// Cross-address-space vectored I/O (Linux). The iovec counts and the
// flags word are `unsigned long` in glibc's declaration, not `int`.
ssize_t process_vm_readv(pid_t pid, const struct iovec *lvec,
                         unsigned long liovcnt, const struct iovec *rvec,
                         unsigned long riovcnt, unsigned long flags);
ssize_t process_vm_writev(pid_t pid, const struct iovec *lvec,
                          unsigned long liovcnt, const struct iovec *rvec,
                          unsigned long riovcnt, unsigned long flags);
#endif
