// signal.h -- asynchronous signal handling (C99 7.14).
//
// C99 mandates `signal()` and `raise()` plus the `SIG_*` macro
// family. POSIX 2017 layers `sigaction()` on top with finer-grained
// dispositions; the POSIX surface is bound on macOS and Linux.
// Windows msvcrt provides the C99 surface only.
//
// `sig_atomic_t` is the integer width that can be safely read or
// written atomically from a signal handler (C99 7.14p2). `int` is
// safe on every supported target.

#pragma once

typedef int sig_atomic_t;

// BSD / POSIX handler type: the disposition passed to and returned by
// `signal()`. Provided as a common extension; matches the host's
// `void (*)(int)`.
typedef void (*sig_t)(int);
// GNU spells the same handler type `sighandler_t` under _GNU_SOURCE.
#ifdef __linux__
typedef void (*sighandler_t)(int);
#endif

// Disposition values. Pass these to `signal()`'s second argument.
// `SIG_ERR` is the failure return value, not a disposition.
#define SIG_DFL  ((void (*)(int))0)
#define SIG_IGN  ((void (*)(int))1)
#define SIG_ERR  ((void (*)(int))-1)

// C99-required signal numbers (7.14). These values match every
// supported host, including Windows msvcrt.
#define SIGINT  2
#define SIGILL  4
#define SIGABRT 6
#define SIGFPE  8
#define SIGSEGV 11
#define SIGTERM 15

#if defined(__APPLE__) || defined(__linux__)
// POSIX signal numbers. Programs gate behavior on `#ifdef SIGPIPE`,
// `#ifdef SIGHUP`, `#ifdef SIGCHLD` and the like, so the full set must
// be present, not just the C99 subset. The low numbers below match both
// Linux and macOS; the job-control and asynchronous-I/O signals diverge,
// so those are defined per target.
#define SIGHUP    1
#define SIGQUIT   3
#define SIGTRAP   5
#define SIGKILL   9
#define SIGPIPE   13
#define SIGALRM   14
#define SIGTTIN   21
#define SIGTTOU   22
#define SIGXCPU   24
#define SIGXFSZ   25
#define SIGVTALRM 26
#define SIGPROF   27
#define SIGWINCH  28
#ifdef __linux__
#define SIGBUS  7
#define SIGUSR1 10
#define SIGUSR2 12
#define SIGCHLD 17
#define SIGCONT 18
#define SIGSTOP 19
#define SIGTSTP 20
#define SIGURG  23
#define SIGIO   29
#define SIGPOLL 29
#define SIGSYS  31
#else /* __APPLE__ */
#define SIGBUS  10
#define SIGUSR1 30
#define SIGUSR2 31
#define SIGCHLD 20
#define SIGCONT 19
#define SIGSTOP 17
#define SIGTSTP 18
#define SIGURG  16
#define SIGIO   23
#define SIGSYS  12
#endif
#endif /* POSIX */

// `NSIG` is one past the highest signal number the platform reserves;
// libc headers expose it and code sizes per-signal tables by it. The
// value is the host's so a table laid out here matches the system
// toolchain's: Darwin counts through SIGUSR2 (32), Linux reserves the
// realtime range (`_NSIG` == 65), the Windows CRT stops at SIGABRT
// (23). A wrong value shifts any `T table[NSIG]` and every field after
// it, so a badc object and a system-compiled object disagree on the
// layout of a struct that embeds one.
#ifdef __APPLE__
#define NSIG 32
#elif defined(__linux__)
#define _NSIG 65
#define NSIG 65
#elif defined(_WIN32)
#define NSIG 23
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::signal,      "_signal")
#pragma binding(libc::raise,       "_raise")
#pragma binding(libc::kill,        "_kill")
#pragma binding(libc::killpg,      "_killpg")
#pragma binding(libc::sigaction,   "_sigaction")
#pragma binding(libc::sigemptyset, "_sigemptyset")
#pragma binding(libc::sigfillset,  "_sigfillset")
#pragma binding(libc::sigaddset,   "_sigaddset")
#pragma binding(libc::sigdelset,   "_sigdelset")
#pragma binding(libc::sigismember, "_sigismember")
#pragma binding(libc::sigprocmask, "_sigprocmask")
#pragma binding(libc::pthread_sigmask, "_pthread_sigmask")
#pragma binding(libc::sigpending,  "_sigpending")
#pragma binding(libc::sigsuspend,  "_sigsuspend")
#pragma binding(libc::sigwait,     "_sigwait")
#pragma binding(libc::siginterrupt,"_siginterrupt")
#pragma binding(libc::sigaltstack, "_sigaltstack")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::signal,      "signal")
#pragma binding(libc::raise,       "raise")
#pragma binding(libc::kill,        "kill")
#pragma binding(libc::killpg,      "killpg")
#pragma binding(libc::sigaction,   "sigaction")
#pragma binding(libc::sigemptyset, "sigemptyset")
#pragma binding(libc::sigfillset,  "sigfillset")
#pragma binding(libc::sigaddset,   "sigaddset")
#pragma binding(libc::sigdelset,   "sigdelset")
#pragma binding(libc::sigismember, "sigismember")
#pragma binding(libc::sigprocmask, "sigprocmask")
#pragma binding(libc::pthread_sigmask, "pthread_sigmask")
#pragma binding(libc::sigpending,  "sigpending")
#pragma binding(libc::sigsuspend,  "sigsuspend")
#pragma binding(libc::sigwait,     "sigwait")
#pragma binding(libc::siginterrupt,"siginterrupt")
// sigwaitinfo / sigtimedwait are Linux-only; Darwin lacks them, so
// configure leaves HAVE_* unset there and never calls them.
#pragma binding(libc::sigwaitinfo, "sigwaitinfo")
#pragma binding(libc::sigtimedwait,"sigtimedwait")
#pragma binding(libc::sigaltstack, "sigaltstack")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::signal, "signal")
#pragma binding(msvcrt::raise,  "raise")
#endif

void (*signal(int sig, void (*func)(int)))(int);
int raise(int sig);
int kill(int pid, int sig);
int killpg(int pgrp, int sig);

#if defined(__APPLE__) || defined(__linux__)
// The signal set as the target's C library declares it: the macOS SDK's
// 32-bit mask, glibc's 1024 bits in `unsigned long` words.
#ifdef __APPLE__
typedef unsigned int sigset_t;
#else
typedef struct { unsigned long __val[1024 / (8 * sizeof(unsigned long))]; } sigset_t;
#endif

// siginfo_t carries a signal's details (POSIX 7.14; also filled by
// waitid). The kernel writes it, so the leading fields sit at the host's
// offsets and the trailing padding covers the platform's full size
// (macOS 104 B, Linux 128 B). On 64-bit Linux a pad word aligns
// the id fields to offset 16.
#ifdef __APPLE__
typedef struct {
    int          si_signo;
    int          si_errno;
    int          si_code;
    int          si_pid;
    unsigned int si_uid;
    int          si_status;
    void         *si_addr; // faulting address (offset 24 on 64-bit)
    unsigned char __pad[104 - 32];
} siginfo_t;
#else
typedef struct {
    int          si_signo;
    int          si_errno;
    int          si_code;
    int          __pad0;
    // The signal-specific payload is a union at offset 16: SIGCHLD fills
    // the pid/uid/status triple, SIGPOLL the band/fd pair. An anonymous
    // union exposes both spellings at their kernel offsets.
    union {
        struct {
            int          si_pid;
            unsigned int si_uid;
            int          si_status;
        };
        struct {
            long         si_band;
            int          si_fd;
        };
        // SIGSEGV / SIGBUS / SIGILL / SIGFPE carry the faulting address at
        // offset 16.
        struct {
            void        *si_addr;
        };
        unsigned char __pad[128 - 16];
    };
} siginfo_t;
#endif

// Both C libraries hold the two handler forms in one union at offset 0;
// glibc appends sa_restorer.
struct sigaction {
    union {
        void (*sa_handler)(int);
        void (*sa_sigaction)(int, siginfo_t *, void *);
    };
    sigset_t sa_mask;
    int sa_flags;
#ifdef __linux__
    void (*sa_restorer)(void);
#endif
};

int sigaction(int sig, struct sigaction *act, struct sigaction *oact);
int sigemptyset(sigset_t *set);
int sigfillset(sigset_t *set);
int sigaddset(sigset_t *set, int signo);
int sigdelset(sigset_t *set, int signo);
int sigismember(const sigset_t *set, int signo);

// Examine and change the signal mask (POSIX). `how` takes one of the
// SIG_BLOCK / SIG_UNBLOCK / SIG_SETMASK values below, whose numbering is
// target-specific because the value reaches the host libc.
int sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
int pthread_sigmask(int how, const sigset_t *set, sigset_t *oldset);
#ifdef __APPLE__
#define SIG_BLOCK   1
#define SIG_UNBLOCK 2
#define SIG_SETMASK 3
#else
#define SIG_BLOCK   0
#define SIG_UNBLOCK 1
#define SIG_SETMASK 2
#endif

// Asynchronous notification (POSIX 7.14): what a per-process timer,
// an AIO completion or a message queue delivers. Linux only -- Darwin
// has neither `struct sigevent` nor the interfaces that take one.
// The layout is glibc's 64-byte record: the value word, the two ints,
// and the SIGEV_THREAD pair at offset 16, which glibc reaches through
// its `sigev_notify_function` / `sigev_notify_attributes` macros.
#ifdef __linux__
union sigval {
    int   sival_int;
    void *sival_ptr;
};

struct sigevent {
    union sigval sigev_value;                     /* offset  0 */
    int          sigev_signo;                     /* offset  8 */
    int          sigev_notify;                    /* offset 12 */
    void       (*sigev_notify_function)(union sigval); /* offset 16 */
    void        *sigev_notify_attributes;         /* offset 24 */
    unsigned char __pad[64 - 32];
};

#define SIGEV_SIGNAL    0
#define SIGEV_NONE      1
#define SIGEV_THREAD    2
#define SIGEV_THREAD_ID 4
#endif

// siginfo_t.si_code values as the target's C library declares them: glibc's
// are the codes of the kernel's <asm-generic/siginfo.h>, the macOS SDK
// numbers its own.
#ifdef __linux__
#define SI_ASYNCNL  (-60)
#define SI_DETHREAD (-7)
#define SI_TKILL    (-6)
#define SI_SIGIO    (-5)
#define SI_ASYNCIO  (-4)
#define SI_MESGQ    (-3)
#define SI_TIMER    (-2)
#define SI_QUEUE    (-1)
#define SI_USER     0
#define SI_KERNEL   0x80

#define ILL_ILLOPC   1
#define ILL_ILLOPN   2
#define ILL_ILLADR   3
#define ILL_ILLTRP   4
#define ILL_PRVOPC   5
#define ILL_PRVREG   6
#define ILL_COPROC   7
#define ILL_BADSTK   8
#define ILL_BADIADDR 9

#define FPE_INTDIV   1
#define FPE_INTOVF   2
#define FPE_FLTDIV   3
#define FPE_FLTOVF   4
#define FPE_FLTUND   5
#define FPE_FLTRES   6
#define FPE_FLTINV   7
#define FPE_FLTSUB   8
#define FPE_FLTUNK   14
#define FPE_CONDTRAP 15

#define SEGV_MAPERR  1
#define SEGV_ACCERR  2
#define SEGV_BNDERR  3
#define SEGV_PKUERR  4
#define SEGV_ACCADI  5
#define SEGV_ADIDERR 6
#define SEGV_ADIPERR 7
#define SEGV_MTEAERR 8
#define SEGV_MTESERR 9
#define SEGV_CPERR   10

#define BUS_ADRALN    1
#define BUS_ADRERR    2
#define BUS_OBJERR    3
#define BUS_MCEERR_AR 4
#define BUS_MCEERR_AO 5

#define TRAP_BRKPT  1
#define TRAP_TRACE  2
#define TRAP_BRANCH 3
#define TRAP_HWBKPT 4
#define TRAP_UNK    5
#define TRAP_PERF   6

#define CLD_EXITED    1
#define CLD_KILLED    2
#define CLD_DUMPED    3
#define CLD_TRAPPED   4
#define CLD_STOPPED   5
#define CLD_CONTINUED 6

#define POLL_IN  1
#define POLL_OUT 2
#define POLL_MSG 3
#define POLL_ERR 4
#define POLL_PRI 5
#define POLL_HUP 6

#define SYS_SECCOMP       1
#define SYS_USER_DISPATCH 2
#elif defined(__APPLE__)
#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#define ILL_NOOP  0
#define FPE_NOOP  0
#define SEGV_NOOP 0
#define BUS_NOOP  0
#define CLD_NOOP  0
#endif

#define ILL_ILLOPC 1
#define ILL_ILLTRP 2
#define ILL_PRVOPC 3
#define ILL_ILLOPN 4
#define ILL_ILLADR 5
#define ILL_PRVREG 6
#define ILL_COPROC 7
#define ILL_BADSTK 8

#define FPE_FLTDIV 1
#define FPE_FLTOVF 2
#define FPE_FLTUND 3
#define FPE_FLTRES 4
#define FPE_FLTINV 5
#define FPE_FLTSUB 6
#define FPE_INTDIV 7
#define FPE_INTOVF 8

#define SEGV_MAPERR 1
#define SEGV_ACCERR 2

#define BUS_ADRALN 1
#define BUS_ADRERR 2
#define BUS_OBJERR 3

#define TRAP_BRKPT 1
#define TRAP_TRACE 2

#define CLD_EXITED    1
#define CLD_KILLED    2
#define CLD_DUMPED    3
#define CLD_TRAPPED   4
#define CLD_STOPPED   5
#define CLD_CONTINUED 6

#define POLL_IN  1
#define POLL_OUT 2
#define POLL_MSG 3
#define POLL_ERR 4
#define POLL_PRI 5
#define POLL_HUP 6

#define SI_USER    0x10001
#define SI_QUEUE   0x10002
#define SI_TIMER   0x10003
#define SI_ASYNCIO 0x10004
#define SI_MESGQ   0x10005
#endif

// Pending-signal query, blocking waits, and the BSD interrupt toggle
// (POSIX). sigwaitinfo / sigtimedwait are Linux-only (see bindings).
int sigpending(sigset_t *set);
int sigsuspend(const sigset_t *mask);
int sigwait(const sigset_t *set, int *sig);
int siginterrupt(int sig, int flag);
#ifdef __linux__
int sigwaitinfo(const sigset_t *set, siginfo_t *info);
int sigtimedwait(const sigset_t *set, siginfo_t *info,
                 const struct timespec *timeout);
#endif

// `sa_flags` bits. The numeric values are target-specific: macOS and
// Linux assign different bit positions, and `sa_flags` is passed to the
// host libc, so each target uses its own constants.
#ifdef __APPLE__
#define SA_ONSTACK   0x0001
#define SA_RESTART   0x0002
#define SA_RESETHAND 0x0004
#define SA_NOCLDSTOP 0x0008
#define SA_NODEFER   0x0010
#define SA_NOCLDWAIT 0x0020
#define SA_SIGINFO   0x0040
#else
#define SA_NOCLDSTOP 0x00000001
#define SA_NOCLDWAIT 0x00000002
#define SA_SIGINFO   0x00000004
#define SA_ONSTACK   0x08000000
#define SA_RESTART   0x10000000
#define SA_NODEFER   0x40000000
#define SA_RESETHAND 0x80000000
#endif

// Alternate signal stack (POSIX `sigaltstack`). The structure is
// marshalled to the host libc, so the member order must match it
// exactly: macOS orders `ss_size` before `ss_flags`, Linux the reverse.
#include <stddef.h>
#ifdef __APPLE__
typedef struct sigaltstack {
    void  *ss_sp;
    size_t ss_size;
    int    ss_flags;
} stack_t;
#define SIGSTKSZ    131072
#define MINSIGSTKSZ 32768
#else
typedef struct {
    void  *ss_sp;
    int    ss_flags;
    size_t ss_size;
} stack_t;
#define SIGSTKSZ    8192
#define MINSIGSTKSZ 2048
#endif
#define SS_ONSTACK 1
#define SS_DISABLE 2
int sigaltstack(const stack_t *ss, stack_t *oss);
#endif
