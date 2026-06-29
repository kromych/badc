/* CoreGraphics slice used by RGFW on macOS: geometry types, display
 * queries, cursor control, and the bitmap-context path for software
 * surfaces. Opaque references are pointers; the framework provides the
 * implementations at link time. */
#ifndef _CORE_GRAPHICS_H
#define _CORE_GRAPHICS_H

#include <stddef.h>
#include <stdint.h>
#include <CoreFoundation/CoreFoundation.h>

typedef double CGFloat;
typedef uint32_t CGDirectDisplayID;
typedef int32_t CGError;
#define kCGErrorSuccess 0
#define CGErrorSuccess 0

typedef struct {
    CGFloat x, y;
} CGPoint;
typedef struct {
    CGFloat width, height;
} CGSize;
typedef struct {
    CGPoint origin;
    CGSize size;
} CGRect;

typedef struct CGContext *CGContextRef;
typedef struct CGColorSpace *CGColorSpaceRef;
typedef struct CGImage *CGImageRef;
typedef struct __CGEvent *CGEventRef;
typedef struct __CGEventSource *CGEventSourceRef;

/* CGImageAlphaInfo values RGFW passes to CGBitmapContextCreate. */
#define kCGImageAlphaPremultipliedLast 1

static CGPoint CGPointMake(CGFloat x, CGFloat y) {
    CGPoint p;
    p.x = x;
    p.y = y;
    return p;
}

CGDirectDisplayID CGMainDisplayID(void);
#define kCGDirectMainDisplay CGMainDisplayID()
CGRect CGDisplayBounds(CGDirectDisplayID display);
size_t CGDisplayPixelsWide(CGDirectDisplayID display);
size_t CGDisplayPixelsHigh(CGDirectDisplayID display);
CGSize CGDisplayScreenSize(CGDirectDisplayID display);
CGError CGDisplayShowCursor(CGDirectDisplayID display);
CGError CGDisplayHideCursor(CGDirectDisplayID display);
CGError CGGetActiveDisplayList(uint32_t maxDisplays,
                              CGDirectDisplayID *activeDisplays,
                              uint32_t *displayCount);
CGError CGWarpMouseCursorPosition(CGPoint newCursorPosition);
CGError CGAssociateMouseAndMouseCursorPosition(int connected);

CGEventRef CGEventCreate(CGEventSourceRef source);
CGPoint CGEventGetLocation(CGEventRef event);

CGContextRef CGBitmapContextCreate(void *data, size_t width, size_t height,
                                   size_t bitsPerComponent, size_t bytesPerRow,
                                   CGColorSpaceRef space, uint32_t bitmapInfo);
CGImageRef CGBitmapContextCreateImage(CGContextRef context);
CGColorSpaceRef CGColorSpaceCreateDeviceRGB(void);
void CGColorSpaceRelease(CGColorSpaceRef space);
void CGContextDrawImage(CGContextRef c, CGRect rect, CGImageRef image);
void CGContextRelease(CGContextRef c);
void CGImageRelease(CGImageRef image);

#endif /* _CORE_GRAPHICS_H */
