/* CoreVideo display-link API. RGFW uses it to drive a vsync callback.
 * The time and status types come from the bundled <CoreVideo/CVBase.h>
 * and <CoreVideo/CVReturn.h>; only the declarations that need a
 * CoreGraphics type live here. */
#ifndef _CV_DISPLAY_LINK_H
#define _CV_DISPLAY_LINK_H

#include <CoreGraphics/CoreGraphics.h>
#include <CoreVideo/CVBase.h>
#include <CoreVideo/CVReturn.h>

typedef struct __CVDisplayLink *CVDisplayLinkRef;

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
