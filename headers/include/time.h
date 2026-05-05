// time.h -- coarse-grained clock interfaces.
//
// `time_t` is just `int` in c5 (everything is 64-bit signed). The
// finer-grained POSIX shapes (`struct timespec`, `struct timeval`)
// are exposed as opaque structs so programs can pass through
// pointers without c5 needing to model the exact layout (which
// differs across libc versions anyway).

#pragma once

#define CLOCKS_PER_SEC 1000000
#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1

struct timespec {
    int tv_sec;
    int tv_nsec;
};

struct timeval {
    int tv_sec;
    int tv_usec;
};

// `struct tm` exposed as an opaque mirror of the libc shape so
// programs that walk the broken-down components (`tm_year`,
// `tm_mon`, ...) typecheck. Layout matches the common Unix /
// glibc / musl encoding; callers that hand pointers to libc
// don't need it to be byte-exact, just large enough.
struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
    int tm_gmtoff;
    char *tm_zone;
};

typedef int time_t;
typedef int clock_t;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::time,          "_time")
#pragma binding(libc::clock,         "_clock")
#pragma binding(libc::clock_gettime, "_clock_gettime")
#pragma binding(libc::gettimeofday,  "_gettimeofday")
#pragma binding(libc::difftime,      "_difftime")
#pragma binding(libc::mktime,        "_mktime")
#pragma binding(libc::localtime,     "_localtime")
#pragma binding(libc::localtime_r,   "_localtime_r")
#pragma binding(libc::gmtime,        "_gmtime")
#pragma binding(libc::gmtime_r,      "_gmtime_r")
#pragma binding(libc::strftime,      "_strftime")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::time,          "time")
#pragma binding(libc::clock,         "clock")
#pragma binding(libc::clock_gettime, "clock_gettime")
#pragma binding(libc::gettimeofday,  "gettimeofday")
#pragma binding(libc::difftime,      "difftime")
#pragma binding(libc::mktime,        "mktime")
#pragma binding(libc::localtime,     "localtime")
#pragma binding(libc::localtime_r,   "localtime_r")
#pragma binding(libc::gmtime,        "gmtime")
#pragma binding(libc::gmtime_r,      "gmtime_r")
#pragma binding(libc::strftime,      "strftime")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::time,     "time")
#pragma binding(msvcrt::clock,    "clock")
#pragma binding(msvcrt::difftime, "difftime")
#pragma binding(msvcrt::mktime,   "mktime")
#pragma binding(msvcrt::localtime,"localtime")
#pragma binding(msvcrt::gmtime,   "gmtime")
#pragma binding(msvcrt::strftime, "strftime")
// Windows doesn't ship POSIX `clock_gettime` / `gettimeofday`. SQLite
// has its own Win32-specific code path that calls
// `GetSystemTimeAsFileTime`; programs that want a portable shape
// either #ifdef _WIN32 themselves or use the kernel32 surface.
#endif

int time(int *out);
int clock();
int clock_gettime(int clk_id, struct timespec *ts);
int gettimeofday(struct timeval *tv, char *tz);
double difftime(int t1, int t0);
int mktime(struct timespec *ts);
struct tm *localtime(int *t);
struct tm *localtime_r(int *t, struct tm *result);
struct tm *gmtime(int *t);
struct tm *gmtime_r(int *t, struct tm *result);
int strftime(char *buf, int max, char *fmt, struct tm *tm);
