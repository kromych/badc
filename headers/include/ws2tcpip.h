#pragma once
// ws2tcpip.h -- WinSock2 TCP/IP extensions (getaddrinfo, getnameinfo,
// inet_ntop/inet_pton, the EAI_* / AI_* / NI_* constants). <winsock2.h>
// supplies the address structures, sockets calls and IPPROTO_* / IP* /
// IPV6_* option constants; this header layers the resolver surface on
// top. Include after <winsock2.h>.
#ifdef _WIN32
#include <winsock2.h>
// addrinfo, servent, hostent, getaddrinfo, freeaddrinfo, getnameinfo,
// getservbyname, gethostbyname and the AI_PASSIVE / NI_MAXHOST /
// NI_NUMERICHOST / NI_NUMERICSERV constants come from <netdb.h>.
#include <netdb.h>

// Presentation-form buffer lengths including the terminating NUL
// (ws2ipdef.h).
#define INET_ADDRSTRLEN  22
#define INET6_ADDRSTRLEN 65

// getaddrinfo error codes (ws2tcpip.h). On Windows these alias the
// WSA* error numbers; the values are fixed by ws2tcpip.h.
#define EAI_AGAIN     11002
#define EAI_BADFLAGS  10022
#define EAI_FAIL      11003
#define EAI_FAMILY    10047
#define EAI_MEMORY    8
#define EAI_NODATA    11001
#define EAI_NONAME    11001
#define EAI_SERVICE   10109
#define EAI_SOCKTYPE  10044
#define EAI_ADDRFAMILY 9
#define EAI_OVERFLOW  10068

// getaddrinfo hint flags beyond AI_PASSIVE / AI_ADDRCONFIG (ws2tcpip.h).
#define AI_CANONNAME    0x00000002
#define AI_NUMERICHOST  0x00000004
#define AI_NUMERICSERV  0x00000008
#define AI_ALL          0x00000100
#define AI_V4MAPPED     0x00000800

// getnameinfo flags beyond NI_NUMERICHOST / NI_NUMERICSERV (ws2tcpip.h).
#define NI_NOFQDN       0x01
#define NI_NAMEREQD     0x04
#define NI_DGRAM        0x10

// Multicast-filter WSAIoctl codes (ws2ipdef.h, reached through
// ws2tcpip.h). Their presence signals a recent enough SDK.
#define SIO_GET_MULTICAST_FILTER  _WSAIOR(IOC_WS2, 14)
#define SIO_SET_MULTICAST_FILTER  _WSAIOW(IOC_WS2, 13)

// IPv4 / IPv6 string-conversion helpers (ws2tcpip.h). inet_ntop and
// inet_pton are ws2_32 exports on the targeted Windows version;
// inet_ntoa / inet_addr predate them. The in_addr / sockaddr types are
// already defined by <winsock2.h>, so they are not redeclared here.
#pragma binding(ws2_32::inet_ntop, "inet_ntop")
#pragma binding(ws2_32::inet_pton, "inet_pton")
#pragma binding(ws2_32::inet_ntoa, "inet_ntoa")
#pragma binding(ws2_32::inet_addr, "inet_addr")
const char *inet_ntop(int af, const void *src, char *dst, size_t size);
int inet_pton(int af, const char *src, void *dst);
char *inet_ntoa(struct in_addr in);
unsigned int inet_addr(const char *cp);
#endif
