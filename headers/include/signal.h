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
// glibc spells the same handler type `sighandler_t` under _GNU_SOURCE.
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

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::signal,      "_signal")
#pragma binding(libc::raise,       "_raise")
#pragma binding(libc::kill,        "_kill")
#pragma binding(libc::sigaction,   "_sigaction")
#pragma binding(libc::sigemptyset, "_sigemptyset")
#pragma binding(libc::sigfillset,  "_sigfillset")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::signal,      "signal")
#pragma binding(libc::raise,       "raise")
#pragma binding(libc::kill,        "kill")
#pragma binding(libc::sigaction,   "sigaction")
#pragma binding(libc::sigemptyset, "sigemptyset")
#pragma binding(libc::sigfillset,  "sigfillset")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::signal, "signal")
#pragma binding(msvcrt::raise,  "raise")
#endif

void (*signal(int sig, void (*func)(int)))(int);
int raise(int sig);
int kill(int pid, int sig);

#if defined(__APPLE__) || defined(__linux__)
// POSIX `sigset_t` is an opaque bag of bits; size differs per
// libc. Reserve 128 bytes -- enough for every supported host
// (Linux glibc 128 B, musl 128 B, macOS 4 B). Oversizing is
// harmless: the kernel reads only the bits it knows.
typedef struct { unsigned char __opaque[128]; } sigset_t;

// `struct sigaction` layout differs per libc. The fields here are
// the POSIX-required set in the order every supported host uses;
// padding to 256 bytes covers Linux glibc (152 B) and macOS (32 B)
// plus arch-specific slack.
struct sigaction {
    void (*sa_handler)(int);
    sigset_t sa_mask;
    int sa_flags;
    void (*sa_sigaction)(int, void *, void *);
    unsigned char __pad[256 - sizeof(void *) - sizeof(sigset_t)
                        - sizeof(int) - sizeof(void *)];
};

int sigaction(int sig, struct sigaction *act, struct sigaction *oact);
int sigemptyset(sigset_t *set);
int sigfillset(sigset_t *set);
#endif
