/* <sys/syscall.h> exposes the architecture's syscall numbers under both
 * the kernel __NR_<name> and the glibc SYS_<name> alias; arch_prctl
 * exists on x86-64 only. */
#ifdef __linux__
#include <sys/syscall.h>
#endif

int main(void) {
#if defined(__linux__) && defined(__x86_64__)
    if (SYS_arch_prctl != 158 || __NR_arch_prctl != 158)
        return 1;
#endif
#if defined(__linux__) && defined(__aarch64__)
#ifdef SYS_arch_prctl
    return 2; /* not an aarch64 syscall */
#endif
#endif
    return 0;
}
