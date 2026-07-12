#pragma once

// sys/epoll.h -- scalable I/O event notification (Linux).

#include <stdint.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::epoll_create,  "epoll_create")
#pragma binding(libc::epoll_create1, "epoll_create1")
#pragma binding(libc::epoll_ctl,     "epoll_ctl")
#pragma binding(libc::epoll_wait,    "epoll_wait")
#endif

// epoll_create1 flag.
#define EPOLL_CLOEXEC 02000000

// epoll_ctl opcodes.
#define EPOLL_CTL_ADD 1
#define EPOLL_CTL_DEL 2
#define EPOLL_CTL_MOD 3

// Event bits for epoll_event.events.
#define EPOLLIN        0x001
#define EPOLLPRI       0x002
#define EPOLLOUT       0x004
#define EPOLLERR       0x008
#define EPOLLHUP       0x010
#define EPOLLRDNORM    0x040
#define EPOLLRDBAND    0x080
#define EPOLLWRNORM    0x100
#define EPOLLWRBAND    0x200
#define EPOLLMSG       0x400
#define EPOLLRDHUP     0x2000
#define EPOLLEXCLUSIVE (1u << 28)
#define EPOLLWAKEUP    (1u << 29)
#define EPOLLONESHOT   (1u << 30)
#define EPOLLET        (1u << 31)

typedef union epoll_data {
    void    *ptr;
    int      fd;
    uint32_t u32;
    uint64_t u64;
} epoll_data_t;

// Naturally aligned on aarch64; x86 packs it to match the 32-bit layout.
struct epoll_event {
    uint32_t     events;
    epoll_data_t data;
};

int epoll_create(int size);
int epoll_create1(int flags);
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
