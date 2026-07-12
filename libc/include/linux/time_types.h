// linux/time_types.h -- the kernel's 64-bit and legacy time structures from
// the uapi header, used by socket timestamping and timer interfaces.

#pragma once

#ifdef __linux__

#include <linux/types.h>

struct __kernel_timespec {
    __kernel_time64_t tv_sec;
    long long tv_nsec;
};

struct __kernel_itimerspec {
    struct __kernel_timespec it_interval;
    struct __kernel_timespec it_value;
};

struct __kernel_old_timeval {
    __kernel_long_t tv_sec;
    __kernel_long_t tv_usec;
};

struct __kernel_old_timespec {
    __kernel_old_time_t tv_sec;
    long tv_nsec;
};

struct __kernel_old_itimerval {
    struct __kernel_old_timeval it_interval;
    struct __kernel_old_timeval it_value;
};

struct __kernel_sock_timeval {
    __s64 tv_sec;
    __s64 tv_usec;
};

#endif /* __linux__ */
