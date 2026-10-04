// The POSIX clocks, sleeps and reentrant time conversions: on Windows those
// libc/lib/time_ext.c defines over kernel32, elsewhere the C library's.
// Every clock reads a normalised time, the realtime clock and gettimeofday
// agree with time(), the monotonic clock never goes back and covers a
// sleep, the process CPU clock advances under work, each clock has a
// resolution, and a bad clock or interval is EINVAL. libSystem has no
// clock_nanosleep. Windows declares the reentrant conversions only under
// _POSIX_C_SOURCE defined before the first include, so they are checked
// where the headers declare them. The exit code names the first check that
// fails.
#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>

static long long ms_of(struct timespec t) { return t.tv_sec * 1000LL + t.tv_nsec / 1000000; }

static int normal(struct timespec t) { return t.tv_sec >= 0 && t.tv_nsec >= 0 && t.tv_nsec < 1000000000; }

int main(void) {
    static const clockid_t ids[] = {CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_PROCESS_CPUTIME_ID,
                                    CLOCK_THREAD_CPUTIME_ID};
    struct timespec t, u, res, nap = {0, 20000000};
    struct timeval tv;
    time_t now;
    volatile unsigned spin = 0;

    for (int i = 0; i < 4; i++) {
        if (clock_gettime(ids[i], &t) != 0 || !normal(t)) return 10 + i;
        if (clock_getres(ids[i], &res) != 0 || !normal(res)) return 20 + i;
        if (res.tv_sec == 0 && res.tv_nsec == 0) return 30 + i;
    }
    now = time(NULL);
    if (clock_gettime(CLOCK_REALTIME, &t) != 0 || t.tv_sec < now - 5 || t.tv_sec > now + 5) return 2;
    if (gettimeofday(&tv, NULL) != 0 || tv.tv_sec < now - 5 || tv.tv_sec > now + 5) return 3;
    if (tv.tv_usec < 0 || tv.tv_usec >= 1000000) return 4;

    // A sleep lasts at least its interval on the monotonic clock.
    clock_gettime(CLOCK_MONOTONIC, &t);
    if (nanosleep(&nap, NULL) != 0) return 5;
    clock_gettime(CLOCK_MONOTONIC, &u);
    if (ms_of(u) - ms_of(t) < 20) return 6;
#ifndef __APPLE__
    t = u;
    if (clock_nanosleep(CLOCK_MONOTONIC, 0, &nap, NULL) != 0) return 7;
    u.tv_nsec += 30000000;
    if (u.tv_nsec >= 1000000000) {
        u.tv_nsec -= 1000000000;
        u.tv_sec++;
    }
    if (clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &u, NULL) != 0) return 8;
    clock_gettime(CLOCK_MONOTONIC, &t);
    if (ms_of(t) < ms_of(u)) return 9;
    if (clock_nanosleep(-1, 0, &nap, NULL) != EINVAL) return 40;
#endif

    // Work advances the process's CPU clock; the loop stops at the first
    // tick, or after five seconds of the monotonic clock.
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t);
    clock_gettime(CLOCK_MONOTONIC, &nap);
    for (;;) {
        for (int i = 0; i < 100000; i++) spin = spin + 1;
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &u);
        if (u.tv_sec != t.tv_sec || u.tv_nsec != t.tv_nsec) break;
        clock_gettime(CLOCK_MONOTONIC, &res);
        if (ms_of(res) - ms_of(nap) > 5000) return 41;
    }

    errno = 0;
    if (clock_gettime(-1, &t) != -1 || errno != EINVAL) return 42;
    nap.tv_sec = 0;
    nap.tv_nsec = 1000000000;
    errno = 0;
    if (nanosleep(&nap, NULL) != -1 || errno != EINVAL) return 43;

#if !defined(_WIN32) || defined(_POSIX_THREAD_SAFE_FUNCTIONS)
    // The reentrant conversions copy what the static ones return.
    struct tm a, b;
    char text[26];
    now = 86400 * 365;
    if (!gmtime_r(&now, &a) || a.tm_year != 71 || a.tm_mon != 0 || a.tm_mday != 1) return 50;
    if (a.tm_hour != 0 || a.tm_yday != 0) return 51;
    now = time(NULL);
    if (!localtime_r(&now, &a)) return 52;
    b = *localtime(&now);
    if (a.tm_sec != b.tm_sec || a.tm_min != b.tm_min || a.tm_hour != b.tm_hour) return 53;
    if (a.tm_mday != b.tm_mday || a.tm_year != b.tm_year || a.tm_isdst != b.tm_isdst) return 54;
    if (!ctime_r(&now, text) || strcmp(text, ctime(&now)) != 0) return 55;
#endif
    return 0;
}
