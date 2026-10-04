// <time.h>'s POSIX clocks, sleeps and reentrant conversions on the Windows
// targets, which mingw-w64 declares and msvcrt does not define. They are
// defined over kernel32 as winpthreads and mingwex define them: realtime
// from the system time, monotonic from the performance counter, the CPU-time
// clocks from the kernel and user times of the process or thread. The file
// compiles to nothing elsewhere; the native-link driver offers it like an
// archive member.

#ifdef _WIN32

#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <windows.h>

// FILETIME counts 100 ns ticks from 1601-01-01; the Unix epoch is this
// many ticks later.
#define EPOCH_TICKS 116444736000000000LL
#define TICKS_PER_SEC 10000000LL
#define NS_PER_SEC 1000000000LL

static long long ticks_of(FILETIME t) {
    return (long long)((unsigned long long)t.dwHighDateTime << 32 | t.dwLowDateTime);
}

static void timespec_of(long long ticks, struct timespec *ts) {
    ts->tv_sec = ticks / TICKS_PER_SEC;
    ts->tv_nsec = ticks % TICKS_PER_SEC * 100;
}

int clock_gettime(clockid_t clk_id, struct timespec *ts) {
    FILETIME created, exited, kernel, user;
    LARGE_INTEGER count, freq;
    switch (clk_id) {
    case CLOCK_REALTIME:
        GetSystemTimePreciseAsFileTime(&user);
        timespec_of(ticks_of(user) - EPOCH_TICKS, ts);
        return 0;
    case CLOCK_REALTIME_COARSE:
        GetSystemTimeAsFileTime(&user);
        timespec_of(ticks_of(user) - EPOCH_TICKS, ts);
        return 0;
    case CLOCK_MONOTONIC:
        QueryPerformanceFrequency(&freq);
        QueryPerformanceCounter(&count);
        ts->tv_sec = count.QuadPart / freq.QuadPart;
        ts->tv_nsec = count.QuadPart % freq.QuadPart * NS_PER_SEC / freq.QuadPart;
        return 0;
    case CLOCK_PROCESS_CPUTIME_ID:
        if (GetProcessTimes(GetCurrentProcess(), &created, &exited, &kernel, &user)) {
            timespec_of(ticks_of(kernel) + ticks_of(user), ts);
            return 0;
        }
        break;
    case CLOCK_THREAD_CPUTIME_ID:
        if (GetThreadTimes(GetCurrentThread(), &created, &exited, &kernel, &user)) {
            timespec_of(ticks_of(kernel) + ticks_of(user), ts);
            return 0;
        }
        break;
    }
    errno = EINVAL;
    return -1;
}

int clock_getres(clockid_t clk_id, struct timespec *res) {
    LARGE_INTEGER freq;
    DWORD adjustment, increment;
    BOOL disabled;
    switch (clk_id) {
    case CLOCK_REALTIME:
    case CLOCK_MONOTONIC:
        // The precise system time and the counter tick at the counter's
        // frequency.
        QueryPerformanceFrequency(&freq);
        res->tv_sec = 0;
        res->tv_nsec = (NS_PER_SEC + freq.QuadPart - 1) / freq.QuadPart;
        return 0;
    case CLOCK_REALTIME_COARSE:
    case CLOCK_PROCESS_CPUTIME_ID:
    case CLOCK_THREAD_CPUTIME_ID:
        // These advance once per scheduler tick.
        if (!GetSystemTimeAdjustment(&adjustment, &increment, &disabled)) {
            break;
        }
        res->tv_sec = 0;
        res->tv_nsec = (long long)increment * 100;
        return 0;
    }
    errno = EINVAL;
    return -1;
}

int clock_settime(clockid_t clk_id, const struct timespec *ts) {
    long long ticks;
    FILETIME ft;
    SYSTEMTIME st;
    if (clk_id != CLOCK_REALTIME || ts->tv_nsec < 0 || ts->tv_nsec >= NS_PER_SEC) {
        errno = EINVAL;
        return -1;
    }
    ticks = ts->tv_sec * TICKS_PER_SEC + ts->tv_nsec / 100 + EPOCH_TICKS;
    ft.dwLowDateTime = (DWORD)ticks;
    ft.dwHighDateTime = (DWORD)((unsigned long long)ticks >> 32);
    if (!FileTimeToSystemTime(&ft, &st)) {
        errno = EINVAL;
        return -1;
    }
    if (!SetSystemTime(&st)) {
        errno = EPERM;
        return -1;
    }
    return 0;
}

// Sleep for at least `req`, rounded up to the millisecond Sleep counts in;
// no signal interrupts it, so `rem` is never written.
int nanosleep(const struct timespec *req, struct timespec *rem) {
    long long ms;
    (void)rem;
    if (req->tv_sec < 0 || req->tv_nsec < 0 || req->tv_nsec >= NS_PER_SEC) {
        errno = EINVAL;
        return -1;
    }
    ms = req->tv_sec * 1000 + (req->tv_nsec + 999999) / 1000000;
    while (ms > 0) {
        // INFINITE (0xFFFFFFFF) is not a duration.
        DWORD part = ms > 0x7FFFFFFF ? 0x7FFFFFFF : (DWORD)ms;
        Sleep(part);
        ms -= part;
    }
    return 0;
}

// POSIX returns the error number itself rather than setting errno.
int clock_nanosleep(clockid_t clk_id, int flags, const struct timespec *req,
                    struct timespec *rem) {
    struct timespec now, left;
    if (clk_id != CLOCK_REALTIME && clk_id != CLOCK_MONOTONIC) {
        return EINVAL;
    }
    if (req->tv_nsec < 0 || req->tv_nsec >= NS_PER_SEC) {
        return EINVAL;
    }
    if (!(flags & TIMER_ABSTIME)) {
        return nanosleep(req, rem) ? errno : 0;
    }
    clock_gettime(clk_id, &now);
    left.tv_sec = req->tv_sec - now.tv_sec;
    left.tv_nsec = req->tv_nsec - now.tv_nsec;
    if (left.tv_nsec < 0) {
        left.tv_nsec += NS_PER_SEC;
        left.tv_sec--;
    }
    // A time already past returns at once.
    if (left.tv_sec < 0) {
        return 0;
    }
    return nanosleep(&left, NULL) ? errno : 0;
}

int gettimeofday(struct timeval *restrict tv, void *restrict tz) {
    FILETIME now;
    long long ticks;
    (void)tz;
    GetSystemTimePreciseAsFileTime(&now);
    ticks = ticks_of(now) - EPOCH_TICKS;
    tv->tv_sec = (long)(ticks / TICKS_PER_SEC);
    tv->tv_usec = (long)(ticks % TICKS_PER_SEC / 10);
    return 0;
}

// msvcrt keeps localtime's, gmtime's and ctime's results per thread, so a
// copy taken at once is the caller's alone.
struct tm *localtime_r(const time_t *t, struct tm *result) {
    struct tm *p = localtime(t);
    if (!p) {
        return NULL;
    }
    *result = *p;
    return result;
}

struct tm *gmtime_r(const time_t *t, struct tm *result) {
    struct tm *p = gmtime(t);
    if (!p) {
        return NULL;
    }
    *result = *p;
    return result;
}

char *ctime_r(const time_t *t, char *buf) {
    char *p = ctime(t);
    if (!p) {
        return NULL;
    }
    // ctime's text is the 26 bytes of "Www Mmm dd hh:mm:ss yyyy\n\0".
    memcpy(buf, p, 26);
    return buf;
}

#endif
