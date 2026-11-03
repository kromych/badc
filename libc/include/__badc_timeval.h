// __badc_timeval.h -- `struct timeval` on Linux and macOS, for <sys/time.h>,
// <sys/select.h> and <sys/resource.h>; <time.h> defines none, as neither
// glibc's nor the macOS SDK's does. The guard is the C library's own (glibc's
// bits/types/struct_timeval.h, the SDK's sys/_types/_timeval.h), so the struct
// is defined once whichever header comes first. Windows takes it from
// <_timeval.h>.

#if defined(__APPLE__)
// Darwin's `tv_usec` is `__darwin_suseconds_t` (`__int32_t`), not a 64-bit
// field as on Linux; gettimeofday and select write only its 4 bytes.
#ifndef _STRUCT_TIMEVAL
#define _STRUCT_TIMEVAL struct timeval
struct timeval {
    long tv_sec;
    int tv_usec;
};
#endif
#elif !defined(_WIN32)
#ifndef __timeval_defined
#define __timeval_defined 1
struct timeval {
    long tv_sec;
    long tv_usec;
};
#endif
#endif
