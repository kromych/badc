// sys/sys_domain.h -- Darwin AF_SYSTEM kernel-socket domain.

#pragma once

#ifdef __APPLE__
#include <stdint.h>

#define SYSPROTO_EVENT 1
#define SYSPROTO_CONTROL 2
#define AF_SYS_CONTROL 2

struct sockaddr_sys {
    unsigned char ss_len;
    unsigned char ss_family;
    uint16_t ss_sysaddr;
    uint32_t ss_reserved[7];
};
#endif
