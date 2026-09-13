/* Linux system call numbers through <sys/syscall.h>, or through the header
 * UNISTD_HEADER names: the kernel table of each Linux architecture as
 * __NR_<name>, SYS_<name> from <sys/syscall.h> alone, no number elsewhere. */
#ifdef UNISTD_HEADER
#include UNISTD_HEADER
#else
#include <sys/syscall.h>
#endif

#if defined(__linux__) && defined(SYS_read) == defined(UNISTD_HEADER)
#error "SYS_<name> comes from <sys/syscall.h> alone"
#endif

#if defined(__linux__) && defined(__x86_64__)
#if __NR_read != 0 || __NR_write != 1 || __NR_close != 3 || __NR_lseek != 8 || \
    __NR_nanosleep != 35 || __NR_sync != 162 || __NR_mount != 165 || \
    __NR_reboot != 169 || __NR_openat != 257 || __NR_mkdirat != 258 || \
    __NR_finit_module != 313 || __NR_clone != 56 || __NR_execve != 59 || \
    __NR_wait4 != 61 || __NR_exit_group != 231
#error "x86_64 syscall numbers"
#endif
_Static_assert(__NR_syslog == 103 && __NR_setns == 308 && __NR_pivot_root == 155 &&
                   __NR_perf_event_open == 298,
               "x86_64 table");
/* ABIs common and 64: the names the x32 rows reuse keep their 64 numbers. */
_Static_assert(__NR_open == 2 && __NR_rt_sigaction == 13 && __NR_ioctl == 16 &&
                   __NR_uretprobe == 335 && __NR_rseq_slice_yield == 471,
               "x86_64 ABI set");
_Static_assert(__X32_SYSCALL_BIT == 0x40000000, "x86_64 uapi macros");
#endif

#if defined(__linux__) && defined(__aarch64__)
#if __NR_mkdirat != 34 || __NR_mount != 40 || __NR_openat != 56 || \
    __NR_close != 57 || __NR_lseek != 62 || __NR_read != 63 || __NR_write != 64 || \
    __NR_sync != 81 || __NR_nanosleep != 101 || __NR_reboot != 142 || \
    __NR_finit_module != 273 || __NR_exit_group != 94 || __NR_clone != 220 || \
    __NR_execve != 221 || __NR_wait4 != 260
#error "aarch64 syscall numbers"
#endif
_Static_assert(__NR_syslog == 116 && __NR_setns == 268 && __NR_pivot_root == 41 &&
                   __NR_perf_event_open == 241,
               "aarch64 table");
/* ABIs common, 64, renameat, rlimit and memfd_secret of the generic table. */
_Static_assert(__NR_renameat == 38 && __NR_getrlimit == 163 && __NR_setrlimit == 164 &&
                   __NR_memfd_secret == 447 && __NR_fcntl == 25 && __NR_fstat == 80 &&
                   __NR_rseq_slice_yield == 471,
               "aarch64 ABI set");
#if defined(__NR_open) || defined(__NR_fcntl64) || defined(__NR_fstatat64) || \
    defined(__NR_riscv_hwprobe) || defined(__X32_SYSCALL_BIT) || \
    defined(SYS_open) || defined(SYS_arch_prctl)
#error "a row or macro outside the aarch64 set"
#endif
#endif

#if defined(__linux__) && !defined(UNISTD_HEADER)
_Static_assert(SYS_syslog == __NR_syslog && SYS_setns == __NR_setns &&
                   SYS_pivot_root == __NR_pivot_root &&
                   SYS_perf_event_open == __NR_perf_event_open && SYS_read == __NR_read,
               "SYS_<name> aliases");
#if defined(__x86_64__) && SYS_arch_prctl != 158
#error "x86_64 SYS_arch_prctl"
#endif
#endif

#if !defined(__linux__) && \
    (defined(SYS_read) || defined(__NR_read) || defined(__X32_SYSCALL_BIT))
#error "a syscall number outside Linux"
#endif

int main(void) {
#if defined(__linux__) && defined(__x86_64__)
    if (__NR_arch_prctl != 158)
        return 1;
    if (__NR_finit_module != 313)
        return 3;
#endif
#if defined(__linux__) && defined(__aarch64__)
#ifdef __NR_arch_prctl
    return 2; /* not an aarch64 syscall */
#endif
    if (__NR_finit_module != 273)
        return 3;
#endif
#if defined(__linux__) && !defined(UNISTD_HEADER)
    if (SYS_finit_module != __NR_finit_module)
        return 4;
#endif
    return 0;
}
