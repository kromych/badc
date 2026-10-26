// aio.h -- POSIX asynchronous input and output, bound to the C library:
// glibc's calls in libc.so.6 and libSystem's. <signal.h> supplies struct
// sigevent and <time.h> struct timespec.

#pragma once

#include <sys/types.h>
#include <signal.h>
#include <time.h>

#ifdef __linux__
// glibc's 168-byte control block, with the library's queueing state
// between aio_sigevent and aio_offset.
struct aiocb {
    int aio_fildes;
    int aio_lio_opcode;
    int aio_reqprio;
    volatile void *aio_buf;
    size_t aio_nbytes;
    struct sigevent aio_sigevent;
    struct aiocb *__next_prio;
    int __abs_prio;
    int __policy;
    int __error_code;
    ssize_t __return_value;
    off_t aio_offset;
    char __glibc_reserved[32];
};

enum { AIO_CANCELED, AIO_NOTCANCELED, AIO_ALLDONE };
#define AIO_CANCELED AIO_CANCELED
#define AIO_NOTCANCELED AIO_NOTCANCELED
#define AIO_ALLDONE AIO_ALLDONE
enum { LIO_READ, LIO_WRITE, LIO_NOP };
#define LIO_READ LIO_READ
#define LIO_WRITE LIO_WRITE
#define LIO_NOP LIO_NOP
enum { LIO_WAIT, LIO_NOWAIT };
#define LIO_WAIT LIO_WAIT
#define LIO_NOWAIT LIO_NOWAIT

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::aio_read, "aio_read")
#pragma binding(libc::aio_write, "aio_write")
#pragma binding(libc::lio_listio, "lio_listio")
#pragma binding(libc::aio_error, "aio_error")
#pragma binding(libc::aio_return, "aio_return")
#pragma binding(libc::aio_cancel, "aio_cancel")
#pragma binding(libc::aio_suspend, "aio_suspend")
#pragma binding(libc::aio_fsync, "aio_fsync")
#pragma binding(libc::aio_init, "aio_init")
#pragma binding(libc::aio_read64, "aio_read64")
#pragma binding(libc::aio_write64, "aio_write64")
#pragma binding(libc::lio_listio64, "lio_listio64")
#pragma binding(libc::aio_error64, "aio_error64")
#pragma binding(libc::aio_return64, "aio_return64")
#pragma binding(libc::aio_cancel64, "aio_cancel64")
#pragma binding(libc::aio_suspend64, "aio_suspend64")
#pragma binding(libc::aio_fsync64, "aio_fsync64")

#ifdef _GNU_SOURCE
// Tuning for glibc's thread pool (a GNU extension).
struct aioinit {
    int aio_threads;
    int aio_num;
    int aio_locks;
    int aio_usedba;
    int aio_debug;
    int aio_numusers;
    int aio_idle_time;
    int aio_reserved;
};
void aio_init(const struct aioinit *init);
#endif

#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
// The large-file names glibc declares; with a 64-bit off_t each is the
// same call as its unsuffixed form.
struct aiocb64 {
    int aio_fildes;
    int aio_lio_opcode;
    int aio_reqprio;
    volatile void *aio_buf;
    size_t aio_nbytes;
    struct sigevent aio_sigevent;
    struct aiocb *__next_prio;
    int __abs_prio;
    int __policy;
    int __error_code;
    ssize_t __return_value;
    off_t aio_offset;
    char __glibc_reserved[32];
};
int aio_read64(struct aiocb64 *aiocbp);
int aio_write64(struct aiocb64 *aiocbp);
int lio_listio64(int mode, struct aiocb64 *const list[restrict], int nent,
                 struct sigevent *restrict sig);
int aio_error64(const struct aiocb64 *aiocbp);
ssize_t aio_return64(struct aiocb64 *aiocbp);
int aio_cancel64(int fildes, struct aiocb64 *aiocbp);
int aio_suspend64(const struct aiocb64 *const list[], int nent,
                  const struct timespec *restrict timeout);
int aio_fsync64(int op, struct aiocb64 *aiocbp);
#endif
#elif defined(__APPLE__)
#include <fcntl.h>

// The SDK's 80-byte control block.
struct aiocb {
    int aio_fildes;
    off_t aio_offset;
    volatile void *aio_buf;
    size_t aio_nbytes;
    int aio_reqprio;
    struct sigevent aio_sigevent;
    int aio_lio_opcode;
};

#define AIO_ALLDONE     0x1
#define AIO_CANCELED    0x2
#define AIO_NOTCANCELED 0x4
#define LIO_NOP         0x0
#define LIO_READ        0x1
#define LIO_WRITE       0x2
#define LIO_NOWAIT      0x1
#define LIO_WAIT        0x2
// The value of the SDKs before macOS 27. The macOS 27 SDK's 32, and the
// aio_readv and aio_writev it adds, which libSystem exports only from 27,
// are left out for images that load on macOS 11.
#define AIO_LISTIO_MAX  16

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::aio_read, "_aio_read")
#pragma binding(libc::aio_write, "_aio_write")
#pragma binding(libc::lio_listio, "_lio_listio")
#pragma binding(libc::aio_error, "_aio_error")
#pragma binding(libc::aio_return, "_aio_return")
#pragma binding(libc::aio_cancel, "_aio_cancel")
#pragma binding(libc::aio_suspend, "_aio_suspend")
#pragma binding(libc::aio_fsync, "_aio_fsync")
#endif

#if defined(__linux__) || defined(__APPLE__)
int aio_read(struct aiocb *aiocbp);
int aio_write(struct aiocb *aiocbp);
int lio_listio(int mode, struct aiocb *const list[restrict], int nent,
               struct sigevent *restrict sig);
int aio_error(const struct aiocb *aiocbp);
ssize_t aio_return(struct aiocb *aiocbp);
int aio_cancel(int fildes, struct aiocb *aiocbp);
int aio_suspend(const struct aiocb *const list[], int nent,
                const struct timespec *restrict timeout);
int aio_fsync(int op, struct aiocb *aiocbp);
#endif
