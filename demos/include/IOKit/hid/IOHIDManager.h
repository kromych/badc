/* IOHIDManager slice used by RGFW's minigamepad backend on macOS. Declares
 * the opaque HID handles, the device/element/value accessors, the manager
 * matching + callback registration API, and the device property-key strings
 * the backend reads. The framework supplies the bodies at link. */
#ifndef _IOKIT_HID_IOHIDMANAGER_H
#define _IOKIT_HID_IOHIDMANAGER_H

#include <stdint.h>
#include <IOKit/IOKitLib.h>

typedef struct __IOHIDManager *IOHIDManagerRef;
typedef struct __IOHIDDevice  *IOHIDDeviceRef;
typedef struct __IOHIDElement *IOHIDElementRef;
typedef struct __IOHIDValue   *IOHIDValueRef;
typedef uint32_t IOHIDElementType;

#define kIOHIDOptionsTypeNone 0

/* IOHIDElementType values (IOHIDElement.h). */
#define kIOHIDElementTypeInput_Misc   1
#define kIOHIDElementTypeInput_Button 2
#define kIOHIDElementTypeInput_Axis   3

/* Device property keys (IOHIDKeys.h). CFSTR wraps these at runtime. */
#define kIOHIDVendorIDKey        "VendorID"
#define kIOHIDProductIDKey       "ProductID"
#define kIOHIDVersionNumberKey   "VersionNumber"
#define kIOHIDProductKey         "Product"
#define kIOHIDPrimaryUsageKey    "PrimaryUsage"
#define kIOHIDDeviceUsagePageKey "DeviceUsagePage"

typedef void (*IOHIDValueCallback)(void *context, IOReturn result,
                                   void *sender, IOHIDValueRef value);
typedef void (*IOHIDDeviceCallback)(void *context, IOReturn result,
                                    void *sender, IOHIDDeviceRef device);

IOHIDManagerRef IOHIDManagerCreate(CFAllocatorRef allocator, IOOptionBits options);
void IOHIDManagerSetDeviceMatching(IOHIDManagerRef manager, CFDictionaryRef matching);
IOReturn IOHIDManagerOpen(IOHIDManagerRef manager, IOOptionBits options);
void IOHIDManagerRegisterDeviceMatchingCallback(IOHIDManagerRef manager,
                                                IOHIDDeviceCallback callback,
                                                void *context);
void IOHIDManagerRegisterDeviceRemovalCallback(IOHIDManagerRef manager,
                                               IOHIDDeviceCallback callback,
                                               void *context);
void IOHIDManagerScheduleWithRunLoop(IOHIDManagerRef manager, CFRunLoopRef runLoop,
                                     CFStringRef runLoopMode);

CFArrayRef IOHIDDeviceCopyMatchingElements(IOHIDDeviceRef device,
                                           CFDictionaryRef matching,
                                           IOOptionBits options);
CFTypeRef IOHIDDeviceGetProperty(IOHIDDeviceRef device, CFStringRef key);
void IOHIDDeviceRegisterInputValueCallback(IOHIDDeviceRef device,
                                           IOHIDValueCallback callback,
                                           void *context);

CFTypeID IOHIDElementGetTypeID(void);
IOHIDElementType IOHIDElementGetType(IOHIDElementRef element);
IOHIDDeviceRef IOHIDElementGetDevice(IOHIDElementRef element);
uint32_t IOHIDElementGetUsagePage(IOHIDElementRef element);
uint32_t IOHIDElementGetUsage(IOHIDElementRef element);
CFIndex IOHIDElementGetLogicalMin(IOHIDElementRef element);
CFIndex IOHIDElementGetLogicalMax(IOHIDElementRef element);

IOHIDElementRef IOHIDValueGetElement(IOHIDValueRef value);
CFIndex IOHIDValueGetIntegerValue(IOHIDValueRef value);

#endif /* _IOKIT_HID_IOHIDMANAGER_H */
