/* Minimal Apple CoreFoundation surface (<CoreFoundation/CoreFoundation.h>).
** Opaque CF*Ref handles are pointers; libSystem provides the runtime.
** Only the types and calls the bundled demos reference are declared. */
#pragma once

#ifdef __APPLE__

typedef const void *CFTypeRef;
typedef struct __CFString *CFStringRef;
typedef struct __CFDictionary *CFDictionaryRef;
typedef struct __CFAllocator *CFAllocatorRef;
typedef long CFIndex;
typedef unsigned long CFTypeID;

#pragma dylib(corefoundation, "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
#pragma binding(corefoundation::CFRelease,   "_CFRelease")
#pragma binding(corefoundation::CFRetain,    "_CFRetain")
#pragma binding(corefoundation::CFGetTypeID, "_CFGetTypeID")

void CFRelease(CFTypeRef cf);
CFTypeRef CFRetain(CFTypeRef cf);
CFTypeID CFGetTypeID(CFTypeRef cf);

#endif
