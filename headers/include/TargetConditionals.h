/* Apple platform-dispatch macros. The SDK header classifies the
** compilation target; code gates on TARGET_OS_* after including it
** unconditionally under __APPLE__. badc targets macOS only, so the
** macOS values are fixed; every other platform macro is 0. On
** non-Apple targets everything is 0, matching code that includes
** this header without an __APPLE__ guard. */
#pragma once

#ifdef __APPLE__
#define TARGET_OS_MAC 1
#define TARGET_OS_OSX 1
#else
#define TARGET_OS_MAC 0
#define TARGET_OS_OSX 0
#endif
#define TARGET_OS_WIN32 0
#define TARGET_OS_WINDOWS 0
#define TARGET_OS_UNIX 0
#define TARGET_OS_LINUX 0
#define TARGET_OS_IPHONE 0
#define TARGET_OS_IOS 0
#define TARGET_OS_WATCH 0
#define TARGET_OS_TV 0
#define TARGET_OS_VISION 0
#define TARGET_OS_SIMULATOR 0
#define TARGET_OS_EMBEDDED 0
#define TARGET_OS_MACCATALYST 0
#define TARGET_OS_DRIVERKIT 0

#ifdef __aarch64__
#define TARGET_CPU_ARM64 1
#define TARGET_CPU_X86_64 0
#else
#define TARGET_CPU_ARM64 0
#define TARGET_CPU_X86_64 1
#endif
#define TARGET_CPU_ARM 0
#define TARGET_CPU_X86 0
#define TARGET_CPU_PPC 0
#define TARGET_CPU_PPC64 0

#define TARGET_RT_LITTLE_ENDIAN 1
#define TARGET_RT_BIG_ENDIAN 0
#define TARGET_RT_64_BIT 1
