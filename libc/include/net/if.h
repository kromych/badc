// net/if.h -- mapping between network interface names and indices (POSIX).

#pragma once

#define IF_NAMESIZE 16
#define IFNAMSIZ    16

struct if_nameindex {
    unsigned int if_index;
    char *if_name;
};

#ifdef __linux__
// Interface request block passed to the SIOC* / TUNSETIFF ioctls. The name
// and value share storage through the ifr_ifrn / ifr_ifru unions; the ifr_*
// macros select the active member (glibc layout).
#include <sys/socket.h>

struct ifmap {
    unsigned long mem_start;
    unsigned long mem_end;
    unsigned short base_addr;
    unsigned char irq;
    unsigned char dma;
    unsigned char port;
};

struct ifreq {
    union {
        char ifrn_name[IFNAMSIZ];
    } ifr_ifrn;
    union {
        struct sockaddr ifru_addr;
        struct sockaddr ifru_dstaddr;
        struct sockaddr ifru_broadaddr;
        struct sockaddr ifru_netmask;
        struct sockaddr ifru_hwaddr;
        short ifru_flags;
        int ifru_ivalue;
        int ifru_mtu;
        struct ifmap ifru_map;
        char ifru_slave[IFNAMSIZ];
        char ifru_newname[IFNAMSIZ];
        char *ifru_data;
    } ifr_ifru;
};
#define ifr_name      ifr_ifrn.ifrn_name
#define ifr_hwaddr    ifr_ifru.ifru_hwaddr
#define ifr_addr      ifr_ifru.ifru_addr
#define ifr_dstaddr   ifr_ifru.ifru_dstaddr
#define ifr_broadaddr ifr_ifru.ifru_broadaddr
#define ifr_netmask   ifr_ifru.ifru_netmask
#define ifr_flags     ifr_ifru.ifru_flags
#define ifr_metric    ifr_ifru.ifru_ivalue
#define ifr_mtu       ifr_ifru.ifru_mtu
#define ifr_map       ifr_ifru.ifru_map
#define ifr_slave     ifr_ifru.ifru_slave
#define ifr_ifindex   ifr_ifru.ifru_ivalue
#define ifr_data      ifr_ifru.ifru_data
#define ifr_newname   ifr_ifru.ifru_newname
// Socket interface-configuration ioctls (linux/sockios.h). Arch independent.
#define SIOCGIFNAME    0x8910
#define SIOCGIFCONF    0x8912
#define SIOCGIFFLAGS   0x8913
#define SIOCSIFFLAGS   0x8914
#define SIOCGIFADDR    0x8915
#define SIOCSIFADDR    0x8916
#define SIOCGIFDSTADDR 0x8917
#define SIOCGIFBRDADDR 0x8919
#define SIOCGIFNETMASK 0x891b
#define SIOCSIFNETMASK 0x891c
#define SIOCGIFMTU     0x8921
#define SIOCSIFMTU     0x8922
#define SIOCSIFHWADDR  0x8924
#define SIOCGIFHWADDR  0x8927
#define SIOCGIFINDEX   0x8933
#define SIOCGIFTXQLEN  0x8942
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::if_nameindex,     "_if_nameindex")
#pragma binding(libc::if_freenameindex, "_if_freenameindex")
#pragma binding(libc::if_indextoname,   "_if_indextoname")
#pragma binding(libc::if_nametoindex,   "_if_nametoindex")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::if_nameindex,     "if_nameindex")
#pragma binding(libc::if_freenameindex, "if_freenameindex")
#pragma binding(libc::if_indextoname,   "if_indextoname")
#pragma binding(libc::if_nametoindex,   "if_nametoindex")
#endif

struct if_nameindex *if_nameindex(void);
void if_freenameindex(struct if_nameindex *ptr);
char *if_indextoname(unsigned int ifindex, char *ifname);
unsigned int if_nametoindex(const char *ifname);
