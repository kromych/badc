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

// Disposition values. Pass these to `signal()`'s second argument.
// `SIG_ERR` is the failure return value, not a disposition.
#define SIG_DFL  ((void (*)(int))0)
#define SIG_IGN  ((void (*)(int))1)
#define SIG_ERR  ((void (*)(int))-1)

// Signal numbers. Values match every supported host's <signal.h>
// for the C99-required set (SIGABRT/SIGFPE/SIGILL/SIGINT/SIGSEGV/
// SIGTERM). Hosts differ on numbers beyond the C99 set (e.g.
// SIGPIPE is 13 on POSIX, undefined on Windows); add only the C99
// + POSIX-common subset here.
#define SIGINT  2
#define SIGILL  4
#define SIGABRT 6
#define SIGFPE  8
#define SIGSEGV 11
#define SIGTERM 15

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::signal,      "_signal")
#pragma binding(libc::raise,       "_raise")
#pragma binding(libc::sigaction,   "_sigaction")
#pragma binding(libc::sigemptyset, "_sigemptyset")
#pragma binding(libc::sigfillset,  "_sigfillset")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::signal,      "signal")
#pragma binding(libc::raise,       "raise")
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
