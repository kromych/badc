// <ulimit.h>: UL_GETFSIZE reports RLIMIT_FSIZE in 512-byte blocks and
// UL_SETFSIZE to that value succeeds and returns it. An unlimited size is
// LONG_MAX in glibc and the infinity divided by 512 in libSystem.
// snapshot-budget: exempt
#include <limits.h>
#include <sys/resource.h>
#include <ulimit.h>

int main(void) {
    struct rlimit rl;
    long want, got;

    if (UL_GETFSIZE != 1 || UL_SETFSIZE != 2) return 1;
    if (getrlimit(RLIMIT_FSIZE, &rl) != 0) return 2;
#ifdef __APPLE__
    want = (long)(rl.rlim_cur / 512);
#else
    want = rl.rlim_cur == RLIM_INFINITY ? LONG_MAX : (long)(rl.rlim_cur / 512);
#endif
    got = ulimit(UL_GETFSIZE);
    if (got != want) return 3;
    if (rl.rlim_cur != RLIM_INFINITY && ulimit(UL_SETFSIZE, got) != got) return 4;
    return 0;
}
