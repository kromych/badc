// Process scheduling (POSIX.1).

#pragma once

#if defined(__APPLE__) || defined(__linux__)
// Scheduling parameters. POSIX requires only `sched_priority`; macOS
// carries 4 trailing opaque bytes, so size the struct to cover both.
struct sched_param {
    int sched_priority;
    unsigned char __opaque[4];
};

// Scheduling policies. The numbering reaches the host libc, so each
// target uses its own values.
#ifdef __APPLE__
#define SCHED_OTHER 1
#define SCHED_RR    2
#define SCHED_FIFO  4
#else
#define SCHED_OTHER 0
#define SCHED_FIFO  1
#define SCHED_RR    2
#define SCHED_BATCH 3
#define SCHED_IDLE  5
#endif
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::sched_yield, "_sched_yield")
#pragma binding(libc::sched_get_priority_max, "_sched_get_priority_max")
#pragma binding(libc::sched_get_priority_min, "_sched_get_priority_min")
// libSystem exports none of sched_setscheduler / sched_getscheduler /
// sched_setparam / sched_getparam / sched_rr_get_interval; leaving
// them unbound makes a use fail at link rather than at load.
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::sched_yield, "sched_yield")
#pragma binding(libc::sched_get_priority_max, "sched_get_priority_max")
#pragma binding(libc::sched_get_priority_min, "sched_get_priority_min")
#pragma binding(libc::sched_setscheduler, "sched_setscheduler")
#pragma binding(libc::sched_getscheduler, "sched_getscheduler")
#pragma binding(libc::sched_setparam, "sched_setparam")
#pragma binding(libc::sched_getparam, "sched_getparam")
#pragma binding(libc::sched_rr_get_interval, "sched_rr_get_interval")
#pragma binding(libc::sched_setaffinity, "sched_setaffinity")
#pragma binding(libc::sched_getaffinity, "sched_getaffinity")
#pragma binding(libc::setns,    "setns")
#pragma binding(libc::unshare,  "unshare")
#pragma binding(libc::clone,    "clone")
#endif

int sched_yield(void);
#if defined(__APPLE__) || defined(__linux__)
int sched_get_priority_max(int policy);
int sched_get_priority_min(int policy);
int sched_setscheduler(int pid, int policy, const struct sched_param *param);
int sched_getscheduler(int pid);
int sched_setparam(int pid, const struct sched_param *param);
int sched_getparam(int pid, struct sched_param *param);
int sched_rr_get_interval(int pid, char *interval);
#endif
#ifdef __linux__
// CPU affinity (Linux; `cpu_set_t` is opaque to c5, passed by address).
int sched_setaffinity(int pid, unsigned long cpusetsize, char *mask);
int sched_getaffinity(int pid, unsigned long cpusetsize, char *mask);
// Namespace control (Linux).
int setns(int fd, int nstype);
int unshare(int flags);

// clone()/unshare() flags (linux/sched.h).
#define CLONE_VM       0x00000100
#define CLONE_FS       0x00000200
#define CLONE_FILES    0x00000400
#define CLONE_SIGHAND  0x00000800
#define CLONE_VFORK    0x00004000
#define CLONE_THREAD   0x00010000
#define CLONE_NEWNS    0x00020000
#define CLONE_SYSVSEM  0x00040000
#define CLONE_SETTLS   0x00080000
#define CLONE_UNTRACED 0x00800000
#define CLONE_NEWUTS   0x04000000
#define CLONE_NEWIPC   0x08000000
#define CLONE_NEWUSER  0x10000000
#define CLONE_NEWPID   0x20000000
#define CLONE_NEWNET   0x40000000
#define CLONE_IO       0x80000000

// clone(2) glibc wrapper; the variadic tail carries the optional
// parent-tid / tls / child-tid arguments.
int clone(int (*fn)(void *), void *stack, int flags, void *arg, ...);

// CPU affinity sets (Linux). cpu_set_t is a fixed 1024-bit mask; the *_S
// macros operate on a caller-sized buffer so larger masks are reachable via
// CPU_ALLOC. malloc/free/memset back the dynamic form.
#include <stdlib.h>
#include <string.h>
#define CPU_SETSIZE 1024
#define __NCPUBITS  (8 * sizeof(unsigned long))
typedef struct {
    unsigned long __bits[CPU_SETSIZE / (8 * sizeof(unsigned long))];
} cpu_set_t;

#define CPU_ALLOC_SIZE(count) \
    ((((count) + __NCPUBITS - 1) / __NCPUBITS) * sizeof(unsigned long))
#define CPU_ALLOC(count) ((cpu_set_t *)malloc(CPU_ALLOC_SIZE(count)))
#define CPU_FREE(set)    free((char *)(set))

#define CPU_ZERO_S(setsize, set) memset((char *)(set), 0, setsize)
#define CPU_SET_S(cpu, setsize, set) \
    ((void)((unsigned long)(cpu) < (unsigned long)(setsize) * 8 \
        ? (((unsigned long *)(set))[(cpu) / __NCPUBITS] |= 1UL << ((cpu) % __NCPUBITS)) \
        : 0UL))
#define CPU_CLR_S(cpu, setsize, set) \
    ((void)((unsigned long)(cpu) < (unsigned long)(setsize) * 8 \
        ? (((unsigned long *)(set))[(cpu) / __NCPUBITS] &= ~(1UL << ((cpu) % __NCPUBITS))) \
        : 0UL))
#define CPU_ISSET_S(cpu, setsize, set) \
    ((unsigned long)(cpu) < (unsigned long)(setsize) * 8 \
        ? ((((unsigned long *)(set))[(cpu) / __NCPUBITS] >> ((cpu) % __NCPUBITS)) & 1UL) \
        : 0UL)
// Set-bit count over the first `setsize` bytes; matches glibc __sched_cpucount
// (popcount of each mask word).
static inline int __cpu_count_s(unsigned long setsize, const unsigned long *bits) {
    int n = 0;
    for (unsigned long i = 0; i < setsize / sizeof(unsigned long); i++)
        n += __builtin_popcountl(bits[i]);
    return n;
}
#define CPU_COUNT_S(setsize, set) __cpu_count_s((setsize), (const unsigned long *)(set))

#define CPU_ZERO(set)       CPU_ZERO_S(sizeof(cpu_set_t), set)
#define CPU_SET(cpu, set)   CPU_SET_S(cpu, sizeof(cpu_set_t), set)
#define CPU_CLR(cpu, set)   CPU_CLR_S(cpu, sizeof(cpu_set_t), set)
#define CPU_ISSET(cpu, set) CPU_ISSET_S(cpu, sizeof(cpu_set_t), set)
#define CPU_COUNT(set)      CPU_COUNT_S(sizeof(cpu_set_t), set)
#endif
