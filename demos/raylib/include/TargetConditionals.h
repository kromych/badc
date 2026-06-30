/* Platform selection macros. This build targets macOS desktop, so the
 * iOS/tvOS/watchOS conditionals are defined to 0 and TARGET_OS_OSX to 1.
 * miniaudio reads these to choose the CoreAudio desktop backend. */
#ifndef __TARGETCONDITIONALS__
#define __TARGETCONDITIONALS__

#define TARGET_OS_MAC     1
#define TARGET_OS_OSX     1
#define TARGET_OS_IPHONE  0
#define TARGET_OS_IOS     0
#define TARGET_OS_TV      0
#define TARGET_OS_WATCH   0
#define TARGET_OS_SIMULATOR 0

#endif /* __TARGETCONDITIONALS__ */
