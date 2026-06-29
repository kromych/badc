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
#pragma binding(libc::sched_setscheduler, "_sched_setscheduler")
#pragma binding(libc::sched_getscheduler, "_sched_getscheduler")
#pragma binding(libc::sched_setparam, "_sched_setparam")
#pragma binding(libc::sched_getparam, "_sched_getparam")
#pragma binding(libc::sched_rr_get_interval, "_sched_rr_get_interval")
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
#endif
