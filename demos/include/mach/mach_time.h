/* mach/mach_time.h -- macOS Mach monotonic clock (minimal subset). */
#ifndef _MACH_MACH_TIME_H
#define _MACH_MACH_TIME_H

#include <stdint.h>

struct mach_timebase_info {
    uint32_t numer;
    uint32_t denom;
};
typedef struct mach_timebase_info *mach_timebase_info_t;
typedef struct mach_timebase_info mach_timebase_info_data_t;

int mach_timebase_info(mach_timebase_info_t info);
uint64_t mach_absolute_time(void);
uint64_t mach_continuous_time(void);

#endif
