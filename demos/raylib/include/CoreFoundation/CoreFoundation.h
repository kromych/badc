/* CoreFoundation slice used by RGFW on macOS: CFString / CFBundle /
 * CFURL handles for loading GL entry points and resolving the resource
 * directory. Opaque CF*Ref handles are pointers; the framework provides
 * the bodies at link time. CFSTR creates the string at runtime rather
 * than via the clang constant-string builtin a from-scratch compiler
 * does not provide. */
#ifndef _CORE_FOUNDATION_H
#define _CORE_FOUNDATION_H

#include <stdint.h>

typedef const void *CFTypeRef;
typedef struct __CFString *CFStringRef;
typedef struct __CFBundle *CFBundleRef;
typedef struct __CFURL *CFURLRef;
typedef struct __CFAllocator *CFAllocatorRef;
typedef uint32_t CFStringEncoding;
typedef int CFComparisonResult;
typedef unsigned char Boolean;
typedef long CFIndex;

#define kCFAllocatorDefault ((CFAllocatorRef)0)
#define kCFStringEncodingASCII 0x0600
#define kCFStringEncodingUTF8 0x08000100
#define kCFCompareEqualTo 0

extern const CFStringRef kCFRunLoopDefaultMode;

void CFRelease(CFTypeRef cf);
CFStringRef CFStringCreateWithCString(CFAllocatorRef alloc, const char *cStr,
                                      CFStringEncoding encoding);
CFComparisonResult CFStringCompare(CFStringRef s1, CFStringRef s2,
                                   unsigned long compareOptions);
CFBundleRef CFBundleGetMainBundle(void);
CFBundleRef CFBundleGetBundleWithIdentifier(CFStringRef bundleID);
void *CFBundleGetFunctionPointerForName(CFBundleRef bundle,
                                        CFStringRef functionName);
CFURLRef CFBundleCopyResourcesDirectoryURL(CFBundleRef bundle);
Boolean CFURLGetFileSystemRepresentation(CFURLRef url, Boolean resolveAgainstBase,
                                         unsigned char *buffer, CFIndex maxBufLen);
CFStringRef CFURLCopyLastPathComponent(CFURLRef url);
Boolean CFStringGetCString(CFStringRef theString, char *buffer, CFIndex bufferSize,
                           CFStringEncoding encoding);
CFIndex CFStringGetLength(CFStringRef theString);

#define CFSTR(s) CFStringCreateWithCString(kCFAllocatorDefault, (s), kCFStringEncodingASCII)

#endif /* _CORE_FOUNDATION_H */
