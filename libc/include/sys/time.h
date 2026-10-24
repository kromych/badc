// sys/time.h -- `struct timeval` and gettimeofday are declared in
// <time.h>; re-expose them here for sources that reach for the
// historical BSD location.

#pragma once

#include <time.h>

// The obsolete zone argument of gettimeofday, which glibc, libSystem and
// mingw-w64 all define here.
struct timezone {
    int tz_minuteswest;
    int tz_dsttime;
};

// BSD timeval arithmetic, defined by glibc and by the macOS SDK unless the
// program asks for strict POSIX there.
#if defined(__linux__) || (defined(__APPLE__) && (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)))
#define timerisset(tvp) ((tvp)->tv_sec || (tvp)->tv_usec)
#define timerclear(tvp) ((tvp)->tv_sec = (tvp)->tv_usec = 0)
#define timercmp(a, b, CMP) \
    (((a)->tv_sec == (b)->tv_sec) ? ((a)->tv_usec CMP (b)->tv_usec) \
                                  : ((a)->tv_sec CMP (b)->tv_sec))
#define timeradd(a, b, result) do { \
    (result)->tv_sec = (a)->tv_sec + (b)->tv_sec; \
    (result)->tv_usec = (a)->tv_usec + (b)->tv_usec; \
    if ((result)->tv_usec >= 1000000) { \
        ++(result)->tv_sec; \
        (result)->tv_usec -= 1000000; \
    } \
} while (0)
#define timersub(a, b, result) do { \
    (result)->tv_sec = (a)->tv_sec - (b)->tv_sec; \
    (result)->tv_usec = (a)->tv_usec - (b)->tv_usec; \
    if ((result)->tv_usec < 0) { \
        --(result)->tv_sec; \
        (result)->tv_usec += 1000000; \
    } \
} while (0)
#endif

#if defined(__APPLE__) || defined(__linux__)
// Interval timer (POSIX setitimer/getitimer). Two `struct timeval`s: the
// time until the next expiration and the reload value. The struct is
// marshalled to the host libc, so the member order matches it.
struct itimerval {
    struct timeval it_interval;
    struct timeval it_value;
};

// Timer identifiers; same numbering on macOS and Linux.
#define ITIMER_REAL    0
#define ITIMER_VIRTUAL 1
#define ITIMER_PROF    2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setitimer, "_setitimer")
#pragma binding(libc::getitimer, "_getitimer")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setitimer, "setitimer")
#pragma binding(libc::getitimer, "getitimer")
#endif

int setitimer(int which, const struct itimerval *new_value,
              struct itimerval *old_value);
int getitimer(int which, struct itimerval *curr_value);
#endif
