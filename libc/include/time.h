// time.h -- coarse-grained clock interfaces.
//
// `time_t` is 8 bytes on every supported target -- `long` on LP64
// (Linux/macOS), `long long` on LLP64 (Windows). The finer-grained
// POSIX `struct timespec` carries a `time_t`-sized seconds count, so
// its layout matches the libc view byte-for-byte and `clock_gettime`
// can write into it directly.

#pragma once

// C99 7.23.1p2: `<time.h>` declares `size_t`.
#include <stddef.h>

// The units of the target's `clock`: milliseconds in msvcrt and the UCRT.
#ifdef __BADC_WINDOWS__
#define CLOCKS_PER_SEC 1000
#else
#define CLOCKS_PER_SEC 1000000
#endif

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

// The UCRT's <time.h> defines no `struct timeval`: the SDK's winsock.h and
// winsock2.h define it unguarded, so a definition here would collide with
// theirs in either order. <sys/time.h> and <winsock2.h> take it from
// <_timeval.h>; gettimeofday below needs only the tag.
struct timeval;
#else
struct timespec {
    long tv_sec;
    long tv_nsec;
};
// glibc's and the macOS SDK's <time.h> define no `struct timeval` either:
// <sys/time.h>, <sys/select.h> and <sys/resource.h> take it from
// <__badc_timeval.h>, and <sys/time.h> declares gettimeofday.
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
#ifdef __linux__
    long tm_gmtoff;
    const char *tm_zone;
#elif !defined(_WIN32)
    long tm_gmtoff;
    char *tm_zone;
#endif
};

// `time_t` is a 64-bit signed count on every target (the UCRT's
// `__time64_t`). `clock_t` is the C library's: `long`, 32 bits on
// Windows, and `unsigned long` on Darwin.
#ifdef __BADC_WINDOWS__
typedef long long time_t;
#else
typedef long time_t;
#endif
#ifdef __APPLE__
typedef unsigned long clock_t;
#else
typedef long clock_t;
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::time,          "_time")
#pragma binding(libc::clock,         "_clock")
#pragma binding(libc::clock_gettime, "_clock_gettime")
#pragma binding(libc::timespec_get,  "_timespec_get")
#pragma binding(libc::clock_settime, "_clock_settime")
#pragma binding(libc::clock_getres,  "_clock_getres")
#pragma binding(libc::nanosleep,     "_nanosleep")
#pragma binding(libc::difftime,      "_difftime")
#pragma binding(libc::mktime,        "_mktime")
#pragma binding(libc::localtime,     "_localtime")
#pragma binding(libc::localtime_r,   "_localtime_r")
#pragma binding(libc::gmtime,        "_gmtime")
#pragma binding(libc::gmtime_r,      "_gmtime_r")
#pragma binding(libc::ctime_r,       "_ctime_r")
#pragma binding(libc::ctime,         "_ctime")
#pragma binding(libc::asctime,       "_asctime")
#pragma binding(libc::asctime_r,     "_asctime_r")
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
#pragma binding(libc::timespec_get,  "timespec_get")
#pragma binding(libc::clock_settime, "clock_settime")
#pragma binding(libc::clock_getres,  "clock_getres")
#pragma binding(libc::clock_nanosleep, "clock_nanosleep")
#pragma binding(libc::nanosleep,     "nanosleep")
#pragma binding(libc::timer_create,  "timer_create")
#pragma binding(libc::timer_delete,  "timer_delete")
#pragma binding(libc::timer_settime, "timer_settime")
#pragma binding(libc::timer_gettime, "timer_gettime")
#pragma binding(libc::timer_getoverrun, "timer_getoverrun")
#pragma binding(libc::difftime,      "difftime")
#pragma binding(libc::mktime,        "mktime")
#pragma binding(libc::localtime,     "localtime")
#pragma binding(libc::localtime_r,   "localtime_r")
#pragma binding(libc::gmtime,        "gmtime")
#pragma binding(libc::gmtime_r,      "gmtime_r")
#pragma binding(libc::ctime_r,       "ctime_r")
#pragma binding(libc::ctime,         "ctime")
#pragma binding(libc::asctime,       "asctime")
#pragma binding(libc::asctime_r,     "asctime_r")
#pragma binding(libc::clock_getcpuclockid, "clock_getcpuclockid")
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
#pragma binding(msvcrt::asctime,  "asctime")
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
// kernel32. The reentrant localtime_r / gmtime_r / ctime_r / asctime_r are
// declared, as there, under `_POSIX_C_SOURCE` alone.
#include <corecrt.h>
#include <__badc_wtime.h>
// The bounds-checked forms <tchar.h>'s _s mappings reach, with mingw-w64's
// prototypes (sec_api/*_s.h); msvcrt.dll exports each on both targets.
#pragma binding(msvcrt::_ctime32_s, "_ctime32_s")
errno_t _ctime32_s(char *_Buf, size_t _SizeInBytes, const __time32_t *_Time);
#pragma binding(msvcrt::_ctime64_s, "_ctime64_s")
errno_t _ctime64_s(char *_Buf, size_t _SizeInBytes, const __time64_t *_Time);
#pragma binding(msvcrt::_strdate_s, "_strdate_s")
errno_t _strdate_s(char *_Buf, size_t _SizeInBytes);
#pragma binding(msvcrt::_strtime_s, "_strtime_s")
errno_t _strtime_s(char *_Buf, size_t _SizeInBytes);
#if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
#define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
#endif
#endif

// POSIX: <time.h> defines clockid_t, as <sys/types.h> does.
#ifndef __BADC_CLOCKID_T
#define __BADC_CLOCKID_T
// The SDK's is an enum of non-negative clocks, unsigned as gcc and clang
// give such an enum.
#ifdef __APPLE__
typedef unsigned int clockid_t;
#else
typedef int clockid_t;
#endif
#endif

// C99 7.23.2: time / clock / mktime return time_t / clock_t. A return
// wider than the declared type is narrowed to it, so an `int` declaration
// truncates: a 64-bit clock() overflows int after ~35 min of CPU time
// (CLOCKS_PER_SEC == 1e6), and time_t past 2038 loses its high half.
// difftime takes two time_t by value; `int` parameters truncate them
// before the subtraction. The time_t pointer parameters likewise carry a
// 64-bit object, not an int.
time_t time(time_t *out);
clock_t clock(void);
int clock_gettime(clockid_t clk_id, struct timespec *ts);
// C17 7.27.2.5: the calendar time in `*ts` for the time base `TIME_UTC`;
// libc/lib/time_ext.c defines it on Windows, whose msvcrt has none.
#define TIME_UTC 1
int timespec_get(struct timespec *ts, int base);
#ifndef __APPLE__
// Suspend until `request` (relative, or absolute under TIMER_ABSTIME);
// `remain` receives the unslept interval on EINTR. libSystem has none.
int clock_nanosleep(clockid_t clk_id, int flags, const struct timespec *request,
                    struct timespec *remain);
#endif
int clock_settime(clockid_t clk_id, const struct timespec *ts);
int clock_getres(clockid_t clk_id, struct timespec *res);
int nanosleep(const struct timespec *req, struct timespec *rem);
#ifdef __BADC_WINDOWS__
// The zone argument is obsolete; mingw-w64 spells it `void *`.
int gettimeofday(struct timeval *restrict tv, void *restrict tz);
#endif
double difftime(time_t t1, time_t t0);
// C99 7.23.2.3: convert broken-down time to a `time_t`. The
// caller's `struct tm` is updated in place (tm_wday / tm_yday and
// any normalization of out-of-range fields). Returns the seconds
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
// POSIX asctime_r: asctime's text in the caller's 26-byte buffer.
char *asctime_r(const struct tm *restrict tm, char *restrict buf);
#endif
// C89 7.12.3.2: static 26-byte timestamp string; not reentrant.
char *ctime(const time_t *t);
// C99 7.23.3.1 asctime.
char *asctime(const struct tm *tm);
#ifdef __linux__
// POSIX: the CPU-time clock of a process.
int clock_getcpuclockid(int pid, clockid_t *clock_id);
#endif
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

#if defined(__APPLE__) || defined(__linux__)
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getdate, "_getdate")
#pragma binding(data libc::getdate_err, "_getdate_err")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getdate, "getdate")
#pragma binding(data libc::getdate_err, "getdate_err")
#endif
// getdate's failure code, 1 to 8 as XSI numbers them.
extern int getdate_err;
struct tm *getdate(const char *string);
#endif

#if defined(__APPLE__) || defined(__linux__)
#ifndef __BADC_LOCALE_T
#define __BADC_LOCALE_T
#ifdef __APPLE__
typedef struct _xlocale *locale_t;
#else
typedef struct __locale_struct *locale_t;
#endif
#endif
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::strftime_l, "_strftime_l")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::strftime_l, "strftime_l")
#endif
size_t strftime_l(char *restrict s, size_t maxsize, const char *restrict format,
                  const struct tm *restrict timeptr, locale_t locale);
#endif
