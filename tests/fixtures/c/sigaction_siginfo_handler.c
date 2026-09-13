// An SA_SIGINFO handler installed through sa_sigaction runs on raise(), with
// its signal in si_signo, and sigaction() reads the same handler back. On
// Linux the context it receives holds a stack pointer below main's frame.

#ifdef __linux__
#define _GNU_SOURCE
#include <ucontext.h>
#endif
#include <signal.h>
#include <string.h>

#if defined(__APPLE__) || defined(__linux__)
static volatile sig_atomic_t hits;
static volatile sig_atomic_t signo;
static volatile sig_atomic_t below_mark;
static char *mark;

static void on_usr1(int sig, siginfo_t *si, void *uc) {
    unsigned long sp = (unsigned long)mark;
#if defined(__linux__) && defined(__x86_64__)
    sp = (unsigned long)((ucontext_t *)uc)->uc_mcontext.gregs[REG_RSP];
#elif defined(__linux__) && defined(__aarch64__)
    sp = (unsigned long)((ucontext_t *)uc)->uc_mcontext.sp;
#else
    (void)uc;
#endif
    hits = hits + 1;
    signo = si->si_signo == sig ? sig : -1;
    below_mark = (unsigned long)mark - sp < (1ul << 20);
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
    if (signo != SIGUSR1) {
        return 5;
    }
    return below_mark ? 0 : 6;
}
#endif

int main(void) {
#if defined(__APPLE__) || defined(__linux__)
    char local;
    mark = &local;
    return check();
#else
    return 0;
#endif
}
