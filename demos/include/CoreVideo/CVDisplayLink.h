/* CoreVideo display-link API. RGFW uses it to drive a vsync callback;
 * the timestamp structs are opaque to the caller (only pointers are
 * passed through the callback). */
#ifndef _CV_DISPLAY_LINK_H
#define _CV_DISPLAY_LINK_H

#include <CoreGraphics/CoreGraphics.h>
#include <stdint.h>

typedef struct __CVDisplayLink *CVDisplayLinkRef;
typedef int32_t CVReturn;
typedef uint64_t CVOptionFlags;

#define kCVReturnSuccess 0

typedef struct {
    int32_t version;
    int32_t flags;
    int64_t hostTime;
    double rateScalar;
    int64_t videoTime;
    int64_t videoRefreshPeriod;
    int32_t smpteTime[8];
    uint64_t reserved[2];
} CVTimeStamp;

typedef CVReturn (*CVDisplayLinkOutputCallback)(
    CVDisplayLinkRef displayLink, const CVTimeStamp *inNow,
    const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn,
    CVOptionFlags *flagsOut, void *displayLinkContext);

CVReturn CVDisplayLinkCreateWithCGDisplay(CGDirectDisplayID displayID,
                                          CVDisplayLinkRef *displayLinkOut);
CVReturn CVDisplayLinkSetOutputCallback(CVDisplayLinkRef displayLink,
                                        CVDisplayLinkOutputCallback callback,
                                        void *userInfo);
CVReturn CVDisplayLinkStart(CVDisplayLinkRef displayLink);
CVReturn CVDisplayLinkStop(CVDisplayLinkRef displayLink);
void CVDisplayLinkRelease(CVDisplayLinkRef displayLink);

#endif /* _CV_DISPLAY_LINK_H */
