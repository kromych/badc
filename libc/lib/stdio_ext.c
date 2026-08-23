// <stdio.h> entry points msvcrt does not export: POSIX.1-2008
// delimited line input (`getline` / `getdelim`, 7.21.5.1-2) and
// descriptor-formatted output (`dprintf` / `vdprintf`, 7.21.6.3).
// libSystem and the Linux C library export all four, so the file is
// gated to Windows and compiles to nothing elsewhere. The native-link
// driver offers it like an archive member, so an image that calls none
// of these carries none of it.

#ifdef _WIN32

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// The capacity a null `*lineptr` starts at, matching glibc's.
#define SE_LINE_INIT 120
// Stack buffer `dprintf` formats into before falling back to the heap.
#define SE_FMT_STACK 256

// The delimiter is kept in the result and the result is NUL-terminated,
// but an embedded NUL does not end the line, so the return value rather
// than `strlen` is the length. End of input with nothing read returns
// -1 and leaves the buffer alone.
long getdelim(char **lineptr, size_t *n, int delim, FILE *stream) {
    char *buf;
    size_t cap;
    size_t len = 0;
    int c;

    if (lineptr == 0 || n == 0 || stream == 0) {
        errno = EINVAL;
        return -1;
    }
    buf = *lineptr;
    cap = *n;
    if (buf == 0 || cap == 0) {
        cap = SE_LINE_INIT;
        buf = (char *)malloc(cap);
        if (buf == 0) {
            errno = ENOMEM;
            return -1;
        }
        *lineptr = buf;
        *n = cap;
    }

    for (;;) {
        c = fgetc(stream);
        if (c == EOF) {
            break;
        }
        // One byte plus the terminator the loop always writes.
        if (len + 2 > cap) {
            size_t want = cap * 2;
            char *grown;
            if (want < len + 2) {
                want = len + 2;
            }
            grown = (char *)realloc(buf, want);
            if (grown == 0) {
                errno = ENOMEM;
                return -1;
            }
            buf = grown;
            cap = want;
            *lineptr = buf;
            *n = cap;
        }
        buf[len] = (char)c;
        len++;
        if (c == (int)(unsigned char)delim) {
            break;
        }
    }

    if (len == 0) {
        return -1;
    }
    buf[len] = 0;
    return (long)len;
}

long getline(char **lineptr, size_t *n, FILE *stream) {
    return getdelim(lineptr, n, '\n', stream);
}

// A short write is not an error: retry from where it stopped.
static int se_write_all(int fd, char *buf, int len) {
    int done = 0;
    while (done < len) {
        int wrote = write(fd, buf + done, len - done);
        if (wrote <= 0) {
            return -1;
        }
        done += wrote;
    }
    return len;
}

// `vsnprintf` is the C99 definition in `libc/lib/runtime.c`; msvcrt's
// own `_vsnprintf` reports truncation as -1 rather than as the length
// the output would have had. Windows `va_list` is a by-value cursor,
// so the second pass restarts from the same argument.
int vdprintf(int fd, const char *fmt, __builtin_va_list ap) {
    char stack[SE_FMT_STACK];
    char *heap;
    int len = vsnprintf(stack, (int)sizeof stack, (char *)fmt, ap);
    int rc;
    if (len < 0) {
        return len;
    }
    if (len < (int)sizeof stack) {
        return se_write_all(fd, stack, len);
    }
    heap = (char *)malloc((size_t)len + 1);
    if (heap == 0) {
        errno = ENOMEM;
        return -1;
    }
    vsnprintf(heap, len + 1, (char *)fmt, ap);
    rc = se_write_all(fd, heap, len);
    free(heap);
    return rc;
}

int dprintf(int fd, const char *fmt, ...) {
    __builtin_va_list ap;
    int rc;
    __builtin_va_start(ap, fmt);
    rc = vdprintf(fd, fmt, ap);
    __builtin_va_end(ap);
    return rc;
}

#endif
