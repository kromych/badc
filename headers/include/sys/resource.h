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

#define RUSAGE_SELF      0
#define RUSAGE_CHILDREN (-1)

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getrlimit, "_getrlimit")
#pragma binding(libc::setrlimit, "_setrlimit")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getrlimit, "getrlimit")
#pragma binding(libc::setrlimit, "setrlimit")
#pragma binding(libc::prlimit, "prlimit64")
#endif

int getrlimit(int resource, struct rlimit *rlp);
int setrlimit(int resource, const struct rlimit *rlp);
#ifdef __linux__
// Linux prlimit: read and/or replace a process's limits in one call. Bound to
// glibc's 64-bit entry; badc's rlim_t is already 64-bit.
int prlimit(int pid, int resource, const struct rlimit *new_limit,
            struct rlimit *old_limit);
#endif
// getrusage itself is declared in <unistd.h>; the RUSAGE_* selectors
// above are the resource.h half of its interface.
#endif
