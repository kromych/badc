// sys/sysctl.h -- Darwin sysctl(3) MIB interface: the common CTL_KERN
// and CTL_HW names plus the three entry points. TODO: the per-subtree
// name tables.

#pragma once

#ifdef __APPLE__
#include <stddef.h>

#define CTL_MAXNAME 12
#define CTL_KERN 1
#define CTL_VM 2
#define CTL_NET 4
#define CTL_HW 6
#define CTL_MACHDEP 7
#define CTL_USER 8

#define KERN_OSTYPE 1
#define KERN_OSRELEASE 2
#define KERN_OSREV 3
#define KERN_VERSION 4
#define KERN_MAXVNODES 5
#define KERN_ARGMAX 8
#define KERN_HOSTNAME 10
#define KERN_PROC 14
#define KERN_OSVERSION 65

#define HW_MACHINE 1
#define HW_MODEL 2
#define HW_NCPU 3
#define HW_BYTEORDER 4
#define HW_PHYSMEM 5
#define HW_USERMEM 6
#define HW_PAGESIZE 7
#define HW_MACHINE_ARCH 12
#define HW_MEMSIZE 24
#define HW_AVAILCPU 25

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::sysctl, "_sysctl")
#pragma binding(libc::sysctlbyname, "_sysctlbyname")
#pragma binding(libc::sysctlnametomib, "_sysctlnametomib")

int sysctl(int *name, unsigned int namelen, void *oldp, size_t *oldlenp,
           void *newp, size_t newlen);
int sysctlbyname(const char *name, void *oldp, size_t *oldlenp, void *newp,
                 size_t newlen);
int sysctlnametomib(const char *name, int *mibp, size_t *sizep);
#endif
