// epoll_wait fills an array of the kernel's records, packed on x86-64. Two
// ready pipes carry distinct 64-bit cookies; both must read back from the
// array, which a record laid out off the kernel's layout fails for the
// second element.

#include <stdint.h>
#include <unistd.h>

#ifdef __linux__
#include <sys/epoll.h>

static int check(void) {
    int a[2], b[2];
    if (pipe(a) != 0 || pipe(b) != 0) {
        return 1;
    }
    int ep = epoll_create1(EPOLL_CLOEXEC);
    if (ep < 0) {
        return 2;
    }
    uint64_t ka = 0x1122334455667788ull;
    uint64_t kb = 0x8877665544332211ull;
    struct epoll_event ev;
    ev.events = EPOLLIN;
    ev.data.u64 = ka;
    if (epoll_ctl(ep, EPOLL_CTL_ADD, a[0], &ev) != 0) {
        return 3;
    }
    ev.data.u64 = kb;
    if (epoll_ctl(ep, EPOLL_CTL_ADD, b[0], &ev) != 0) {
        return 4;
    }
    if (write(a[1], "a", 1) != 1 || write(b[1], "b", 1) != 1) {
        return 5;
    }
    struct epoll_event out[2];
    if (epoll_wait(ep, out, 2, 1000) != 2) {
        return 6;
    }
    int seen = 0;
    for (int i = 0; i < 2; i++) {
        if (out[i].events != EPOLLIN) {
            return 7;
        }
        if (out[i].data.u64 == ka) {
            seen |= 1;
        } else if (out[i].data.u64 == kb) {
            seen |= 2;
        } else {
            return 8;
        }
    }
    close(ep);
    close(a[0]);
    close(a[1]);
    close(b[0]);
    close(b[1]);
    return seen == 3 ? 0 : 9;
}
#endif

int main(void) {
#ifdef __linux__
    return check();
#else
    return 0;
#endif
}
