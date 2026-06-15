// arpa/inet.h -- Internet address manipulation (POSIX 7.4).

#pragma once

#include <netinet/in.h>

#ifdef __APPLE__
#pragma binding(libc::inet_ntoa, "_inet_ntoa")
#pragma binding(libc::inet_addr, "_inet_addr")
#pragma binding(libc::inet_ntop, "_inet_ntop")
#pragma binding(libc::inet_pton, "_inet_pton")
#endif

#ifdef __linux__
#pragma binding(libc::inet_ntoa, "inet_ntoa")
#pragma binding(libc::inet_addr, "inet_addr")
#pragma binding(libc::inet_ntop, "inet_ntop")
#pragma binding(libc::inet_pton, "inet_pton")
#endif

#ifdef _WIN32
#pragma binding(ws2_32::inet_ntoa, "inet_ntoa")
#pragma binding(ws2_32::inet_addr, "inet_addr")
#pragma binding(ws2_32::inet_ntop, "inet_ntop")
#pragma binding(ws2_32::inet_pton, "inet_pton")
#endif

char *inet_ntoa(struct in_addr in);
unsigned int inet_addr(const char *cp);
const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
int inet_pton(int af, const char *src, void *dst);
