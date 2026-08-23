// <unistd.h> entry points with no export outside the Linux C library:
// `copy_file_range`. libSystem's `fcopyfile` and Windows' `CopyFileEx`
// are neither descriptor-and-offset shaped nor partial-copy shaped, so
// what carries over is glibc's own fallback for a kernel that does not
// implement the call: a read/write loop over a bounce buffer advancing
// the offsets the way the system call does. The file is gated to the
// targets with no system call behind the name and compiles to nothing
// on Linux. The native-link driver offers it like an archive member,
// so an image that does not call it carries none of it.
//
// A cross-device copy is copied rather than refused with EXDEV: glibc's
// fallback copies, and current kernels copy across file systems too, so
// EXDEV would be a behaviour only this emulation has.

#ifndef __linux__

#include <errno.h>
#include <stdio.h>
#include <unistd.h>

#define CFR_CHUNK 65536

#ifdef _WIN32

// msvcrt has no positional read/write, and `_lseek` is 32-bit, so the
// primitives seek with the 64-bit entry point and restore the position
// the caller had. `<stdio.h>` binds and declares `_lseeki64`.
static long cfr_tell(int fd) { return (long)_lseeki64(fd, 0, SEEK_CUR); }

static long cfr_seek(int fd, long off) {
    return (long)_lseeki64(fd, off, SEEK_SET);
}

static long cfr_pread(int fd, char *buf, unsigned long n, long off) {
    long save = cfr_tell(fd);
    long got;
    if (save < 0 || cfr_seek(fd, off) < 0) {
        return -1;
    }
    got = (long)read(fd, buf, (int)n);
    cfr_seek(fd, save);
    return got;
}

static long cfr_pwrite(int fd, char *buf, unsigned long n, long off) {
    long save = cfr_tell(fd);
    long put;
    if (save < 0 || cfr_seek(fd, off) < 0) {
        return -1;
    }
    put = (long)write(fd, buf, (int)n);
    cfr_seek(fd, save);
    return put;
}

#else

static long cfr_tell(int fd) { return lseek(fd, 0, SEEK_CUR); }

static long cfr_seek(int fd, long off) { return lseek(fd, off, SEEK_SET); }

static long cfr_pread(int fd, char *buf, unsigned long n, long off) {
    return pread(fd, buf, n, off);
}

static long cfr_pwrite(int fd, char *buf, unsigned long n, long off) {
    return pwrite(fd, buf, n, off);
}

#endif

long copy_file_range(int fd_in, long *off_in, int fd_out, long *off_out,
                     unsigned long len, unsigned int flags) {
    char buf[CFR_CHUNK];
    unsigned long done = 0;
    long in_pos;
    long out_pos;

    // The system call reserves `flags` for future use and rejects any
    // nonzero value.
    if (flags != 0) {
        errno = EINVAL;
        return -1;
    }
    in_pos = off_in ? *off_in : cfr_tell(fd_in);
    out_pos = off_out ? *off_out : cfr_tell(fd_out);
    if (in_pos < 0 || out_pos < 0) {
        return -1;
    }

    while (done < len) {
        unsigned long want = len - done;
        long got;
        long at = 0;
        if (want > CFR_CHUNK) {
            want = CFR_CHUNK;
        }
        got = cfr_pread(fd_in, buf, want, in_pos);
        if (got <= 0) {
            // End of input, or a failure after a partial copy: the
            // count already copied is the result either way.
            if (got < 0 && done == 0) {
                return -1;
            }
            break;
        }
        while (at < got) {
            long put = cfr_pwrite(fd_out, buf + at, (unsigned long)(got - at),
                                  out_pos + at);
            if (put <= 0) {
                break;
            }
            at += put;
        }
        in_pos += at;
        out_pos += at;
        done += (unsigned long)at;
        if (at < got) {
            if (done == 0) {
                return -1;
            }
            break;
        }
    }

    // A null offset argument names the descriptor's own position, which
    // the copy advances; a non-null one leaves the position alone.
    if (off_in) {
        *off_in = in_pos;
    } else if (cfr_seek(fd_in, in_pos) < 0) {
        return -1;
    }
    if (off_out) {
        *off_out = out_pos;
    } else if (cfr_seek(fd_out, out_pos) < 0) {
        return -1;
    }
    return (long)done;
}

#endif
