// __badc_in6.h -- the IPv6 address predicates: the IN6_IS_ADDR_* tests of
// RFC 3493, which <netinet/in.h> defines, and IN6_ARE_ADDR_EQUAL, which glibc
// and macOS define beside them. On Windows <ws2tcpip.h> and the ws2ipdef.h it
// includes define the same set. Each tests the 16 address bytes, so the result
// does not depend on the target's byte order.

#pragma once

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
