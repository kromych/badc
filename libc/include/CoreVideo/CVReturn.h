// CoreVideo/CVReturn.h -- the CoreVideo status codes. macOS only.
// Values match the macOS SDK header of the same name, including the
// _CVReturn tag the SDK gives the constant set in C.

#pragma once

#include <CoreVideo/CVBase.h>
#include <stdint.h>

#ifdef __APPLE__

typedef int32_t CVReturn;

enum _CVReturn {
    kCVReturnSuccess = 0,

    kCVReturnFirst = -6660,

    kCVReturnError = kCVReturnFirst,
    kCVReturnInvalidArgument = -6661,
    kCVReturnAllocationFailed = -6662,
    kCVReturnUnsupported = -6663,

    kCVReturnInvalidDisplay = -6670,
    kCVReturnDisplayLinkAlreadyRunning = -6671,
    kCVReturnDisplayLinkNotRunning = -6672,
    kCVReturnDisplayLinkCallbacksNotSet = -6673,

    kCVReturnInvalidPixelFormat = -6680,
    kCVReturnInvalidSize = -6681,
    kCVReturnInvalidPixelBufferAttributes = -6682,
    kCVReturnPixelBufferNotOpenGLCompatible = -6683,
    kCVReturnPixelBufferNotMetalCompatible = -6684,

    kCVReturnWouldExceedAllocationThreshold = -6689,
    kCVReturnPoolAllocationFailed = -6690,
    kCVReturnInvalidPoolAttributes = -6691,
    kCVReturnRetry = -6692,

    kCVReturnLast = -6699
};

#endif
