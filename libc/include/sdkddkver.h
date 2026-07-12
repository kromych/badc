#pragma once
// Windows SDK version constants (subset). These select API availability
// by target Windows version. The default target is Windows 10, matching
// the value the interpreter build pins NTDDI_VERSION to.

#define _WIN32_WINNT_NT4     0x0400
#define _WIN32_WINNT_WIN2K   0x0500
#define _WIN32_WINNT_WINXP   0x0501
#define _WIN32_WINNT_WS03    0x0502
#define _WIN32_WINNT_VISTA   0x0600
#define _WIN32_WINNT_WIN7    0x0601
#define _WIN32_WINNT_WIN8    0x0602
#define _WIN32_WINNT_WINBLUE 0x0603
#define _WIN32_WINNT_WIN10   0x0A00

#define NTDDI_WIN2K   0x05000000
#define NTDDI_WINXP   0x05010000
#define NTDDI_WS03    0x05020000
#define NTDDI_VISTA   0x06000000
#define NTDDI_WIN7    0x06010000
#define NTDDI_WIN8    0x06020000
#define NTDDI_WINBLUE 0x06030000
#define NTDDI_WIN10   0x0A000000

#ifndef _WIN32_WINNT
#define _WIN32_WINNT _WIN32_WINNT_WIN10
#endif
#ifndef WINVER
#define WINVER _WIN32_WINNT
#endif
#ifndef NTDDI_VERSION
#define NTDDI_VERSION NTDDI_WIN10
#endif
