// CoreVideo/CVHostTime.h -- the host time base CoreVideo timestamps use.
// macOS only. Prototypes match the macOS SDK header of the same name;
// every entry below is exported by CoreVideo.framework.
//
// The base is the one mach_absolute_time reports, so a value read here
// is comparable with one read through <mach/mach_time.h>.

#pragma once

#include <CoreVideo/CVBase.h>
#include <stdint.h>

#ifdef __APPLE__

#pragma dylib(corevideo, "/System/Library/Frameworks/CoreVideo.framework/CoreVideo")
#pragma binding(corevideo::CVGetCurrentHostTime, "_CVGetCurrentHostTime")
#pragma binding(corevideo::CVGetHostClockFrequency, "_CVGetHostClockFrequency")
#pragma binding(corevideo::CVGetHostClockMinimumTimeDelta, "_CVGetHostClockMinimumTimeDelta")

uint64_t CVGetCurrentHostTime(void);
double   CVGetHostClockFrequency(void);
uint32_t CVGetHostClockMinimumTimeDelta(void);

#endif
