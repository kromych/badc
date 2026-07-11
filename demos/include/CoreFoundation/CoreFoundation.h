/* CoreFoundation slice used by RGFW on macOS: CFString / CFBundle /
 * CFURL handles for loading GL entry points and resolving the resource
 * directory. Opaque CF*Ref handles are pointers; the framework provides
 * the bodies at link time. CFSTR creates the string at runtime rather
 * than via the clang constant-string builtin a from-scratch compiler
 * does not provide. */
#ifndef _CORE_FOUNDATION_H
#define _CORE_FOUNDATION_H

#include <stdint.h>
#include <stdbool.h>

typedef const void *CFTypeRef;
typedef struct __CFString *CFStringRef;
typedef struct __CFBundle *CFBundleRef;
typedef struct __CFURL *CFURLRef;
typedef struct __CFAllocator *CFAllocatorRef;
typedef struct __CFArray *CFArrayRef;
typedef struct __CFDictionary *CFDictionaryRef;
typedef struct __CFDictionary *CFMutableDictionaryRef;
typedef struct __CFNumber *CFNumberRef;
typedef struct __CFRunLoop *CFRunLoopRef;
typedef struct __CFData *CFDataRef;
typedef uint32_t CFStringEncoding;
typedef int CFComparisonResult;
typedef unsigned char Boolean;
typedef long CFIndex;
typedef unsigned long CFTypeID;
typedef CFIndex CFNumberType;
typedef double CFTimeInterval;

/* CFDictionaryCreateMutable takes the address of the framework's key/value
 * callback structs; the code never inspects the members, so opaque fields
 * suffice while the extern const symbols resolve at link. */
typedef struct {
    CFIndex version;
    void *retain;
    void *release;
    void *copyDescription;
    void *equal;
    void *hash;
} CFDictionaryKeyCallBacks;
typedef struct {
    CFIndex version;
    void *retain;
    void *release;
    void *copyDescription;
    void *equal;
} CFDictionaryValueCallBacks;

#define kCFAllocatorDefault ((CFAllocatorRef)0)
#define kCFStringEncodingASCII 0x0600
#define kCFStringEncodingUTF8 0x08000100
#define kCFCompareEqualTo 0

/* CFNumberType values (CFNumber.h). */
#define kCFNumberSInt32Type 3
#define kCFNumberIntType 9

extern const CFStringRef kCFRunLoopDefaultMode;
extern const CFDictionaryKeyCallBacks kCFTypeDictionaryKeyCallBacks;
extern const CFDictionaryValueCallBacks kCFTypeDictionaryValueCallBacks;

void CFRelease(CFTypeRef cf);
CFTypeID CFGetTypeID(CFTypeRef cf);
CFIndex CFArrayGetCount(CFArrayRef theArray);
const void *CFArrayGetValueAtIndex(CFArrayRef theArray, CFIndex idx);
CFMutableDictionaryRef CFDictionaryCreateMutable(
    CFAllocatorRef allocator, CFIndex capacity,
    const CFDictionaryKeyCallBacks *keyCallBacks,
    const CFDictionaryValueCallBacks *valueCallBacks);
void CFDictionarySetValue(CFMutableDictionaryRef theDict, const void *key,
                          const void *value);
CFNumberRef CFNumberCreate(CFAllocatorRef allocator, CFNumberType theType,
                           const void *valuePtr);
Boolean CFNumberGetValue(CFNumberRef number, CFNumberType theType,
                         void *valuePtr);
CFRunLoopRef CFRunLoopGetCurrent(void);
int32_t CFRunLoopRunInMode(CFStringRef mode, CFTimeInterval seconds,
                           Boolean returnAfterSourceHandled);
CFStringRef CFStringCreateWithCString(CFAllocatorRef alloc, const char *cStr,
                                      CFStringEncoding encoding);
CFComparisonResult CFStringCompare(CFStringRef s1, CFStringRef s2,
                                   unsigned long compareOptions);
CFBundleRef CFBundleGetMainBundle(void);
CFBundleRef CFBundleGetBundleWithIdentifier(CFStringRef bundleID);
void *CFBundleGetFunctionPointerForName(CFBundleRef bundle,
                                        CFStringRef functionName);
void *CFBundleGetDataPointerForName(CFBundleRef bundle, CFStringRef symbolName);
const uint8_t *CFDataGetBytePtr(CFDataRef theData);
CFURLRef CFBundleCopyResourcesDirectoryURL(CFBundleRef bundle);
Boolean CFURLGetFileSystemRepresentation(CFURLRef url, Boolean resolveAgainstBase,
                                         unsigned char *buffer, CFIndex maxBufLen);
CFStringRef CFURLCopyLastPathComponent(CFURLRef url);
Boolean CFStringGetCString(CFStringRef theString, char *buffer, CFIndex bufferSize,
                           CFStringEncoding encoding);
CFIndex CFStringGetLength(CFStringRef theString);

#define CFSTR(s) CFStringCreateWithCString(kCFAllocatorDefault, (s), kCFStringEncodingASCII)

#endif /* _CORE_FOUNDATION_H */
