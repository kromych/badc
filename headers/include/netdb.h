// netdb.h -- network database operations (POSIX 7.39): address and service
// resolution. Layouts and constants are verified against the system headers
// on each target; struct addrinfo's member order and several flag values
// differ between Linux/glibc and macOS/BSD.

#pragma once

#include <sys/types.h> // socklen_t
#include <sys/socket.h>

// `struct addrinfo` is filled by getaddrinfo and walked by the caller
// (ai_family / ai_socktype / ai_protocol / ai_addr / ai_addrlen / ai_next).
// macOS/BSD order ai_canonname before ai_addr; Linux/glibc the reverse. Both
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
#if defined(__APPLE__) || defined(_WIN32)
#define AI_ADDRCONFIG  0x0400
#define NI_NUMERICHOST 0x0002
#define NI_NUMERICSERV 0x0008
#elif defined(__linux__)
#define AI_ADDRCONFIG  0x0020
#define NI_NUMERICHOST 0x0001
#define NI_NUMERICSERV 0x0002
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
#pragma binding(libc::gethostbyname,"_gethostbyname")
#endif

#ifdef __linux__
#pragma binding(libc::getaddrinfo,  "getaddrinfo")
#pragma binding(libc::freeaddrinfo, "freeaddrinfo")
#pragma binding(libc::getnameinfo,  "getnameinfo")
#pragma binding(libc::gai_strerror, "gai_strerror")
#pragma binding(libc::getservbyname,"getservbyname")
#pragma binding(libc::gethostbyname,"gethostbyname")
#endif

#ifdef _WIN32
#pragma binding(ws2_32::getaddrinfo,  "getaddrinfo")
#pragma binding(ws2_32::freeaddrinfo, "freeaddrinfo")
#pragma binding(ws2_32::getnameinfo,  "getnameinfo")
#pragma binding(ws2_32::getservbyname,"getservbyname")
#pragma binding(ws2_32::gethostbyname,"gethostbyname")
#endif

int getaddrinfo(const char *node, const char *service,
                const struct addrinfo *hints, struct addrinfo **res);
void freeaddrinfo(struct addrinfo *res);
int getnameinfo(const struct sockaddr *sa, socklen_t salen, char *host,
                socklen_t hostlen, char *serv, socklen_t servlen, int flags);
const char *gai_strerror(int errcode);
struct servent *getservbyname(const char *name, const char *proto);
struct hostent *gethostbyname(const char *name);
