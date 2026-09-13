/* <sys/syscall.h>: the kernel table of each Linux architecture under both
 * __NR_<name> and SYS_<name>, and no number on another target. */
#include <sys/syscall.h>

#if defined(__linux__) && defined(__x86_64__)
#if SYS_read != 0 || SYS_write != 1 || SYS_close != 3 || SYS_lseek != 8 || \
    SYS_nanosleep != 35 || SYS_sync != 162 || SYS_mount != 165 || \
    SYS_reboot != 169 || SYS_openat != 257 || SYS_mkdirat != 258 || \
    SYS_finit_module != 313 || SYS_clone != 56 || SYS_execve != 59 || \
    SYS_wait4 != 61 || SYS_exit_group != 231
#error "x86_64 syscall numbers"
#endif
_Static_assert(SYS_syslog == 103 && SYS_setns == 308 && SYS_pivot_root == 155 &&
                   SYS_perf_event_open == 298 && __NR_perf_event_open == 298,
               "x86_64 table");
/* ABIs common and 64: the names the x32 rows reuse keep their 64 numbers. */
_Static_assert(SYS_open == 2 && SYS_rt_sigaction == 13 && SYS_ioctl == 16 &&
                   SYS_uretprobe == 335 && SYS_rseq_slice_yield == 471,
               "x86_64 ABI set");
#endif

#if defined(__linux__) && defined(__aarch64__)
#if SYS_mkdirat != 34 || SYS_mount != 40 || SYS_openat != 56 || \
    SYS_close != 57 || SYS_lseek != 62 || SYS_read != 63 || SYS_write != 64 || \
    SYS_sync != 81 || SYS_nanosleep != 101 || SYS_reboot != 142 || \
    SYS_finit_module != 273 || SYS_exit_group != 94 || SYS_clone != 220 || \
    SYS_execve != 221 || SYS_wait4 != 260
#error "aarch64 syscall numbers"
#endif
_Static_assert(SYS_syslog == 116 && SYS_setns == 268 && SYS_pivot_root == 41 &&
                   SYS_perf_event_open == 241 && __NR_perf_event_open == 241,
               "aarch64 table");
/* ABIs common, 64, renameat, rlimit and memfd_secret of the generic table. */
_Static_assert(SYS_renameat == 38 && SYS_getrlimit == 163 && SYS_setrlimit == 164 &&
                   SYS_memfd_secret == 447 && SYS_fcntl == 25 && SYS_fstat == 80 &&
                   SYS_rseq_slice_yield == 471,
               "aarch64 ABI set");
#if defined(SYS_open) || defined(SYS_fcntl64) || defined(SYS_fstatat64) || \
    defined(SYS_riscv_hwprobe)
#error "a row outside the aarch64 ABI set"
#endif
#endif

#if !defined(__linux__) && (defined(SYS_read) || defined(__NR_read))
#error "a syscall number outside Linux"
#endif

int main(void) {
#if defined(__linux__) && defined(__x86_64__)
    if (SYS_arch_prctl != 158 || __NR_arch_prctl != 158)
        return 1;
    if (SYS_finit_module != 313 || __NR_finit_module != 313)
        return 3;
#endif
#if defined(__linux__) && defined(__aarch64__)
#ifdef SYS_arch_prctl
    return 2; /* not an aarch64 syscall */
#endif
    if (SYS_finit_module != 273 || __NR_finit_module != 273)
        return 3;
#endif
    return 0;
}
