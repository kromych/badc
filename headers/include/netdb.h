// netdb.h -- network database operations (POSIX 7.39): address and service
// resolution. Layouts and constants are verified against the system headers
// on each target; struct addrinfo's member order and several flag values
// differ between Linux and macOS/BSD.

#pragma once

#include <sys/types.h> // socklen_t
#include <sys/socket.h>

// `struct addrinfo` is filled by getaddrinfo and walked by the caller
// (ai_family / ai_socktype / ai_protocol / ai_addr / ai_addrlen / ai_next).
// macOS/BSD order ai_canonname before ai_addr; Linux the reverse. Both
// are 48 bytes on a 64-bit target.
#if defined(__APPLE__) || defined(_WIN32)
struct addrinfo {
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    // Windows types ai_addrlen as size_t (8 bytes); macOS as socklen_t (4
    // bytes) followed by 4 bytes of padding. Either way ai_canonname lands at
    // offset 24, so the two declarations are layout-compatible.
#ifdef _WIN32
    unsigned long long ai_addrlen;
#else
    socklen_t ai_addrlen;
#endif
    char *ai_canonname;
    struct sockaddr *ai_addr;
    struct addrinfo *ai_next;
};
#elif defined(__linux__)
struct addrinfo {
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    socklen_t ai_addrlen;
    struct sockaddr *ai_addr;
    char *ai_canonname;
    struct addrinfo *ai_next;
};
#endif

// POSIX `struct servent` and `struct hostent` -- identical layout on every
// supported target.
struct servent {
    char *s_name;
    char **s_aliases;
    int s_port;
    char *s_proto;
};

// `struct protoent` is provided by <winsock2.h> on Windows; defining it here as
// well would redefine it wherever both headers are included (ws2tcpip.h pulls in
// netdb.h). servent and hostent are not declared by winsock2.h, so they stay.
#ifndef _WIN32
struct protoent {
    char *p_name;
    char **p_aliases;
    int p_proto;
};
#endif

struct hostent {
    char *h_name;
    char **h_aliases;
    int h_addrtype;
    int h_length;
    char **h_addr_list;
};

// getaddrinfo hints / getnameinfo flags. AI_PASSIVE, NI_MAXHOST and
// NI_MAXSERV match across targets; the rest differ.
#define AI_PASSIVE 0x0001
#define NI_MAXHOST 1025
#define NI_MAXSERV 32
#define AI_CANONNAME 0x0002
#define AI_NUMERICHOST 0x0004
#if defined(__APPLE__) || defined(_WIN32)
#define AI_ADDRCONFIG  0x0400
#define NI_NUMERICHOST 0x0002
#define NI_NUMERICSERV 0x0008
#define AI_NUMERICSERV 0x1000
#define AI_ALL 0x0100
#define AI_V4MAPPED 0x0800
#define NI_NOFQDN 0x01
#define NI_NAMEREQD 0x04
#define NI_DGRAM 0x10
#elif defined(__linux__)
#define AI_ADDRCONFIG  0x0020
#define NI_NUMERICHOST 0x0001
#define NI_NUMERICSERV 0x0002
#define AI_NUMERICSERV 0x0400
#define AI_ALL 0x0010
#define AI_V4MAPPED 0x0008
#define NI_NOFQDN 0x04
#define NI_NAMEREQD 0x08
#define NI_DGRAM 0x10
#endif
// EAI_SYSTEM: positive on macOS, negative on Linux; Windows does not define it.
#ifdef __APPLE__
#define EAI_SYSTEM 11
#elif defined(__linux__)
#define EAI_SYSTEM (-11)
#endif

#ifdef __APPLE__
#pragma binding(libc::getaddrinfo,  "_getaddrinfo")
#pragma binding(libc::freeaddrinfo, "_freeaddrinfo")
#pragma binding(libc::getnameinfo,  "_getnameinfo")
#pragma binding(libc::gai_strerror, "_gai_strerror")
#pragma binding(libc::getservbyname,"_getservbyname")
#pragma binding(libc::getservbyport,"_getservbyport")
#pragma binding(libc::getprotobyname,"_getprotobyname")
#pragma binding(libc::getprotobynumber,"_getprotobynumber")
#pragma binding(libc::gethostbyname,"_gethostbyname")
#pragma binding(libc::hstrerror,   "_hstrerror")
#pragma binding(libc::gethostbyaddr,"_gethostbyaddr")
#endif

#ifdef __linux__
#pragma binding(libc::getaddrinfo,  "getaddrinfo")
#pragma binding(libc::freeaddrinfo, "freeaddrinfo")
#pragma binding(libc::getnameinfo,  "getnameinfo")
#pragma binding(libc::gai_strerror, "gai_strerror")
#pragma binding(libc::getservbyname,"getservbyname")
#pragma binding(libc::getservbyport,"getservbyport")
#pragma binding(libc::getprotobyname,"getprotobyname")
#pragma binding(libc::getprotobynumber,"getprotobynumber")
#pragma binding(libc::gethostbyname,"gethostbyname")
#pragma binding(libc::hstrerror,   "hstrerror")
#pragma binding(libc::gethostbyaddr,"gethostbyaddr")
// Linux reentrant resolver variants (GNU extensions). configure
// selects these over the non-reentrant forms when present, so a
// program built against the Linux C library references them by name. macOS resolves
// the MT-safe non-_r forms instead and never names these.
#pragma binding(libc::gethostbyname_r,"gethostbyname_r")
#pragma binding(libc::gethostbyaddr_r,"gethostbyaddr_r")
#endif

#ifdef _WIN32
#pragma binding(ws2_32::getaddrinfo,  "getaddrinfo")
#pragma binding(ws2_32::freeaddrinfo, "freeaddrinfo")
#pragma binding(ws2_32::getnameinfo,  "getnameinfo")
#pragma binding(ws2_32::getservbyname,"getservbyname")
#pragma binding(ws2_32::getservbyport,"getservbyport")
#pragma binding(ws2_32::getprotobyname,"getprotobyname")
#pragma binding(ws2_32::getprotobynumber,"getprotobynumber")
#pragma binding(ws2_32::gethostbyname,"gethostbyname")
#pragma binding(ws2_32::gethostbyaddr,"gethostbyaddr")
#endif

int getaddrinfo(const char *node, const char *service,
                const struct addrinfo *hints, struct addrinfo **res);
void freeaddrinfo(struct addrinfo *res);
int getnameinfo(const struct sockaddr *sa, socklen_t salen, char *host,
                socklen_t hostlen, char *serv, socklen_t servlen, int flags);
const char *gai_strerror(int errcode);
// Error string for an h_errno value (the network database).
const char *hstrerror(int err);

// h_errno: the network-database error code. macOS exposes it as a data
// symbol; glibc routes it through a thread-local accessor (like errno).
#ifdef __APPLE__
#pragma binding(data libc::h_errno, "_h_errno")
extern int h_errno;
#elif defined(__linux__)
#pragma binding(libc::__h_errno_location, "__h_errno_location")
int *__h_errno_location(void);
#define h_errno (*__h_errno_location())
#endif
struct servent *getservbyname(const char *name, const char *proto);
struct servent *getservbyport(int port, const char *proto);
struct protoent *getprotobyname(const char *name);
struct protoent *getprotobynumber(int proto);
struct hostent *gethostbyname(const char *name);
struct hostent *gethostbyaddr(const void *addr, unsigned int len, int type);
#ifdef __linux__
// Linux 6-argument / 8-argument reentrant resolver forms: fill the
// caller's `struct hostent` + scratch buffer, set `*result` and return
// 0 on success or an error code, writing the resolver error to
// `*h_errnop`.
int gethostbyname_r(const char *name, struct hostent *ret, char *buf,
                    unsigned long buflen, struct hostent **result,
                    int *h_errnop);
int gethostbyaddr_r(const void *addr, unsigned int len, int type,
                    struct hostent *ret, char *buf, unsigned long buflen,
                    struct hostent **result, int *h_errnop);
#endif
