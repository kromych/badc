#pragma once
// hvsocket.h -- Hyper-V socket (AF_HYPERV) protocol and option
// constants. The SOCKADDR_HV address structure comes from <winsock2.h>.
#ifdef _WIN32
#include <winsock2.h>

// AF_HYPERV raw protocol (hvsocket.h).
#define HV_PROTOCOL_RAW 1

// HVSOCKET option names / limits (hvsocket.h).
#define HVSOCKET_CONNECT_TIMEOUT       0x01
#define HVSOCKET_CONNECT_TIMEOUT_MAX   300000
#define HVSOCKET_CONNECTED_SUSPEND     0x04
#define HVSOCKET_HIGH_VTL              0x08
#define HVSOCKET_ADDRESS_FLAG_PASSTHRU 0x01
#endif
