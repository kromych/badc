// sigsetjmp with a nonzero savemask saves the signal mask and siglongjmp
// restores it; with savemask 0 the jump leaves the mask as it finds it
// (POSIX sigsetjmp).
//
// Returns 0 on success, otherwise the number of the failing check.

#include <setjmp.h>
#include <signal.h>

static sigjmp_buf env;

static int blocked(int sig) {
    sigset_t cur;
    sigprocmask(SIG_BLOCK, 0, &cur);
    return sigismember(&cur, sig);
}

static void block(int sig) {
    sigset_t s;
    sigemptyset(&s);
    sigaddset(&s, sig);
    sigprocmask(SIG_BLOCK, &s, 0);
}

static void unblock(int sig) {
    sigset_t s;
    sigemptyset(&s);
    sigaddset(&s, sig);
    sigprocmask(SIG_UNBLOCK, &s, 0);
}

int main(void) {
    unblock(SIGUSR1);
    unblock(SIGUSR2);
    if (blocked(SIGUSR1) || blocked(SIGUSR2)) {
        return 1;
    }
    if (sigsetjmp(env, 1) == 0) {
        block(SIGUSR1);
        if (!blocked(SIGUSR1)) {
            return 2;
        }
        siglongjmp(env, 1);
    }
    if (blocked(SIGUSR1)) {
        return 3;
    }
    if (sigsetjmp(env, 0) == 0) {
        block(SIGUSR2);
        siglongjmp(env, 1);
    }
    int kept = blocked(SIGUSR2);
    unblock(SIGUSR2);
    return kept ? 0 : 4;
}
