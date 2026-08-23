// mach/mach_time.h -- macOS Mach monotonic clocks.
//
// The absolute- and continuous-time counters and the timebase ratio that
// converts their ticks to nanoseconds. macOS only; libSystem supplies
// the symbols. Declarations match the macOS SDK header of the same name,
// with kern_return_t spelled as the int it is a typedef for so this
// header stays independent of <mach/mach.h>.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mach_absolute_time, "_mach_absolute_time")
#pragma binding(libc::mach_approximate_time, "_mach_approximate_time")
#pragma binding(libc::mach_continuous_time, "_mach_continuous_time")
#pragma binding(libc::mach_continuous_approximate_time, "_mach_continuous_approximate_time")
#pragma binding(libc::mach_timebase_info, "_mach_timebase_info")
#pragma binding(libc::mach_wait_until, "_mach_wait_until")

struct mach_timebase_info {
    unsigned int numer;
    unsigned int denom;
};
typedef struct mach_timebase_info *mach_timebase_info_t;
typedef struct mach_timebase_info  mach_timebase_info_data_t;

int mach_timebase_info(mach_timebase_info_t info);
int mach_wait_until(unsigned long long deadline);

unsigned long long mach_absolute_time(void);
unsigned long long mach_approximate_time(void);
// Continuous time keeps counting across system sleep.
unsigned long long mach_continuous_time(void);
unsigned long long mach_continuous_approximate_time(void);
#endif
