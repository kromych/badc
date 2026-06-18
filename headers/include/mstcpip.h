#pragma once
// mstcpip.h -- Microsoft-specific TCP/IP WSAIoctl extensions. Defining
// the include guard `_MSTCPIP_` lets consumers detect a recent enough
// SDK (the SIO_GET_MULTICAST_FILTER probe). Include after <winsock2.h>.
#ifdef _WIN32
#define _MSTCPIP_
#include <winsock2.h>

// SIO_* WSAIoctl command codes (mstcpip.h). Built from the vendor /
// WS2 ioctl groups defined in <winsock2.h>.
#define SIO_RCVALL              _WSAIOW(IOC_VENDOR, 1)
#define SIO_RCVALL_MCAST        _WSAIOW(IOC_VENDOR, 2)
#define SIO_RCVALL_IGMPMCAST    _WSAIOW(IOC_VENDOR, 3)
#define SIO_KEEPALIVE_VALS         _WSAIOW(IOC_VENDOR, 4)
#define SIO_LOOPBACK_FAST_PATH     _WSAIOW(IOC_VENDOR, 16)
#define SIO_TCP_SET_ACK_FREQUENCY  _WSAIOW(IOC_VENDOR, 23)
#define SIO_TCP_INFO               _WSAIORW(IOC_VENDOR, 39)

// SIO_RCVALL option values (mstcpip.h RCVALL_VALUE).
#define RCVALL_OFF              0
#define RCVALL_ON               1
#define RCVALL_SOCKETLEVELONLY  2
#define RCVALL_IPLEVEL          3
#define RCVALL_MAX              4

// SIO_KEEPALIVE_VALS input buffer (mstcpip.h). All fields are in
// milliseconds; `onoff` enables per-connection keepalive.
struct tcp_keepalive {
    unsigned long onoff;
    unsigned long keepalivetime;
    unsigned long keepaliveinterval;
};
#endif
