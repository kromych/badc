// sys/resource.h -- process resource limits (POSIX getrlimit/setrlimit).

#pragma once

#if defined(__APPLE__) || defined(__linux__)
// `rlim_t` is a 64-bit unsigned count on both supported hosts.
typedef unsigned long long rlim_t;

// A soft (current) and hard (ceiling) limit pair. The struct is
// marshalled to the host libc, so the member order matches it.
struct rlimit {
    rlim_t rlim_cur;
    rlim_t rlim_max;
};

#define RLIM_INFINITY (~0ULL)

// Limit identifiers. The numbering past STACK/CORE diverges between
// macOS and Linux because the value reaches the host libc.
#define RLIMIT_CPU   0
#define RLIMIT_FSIZE 1
#define RLIMIT_DATA  2
#define RLIMIT_STACK 3
#define RLIMIT_CORE  4
#ifdef __APPLE__
#define RLIMIT_AS      5
#define RLIMIT_MEMLOCK 6
#define RLIMIT_NPROC   7
#define RLIMIT_NOFILE  8
#else
#define RLIMIT_RSS     5
#define RLIMIT_NPROC   6
#define RLIMIT_NOFILE  7
#define RLIMIT_MEMLOCK 8
#define RLIMIT_AS      9
#endif

// Count of RLIMIT_* identifiers; Linux defines more than macOS.
#ifdef __APPLE__
#define RLIM_NLIMITS 9
#else
#define RLIM_NLIMITS 16
#endif

#include <sys/time.h>

// getrusage's selectors and record, as glibc and the macOS SDK lay it out:
// two `struct timeval` times and fourteen `long` counters.
#define RUSAGE_SELF      0
#define RUSAGE_CHILDREN (-1)
#ifdef __linux__
#define RUSAGE_THREAD    1
#endif
struct rusage {
    struct timeval ru_utime;
    struct timeval ru_stime;
    long ru_maxrss;
    long ru_ixrss;
    long ru_idrss;
    long ru_isrss;
    long ru_minflt;
    long ru_majflt;
    long ru_nswap;
    long ru_inblock;
    long ru_oublock;
    long ru_msgsnd;
    long ru_msgrcv;
    long ru_nsignals;
    long ru_nvcsw;
    long ru_nivcsw;
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getrlimit, "_getrlimit")
#pragma binding(libc::setrlimit, "_setrlimit")
#pragma binding(libc::getrusage, "_getrusage")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getrlimit, "getrlimit")
#pragma binding(libc::setrlimit, "setrlimit")
#pragma binding(libc::prlimit, "prlimit64")
#pragma binding(libc::getrusage, "getrusage")
#endif

int getrlimit(int resource, struct rlimit *rlp);
int setrlimit(int resource, const struct rlimit *rlp);
#ifdef __linux__
// Linux prlimit: read and/or replace a process's limits in one call. Bound to
// glibc's 64-bit entry; badc's rlim_t is already 64-bit.
int prlimit(int pid, int resource, const struct rlimit *new_limit,
            struct rlimit *old_limit);
#endif
int getrusage(int who, struct rusage *r_usage);
#endif

#if defined(__APPLE__) || defined(__linux__)
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getpriority, "_getpriority")
#pragma binding(libc::setpriority, "_setpriority")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getpriority, "getpriority")
#pragma binding(libc::setpriority, "setpriority")
#endif
#include <sys/types.h>
#define PRIO_PROCESS 0
#define PRIO_PGRP    1
#define PRIO_USER    2
int getpriority(int which, id_t who);
int setpriority(int which, id_t who, int value);
#endif
