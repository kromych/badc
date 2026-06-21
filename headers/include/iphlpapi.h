#pragma once
// iphlpapi.h -- IP Helper API subset: interface index/name conversion
// and the interface table (netioapi.h types). Bound to iphlpapi.dll.
#ifdef _WIN32
#include <windows.h>

#define NO_ERROR 0
// IF_MAX_STRING_SIZE / NDIS_IF_MAX_STRING_SIZE: interface alias and
// description buffer length in WCHARs (ifdef.h / ntddndis.h).
#define IF_MAX_STRING_SIZE      256
#define NDIS_IF_MAX_STRING_SIZE IF_MAX_STRING_SIZE
// POSIX-style buffer length for if_indextoname (ws2ipdef.h).
#define IF_NAMESIZE             256

// NET_IFINDEX is the 32-bit interface index; NET_LUID is the 64-bit
// locally unique identifier (ifdef.h).
typedef unsigned int NET_IFINDEX;
typedef union _NET_LUID {
    ULONG64 Value;
    ULONG64 Info;
} NET_LUID;
typedef NET_LUID IF_LUID;

// MibIfTableLevel selector for GetIfTable2Ex (netioapi.h).
typedef enum _MIB_IF_TABLE_LEVEL {
    MibIfTableNormal           = 0,
    MibIfTableRaw              = 1,
    MibIfTableNormalWithoutStatistics = 2
} MIB_IF_TABLE_LEVEL;

// MIB_IF_ROW2 (netioapi.h) is 1352 bytes on x64. Only InterfaceLuid
// (offset 0) and InterfaceIndex (offset 8) are read by name; the rest
// of the ABI-fixed record is reserved so the iphlpapi-filled table
// strides correctly and sizeof matches the SDK.
typedef struct _MIB_IF_ROW2 {
    NET_LUID     InterfaceLuid;
    NET_IFINDEX  InterfaceIndex;
    unsigned char _reserved[1340];
} MIB_IF_ROW2;
typedef struct _MIB_IF_ROW2 *PMIB_IF_ROW2;

// MIB_IF_TABLE2 (netioapi.h): a counted, variable-length array of
// MIB_IF_ROW2 allocated by GetIfTable2Ex and released by FreeMibTable.
typedef struct _MIB_IF_TABLE2 {
    ULONG       NumEntries;
    MIB_IF_ROW2 Table[1];
} MIB_IF_TABLE2;
typedef struct _MIB_IF_TABLE2 *PMIB_IF_TABLE2;

#pragma dylib(iphlpapi, "iphlpapi.dll")
#pragma binding(iphlpapi::if_nametoindex, "if_nametoindex")
#pragma binding(iphlpapi::if_indextoname, "if_indextoname")
#pragma binding(iphlpapi::GetIfTable2Ex,  "GetIfTable2Ex")
#pragma binding(iphlpapi::FreeMibTable,   "FreeMibTable")
#pragma binding(iphlpapi::ConvertInterfaceLuidToNameW, "ConvertInterfaceLuidToNameW")

NET_IFINDEX if_nametoindex(const char *name);
char *if_indextoname(NET_IFINDEX index, char *name);
DWORD GetIfTable2Ex(MIB_IF_TABLE_LEVEL level, PMIB_IF_TABLE2 *table);
void FreeMibTable(void *memory);
DWORD ConvertInterfaceLuidToNameW(const NET_LUID *luid, WCHAR *name,
                                  size_t length);
#endif
