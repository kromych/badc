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

// Per-target clockid_t values. POSIX leaves the integer assignments
// implementation-defined and every libc picks its own; the constants
// here must match what the host's `clock_gettime` accepts at runtime,
// otherwise the call returns -1 with errno = EINVAL and the timespec
// is left untouched.
//
//   * Linux / musl: REALTIME=0, MONOTONIC=1 (linux/time.h).
//   * Apple libSystem:   REALTIME=0, MONOTONIC=6 (sys/_types/_clockid_t.h).
//   * Windows: no POSIX `clock_gettime` -- the time.h surface routes
//     through a c5-side shim that internally calls
//     `QueryPerformanceCounter`, so the constant value is opaque to
//     the host and only needs to be self-consistent within c5.
#ifdef __APPLE__
#define CLOCK_REALTIME  0
#define CLOCK_MONOTONIC 6
#else
#define CLOCK_REALTIME  0
#define CLOCK_MONOTONIC 1
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

struct timeval {
    long long tv_sec;
    long long tv_usec;
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
// would put `tm_zone` at offset 40 and read a garbage pointer.
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
    long tm_gmtoff;
    char *tm_zone;
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
#pragma binding(libc::clock_nanosleep, "_clock_nanosleep")
#pragma binding(libc::gettimeofday,  "_gettimeofday")
#pragma binding(libc::difftime,      "_difftime")
#pragma binding(libc::mktime,        "_mktime")
#pragma binding(libc::localtime,     "_localtime")
#pragma binding(libc::localtime_r,   "_localtime_r")
#pragma binding(libc::gmtime,        "_gmtime")
#pragma binding(libc::gmtime_r,      "_gmtime_r")
#pragma binding(libc::ctime_r,       "_ctime_r")
#pragma binding(libc::strftime,      "_strftime")
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
#pragma binding(libc::gettimeofday,  "gettimeofday")
#pragma binding(libc::difftime,      "difftime")
#pragma binding(libc::mktime,        "mktime")
#pragma binding(libc::localtime,     "localtime")
#pragma binding(libc::localtime_r,   "localtime_r")
#pragma binding(libc::gmtime,        "gmtime")
#pragma binding(libc::gmtime_r,      "gmtime_r")
#pragma binding(libc::ctime_r,       "ctime_r")
#pragma binding(libc::strftime,      "strftime")
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
#pragma binding(msvcrt::strftime, "strftime")
#pragma binding(msvcrt::tzset,    "_tzset")
// Windows doesn't ship POSIX `clock_gettime` / `gettimeofday`. SQLite
// has its own Win32-specific code path that calls
// `GetSystemTimeAsFileTime`; programs that want a portable shape
// either #ifdef _WIN32 themselves or use the kernel32 surface.
#endif

// C99 7.23.2: time / clock / mktime return time_t / clock_t, which are
// 64-bit. A return wider than the declared type is narrowed to it, so an
// `int` declaration truncates: clock() overflows int after ~35 min of CPU
// time (CLOCKS_PER_SEC == 1e6), and time_t past 2038 loses its high half.
// difftime takes two time_t by value; `int` parameters truncate them
// before the subtraction. The time_t pointer parameters likewise carry a
// 64-bit object, not an int.
time_t time(time_t *out);
clock_t clock();
int clock_gettime(int clk_id, struct timespec *ts);
// Suspend until `request` (relative, or absolute under TIMER_ABSTIME);
// `remain` receives the unslept interval on EINTR.
int clock_nanosleep(int clk_id, int flags, struct timespec *request,
                    struct timespec *remain);
int clock_settime(int clk_id, const struct timespec *ts);
int clock_getres(int clk_id, struct timespec *res);
int gettimeofday(struct timeval *tv, char *tz);
double difftime(time_t t1, time_t t0);
// C99 7.23.2.3: convert broken-down time to a `time_t`. The
// caller's `struct tm` is updated in place (tm_wday / tm_yday and
// any normalisation of out-of-range fields). Returns the seconds
// count or (time_t)-1 on failure.
time_t mktime(struct tm *tm);
struct tm *localtime(time_t *t);
struct tm *localtime_r(time_t *t, struct tm *result);
struct tm *gmtime(time_t *t);
struct tm *gmtime_r(time_t *t, struct tm *result);
// POSIX `ctime_r` -- 26-byte timestamp string written into the
// caller's buffer; returns the buffer pointer or NULL on error.
char *ctime_r(time_t *t, char *buf);
int strftime(char *buf, int max, char *fmt, struct tm *tm);
// POSIX 7.24.1: initialize the timezone conversion state from the TZ
// environment variable (or the system default). No arguments, no result.
void tzset(void);
// POSIX `tzset` outputs: the two timezone-abbreviation strings (standard
// and daylight), the seconds west of UTC, and a daylight-saving flag.
extern char *tzname[2];
extern long timezone;
extern int daylight;
