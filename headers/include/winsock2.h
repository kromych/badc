#pragma once
#ifdef _WIN32
// Minimal Winsock address types. <sys/socket.h> already provides struct
// sockaddr, struct sockaddr_storage, the AF_INET6 / SOL_SOCKET constants,
// and the ws2_32 bindings for the Windows target; this header adds the
// remaining address structures a consumer's `sockaddr` union lays out.
// SOCKET and GUID come from <windows.h>.
#include <windows.h>
#include <sys/socket.h>

// BSD fixed-width aliases winsock2.h carries forward.
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
typedef unsigned long  u_long;

// Winsock has no separate resolver-error variable; h_errno maps onto
// the last per-thread socket error (winsock2.h).
#define h_errno (WSAGetLastError())

#ifndef AF_UNSPEC
#define AF_UNSPEC 0
#endif
#ifndef AF_INET
#define AF_INET 2
#endif
#define AF_BTH 32
#define INVALID_SOCKET (~(SOCKET)0)
#define SOCKET_ERROR   (-1)

// IPv4 address (winsock2.h / in.h). The SDK wraps the 4-byte value in
// the `S_un` union and exposes `s_addr` as a macro alias for the full
// 32-bit member; `in_addr` stays 4 bytes wide.
struct in_addr {
    union {
        struct { unsigned char  s_b1, s_b2, s_b3, s_b4; } S_un_b;
        struct { unsigned short s_w1, s_w2; }             S_un_w;
        unsigned long S_addr;
    } S_un;
};
#define s_addr S_un.S_addr
struct sockaddr_in {
    short          sin_family;
    unsigned short sin_port;
    struct in_addr sin_addr;
    char           sin_zero[8];
};
struct in6_addr {
    unsigned char s6_addr[16];
};
struct sockaddr_in6 {
    short          sin6_family;
    unsigned short sin6_port;
    unsigned long  sin6_flowinfo;
    struct in6_addr sin6_addr;
    unsigned long  sin6_scope_id;
};
// IN6ADDR_ANY_INIT is all zeros (in6.h); a zero-filled const matches.
static const struct in6_addr in6addr_any;

// Uppercase aliases the SDK carries for the address structures.
typedef struct sockaddr_in  SOCKADDR_IN,  *PSOCKADDR_IN,  *LPSOCKADDR_IN;
typedef struct sockaddr_in6 SOCKADDR_IN6, *PSOCKADDR_IN6, *LPSOCKADDR_IN6;
// Hyper-V socket address (AF_HYPERV).
typedef struct _SOCKADDR_HV {
    unsigned short Family;
    unsigned short Reserved;
    GUID           VmId;
    GUID           ServiceId;
} SOCKADDR_HV;

// Additional address families (winsock2.h / ws2def.h).
#define AF_IPX        6
#define AF_APPLETALK  16
#define AF_NETBIOS    17
#define AF_IRDA       26
#define AF_HYPERV     34

// Socket types (winsock2.h).
#define SOCK_STREAM    1
#define SOCK_DGRAM     2
#define SOCK_RAW       3
#define SOCK_RDM       4
#define SOCK_SEQPACKET 5

// Protocol numbers (ws2def.h IPPROTO enum). These are enumerators, not
// macros: consumers re-expose individual members with a `#define X X`
// shim so `#ifdef` works, which requires the underlying name to resolve
// to an enum constant rather than a macro. Duplicate values (e.g.
// IPPROTO_IP / IPPROTO_HOPOPTS) follow the IANA assignments. The two
// TCP/UDP names <sys/socket.h> defines as macros are dropped so the
// enum can carry them in the Windows shape.
#undef IPPROTO_TCP
#undef IPPROTO_UDP
typedef enum {
    IPPROTO_HOPOPTS  = 0,
    IPPROTO_IP       = 0,
    IPPROTO_ICMP     = 1,
    IPPROTO_IGMP     = 2,
    IPPROTO_GGP      = 3,
    IPPROTO_IPV4     = 4,
    IPPROTO_ST       = 5,
    IPPROTO_TCP      = 6,
    IPPROTO_CBT      = 7,
    IPPROTO_EGP      = 8,
    IPPROTO_IGP      = 9,
    IPPROTO_PUP      = 12,
    IPPROTO_UDP      = 17,
    IPPROTO_IDP      = 22,
    IPPROTO_RDP      = 27,
    IPPROTO_IPV6     = 41,
    IPPROTO_ROUTING  = 43,
    IPPROTO_FRAGMENT = 44,
    IPPROTO_ESP      = 50,
    IPPROTO_AH       = 51,
    IPPROTO_ICMPV6   = 58,
    IPPROTO_NONE     = 59,
    IPPROTO_DSTOPTS  = 60,
    IPPROTO_ND       = 77,
    IPPROTO_ICLFXBM  = 78,
    IPPROTO_PIM      = 103,
    IPPROTO_PGM      = 113,
    IPPROTO_L2TP     = 115,
    IPPROTO_SCTP     = 132,
    IPPROTO_RAW      = 255,
    IPPROTO_MAX      = 256
} IPPROTO;

// Well-known reserved ports.
#define IPPORT_RESERVED     1024

// IPv4 wildcard / special addresses, host byte order (winsock2.h).
#define INADDR_ANY       0x00000000
#define INADDR_LOOPBACK  0x7f000001
#define INADDR_BROADCAST 0xffffffff
#define INADDR_NONE      0xffffffff

// setsockopt levels / option names beyond the BSD core in <sys/socket.h>.
#define SO_DEBUG       0x0001
#define SO_ACCEPTCONN  0x0002
#define SO_DONTROUTE   0x0010
#define SO_BROADCAST   0x0020
#define SO_USELOOPBACK 0x0040
#define SO_LINGER      0x0080
#define SO_OOBINLINE   0x0100
#define SO_SNDLOWAT    0x1003
#define SO_RCVLOWAT    0x1004
#define SO_SNDTIMEO    0x1005
#define SO_RCVTIMEO    0x1006
#define SO_TYPE        0x1008
#define SO_EXCLUSIVEADDRUSE 0xfffffffb

// recv / send flags (winsock2.h).
#define MSG_OOB       0x1
#define MSG_PEEK      0x2
#define MSG_DONTROUTE 0x4
#define MSG_WAITALL   0x8
#define MSG_BCAST     0x400
#define MSG_MCAST     0x800

// TCP-level options (ws2tcpip.h / mstcpip.h).
#define TCP_NODELAY     0x0001
#define TCP_EXPEDITED_1122 0x0002
#define TCP_KEEPALIVE   3
#define TCP_MAXSEG      4
#define TCP_MAXRT       5
#define TCP_STDURG      6
#define TCP_NOURG       7
#define TCP_ATMARK      8
#define TCP_NOSYNRETRIES 9
#define TCP_TIMESTAMPS  10
#define TCP_OFFLOAD_PREFERENCE 11
#define TCP_CONGESTION_ALGORITHM 12
#define TCP_DELAY_FIN_ACK 13
#define TCP_MAXRTMS     14
#define TCP_FASTOPEN    15
#define TCP_KEEPCNT     16
#define TCP_KEEPIDLE    TCP_KEEPALIVE
#define TCP_KEEPINTVL   17

// IP-level options (ws2ipdef.h).
#define IP_OPTIONS          1
#define IP_HDRINCL          2
#define IP_TOS              3
#define IP_TTL              4
#define IP_MULTICAST_IF     9
#define IP_MULTICAST_TTL    10
#define IP_MULTICAST_LOOP   11
#define IP_ADD_MEMBERSHIP   12
#define IP_DROP_MEMBERSHIP  13
#define IP_ADD_SOURCE_MEMBERSHIP   15
#define IP_DROP_SOURCE_MEMBERSHIP  16
#define IP_BLOCK_SOURCE     17
#define IP_UNBLOCK_SOURCE   18
#define IP_PKTINFO          19
#define IP_RECVTTL          21
#define IP_RECVTOS          40
#define IP_DEFAULT_MULTICAST_TTL  1
#define IP_DEFAULT_MULTICAST_LOOP 1
#define IP_MAX_MEMBERSHIPS  20

// IPv6-level options (ws2ipdef.h).
#define IPV6_HOPOPTS        1
#define IPV6_HDRINCL        2
#define IPV6_UNICAST_HOPS   4
#define IPV6_MULTICAST_IF   9
#define IPV6_MULTICAST_HOPS 10
#define IPV6_MULTICAST_LOOP 11
#define IPV6_JOIN_GROUP     12
#define IPV6_LEAVE_GROUP    13
#define IPV6_PKTINFO        19
#define IPV6_HOPLIMIT       21
#define IPV6_RECVTCLASS     40
#define IPV6_TCLASS         39
#define IPV6_V6ONLY         27
#define IPV6_CHECKSUM       26
#define IPV6_DONTFRAG       14
#define IPV6_RTHDR          32
#define IPV6_RECVRTHDR      38
#define IPV6_RECVPKTINFO    49
#define IPV6_PATHMTU        44
#define IPV6_RECVPATHMTU    52

// ioctlsocket / WSAIoctl command codes (winsock2.h).
#define FIONREAD   0x4004667f
#define FIONBIO    0x8004667e
#define FIOASYNC   0x8004667d

// WSAIoctl IOCTL code construction (winsock2.h). IOC_VENDOR is the
// vendor-specific group used by the SIO_* extension ioctls.
#define IOC_VOID  0x20000000
#define IOC_OUT   0x40000000
#define IOC_IN    0x80000000
#define IOC_INOUT (IOC_IN | IOC_OUT)
#define IOC_WS2   0x08000000
#define IOC_PROTOCOL 0x10000000
#define IOC_VENDOR   0x18000000
#define _IO(x,y)    (IOC_VOID | ((x) << 8) | (y))
#define _IOR(x,y,t) (IOC_OUT | (((long)sizeof(t)) << 16) | ((x) << 8) | (y))
#define _IOW(x,y,t) (IOC_IN | (((long)sizeof(t)) << 16) | ((x) << 8) | (y))
#define _WSAIO(x,y)    (IOC_VOID | (x) | (y))
#define _WSAIOR(x,y)   (IOC_OUT | (x) | (y))
#define _WSAIOW(x,y)   (IOC_IN | (x) | (y))
#define _WSAIORW(x,y)  (IOC_INOUT | (x) | (y))

// `WSADATA` is filled by WSAStartup. The x64 layout places the
// description / status arrays after the vendor pointer (winsock2.h);
// WSADESCRIPTION_LEN is 256 and WSASYS_STATUS_LEN is 128, each plus
// the trailing NUL.
struct WSAData {
    WORD           wVersion;
    WORD           wHighVersion;
    unsigned short iMaxSockets;
    unsigned short iMaxUdpDg;
    char          *lpVendorInfo;
    char           szDescription[257];
    char           szSystemStatus[129];
};
typedef struct WSAData WSADATA;
typedef struct WSAData *LPWSADATA;

// `WSAPROTOCOL_INFOW` is written by WSADuplicateSocketW and consumed by
// WSASocketW; the layout is fixed by the ws2_32 ABI (winsock2.h). Only
// iAddressFamily / iSocketType / iProtocol are read by name here, but
// the whole 372-byte object crosses the boundary, so the trailing
// fields are reproduced for size fidelity.
#define WSAPROTOCOL_LEN     255
#define MAX_PROTOCOL_CHAIN  7
typedef struct _WSAPROTOCOLCHAIN {
    int ChainLen;
    DWORD ChainEntries[MAX_PROTOCOL_CHAIN];
} WSAPROTOCOLCHAIN;
typedef struct _WSAPROTOCOL_INFOW {
    DWORD            dwServiceFlags1;
    DWORD            dwServiceFlags2;
    DWORD            dwServiceFlags3;
    DWORD            dwServiceFlags4;
    DWORD            dwProviderFlags;
    GUID             ProviderId;
    DWORD            dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    DWORD            dwMessageSize;
    DWORD            dwProviderReserved;
    unsigned short   szProtocol[256];
} WSAPROTOCOL_INFOW;
typedef struct _WSAPROTOCOL_INFOW *LPWSAPROTOCOL_INFOW;

// WSASocketW dwFlags (winsock2.h).
#define WSA_FLAG_OVERLAPPED        0x01
#define WSA_FLAG_NO_HANDLE_INHERIT 0x80
// WSASocketW / WSADuplicateSocketW use -1 in the family/type/protocol
// slots to mean "take these from the protocol-info block".
#define FROM_PROTOCOL_INFO (-1)

// `struct timeval` for select() is supplied by <time.h>, already
// pulled in ahead of this header.

// Windows `fd_set` is an array of SOCKET handles, not the POSIX
// bitmap (winsock2.h). The FD_* macros operate on that array;
// membership tests route through ws2_32's __WSAFDIsSet.
#define FD_SETSIZE 64
typedef struct fd_set {
    unsigned int fd_count;
    SOCKET       fd_array[FD_SETSIZE];
} fd_set;
int __WSAFDIsSet(SOCKET fd, fd_set *set);
#define FD_ZERO(set) ((set)->fd_count = 0)
#define FD_ISSET(fd, set) __WSAFDIsSet((SOCKET)(fd), (fd_set *)(set))
#define FD_SET(fd, set) do { \
    unsigned int __i; \
    for (__i = 0; __i < (set)->fd_count; __i++) { \
        if ((set)->fd_array[__i] == (SOCKET)(fd)) break; \
    } \
    if (__i == (set)->fd_count && (set)->fd_count < FD_SETSIZE) { \
        (set)->fd_array[__i] = (SOCKET)(fd); \
        (set)->fd_count = (set)->fd_count + 1; \
    } \
} while (0)
#define FD_CLR(fd, set) do { \
    unsigned int __i; \
    for (__i = 0; __i < (set)->fd_count; __i++) { \
        if ((set)->fd_array[__i] == (SOCKET)(fd)) { \
            while (__i < (set)->fd_count - 1) { \
                (set)->fd_array[__i] = (set)->fd_array[__i + 1]; \
                __i = __i + 1; \
            } \
            (set)->fd_count = (set)->fd_count - 1; \
            break; \
        } \
    } \
} while (0)

// `struct sockaddr` alias used across the Winsock surface (winsock2.h).
typedef struct sockaddr SOCKADDR;
typedef struct sockaddr *PSOCKADDR;
typedef struct sockaddr *LPSOCKADDR;

// Scatter/gather buffer descriptor for the WSA* overlapped calls
// (winsock2.h). `len` is a byte count; `buf` points at the data.
typedef struct _WSABUF {
    ULONG len;
    char *buf;
} WSABUF, *LPWSABUF;

// Overlapped socket I/O (winsock2.h). The completion-routine argument
// is NULL for IOCP-driven I/O, so it is typed as an opaque pointer.
// `lpOverlapped` carries a WSAOVERLAPPED, layout-identical to
// OVERLAPPED from <windows.h>.
#pragma binding(ws2_32::WSARecv,             "WSARecv")
#pragma binding(ws2_32::WSASend,             "WSASend")
#pragma binding(ws2_32::WSARecvFrom,         "WSARecvFrom")
#pragma binding(ws2_32::WSASendTo,           "WSASendTo")
int WSARecv(SOCKET s, LPWSABUF buffers, DWORD bufferCount, LPDWORD recvd,
            LPDWORD flags, LPOVERLAPPED overlapped, void *completionRoutine);
int WSASend(SOCKET s, LPWSABUF buffers, DWORD bufferCount, LPDWORD sent,
            DWORD flags, LPOVERLAPPED overlapped, void *completionRoutine);
int WSARecvFrom(SOCKET s, LPWSABUF buffers, DWORD bufferCount, LPDWORD recvd,
                LPDWORD flags, struct sockaddr *from, int *fromlen,
                LPOVERLAPPED overlapped, void *completionRoutine);
int WSASendTo(SOCKET s, LPWSABUF buffers, DWORD bufferCount, LPDWORD sent,
              DWORD flags, const struct sockaddr *to, int tolen,
              LPOVERLAPPED overlapped, void *completionRoutine);

// Parse a numeric address string into a sockaddr (winsock2.h). The
// length is in/out: callers pass the buffer size and read back the
// bytes written.
#pragma binding(ws2_32::WSAStringToAddressW, "WSAStringToAddressW")
int WSAStringToAddressW(wchar_t *addressString, int addressFamily,
                        LPWSAPROTOCOL_INFOW protocolInfo,
                        struct sockaddr *address, int *addressLength);

// Connect a socket, optionally exchanging connect-time data (winsock2.h).
// The caller/callee WSABUF and QoS arguments are NULL for a plain
// connectionless bind; the QoS pointers are opaque here.
#pragma binding(ws2_32::WSAConnect,          "WSAConnect")
int WSAConnect(SOCKET s, const struct sockaddr *name, int namelen,
               LPWSABUF callerData, LPWSABUF calleeData, void *sqos,
               void *gqos);

#pragma binding(ws2_32::WSAIoctl,            "WSAIoctl")
#pragma binding(ws2_32::WSASocketW,          "WSASocketW")
#pragma binding(ws2_32::WSADuplicateSocketW, "WSADuplicateSocketW")
#pragma binding(ws2_32::select,              "select")
#pragma binding(ws2_32::__WSAFDIsSet,        "__WSAFDIsSet")
#pragma binding(ws2_32::getservbyport,       "getservbyport")
#pragma binding(ws2_32::getprotobyname,      "getprotobyname")
#pragma binding(ws2_32::getprotobynumber,    "getprotobynumber")
#pragma binding(ws2_32::gethostname,         "gethostname")
#pragma binding(ws2_32::htons,               "htons")
#pragma binding(ws2_32::ntohs,               "ntohs")
#pragma binding(ws2_32::htonl,               "htonl")
#pragma binding(ws2_32::ntohl,               "ntohl")
#pragma binding(ws2_32::recvfrom,            "recvfrom")
#pragma binding(ws2_32::sendto,              "sendto")

// WSAStartup / WSACleanup / closesocket / ioctlsocket and the byte-order
// helpers are declared and bound in <sys/socket.h>, which this header
// includes; the version word is MAKEWORD(major, minor).
int WSAIoctl(SOCKET s, DWORD code, void *inbuf, DWORD inlen, void *outbuf,
             DWORD outlen, DWORD *bytes, void *overlapped, void *routine);
SOCKET WSASocketW(int af, int type, int protocol, LPWSAPROTOCOL_INFOW info,
                  unsigned int group, DWORD flags);
int WSADuplicateSocketW(SOCKET s, DWORD processId, LPWSAPROTOCOL_INFOW info);
int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
           const struct timeval *timeout);
struct servent *getservbyport(int port, const char *proto);
struct protoent *getprotobyname(const char *name);
struct protoent *getprotobynumber(int proto);
int gethostname(char *name, int namelen);
unsigned short htons(unsigned short hostshort);
unsigned short ntohs(unsigned short netshort);
unsigned int   htonl(unsigned int hostlong);
unsigned int   ntohl(unsigned int netlong);
int recvfrom(SOCKET s, char *buf, int len, int flags, struct sockaddr *from,
             int *fromlen);
int sendto(SOCKET s, const char *buf, int len, int flags,
           const struct sockaddr *to, int tolen);

// `struct protoent` (winsock2.h); servent / hostent come from <netdb.h>.
struct protoent {
    char  *p_name;
    char **p_aliases;
    short  p_proto;
};
#endif
