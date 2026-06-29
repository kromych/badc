/* macOS framework bindings for the RGFW backend. Force-included into
 * rcore.c (the only translation unit that reaches RGFW's Cocoa / Core*
 * calls) so badc emits the dynamic imports and LC_LOAD_DYLIB commands.
 * GL entry points are not bound here: GLAD loads them at runtime through
 * RGFW_getProcAddress. AppKit and Foundation carry no bound symbol --
 * declaring the dylib loads the framework so its Objective-C classes
 * (NSApplication, NSWindow, ...) register for objc_getClass. */
#ifndef RGFW_MACOS_LINK_H
#define RGFW_MACOS_LINK_H

#pragma dylib(libobjc, "/usr/lib/libobjc.A.dylib")
#pragma binding(libobjc::sel_registerName, "_sel_registerName")
#pragma binding(libobjc::objc_msgSend, "_objc_msgSend")
#pragma binding(libobjc::objc_getClass, "_objc_getClass")
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
#pragma binding(corefoundation::CFBundleGetMainBundle, "_CFBundleGetMainBundle")
#pragma binding(corefoundation::CFBundleGetBundleWithIdentifier, "_CFBundleGetBundleWithIdentifier")
#pragma binding(corefoundation::CFBundleGetFunctionPointerForName, "_CFBundleGetFunctionPointerForName")
#pragma binding(corefoundation::CFBundleCopyResourcesDirectoryURL, "_CFBundleCopyResourcesDirectoryURL")
#pragma binding(corefoundation::CFURLGetFileSystemRepresentation, "_CFURLGetFileSystemRepresentation")
#pragma binding(corefoundation::CFURLCopyLastPathComponent, "_CFURLCopyLastPathComponent")

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
