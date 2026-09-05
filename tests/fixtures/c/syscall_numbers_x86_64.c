/* <sys/syscall.h> exposes the architecture's syscall numbers under both
 * the kernel __NR_<name> and the glibc SYS_<name> alias; arch_prctl
 * exists on x86-64 only. */
#ifdef __linux__
#include <sys/syscall.h>
#endif

/* The numbers a program with no C library reaches for, pinned per
 * architecture at preprocessing time so a cross compile checks them too;
 * an undefined name reads as 0 here and fails the same way. */
#if defined(__linux__) && defined(__x86_64__)
#if SYS_read != 0 || SYS_write != 1 || SYS_close != 3 || SYS_lseek != 8 || \
    SYS_nanosleep != 35 || SYS_sync != 162 || SYS_mount != 165 || \
    SYS_reboot != 169 || SYS_openat != 257 || SYS_mkdirat != 258 || \
    SYS_finit_module != 313
#error "x86_64 syscall numbers"
#endif
#endif
#if defined(__linux__) && defined(__aarch64__)
#if SYS_mkdirat != 34 || SYS_mount != 40 || SYS_openat != 56 || \
    SYS_close != 57 || SYS_lseek != 62 || SYS_read != 63 || SYS_write != 64 || \
    SYS_sync != 81 || SYS_nanosleep != 101 || SYS_reboot != 142 || \
    SYS_finit_module != 273
#error "aarch64 syscall numbers"
#endif
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
