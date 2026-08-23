// CoreVideo/CVBase.h -- the CoreVideo time and SMPTE types. macOS only.
// Field layout and constant values match the macOS SDK header of the
// same name.
//
// The SDK writes each constant set as CF_ENUM / CF_OPTIONS, which in C
// expand to the value type as a typedef plus an unnamed enum holding
// the constants. The forms below are that expansion.
//
// kCVZeroTime and kCVIndefiniteTime are data exports of the framework
// and are not declared. The COREVIDEO_SUPPORTS_* configuration macros
// are left out: they gate the SDK umbrella over the OpenGL, Metal and
// Direct3D headers, which this set does not carry.

#pragma once

#include <stdint.h>

#ifdef __APPLE__

typedef uint64_t CVOptionFlags;

struct CVSMPTETime {
    int16_t  subframes;
    int16_t  subframeDivisor;
    uint32_t counter;
    uint32_t type;
    uint32_t flags;
    int16_t  hours;
    int16_t  minutes;
    int16_t  seconds;
    int16_t  frames;
};
typedef struct CVSMPTETime CVSMPTETime;

typedef uint32_t CVSMPTETimeType;
enum {
    kCVSMPTETimeType24 = 0,
    kCVSMPTETimeType25 = 1,
    kCVSMPTETimeType30Drop = 2,
    kCVSMPTETimeType30 = 3,
    kCVSMPTETimeType2997 = 4,
    kCVSMPTETimeType2997Drop = 5,
    kCVSMPTETimeType60 = 6,
    kCVSMPTETimeType5994 = 7
};

typedef uint32_t CVSMPTETimeFlags;
enum {
    kCVSMPTETimeValid = (1L << 0),
    kCVSMPTETimeRunning = (1L << 1)
};

typedef int32_t CVTimeFlags;
enum { kCVTimeIsIndefinite = 1 << 0 };

typedef struct {
    int64_t timeValue;
    int32_t timeScale;
    int32_t flags;
} CVTime;

// version selects the layout the framework fills in; 0 is the only one
// defined. hostTime shares the Mach absolute time base that
// mach_absolute_time reports.
typedef struct {
    uint32_t    version;
    int32_t     videoTimeScale;
    int64_t     videoTime;
    uint64_t    hostTime;
    double      rateScalar;
    int64_t     videoRefreshPeriod;
    CVSMPTETime smpteTime;
    uint64_t    flags;
    uint64_t    reserved;
} CVTimeStamp;

typedef uint64_t CVTimeStampFlags;
enum {
    kCVTimeStampVideoTimeValid = (1L << 0),
    kCVTimeStampHostTimeValid = (1L << 1),
    kCVTimeStampSMPTETimeValid = (1L << 2),
    kCVTimeStampVideoRefreshPeriodValid = (1L << 3),
    kCVTimeStampRateScalarValid = (1L << 4),

    kCVTimeStampTopField = (1L << 16),
    kCVTimeStampBottomField = (1L << 17),

    kCVTimeStampVideoHostTimeValid =
        (kCVTimeStampVideoTimeValid | kCVTimeStampHostTimeValid),
    kCVTimeStampIsInterlaced = (kCVTimeStampTopField | kCVTimeStampBottomField)
};

#endif
