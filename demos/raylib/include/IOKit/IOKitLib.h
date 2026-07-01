/* IOKit base slice used by RGFW's minigamepad backend on macOS. The HID
 * gamepad code reaches IOKit only through the IOHIDManager API and Core
 * Foundation; this header supplies the scalar IOKit types those calls
 * take and pulls in the CoreFoundation handles they share. */
#ifndef _IOKIT_LIB_H
#define _IOKIT_LIB_H

#include <stdint.h>
#include <CoreFoundation/CoreFoundation.h>

typedef int IOReturn;
typedef int kern_return_t;
typedef uint32_t IOOptionBits;
typedef uint32_t mach_port_t;
typedef mach_port_t io_object_t;
typedef io_object_t io_iterator_t;
typedef io_object_t io_service_t;
typedef io_object_t io_registry_entry_t;

#define kNilOptions 0
/* The default main port is the null mach port; the framework resolves it. */
#define kIOMainPortDefault 0

kern_return_t IOServiceGetMatchingServices(mach_port_t mainPort,
                                           CFDictionaryRef matching,
                                           io_iterator_t *existing);
CFMutableDictionaryRef IOServiceMatching(const char *name);
io_object_t IOIteratorNext(io_iterator_t iterator);
CFTypeRef IORegistryEntryCreateCFProperty(io_registry_entry_t entry,
                                          CFStringRef key,
                                          CFAllocatorRef allocator,
                                          IOOptionBits options);
kern_return_t IOObjectRelease(io_object_t object);

#endif /* _IOKIT_LIB_H */
