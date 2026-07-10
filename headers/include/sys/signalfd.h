#pragma once

// sys/signalfd.h -- accept signals through a file descriptor (Linux).

#include <stdint.h>
#include <signal.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::signalfd, "signalfd")
#endif

// signalfd flags.
#define SFD_CLOEXEC  02000000
#define SFD_NONBLOCK 00004000

// Fixed kernel ABI record read from a signalfd descriptor.
struct signalfd_siginfo {
    uint32_t ssi_signo;
    int32_t  ssi_errno;
    int32_t  ssi_code;
    uint32_t ssi_pid;
    uint32_t ssi_uid;
    int32_t  ssi_fd;
    uint32_t ssi_tid;
    uint32_t ssi_band;
    uint32_t ssi_overrun;
    uint32_t ssi_trapno;
    int32_t  ssi_status;
    int32_t  ssi_int;
    uint64_t ssi_ptr;
    uint64_t ssi_utime;
    uint64_t ssi_stime;
    uint64_t ssi_addr;
    uint16_t ssi_addr_lsb;
    uint16_t __pad2;
    int32_t  ssi_syscall;
    uint64_t ssi_call_addr;
    uint32_t ssi_arch;
    uint8_t  __pad[28];
};

int signalfd(int fd, const sigset_t *mask, int flags);
