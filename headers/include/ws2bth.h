#pragma once
// ws2bth.h -- Bluetooth address family for WinSock2 (AF_BTH). Defines
// the BTHPROTO_* protocol numbers, the SOCKADDR_BTH address structure
// and BT_PORT_ANY. Include after <winsock2.h>.
#ifdef _WIN32
#include <winsock2.h>

typedef ULONGLONG BTH_ADDR;
typedef BTH_ADDR *PBTH_ADDR;

// Bluetooth protocols (ws2bth.h).
#define BTHPROTO_RFCOMM 0x0003
#define BTHPROTO_L2CAP  0x0100

// RFCOMM channel / L2CAP PSM wildcard (ws2bth.h).
#define BT_PORT_ANY  ((ULONG)-1)
#define BT_PORT_MIN  0x1
#define BT_PORT_MAX  0xffff

// setsockopt levels for the Bluetooth protocols (ws2bth.h).
#define SOL_RFCOMM  0x0003
#define SOL_L2CAP   0x0100
#define SOL_SCO     0x0101

// SOL_RFCOMM option names (ws2bth.h).
#define SO_BTH_ENCRYPT  0x00000001
#define SO_BTH_AUTHENTICATE 0x80000001
#define SO_BTH_MTU      0x80000007
#define SO_BTH_MTU_MAX  0x80000008
#define SO_BTH_MTU_MIN  0x8000000a

// SOCKADDR_BTH (ws2bth.h): AF_BTH socket address. Packed to 1 by the
// pshpack1.h / poppack.h pair the consumer wraps it in.
typedef struct _SOCKADDR_BTH {
    USHORT    addressFamily;
    BTH_ADDR  btAddr;
    GUID      serviceClassId;
    ULONG     port;
} SOCKADDR_BTH;
typedef struct _SOCKADDR_BTH *PSOCKADDR_BTH;
#endif
