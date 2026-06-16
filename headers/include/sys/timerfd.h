#pragma once

// sys/timerfd.h -- file-descriptor-based timers (Linux).

#include <time.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::timerfd_create,  "timerfd_create")
#pragma binding(libc::timerfd_settime, "timerfd_settime")
#pragma binding(libc::timerfd_gettime, "timerfd_gettime")
#endif

// timerfd_create flags.
#define TFD_CLOEXEC  02000000
#define TFD_NONBLOCK 00004000
// timerfd_settime flag: the expiration is absolute.
#define TFD_TIMER_ABSTIME 1

// A timer's interval and next expiration (POSIX.1).
struct itimerspec {
    struct timespec it_interval;
    struct timespec it_value;
};

int timerfd_create(int clockid, int flags);
int timerfd_settime(int fd, int flags, const struct itimerspec *new_value,
                    struct itimerspec *old_value);
int timerfd_gettime(int fd, struct itimerspec *curr_value);
