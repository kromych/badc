// time.h -- coarse-grained clock interfaces.
//
// `time_t` is 8 bytes on every supported target -- `long` on LP64
// (Linux/macOS), `long long` on LLP64 (Windows). The finer-grained
// POSIX shapes (`struct timespec`, `struct timeval`) carry a
// `time_t`-sized seconds count, so their layout matches the libc
// view byte-for-byte and `clock_gettime`/`gettimeofday` can write
// into them directly.

#pragma once

// C99 7.23.1p2: `<time.h>` declares `size_t`.
#include <stddef.h>

#define CLOCKS_PER_SEC 1000000

// Per-target clockid_t values. POSIX leaves the integer assignments
// implementation-defined and every libc picks its own; the constants
// here must match what the target's `clock_gettime` accepts at runtime,
// otherwise the call returns -1 with errno = EINVAL and the timespec
// is left untouched.
//
//   * Linux / musl: REALTIME=0, MONOTONIC=1 (linux/time.h).
//   * Apple libSystem:   REALTIME=0, MONOTONIC=6 (sys/_types/_clockid_t.h).
//   * Windows: mingw-w64's numbering, REALTIME=0, MONOTONIC=1
//     (pthread_time.h); libc/lib/time_ext.c defines the clocks.
#ifdef __APPLE__
#define CLOCK_REALTIME  0
#define CLOCK_MONOTONIC 6
// Per-process and per-thread CPU-time clocks (POSIX). libSystem's
// clockid_t enum numbers them 12 and 16, glibc 2 and 3.
#define CLOCK_PROCESS_CPUTIME_ID 12
#define CLOCK_THREAD_CPUTIME_ID  16
#else
#define CLOCK_REALTIME  0
#define CLOCK_MONOTONIC 1
#define CLOCK_PROCESS_CPUTIME_ID 2
#define CLOCK_THREAD_CPUTIME_ID  3
#endif
#ifdef _WIN32
// The system time at the scheduler tick's granularity (mingw-w64).
#define CLOCK_REALTIME_COARSE 4
#else
// Raw hardware monotonic clock, unadjusted by NTP slewing. Same id on
// macOS and Linux.
#define CLOCK_MONOTONIC_RAW 4
#endif
// `clock_nanosleep` / `timer_settime` flag: the supplied time is
// absolute, not a relative interval. Same value on every target.
#define TIMER_ABSTIME 1

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

// Winsock's select() reads `struct timeval` as two 32-bit `long` fields
// (LLP64), so the whole object is 8 bytes. A 64-bit field would place
// tv_usec where select expects tv_sec's high half, zeroing the timeout.
struct timeval {
    long tv_sec;
    long tv_usec;
};
#elif defined(__APPLE__)
struct timespec {
    long tv_sec;
    long tv_nsec;
};

// Darwin's `tv_usec` is `__darwin_suseconds_t` (`__int32_t`), not a
// 64-bit field as on Linux. gettimeofday / select write only the
// 4-byte value; declaring it `long` would read 4 bytes of adjacent
// storage as the high half and yield a garbage microsecond count.
struct timeval {
    long tv_sec;
    int tv_usec;
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

// `struct tm`. The host's localtime / gmtime fill this and the program
// reads the fields back, so the BSD extension members must sit at the
// host's offsets. On macOS and Linux `tm_gmtoff` is a `long` (8 bytes,
// 8-aligned), which places `tm_zone` at offset 48; an `int tm_gmtoff`
// would put `tm_zone` at offset 40 and read a garbage pointer. msvcrt's
// has the nine C99 members alone.
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
#ifndef _WIN32
    long tm_gmtoff;
    char *tm_zone;
#endif
};

// `time_t` and `clock_t` are 8-byte signed counts everywhere
// 64-bit (Linux, macOS Darwin, Windows UCRT after Y2038
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
#pragma binding(libc::clock_settime, "_clock_settime")
#pragma binding(libc::clock_getres,  "_clock_getres")
#pragma binding(libc::nanosleep,     "_nanosleep")
// libSystem exports no clock_nanosleep; unbound so a use fails at link.
#pragma binding(libc::gettimeofday,  "_gettimeofday")
#pragma binding(libc::difftime,      "_difftime")
#pragma binding(libc::mktime,        "_mktime")
#pragma binding(libc::localtime,     "_localtime")
#pragma binding(libc::localtime_r,   "_localtime_r")
#pragma binding(libc::gmtime,        "_gmtime")
#pragma binding(libc::gmtime_r,      "_gmtime_r")
#pragma binding(libc::ctime_r,       "_ctime_r")
#pragma binding(libc::ctime,         "_ctime")
#pragma binding(libc::strftime,      "_strftime")
#pragma binding(libc::strptime,      "_strptime")
#pragma binding(libc::tzset,         "_tzset")
// `tzset` outputs, bound as data imports to libSystem (the underscored
// symbols), mirroring the `environ` GOT-import treatment.
#pragma binding(data libc::tzname,   "_tzname")
#pragma binding(data libc::timezone, "_timezone")
#pragma binding(data libc::daylight, "_daylight")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::time,          "time")
#pragma binding(libc::clock,         "clock")
#pragma binding(libc::clock_gettime, "clock_gettime")
#pragma binding(libc::clock_settime, "clock_settime")
#pragma binding(libc::clock_getres,  "clock_getres")
#pragma binding(libc::clock_nanosleep, "clock_nanosleep")
#pragma binding(libc::nanosleep,     "nanosleep")
#pragma binding(libc::timer_create,  "timer_create")
#pragma binding(libc::timer_delete,  "timer_delete")
#pragma binding(libc::timer_settime, "timer_settime")
#pragma binding(libc::timer_gettime, "timer_gettime")
#pragma binding(libc::timer_getoverrun, "timer_getoverrun")
#pragma binding(libc::gettimeofday,  "gettimeofday")
#pragma binding(libc::difftime,      "difftime")
#pragma binding(libc::mktime,        "mktime")
#pragma binding(libc::localtime,     "localtime")
#pragma binding(libc::localtime_r,   "localtime_r")
#pragma binding(libc::gmtime,        "gmtime")
#pragma binding(libc::gmtime_r,      "gmtime_r")
#pragma binding(libc::ctime_r,       "ctime_r")
#pragma binding(libc::ctime,         "ctime")
#pragma binding(libc::strftime,      "strftime")
#pragma binding(libc::strptime,      "strptime")
#pragma binding(libc::tzset,         "tzset")
// `tzset` writes the zone names / offset / DST flag into these C library
// data symbols; bind them as data imports so a read after `tzset()` sees
// the library's values (the COPY-relocation analogue of `environ`).
#pragma binding(data libc::tzname,   "tzname")
#pragma binding(data libc::timezone, "timezone")
#pragma binding(data libc::daylight, "daylight")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::time,     "time")
#pragma binding(msvcrt::clock,    "clock")
#pragma binding(msvcrt::difftime, "difftime")
#pragma binding(msvcrt::mktime,   "mktime")
#pragma binding(msvcrt::localtime,"localtime")
#pragma binding(msvcrt::gmtime,   "gmtime")
#pragma binding(msvcrt::ctime,    "ctime")
#pragma binding(msvcrt::strftime, "strftime")
#pragma binding(msvcrt::tzset,    "_tzset")
// msvcrt.dll exports the tzset outputs as data on both x64 and
// arm64 (probed on the real boxes); bind each as a loader-filled
// import so a read after `tzset()` sees the CRT's values -- the
// same treatment as `environ` (see <stdlib.h>).
#pragma binding(data msvcrt::tzname,   "_tzname")
#pragma binding(data msvcrt::timezone, "_timezone")
#pragma binding(data msvcrt::daylight, "_daylight")
// msvcrt has none of the POSIX clocks, nanosleep or gettimeofday, which
// mingw-w64 declares here; libc/lib/time_ext.c defines them over
// kernel32. The reentrant localtime_r / gmtime_r / ctime_r are declared,
// as there, under `_POSIX_C_SOURCE` alone.
#if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
#define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
#endif
#endif

// POSIX: <time.h> defines clockid_t, as <sys/types.h> does.
#ifndef __BADC_CLOCKID_T
#define __BADC_CLOCKID_T
typedef int clockid_t;
#endif

// C99 7.23.2: time / clock / mktime return time_t / clock_t, which are
// 64-bit. A return wider than the declared type is narrowed to it, so an
// `int` declaration truncates: clock() overflows int after ~35 min of CPU
// time (CLOCKS_PER_SEC == 1e6), and time_t past 2038 loses its high half.
// difftime takes two time_t by value; `int` parameters truncate them
// before the subtraction. The time_t pointer parameters likewise carry a
// 64-bit object, not an int.
time_t time(time_t *out);
clock_t clock(void);
int clock_gettime(clockid_t clk_id, struct timespec *ts);
// Suspend until `request` (relative, or absolute under TIMER_ABSTIME);
// `remain` receives the unslept interval on EINTR.
int clock_nanosleep(clockid_t clk_id, int flags, const struct timespec *request,
                    struct timespec *remain);
int clock_settime(clockid_t clk_id, const struct timespec *ts);
int clock_getres(clockid_t clk_id, struct timespec *res);
int nanosleep(const struct timespec *req, struct timespec *rem);
// The zone argument is obsolete; glibc, libSystem and mingw-w64 all
// spell it `void *`.
int gettimeofday(struct timeval *restrict tv, void *restrict tz);
double difftime(time_t t1, time_t t0);
// C99 7.23.2.3: convert broken-down time to a `time_t`. The
// caller's `struct tm` is updated in place (tm_wday / tm_yday and
// any normalisation of out-of-range fields). Returns the seconds
// count or (time_t)-1 on failure.
time_t mktime(struct tm *tm);
struct tm *localtime(const time_t *t);
struct tm *gmtime(const time_t *t);
#if !defined(_WIN32) || defined(_POSIX_THREAD_SAFE_FUNCTIONS)
struct tm *localtime_r(const time_t *t, struct tm *result);
struct tm *gmtime_r(const time_t *t, struct tm *result);
// POSIX `ctime_r` -- 26-byte timestamp string written into the
// caller's buffer; returns the buffer pointer or NULL on error.
char *ctime_r(const time_t *t, char *buf);
#endif
// C89 7.12.3.2: static 26-byte timestamp string; not reentrant.
char *ctime(const time_t *t);
size_t strftime(char *buf, size_t max, const char *fmt, const struct tm *tm);
#ifdef __linux__
// POSIX per-process timers. `timer_t` is an opaque handle glibc defines
// as a pointer; `struct sigevent` comes from <signal.h>, and the
// prototypes need only its tag. Linux only -- Darwin implements none of
// these.
typedef void *timer_t;
struct itimerspec {
    struct timespec it_interval;
    struct timespec it_value;
};
struct sigevent;
int timer_create(int clockid, struct sigevent *sevp, timer_t *timerid);
int timer_delete(timer_t timerid);
int timer_settime(timer_t timerid, int flags, const struct itimerspec *new_value,
                  struct itimerspec *old_value);
int timer_gettime(timer_t timerid, struct itimerspec *curr_value);
int timer_getoverrun(timer_t timerid);
#endif

#ifndef _WIN32
// POSIX 7.24.1: the inverse of strftime -- parse `buf` per `fmt` into
// `tm` and return the first unparsed character, or NULL on a mismatch.
// The Windows C runtime has no equivalent.
char *strptime(const char *buf, const char *fmt, struct tm *tm);
#endif
// POSIX 7.24.1: initialize the timezone conversion state from the TZ
// environment variable (or the system default). No arguments, no result.
void tzset(void);
// POSIX `tzset` outputs: the two timezone-abbreviation strings (standard
// and daylight), the seconds west of UTC, and a daylight-saving flag.
extern char *tzname[2];
extern long timezone;
extern int daylight;
