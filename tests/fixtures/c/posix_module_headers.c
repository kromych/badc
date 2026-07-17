// POSIX/C99 surface: the signal mask family (POSIX), resource limits
// (POSIX), wide classification (C99 7.25), and the single-byte/wide
// conversion in <wchar.h>. The portable subset is exercised at runtime;
// the Unix-only calls are guarded so the fixture also builds on Windows.

#include <wchar.h>
#include <wctype.h>

#if defined(__APPLE__) || defined(__linux__)
#include <signal.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/times.h>
#include <sys/wait.h>
#include <sys/param.h>
#include <fcntl.h>
#include <sched.h>
#include <spawn.h>
#endif

int main(void) {
    // <wchar.h> 7.24.6.1 + <wctype.h> 7.25 round-trip a byte through the
    // wide-character classifier.
    wint_t w = btowc('A');
    if (w != (wint_t)'A') return 1;
    if (!iswalnum(w) || !iswupper(w)) return 2;
    if (towlower(w) != (wint_t)'a') return 3;
    if (wctob(w) != 'A') return 4;
    if (!iswctype(w, wctype("alpha"))) return 5;

#if defined(__APPLE__) || defined(__linux__)
    // POSIX signal-set manipulation.
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    if (sigismember(&set, SIGINT) != 1) return 6;
    if (sigismember(&set, SIGTERM) != 0) return 7;
    sigdelset(&set, SIGINT);
    if (sigismember(&set, SIGINT) != 0) return 8;

    // SIG_* and the timer / wait identifiers are defined.
    int how = SIG_SETMASK + SIG_BLOCK + SIG_UNBLOCK;
    int which = ITIMER_REAL + ITIMER_VIRTUAL + ITIMER_PROF;
    idtype_t id = P_PID;
    if (how < 0 || which < 0 || id != P_PID) return 9;

    // POSIX resource limit query.
    struct rlimit rl;
    if (getrlimit(RLIMIT_CORE, &rl) != 0) return 10;

    // The interval-timer struct nests two timevals.
    struct itimerval it;
    it.it_value.tv_sec = 0;
    it.it_interval.tv_sec = 0;
    if (sizeof it != 2 * sizeof(struct timeval)) return 11;

    // The newly added constants and aggregate types resolve and parse.
    int at = AT_FDCWD + AT_SYMLINK_NOFOLLOW + AT_REMOVEDIR;
    int policy = SCHED_OTHER + SCHED_FIFO + SCHED_RR;
    int spawn = POSIX_SPAWN_SETSIGDEF + POSIX_SPAWN_SETSIGMASK;
    if (at == 0 && policy == 0 && spawn == 0) return 12;
    if (MAXPATHLEN < 256 || MAXLOGNAME < 1) return 13;

    struct sched_param sp;
    posix_spawnattr_t attr;
    posix_spawn_file_actions_t fa;
    struct tms tmsbuf;
    sp.sched_priority = 0;
    if (&attr == 0 || &fa == 0 || &tmsbuf == 0 || sp.sched_priority != 0)
        return 14;
#endif

    return 0;
}
