// psapi.h -- process status API, the process-memory counters subset.
// Since PSAPI_VERSION 2 the SDK routes these through kernel32's K32*
// exports; the binding goes there directly.

#pragma once

#ifdef _WIN32
#include <windows.h>

typedef struct _PROCESS_MEMORY_COUNTERS {
    DWORD cb;
    DWORD PageFaultCount;
    SIZE_T PeakWorkingSetSize;
    SIZE_T WorkingSetSize;
    SIZE_T QuotaPeakPagedPoolUsage;
    SIZE_T QuotaPagedPoolUsage;
    SIZE_T QuotaPeakNonPagedPoolUsage;
    SIZE_T QuotaNonPagedPoolUsage;
    SIZE_T PagefileUsage;
    SIZE_T PeakPagefileUsage;
} PROCESS_MEMORY_COUNTERS, *PPROCESS_MEMORY_COUNTERS;

#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::GetProcessMemoryInfo, "K32GetProcessMemoryInfo")

BOOL GetProcessMemoryInfo(HANDLE Process, PPROCESS_MEMORY_COUNTERS ppsmemCounters, DWORD cb);
#endif
