/* macOS framework bindings for the RGFW backend. Force-included into
 * rcore.c (the only translation unit that reaches RGFW's Cocoa / Core*
 * calls) so badc emits the dynamic imports and LC_LOAD_DYLIB commands.
 * GL entry points are not bound here: GLAD loads them at runtime through
 * RGFW_getProcAddress. AppKit and Foundation carry no bound symbol --
 * declaring the dylib loads the framework so its Objective-C classes
 * (NSApplication, NSWindow, ...) register for objc_getClass. */
#ifndef RGFW_MACOS_LINK_H
#define RGFW_MACOS_LINK_H

/* RGFW references CoreGraphics and CGL names before it pulls those headers in
 * its implementation section, so the types and constants must already be
 * visible. This header is force-included into rcore.c ahead of RGFW.h. */
#include <CoreGraphics/CoreGraphics.h>
#include <OpenGL/OpenGL.h>

#pragma dylib(libobjc, "/usr/lib/libobjc.A.dylib")
#pragma binding(libobjc::sel_registerName, "_sel_registerName")
#pragma binding(libobjc::sel_getUid, "_sel_getUid")
#pragma binding(libobjc::objc_msgSend, "_objc_msgSend")
#pragma binding(libobjc::objc_msgSendSuper, "_objc_msgSendSuper")
#pragma binding(libobjc::objc_getClass, "_objc_getClass")
#pragma binding(libobjc::object_getClass, "_object_getClass")
#pragma binding(libobjc::class_getSuperclass, "_class_getSuperclass")
#pragma binding(libobjc::objc_disposeClassPair, "_objc_disposeClassPair")
#pragma binding(libobjc::objc_allocateClassPair, "_objc_allocateClassPair")
#pragma binding(libobjc::objc_registerClassPair, "_objc_registerClassPair")
#pragma binding(libobjc::class_addMethod, "_class_addMethod")
#pragma binding(libobjc::class_addIvar, "_class_addIvar")
#pragma binding(libobjc::object_getInstanceVariable, "_object_getInstanceVariable")
#pragma binding(libobjc::object_setInstanceVariable, "_object_setInstanceVariable")

#pragma dylib(corefoundation, "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
#pragma binding(corefoundation::CFRelease, "_CFRelease")
#pragma binding(corefoundation::CFStringCreateWithCString, "_CFStringCreateWithCString")
#pragma binding(corefoundation::CFStringCompare, "_CFStringCompare")
#pragma binding(corefoundation::CFStringGetCString, "_CFStringGetCString")
#pragma binding(corefoundation::CFBundleGetMainBundle, "_CFBundleGetMainBundle")
#pragma binding(corefoundation::CFBundleGetBundleWithIdentifier, "_CFBundleGetBundleWithIdentifier")
#pragma binding(corefoundation::CFBundleGetFunctionPointerForName, "_CFBundleGetFunctionPointerForName")
#pragma binding(corefoundation::CFBundleCopyResourcesDirectoryURL, "_CFBundleCopyResourcesDirectoryURL")
#pragma binding(corefoundation::CFURLGetFileSystemRepresentation, "_CFURLGetFileSystemRepresentation")
#pragma binding(corefoundation::CFURLCopyLastPathComponent, "_CFURLCopyLastPathComponent")
#pragma binding(corefoundation::CFGetTypeID, "_CFGetTypeID")
#pragma binding(corefoundation::CFArrayGetCount, "_CFArrayGetCount")
#pragma binding(corefoundation::CFArrayGetValueAtIndex, "_CFArrayGetValueAtIndex")
#pragma binding(corefoundation::CFDictionaryCreateMutable, "_CFDictionaryCreateMutable")
#pragma binding(corefoundation::CFDictionarySetValue, "_CFDictionarySetValue")
#pragma binding(corefoundation::CFNumberCreate, "_CFNumberCreate")
#pragma binding(corefoundation::CFNumberGetValue, "_CFNumberGetValue")
#pragma binding(corefoundation::CFRunLoopGetCurrent, "_CFRunLoopGetCurrent")
#pragma binding(corefoundation::CFRunLoopRunInMode, "_CFRunLoopRunInMode")
#pragma binding(corefoundation::CFBundleGetDataPointerForName, "_CFBundleGetDataPointerForName")
#pragma binding(corefoundation::CFDataGetBytePtr, "_CFDataGetBytePtr")
#pragma binding(data corefoundation::kCFRunLoopDefaultMode, "_kCFRunLoopDefaultMode")
#pragma binding(data corefoundation::kCFTypeDictionaryKeyCallBacks, "_kCFTypeDictionaryKeyCallBacks")
#pragma binding(data corefoundation::kCFTypeDictionaryValueCallBacks, "_kCFTypeDictionaryValueCallBacks")

#pragma dylib(iokit, "/System/Library/Frameworks/IOKit.framework/IOKit")
#pragma binding(iokit::IOHIDManagerCreate, "_IOHIDManagerCreate")
#pragma binding(iokit::IOHIDManagerOpen, "_IOHIDManagerOpen")
#pragma binding(iokit::IOHIDManagerSetDeviceMatching, "_IOHIDManagerSetDeviceMatching")
#pragma binding(iokit::IOHIDManagerRegisterDeviceMatchingCallback, "_IOHIDManagerRegisterDeviceMatchingCallback")
#pragma binding(iokit::IOHIDManagerRegisterDeviceRemovalCallback, "_IOHIDManagerRegisterDeviceRemovalCallback")
#pragma binding(iokit::IOHIDManagerScheduleWithRunLoop, "_IOHIDManagerScheduleWithRunLoop")
#pragma binding(iokit::IOHIDDeviceCopyMatchingElements, "_IOHIDDeviceCopyMatchingElements")
#pragma binding(iokit::IOHIDDeviceGetProperty, "_IOHIDDeviceGetProperty")
#pragma binding(iokit::IOHIDDeviceRegisterInputValueCallback, "_IOHIDDeviceRegisterInputValueCallback")
#pragma binding(iokit::IOHIDElementGetTypeID, "_IOHIDElementGetTypeID")
#pragma binding(iokit::IOHIDElementGetType, "_IOHIDElementGetType")
#pragma binding(iokit::IOHIDElementGetDevice, "_IOHIDElementGetDevice")
#pragma binding(iokit::IOHIDElementGetUsagePage, "_IOHIDElementGetUsagePage")
#pragma binding(iokit::IOHIDElementGetUsage, "_IOHIDElementGetUsage")
#pragma binding(iokit::IOHIDElementGetLogicalMin, "_IOHIDElementGetLogicalMin")
#pragma binding(iokit::IOHIDElementGetLogicalMax, "_IOHIDElementGetLogicalMax")
#pragma binding(iokit::IOHIDValueGetElement, "_IOHIDValueGetElement")
#pragma binding(iokit::IOHIDValueGetIntegerValue, "_IOHIDValueGetIntegerValue")
#pragma binding(iokit::IOServiceGetMatchingServices, "_IOServiceGetMatchingServices")
#pragma binding(iokit::IOServiceMatching, "_IOServiceMatching")
#pragma binding(iokit::IOIteratorNext, "_IOIteratorNext")
#pragma binding(iokit::IORegistryEntryCreateCFProperty, "_IORegistryEntryCreateCFProperty")
#pragma binding(iokit::IOObjectRelease, "_IOObjectRelease")

#pragma dylib(carbon, "/System/Library/Frameworks/Carbon.framework/Carbon")
#pragma binding(carbon::UCKeyTranslate, "_UCKeyTranslate")

#pragma dylib(coregraphics, "/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics")
#pragma binding(coregraphics::CGMainDisplayID, "_CGMainDisplayID")
#pragma binding(coregraphics::CGDisplayBounds, "_CGDisplayBounds")
#pragma binding(coregraphics::CGDisplayPixelsWide, "_CGDisplayPixelsWide")
#pragma binding(coregraphics::CGDisplayPixelsHigh, "_CGDisplayPixelsHigh")
#pragma binding(coregraphics::CGDisplayScreenSize, "_CGDisplayScreenSize")
#pragma binding(coregraphics::CGDisplayShowCursor, "_CGDisplayShowCursor")
#pragma binding(coregraphics::CGDisplayHideCursor, "_CGDisplayHideCursor")
#pragma binding(coregraphics::CGGetActiveDisplayList, "_CGGetActiveDisplayList")
#pragma binding(coregraphics::CGWarpMouseCursorPosition, "_CGWarpMouseCursorPosition")
#pragma binding(coregraphics::CGAssociateMouseAndMouseCursorPosition, "_CGAssociateMouseAndMouseCursorPosition")
#pragma binding(coregraphics::CGEventCreate, "_CGEventCreate")
#pragma binding(coregraphics::CGEventGetLocation, "_CGEventGetLocation")
#pragma binding(coregraphics::CGBitmapContextCreate, "_CGBitmapContextCreate")
#pragma binding(coregraphics::CGBitmapContextCreateImage, "_CGBitmapContextCreateImage")
#pragma binding(coregraphics::CGColorSpaceCreateDeviceRGB, "_CGColorSpaceCreateDeviceRGB")
#pragma binding(coregraphics::CGColorSpaceRelease, "_CGColorSpaceRelease")
#pragma binding(coregraphics::CGContextRelease, "_CGContextRelease")
#pragma binding(coregraphics::CGDisplayUnitNumber, "_CGDisplayUnitNumber")
#pragma binding(coregraphics::CGOpenGLDisplayMaskToDisplayID, "_CGOpenGLDisplayMaskToDisplayID")
#pragma binding(coregraphics::CGDisplayCopyDisplayMode, "_CGDisplayCopyDisplayMode")
#pragma binding(coregraphics::CGDisplayCopyAllDisplayModes, "_CGDisplayCopyAllDisplayModes")
#pragma binding(coregraphics::CGDisplayModeGetWidth, "_CGDisplayModeGetWidth")
#pragma binding(coregraphics::CGDisplayModeGetHeight, "_CGDisplayModeGetHeight")
#pragma binding(coregraphics::CGDisplayModeGetRefreshRate, "_CGDisplayModeGetRefreshRate")
#pragma binding(coregraphics::CGDisplaySetDisplayMode, "_CGDisplaySetDisplayMode")
#pragma binding(coregraphics::CGDisplayGammaTableCapacity, "_CGDisplayGammaTableCapacity")
#pragma binding(coregraphics::CGGetDisplayTransferByTable, "_CGGetDisplayTransferByTable")
#pragma binding(coregraphics::CGSetDisplayTransferByTable, "_CGSetDisplayTransferByTable")

#pragma dylib(corevideo, "/System/Library/Frameworks/CoreVideo.framework/CoreVideo")
#pragma binding(corevideo::CVDisplayLinkCreateWithCGDisplay, "_CVDisplayLinkCreateWithCGDisplay")
#pragma binding(corevideo::CVDisplayLinkSetOutputCallback, "_CVDisplayLinkSetOutputCallback")
#pragma binding(corevideo::CVDisplayLinkStart, "_CVDisplayLinkStart")
#pragma binding(corevideo::CVDisplayLinkStop, "_CVDisplayLinkStop")
#pragma binding(corevideo::CVDisplayLinkRelease, "_CVDisplayLinkRelease")

/* Loaded for Objective-C class registration; no C symbol is bound. */
#pragma dylib(appkit, "/System/Library/Frameworks/AppKit.framework/AppKit")
#pragma dylib(foundation, "/System/Library/Frameworks/Foundation.framework/Foundation")
#pragma dylib(opengl, "/System/Library/Frameworks/OpenGL.framework/OpenGL")

#endif /* RGFW_MACOS_LINK_H */
