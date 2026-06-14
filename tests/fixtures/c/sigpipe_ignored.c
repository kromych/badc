// POSIX programs gate signal handling on `#ifdef SIGPIPE` and install
// dispositions by signal number, so the full POSIX signal set must be
// defined in <signal.h>, not just the C99 subset. A `write` to a pipe
// whose read end is closed raises SIGPIPE; with `SIG_IGN` installed the
// process survives and the write fails with -1 (EPIPE) instead of being
// terminated. If SIGPIPE were undefined this would not compile; if the
// disposition were not honored the process would die before returning.
#include <signal.h>
#if defined(__APPLE__) || defined(__linux__)
#include <unistd.h>
#endif

int main(void) {
#if defined(__APPLE__) || defined(__linux__)
    if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
        return 1;
    }
    int fd[2];
    if (pipe(fd) != 0) {
        return 2;
    }
    close(fd[0]);
    long n = write(fd[1], "x", 1);
    if (n != -1) {
        return 3;
    }
#endif
    return 0;
}
