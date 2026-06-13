// netinet/in.h -- Internet address family (POSIX 7.40). Struct layouts are
// verified against the system headers on each target: macOS/BSD prefix a
// 1-byte length field, so the leading family region is shaped per target
// while sin_port / sin_addr land at the same offsets everywhere.

#pragma once

#include <sys/socket.h>

#define IPPROTO_IPV6 41
#define IPV6_V6ONLY  26 // Linux value; macOS=27 -- set via setsockopt only

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


// IN6_ARE_ADDR_EQUAL compares two in6_addr by their 16 bytes. in6addr_any is
// the all-zero unspecified address (POSIX guarantees its value), provided here
// as a const object so callers can take its address without a libc data
// import.
#define IN6_ARE_ADDR_EQUAL(a, b) ( \
    ((const unsigned int *)(a))[0] == ((const unsigned int *)(b))[0] && \
    ((const unsigned int *)(a))[1] == ((const unsigned int *)(b))[1] && \
    ((const unsigned int *)(a))[2] == ((const unsigned int *)(b))[2] && \
    ((const unsigned int *)(a))[3] == ((const unsigned int *)(b))[3])
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
