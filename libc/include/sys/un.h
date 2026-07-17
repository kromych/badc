// sys/un.h -- Unix-domain socket address (POSIX). The layout reaches the host
// libc, so the member order and sun_path length match each target.

#pragma once

struct sockaddr_un {
#ifdef __APPLE__
    unsigned char sun_len;
    unsigned char sun_family;
    char sun_path[104];
#else
    unsigned short sun_family;
    char sun_path[108];
#endif
};
