// netinet/tcp.h -- TCP-level socket options (IPPROTO_TCP setsockopt names).
// TCP_NODELAY and TCP_MAXSEG share values across targets; the keep-alive
// tuning names are BSD-numbered on macOS and distinct on Linux.

#pragma once

#define TCP_NODELAY 1
#define TCP_MAXSEG  2

#ifdef __linux__
#define TCP_KEEPIDLE   4
#define TCP_KEEPINTVL  5
#define TCP_KEEPCNT    6
#define TCP_FASTOPEN   23
#elif defined(__APPLE__)
#define TCP_KEEPALIVE  0x10
#define TCP_KEEPINTVL  0x101
#define TCP_KEEPCNT    0x102
#define TCP_FASTOPEN   0x105
#endif
