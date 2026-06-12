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
#endif

#ifdef _WIN32
// Winsock exposes WSAPoll with the same shape; not bound here.
#endif

int poll(struct pollfd *fds, nfds_t nfds, int timeout);
