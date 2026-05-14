// time.h -- coarse-grained clock interfaces.
//
// `time_t` is 8 bytes on every supported target -- `long` on LP64
// (Linux/macOS), `long long` on LLP64 (Windows). The finer-grained
// POSIX shapes (`struct timespec`, `struct timeval`) carry a
// `time_t`-sized seconds count, so their layout matches the libc
// view byte-for-byte and `clock_gettime`/`gettimeofday` can write
// into them directly.

#pragma once

#define CLOCKS_PER_SEC 1000000
#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1

// `tv_sec` is `time_t` per POSIX; we just inline the per-target
// width so the typedef order doesn't matter. `tv_nsec` / `tv_usec`
// are signed long on POSIX (8 on LP64, 4 on LLP64), which we
// likewise spell out per target. `time_t` itself is declared
// alongside the binding pragmas below, since `clock_t` shares
// the same width.
#ifdef __BADC_WINDOWS__
struct timespec {
    long long tv_sec;
    long long tv_nsec;
};

struct timeval {
    long long tv_sec;
    long long tv_usec;
};
#else
struct timespec {
    long tv_sec;
    long tv_nsec;
};

struct timeval {
    long tv_sec;
    long tv_usec;
};
#endif

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

// `time_t` and `clock_t` are 8-byte signed counts everywhere
// 64-bit (Linux glibc, macOS Darwin, Windows UCRT after Y2038
// transitioned everything to `long long`). Storing them as
// `int` means values past 2038 wrap silently; programs that
// `time(NULL)` and arithmetic on the result lose 4 bytes.
//
// On Windows we're LLP64 (`long` = 32 bits), so these have to
// be `long long` to keep 64-bit width and match the UCRT ABI.
// On Linux/macOS LP64, `long` is already 64 bits.
#ifdef __BADC_WINDOWS__
typedef long long time_t;
typedef long long clock_t;
#else
typedef long time_t;
typedef long clock_t;
#endif

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
#pragma binding(libc::ctime_r,       "_ctime_r")
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
#pragma binding(libc::ctime_r,       "ctime_r")
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
// POSIX `ctime_r` -- 26-byte timestamp string written into the
// caller's buffer; returns the buffer pointer or NULL on error.
char *ctime_r(int *t, char *buf);
int strftime(char *buf, int max, char *fmt, struct tm *tm);
