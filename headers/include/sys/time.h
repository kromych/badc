// sys/time.h -- `struct timeval` and gettimeofday are declared in
// <time.h>; re-expose them here for sources that reach for the
// historical BSD location.

#pragma once

#include <time.h>

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
