#pragma once

// Linux syscall numbers. The set is architecture-specific; only the
// numbers reached for by the bundled demos and by QEMU's core threading /
// util layer (via <sys/syscall.h>) are listed. glibc exposes both the
// kernel __NR_<name> and the SYS_<name> alias (SYS_x == __NR_x); code uses
// either, so both are provided. Values verified against the aarch64 and
// x86_64 kernel uapi headers.

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::syscall, "syscall")

#if defined(__aarch64__)
#define __NR_getdents64      61
#define __NR_futex           98
#define __NR_getcpu         168
#define __NR_gettid         178
#define __NR_prlimit64      261
#define __NR_renameat2      276
#define __NR_getrandom      278
#define __NR_memfd_create   279
#define __NR_userfaultfd    282
#define __NR_membarrier     283
#define __NR_copy_file_range 285
#define __NR_statx          291
#define __NR_pidfd_open     434
#define __NR_close_range    436
#else
#define __NR_gettid         186
#define __NR_getdents64     217
#define __NR_futex          202
#define __NR_prlimit64      302
#define __NR_getcpu         309
#define __NR_renameat2      316
#define __NR_getrandom      318
#define __NR_memfd_create   319
#define __NR_userfaultfd    323
#define __NR_membarrier     324
#define __NR_copy_file_range 326
#define __NR_statx          332
#define __NR_pidfd_open     434
#define __NR_close_range    436
#endif

#define SYS_getdents64      __NR_getdents64
#define SYS_futex           __NR_futex
#define SYS_getcpu          __NR_getcpu
#define SYS_gettid          __NR_gettid
#define SYS_prlimit64       __NR_prlimit64
#define SYS_renameat2       __NR_renameat2
#define SYS_getrandom       __NR_getrandom
#define SYS_memfd_create    __NR_memfd_create
#define SYS_userfaultfd     __NR_userfaultfd
#define SYS_membarrier      __NR_membarrier
#define SYS_copy_file_range __NR_copy_file_range
#define SYS_statx           __NR_statx
#define SYS_pidfd_open      __NR_pidfd_open
#define SYS_close_range     __NR_close_range

long syscall(long number, ...);
#endif
