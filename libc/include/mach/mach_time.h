// mach/mach_time.h -- macOS Mach monotonic clock.
//
// The Mach absolute-time counter and the timebase ratio that converts
// its ticks to nanoseconds. macOS only; libSystem supplies the symbols.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mach_absolute_time, "_mach_absolute_time")
#pragma binding(libc::mach_timebase_info, "_mach_timebase_info")

typedef struct {
    unsigned int numer;
    unsigned int denom;
} mach_timebase_info_data_t;

unsigned long long mach_absolute_time(void);
int mach_timebase_info(mach_timebase_info_data_t *info);
#endif
