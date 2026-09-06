// sys/sysinfo.h -- Linux system statistics.
//
// The kernel writes `struct sysinfo`, so the field offsets are the
// 64-bit layout's; the trailing pad covers the record's full 112 bytes.
// Memory sizes are in units of `mem_unit` bytes.

#pragma once

#ifdef __linux__

struct sysinfo {
    long          uptime;     /* offset   0, seconds since boot */
    unsigned long loads[3];   /* offset   8, 1/5/15-minute load, 1<<16 fixed */
    unsigned long totalram;   /* offset  32 */
    unsigned long freeram;    /* offset  40 */
    unsigned long sharedram;  /* offset  48 */
    unsigned long bufferram;  /* offset  56 */
    unsigned long totalswap;  /* offset  64 */
    unsigned long freeswap;   /* offset  72 */
    unsigned short procs;     /* offset  80, current process count */
    unsigned short __pad0;    /* offset  82 */
    unsigned long totalhigh;  /* offset  88 */
    unsigned long freehigh;   /* offset  96 */
    unsigned int mem_unit;    /* offset 104 */
    unsigned char __pad1[4];  /* offset 108, record ends at 112 */
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::sysinfo, "sysinfo")
#pragma binding(libc::get_nprocs, "get_nprocs")
#pragma binding(libc::get_nprocs_conf, "get_nprocs_conf")
#pragma binding(libc::get_phys_pages, "get_phys_pages")
#pragma binding(libc::get_avphys_pages, "get_avphys_pages")

int sysinfo(struct sysinfo *info);
// Processors online and configured, and physical pages total and free.
int get_nprocs(void);
int get_nprocs_conf(void);
long get_phys_pages(void);
long get_avphys_pages(void);

#endif
