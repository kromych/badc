// poll.h -- POSIX synchronous I/O multiplexing. The event/result
// flag values match macOS and Linux.

#pragma once

struct pollfd {
    int fd;
    short events;
    short revents;
};

typedef unsigned long nfds_t;

#define POLLIN  0x001
#define POLLPRI 0x002
#define POLLOUT 0x004
#define POLLERR 0x008
#define POLLHUP 0x010
#define POLLNVAL 0x020

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::poll, "_poll")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::poll, "poll")
#pragma binding(libc::ppoll, "ppoll")
#endif

#ifdef _WIN32
// Winsock exposes WSAPoll with the same shape; not bound here.
#endif

int poll(struct pollfd *fds, nfds_t nfds, int timeout);

#ifdef __linux__
// ppoll: poll with a nanosecond timeout and an optional signal mask (Linux).
// struct timespec comes from <time.h> at the call site; the mask is passed by
// address (sigset_t *, or NULL).
struct timespec;
int ppoll(struct pollfd *fds, nfds_t nfds, const struct timespec *tmo,
          const void *sigmask);
#endif
