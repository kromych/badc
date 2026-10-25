// POSIX asynchronous I/O (<aio.h>) with the C library's control block: an
// aio_write and an aio_read at offsets complete under aio_suspend with
// aio_error 0 and aio_return the byte count, lio_listio runs a read and a
// LIO_NOP to completion under LIO_WAIT, aio_fsync completes, and
// aio_cancel of a descriptor with nothing outstanding reports AIO_ALLDONE.
// snapshot-budget: exempt
#include <aio.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#if defined(__APPLE__)
#define WANT_AIOCB 80
#define WANT_SIGEVENT 32
#else
#define WANT_AIOCB 168
#define WANT_SIGEVENT 64
#endif

static int finish(struct aiocb *cb, ssize_t want) {
    const struct aiocb *list[1];
    struct timespec limit = {5, 0};
    int e;

    list[0] = cb;
    while ((e = aio_error(cb)) == EINPROGRESS)
        if (aio_suspend(list, 1, &limit) != 0 && errno != EINTR) return 1;
    return e != 0 || aio_return(cb) != want;
}

int main(void) {
    char path[] = "/tmp/badc-aio-XXXXXX";
    char back[8], tail[4];
    struct aiocb w, r, t, nop;
    struct aiocb *list[2];
    int fd = mkstemp(path);

    if (sizeof(struct aiocb) != WANT_AIOCB || sizeof(struct sigevent) != WANT_SIGEVENT) return 1;
    if (fd < 0) return 2;
    unlink(path);
    memset(&w, 0, sizeof w);
    w.aio_fildes = fd;
    w.aio_buf = "asyncio!tail";
    w.aio_nbytes = 12;
    w.aio_offset = 0;
    w.aio_sigevent.sigev_notify = SIGEV_NONE;
    if (aio_write(&w) != 0) return 3;
    if (finish(&w, 12)) return 4;
    memset(&r, 0, sizeof r);
    r.aio_fildes = fd;
    r.aio_buf = back;
    r.aio_nbytes = sizeof back;
    r.aio_offset = 0;
    if (aio_read(&r) != 0) return 5;
    if (finish(&r, 8) || memcmp(back, "asyncio!", 8) != 0) return 6;
    memset(&t, 0, sizeof t);
    t.aio_fildes = fd;
    t.aio_buf = tail;
    t.aio_nbytes = sizeof tail;
    t.aio_offset = 8;
    t.aio_lio_opcode = LIO_READ;
    memset(&nop, 0, sizeof nop);
    nop.aio_fildes = fd;
    nop.aio_lio_opcode = LIO_NOP;
    list[0] = &t;
    list[1] = &nop;
    if (lio_listio(LIO_WAIT, list, 2, 0) != 0) return 7;
    if (aio_error(&t) != 0 || aio_return(&t) != 4 || memcmp(tail, "tail", 4) != 0) return 8;
    if (aio_fsync(O_SYNC, &w) != 0) return 9;
    if (finish(&w, 0)) return 10;
    if (aio_cancel(fd, 0) != AIO_ALLDONE) return 11;
    // macOS keeps a LIO_NOP entry, counted against the process's aio limit,
    // until it is returned (the JIT runs fixtures in one process). It is
    // returned after the cancel: with no entry left on the descriptor, macOS's
    // aio_cancel reports EBADF while another process has aio work queued.
    aio_return(&nop);
    close(fd);
    return 0;
}
