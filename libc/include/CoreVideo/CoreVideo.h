// CoreVideo/CoreVideo.h -- umbrella for the CoreVideo framework. macOS
// only. Carries the parts of the SDK umbrella that stand on stdint
// alone plus the host-time calls, which take and return nothing beyond
// it.
//
// Left out, each needing a type or a framework export this set does not
// carry:
//
//   CVDisplayLink.h  -- CGDirectDisplayID, CGOpenGLDisplayMask,
//                       CGLContextObj, CFTypeID and Boolean, from
//                       CoreGraphics, OpenGL and MacTypes.
//   CVBuffer.h       -- attachment keys are CFStringRef data exports and
//                       the accessors take CFDictionaryRef.
//   CVImageBuffer.h, CVPixelBuffer.h, CVPixelBufferPool.h,
//   CVPixelFormatDescription.h
//                    -- same CFStringRef attribute-key surface; the
//                       pixel-format constants are multi-character
//                       character constants, whose value C99 leaves
//                       implementation-defined.
//   CVOpenGL*.h, CVMetal*.h, CVDirect3D*.h
//                    -- OpenGL, Metal and Direct3D handle types.
//
// A program can therefore build a CVTimeStamp, read the host clock and
// test a CVReturn. No other CoreVideo entry point is declared, so a call
// to one is rejected rather than bound to a stand-in.

#pragma once

#include <CoreVideo/CVBase.h>
#include <CoreVideo/CVHostTime.h>
#include <CoreVideo/CVReturn.h>
