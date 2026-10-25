// POSIX.1-2008 <sys/select.h> select and pselect take fd_set, struct
// timeval, struct timespec and sigset_t pointers, and <sys/resource.h>
// getrusage a struct rusage pointer (as do the BSD wait3 / wait4 of
// <sys/wait.h>): each is taken as a pointer to its POSIX type and called on
// a pipe holding a byte and on the calling process.

#include <signal.h>
#include <stddef.h>
#include <sys/resource.h>
#include <sys/select.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
    int (*sel)(int, fd_set *restrict, fd_set *restrict, fd_set *restrict,
               struct timeval *restrict) = select;
    int (*psel)(int, fd_set *restrict, fd_set *restrict, fd_set *restrict,
                const struct timespec *restrict, const sigset_t *restrict) = pselect;
    int (*usage)(int, struct rusage *) = getrusage;
    pid_t (*w3)(int *, int, struct rusage *) = wait3;
    pid_t (*w4)(pid_t, int *, int, struct rusage *) = wait4;
    struct timeval tv = {0, 0};
    struct timespec ts = {0, 0};
    struct rusage ru;
    sigset_t mask;
    fd_set r;
    int fds[2];
    if (pipe(fds) != 0 || write(fds[1], "x", 1) != 1)
        return 1;
    FD_ZERO(&r);
    FD_SET(fds[0], &r);
    if (sel(fds[0] + 1, &r, NULL, NULL, &tv) != 1 || !FD_ISSET(fds[0], &r))
        return 2;
    sigemptyset(&mask);
    FD_ZERO(&r);
    FD_SET(fds[0], &r);
    if (psel(fds[0] + 1, &r, NULL, NULL, &ts, &mask) != 1 || !FD_ISSET(fds[0], &r))
        return 3;
    if (usage(RUSAGE_SELF, &ru) != 0 || ru.ru_maxrss <= 0 || ru.ru_utime.tv_usec < 0)
        return 4;
    close(fds[0]);
    close(fds[1]);
    return w3 && w4 ? 0 : 5;
}
