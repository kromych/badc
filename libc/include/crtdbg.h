// crtdbg.h -- CRT debug-heap and report interface. badc never defines
// _DEBUG, so this is the release shape of the UCRT header: report
// constants keep their values, entry points fold to the same no-op
// macros the UCRT uses. TODO: the _DEBUG report/heap entry points.

#pragma once

#ifdef _WIN32
#include <stdint.h>

typedef void *_HFILE;

#define _CRT_WARN 0
#define _CRT_ERROR 1
#define _CRT_ASSERT 2
#define _CRT_ERRCNT 3

#define _CRTDBG_MODE_FILE 0x1
#define _CRTDBG_MODE_DEBUG 0x2
#define _CRTDBG_MODE_WNDW 0x4
#define _CRTDBG_REPORT_MODE -1

#define _CRTDBG_INVALID_HFILE ((_HFILE)(intptr_t)-1)
#define _CRTDBG_HFILE_ERROR ((_HFILE)(intptr_t)-2)
#define _CRTDBG_FILE_STDOUT ((_HFILE)(intptr_t)-4)
#define _CRTDBG_FILE_STDERR ((_HFILE)(intptr_t)-5)
#define _CRTDBG_REPORT_FILE ((_HFILE)(intptr_t)-6)

#define _CrtSetReportMode(t, f) ((int)0)
#define _CrtSetReportFile(t, f) ((_HFILE)0)
#define _CrtSetDbgFlag(f) ((int)0)
#define _CrtCheckMemory() ((int)1)
#define _CrtDumpMemoryLeaks() ((int)0)
#define _CrtDbgBreak() ((void)0)
#define _ASSERT(expr) ((void)0)
#define _ASSERTE(expr) ((void)0)
#endif
