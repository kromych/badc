// An SA_SIGINFO handler installed through sa_sigaction runs on raise(), with
// its signal in si_signo, and sigaction() reads the same handler back.

#include <signal.h>
#include <string.h>

#if defined(__APPLE__) || defined(__linux__)
static volatile sig_atomic_t hits;
static volatile sig_atomic_t signo;

static void on_usr1(int sig, siginfo_t *si, void *uc) {
    (void)uc;
    hits = hits + 1;
    signo = si->si_signo == sig ? sig : -1;
}

static int check(void) {
    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_sigaction = on_usr1;
    sa.sa_flags = SA_SIGINFO;
    sigemptyset(&sa.sa_mask);
    if (sigaction(SIGUSR1, &sa, 0) != 0) {
        return 2;
    }
    struct sigaction old;
    memset(&old, 0, sizeof old);
    if (sigaction(SIGUSR1, 0, &old) != 0) {
        return 3;
    }
    if (old.sa_sigaction != on_usr1 || (old.sa_flags & SA_SIGINFO) == 0) {
        return 4;
    }
    raise(SIGUSR1);
    if (hits != 1) {
        return 1;
    }
    return signo == SIGUSR1 ? 0 : 5;
}
#endif

int main(void) {
#if defined(__APPLE__) || defined(__linux__)
    return check();
#else
    return 0;
#endif
}
