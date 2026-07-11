/* Demo-local <shellscalingapi.h>. Per-monitor DPI enumeration types RGFW uses.
 * GetDpiForMonitor itself is resolved at runtime via GetProcAddress, so only
 * the type and selector are needed here; base types come from <windows.h>. */
#ifndef RGFW_DEMO_SHELLSCALINGAPI_H
#define RGFW_DEMO_SHELLSCALINGAPI_H

#include <windows.h>

typedef enum MONITOR_DPI_TYPE {
    MDT_EFFECTIVE_DPI = 0,
    MDT_ANGULAR_DPI   = 1,
    MDT_RAW_DPI       = 2,
    MDT_DEFAULT       = MDT_EFFECTIVE_DPI
} MONITOR_DPI_TYPE;

typedef enum PROCESS_DPI_AWARENESS {
    PROCESS_DPI_UNAWARE           = 0,
    PROCESS_SYSTEM_DPI_AWARE      = 1,
    PROCESS_PER_MONITOR_DPI_AWARE = 2
} PROCESS_DPI_AWARENESS;

#endif /* RGFW_DEMO_SHELLSCALINGAPI_H */
