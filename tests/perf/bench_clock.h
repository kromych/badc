// Monotonic wall clock for the perf fixtures: milliseconds from an
// arbitrary origin, so only a difference of two readings means anything.
// Windows has no clock_gettime; its high-resolution counter stands in.

#ifndef BENCH_CLOCK_H
#define BENCH_CLOCK_H

#if defined(_WIN32)
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#ifndef NOMINMAX
#define NOMINMAX
#endif
#include <windows.h>

static double bench_ms(void)
{
    LARGE_INTEGER freq, now;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&now);
    return (double)now.QuadPart * 1000.0 / (double)freq.QuadPart;
}
#else
#include <time.h>

static double bench_ms(void)
{
    struct timespec now;
    clock_gettime(CLOCK_MONOTONIC, &now);
    return (double)now.tv_sec * 1000.0 + (double)now.tv_nsec / 1000000.0;
}
#endif

#endif
