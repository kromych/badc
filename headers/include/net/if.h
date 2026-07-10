// net/if.h -- mapping between network interface names and indices (POSIX).

#pragma once

#define IF_NAMESIZE 16
#define IFNAMSIZ    16

struct if_nameindex {
    unsigned int if_index;
    char *if_name;
};

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
