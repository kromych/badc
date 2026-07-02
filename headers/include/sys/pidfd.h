// sys/pidfd.h -- process file descriptors (glibc 2.36, Linux 5.3+).

#pragma once

#ifdef __linux__
#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>

// Matches the kernel uapi definition: O_NONBLOCK on every arch.
#define PIDFD_NONBLOCK O_NONBLOCK

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::pidfd_open, "pidfd_open")
#pragma binding(libc::pidfd_getfd, "pidfd_getfd")
#pragma binding(libc::pidfd_send_signal, "pidfd_send_signal")

int pidfd_open(pid_t pid, unsigned int flags);
int pidfd_getfd(int pidfd, int targetfd, unsigned int flags);
int pidfd_send_signal(int pidfd, int sig, siginfo_t *info, unsigned int flags);
#endif
