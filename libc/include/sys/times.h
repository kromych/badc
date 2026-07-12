// sys/times.h -- process times (POSIX times()).

#pragma once

#if defined(__APPLE__) || defined(__linux__)
// `clock_t` is an 8-byte count from <time.h>.
#include <time.h>

// User and system CPU time for the calling process and its waited-for
// children, in clock ticks. The struct is filled by the host libc, so
// the member order matches it.
struct tms {
    clock_t tms_utime;
    clock_t tms_stime;
    clock_t tms_cutime;
    clock_t tms_cstime;
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::times, "_times")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::times, "times")
#endif

// Returns elapsed real time in clock ticks since an arbitrary epoch, or
// (clock_t)-1 on error; fills `*buf` with the CPU-time breakdown.
clock_t times(struct tms *buf);
#endif
