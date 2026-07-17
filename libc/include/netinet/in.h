// netinet/in.h -- Internet address family (POSIX 7.40). Struct layouts are
// verified against the system headers on each target: macOS/BSD prefix a
// 1-byte length field, so the leading family region is shaped per target
// while sin_port / sin_addr land at the same offsets everywhere.

#pragma once

#include <sys/socket.h>

// IANA-assigned protocol numbers (POSIX 7.40 requires IP, IPV6, ICMP,
// RAW, TCP, UDP; the rest are the values every platform shares).
#define IPPROTO_IP       0
#define IPPROTO_HOPOPTS  0  // IPv6 hop-by-hop options
#define IPPROTO_ICMP     1
#define IPPROTO_IGMP     2
#define IPPROTO_IPIP     4  // IPIP tunnels
#define IPPROTO_TCP      6
#define IPPROTO_EGP      8
#define IPPROTO_PUP      12
#define IPPROTO_UDP      17
#define IPPROTO_IDP      22
#define IPPROTO_TP       29
#define IPPROTO_DCCP     33
#define IPPROTO_IPV6     41
#define IPPROTO_ROUTING  43 // IPv6 routing header
#define IPPROTO_FRAGMENT 44 // IPv6 fragmentation header
#define IPPROTO_RSVP     46
#define IPPROTO_GRE      47
#define IPPROTO_ESP      50
#define IPPROTO_AH       51
#define IPPROTO_ICMPV6   58
#define IPPROTO_NONE     59 // IPv6 no-next-header
#define IPPROTO_DSTOPTS  60 // IPv6 destination options
#define IPPROTO_MTP      92
#define IPPROTO_ENCAP    98
#define IPPROTO_PIM      103
#define IPPROTO_COMP     108
#define IPPROTO_SCTP     132
#define IPPROTO_UDPLITE  136
#define IPPROTO_MPLS     137
#define IPPROTO_RAW      255
#define IPPROTO_MAX      263
#ifdef __linux__
#define IPPROTO_MPTCP 262 // Multipath TCP (Linux)
#endif
#define IPV6_V6ONLY  26 // Linux value; macOS=27 -- set via setsockopt only

// IP / IPv6 per-packet class-of-service option names for setsockopt. The
// numbering is BSD-derived on macOS and distinct on Linux.
#ifdef __linux__
#define IP_TOS      1
#define IPV6_TCLASS 67
#else
#define IP_TOS      3
#define IPV6_TCLASS 36
#endif

// TTL / hop-limit and (Linux) error-queue option names for setsockopt.
#ifdef __linux__
#define IP_TTL              2
#define IP_RECVERR          11
#define IPV6_UNICAST_HOPS   16
#define IPV6_RECVERR        25
#else
#define IP_TTL              4
#define IPV6_UNICAST_HOPS   4
#endif

// Multicast setsockopt option names. Linux values; the BSD/macOS numbering
// differs and is added when a macOS target needs it.
#ifdef __linux__
#define IP_MULTICAST_IF     32
#define IP_MULTICAST_TTL    33
#define IP_MULTICAST_LOOP   34
#define IP_ADD_MEMBERSHIP   35
#define IP_DROP_MEMBERSHIP  36
#define IPV6_MULTICAST_IF   17
#define IPV6_MULTICAST_HOPS 18
#define IPV6_MULTICAST_LOOP 19
#define IPV6_JOIN_GROUP     20
#define IPV6_LEAVE_GROUP    21
#endif

// Port number in network byte order.
typedef unsigned short in_port_t;

// IPv4 address in host byte order.
typedef unsigned int in_addr_t;

// Well-known IPv4 addresses in host byte order (uniform across targets).
#define INADDR_ANY             0x00000000U
#define INADDR_BROADCAST       0xffffffffU
#define INADDR_NONE            0xffffffffU
#define INADDR_LOOPBACK        0x7f000001U
#define INADDR_UNSPEC_GROUP    0xe0000000U
#define INADDR_ALLHOSTS_GROUP  0xe0000001U
#define INADDR_ALLRTRS_GROUP   0xe0000002U
#define INADDR_MAX_LOCAL_GROUP 0xe00000ffU

// Address-class predicates on a host-order IPv4 address (uniform across
// targets); IN_MULTICAST tests the class-D 224.0.0.0/4 range.
#define IN_CLASSA(a)       ((((in_addr_t)(a)) & 0x80000000) == 0)
#define IN_CLASSB(a)       ((((in_addr_t)(a)) & 0xc0000000) == 0x80000000)
#define IN_CLASSC(a)       ((((in_addr_t)(a)) & 0xe0000000) == 0xc0000000)
#define IN_CLASSD(a)       ((((in_addr_t)(a)) & 0xf0000000) == 0xe0000000)
#define IN_MULTICAST(a)    IN_CLASSD(a)
#define IN_EXPERIMENTAL(a) ((((in_addr_t)(a)) & 0xe0000000) == 0xe0000000)
#define IN_BADCLASS(a)     ((((in_addr_t)(a)) & 0xf0000000) == 0xf0000000)

// Network-part masks / host-part shifts per class, and the loopback network.
#define IN_CLASSA_NET      0xff000000U
#define IN_CLASSA_NSHIFT   24
#define IN_CLASSA_HOST     0x00ffffffU
#define IN_CLASSA_MAX      128
#define IN_CLASSB_NET      0xffff0000U
#define IN_CLASSB_NSHIFT   16
#define IN_CLASSB_HOST     0x0000ffffU
#define IN_CLASSB_MAX      65536
#define IN_CLASSC_NET      0xffffff00U
#define IN_CLASSC_NSHIFT   8
#define IN_CLASSC_HOST     0x000000ffU
#define IN_CLASSD_NET      0xf0000000U
#define IN_CLASSD_NSHIFT   28
#define IN_LOOPBACKNET     127

// Buffer sizes for the textual forms of an address (POSIX).
#define INET_ADDRSTRLEN  16
#define INET6_ADDRSTRLEN 46

// 4-byte IPv4 address.
struct in_addr {
    unsigned int s_addr;
};

// 16-byte IPv6 address.
struct in6_addr {
    unsigned char s6_addr[16];
};

// 16-byte IPv4 socket address; sin_port at offset 2, sin_addr at offset 4 on
// every target.
#ifdef __APPLE__
struct sockaddr_in {
    unsigned char sin_len;
    unsigned char sin_family;
    unsigned short sin_port;
    struct in_addr sin_addr;
    char sin_zero[8];
};
#elif defined(__linux__) || defined(_WIN32)
struct sockaddr_in {
    unsigned short sin_family;
    unsigned short sin_port;
    struct in_addr sin_addr;
    char sin_zero[8];
};
#endif

// 28-byte IPv6 socket address; sin6_port at 2, sin6_flowinfo at 4,
// sin6_addr at 8, sin6_scope_id at 24 on every target.
#ifdef __APPLE__
struct sockaddr_in6 {
    unsigned char sin6_len;
    unsigned char sin6_family;
    unsigned short sin6_port;
    unsigned int sin6_flowinfo;
    struct in6_addr sin6_addr;
    unsigned int sin6_scope_id;
};
#elif defined(__linux__) || defined(_WIN32)
struct sockaddr_in6 {
    unsigned short sin6_family;
    unsigned short sin6_port;
    unsigned int sin6_flowinfo;
    struct in6_addr sin6_addr;
    unsigned int sin6_scope_id;
};
#endif

// Multicast group membership requests for setsockopt (IP_ADD_MEMBERSHIP /
// IPV6_JOIN_GROUP and their drop counterparts). Layouts are uniform across
// targets: struct in_addr / in6_addr already carry the address bytes.
struct ip_mreq {
    struct in_addr imr_multiaddr; // group address
    struct in_addr imr_interface; // local interface address
};

struct ip_mreqn {
    struct in_addr imr_multiaddr;
    struct in_addr imr_address;   // local interface address
    int imr_ifindex;              // interface index
};

struct ipv6_mreq {
    struct in6_addr ipv6mr_multiaddr;
    unsigned int ipv6mr_interface; // interface index
};


// IN6_ARE_ADDR_EQUAL compares two in6_addr by their 16 bytes. in6addr_any is
// the all-zero unspecified address (POSIX guarantees its value), provided here
// as a const object so callers can take its address without a libc data
// import.

// An IPv4-mapped IPv6 address is ::ffff:a.b.c.d -- bytes 0..9 zero, 10..11
// 0xff, the low 4 the IPv4 address.
#define IN6_IS_ADDR_V4MAPPED(a) ( \
    ((const unsigned int *)(a))[0] == 0 && \
    ((const unsigned int *)(a))[1] == 0 && \
    ((const unsigned char *)(a))[8] == 0 && \
    ((const unsigned char *)(a))[9] == 0 && \
    ((const unsigned char *)(a))[10] == 0xff && \
    ((const unsigned char *)(a))[11] == 0xff)

#define IN6_ARE_ADDR_EQUAL(a, b) ( \
    ((const unsigned int *)(a))[0] == ((const unsigned int *)(b))[0] && \
    ((const unsigned int *)(a))[1] == ((const unsigned int *)(b))[1] && \
    ((const unsigned int *)(a))[2] == ((const unsigned int *)(b))[2] && \
    ((const unsigned int *)(a))[3] == ((const unsigned int *)(b))[3])

// The remaining IPv6 address-class predicates, tested on the 16 address bytes
// so the result is byte-order independent across targets.
#define IN6_IS_ADDR_UNSPECIFIED(a) ( \
    ((const unsigned int *)(a))[0] == 0 && ((const unsigned int *)(a))[1] == 0 && \
    ((const unsigned int *)(a))[2] == 0 && ((const unsigned int *)(a))[3] == 0)

#define IN6_IS_ADDR_LOOPBACK(a) ( \
    ((const unsigned int *)(a))[0] == 0 && ((const unsigned int *)(a))[1] == 0 && \
    ((const unsigned int *)(a))[2] == 0 && \
    ((const unsigned char *)(a))[12] == 0 && ((const unsigned char *)(a))[13] == 0 && \
    ((const unsigned char *)(a))[14] == 0 && ((const unsigned char *)(a))[15] == 1)

#define IN6_IS_ADDR_MULTICAST(a) (((const unsigned char *)(a))[0] == 0xff)

#define IN6_IS_ADDR_LINKLOCAL(a) ( \
    ((const unsigned char *)(a))[0] == 0xfe && \
    (((const unsigned char *)(a))[1] & 0xc0) == 0x80)

#define IN6_IS_ADDR_SITELOCAL(a) ( \
    ((const unsigned char *)(a))[0] == 0xfe && \
    (((const unsigned char *)(a))[1] & 0xc0) == 0xc0)

#define IN6_IS_ADDR_V4COMPAT(a) ( \
    ((const unsigned int *)(a))[0] == 0 && ((const unsigned int *)(a))[1] == 0 && \
    ((const unsigned int *)(a))[2] == 0 && ntohl(((const unsigned int *)(a))[3]) > 1)

// Multicast scope is the low nibble of the second address byte.
#define IN6_IS_ADDR_MC_NODELOCAL(a) \
    (IN6_IS_ADDR_MULTICAST(a) && (((const unsigned char *)(a))[1] & 0xf) == 0x1)
#define IN6_IS_ADDR_MC_LINKLOCAL(a) \
    (IN6_IS_ADDR_MULTICAST(a) && (((const unsigned char *)(a))[1] & 0xf) == 0x2)
#define IN6_IS_ADDR_MC_SITELOCAL(a) \
    (IN6_IS_ADDR_MULTICAST(a) && (((const unsigned char *)(a))[1] & 0xf) == 0x5)
#define IN6_IS_ADDR_MC_ORGLOCAL(a) \
    (IN6_IS_ADDR_MULTICAST(a) && (((const unsigned char *)(a))[1] & 0xf) == 0x8)
#define IN6_IS_ADDR_MC_GLOBAL(a) \
    (IN6_IS_ADDR_MULTICAST(a) && (((const unsigned char *)(a))[1] & 0xf) == 0xe)
static const struct in6_addr in6addr_any;

#ifdef __APPLE__
#pragma binding(libc::htons, "_htons")
#pragma binding(libc::ntohs, "_ntohs")
#pragma binding(libc::htonl, "_htonl")
#pragma binding(libc::ntohl, "_ntohl")
#endif

#ifdef __linux__
#pragma binding(libc::htons, "htons")
#pragma binding(libc::ntohs, "ntohs")
#pragma binding(libc::htonl, "htonl")
#pragma binding(libc::ntohl, "ntohl")
#endif

#ifdef _WIN32
#pragma binding(ws2_32::htons, "htons")
#pragma binding(ws2_32::ntohs, "ntohs")
#pragma binding(ws2_32::htonl, "htonl")
#pragma binding(ws2_32::ntohl, "ntohl")
#endif

unsigned short htons(unsigned short hostshort);
unsigned short ntohs(unsigned short netshort);
unsigned int htonl(unsigned int hostlong);
unsigned int ntohl(unsigned int netlong);
