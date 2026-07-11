// linux/vm_sockets.h -- AF_VSOCK address family from the kernel uapi
// header: the sockaddr_vm address structure, well-known context IDs, and the
// SO_VM_SOCKETS_* socket options.

#pragma once

#ifdef __linux__

#include <linux/types.h>
#include <sys/socket.h>

#define SO_VM_SOCKETS_BUFFER_SIZE         0
#define SO_VM_SOCKETS_BUFFER_MIN_SIZE     1
#define SO_VM_SOCKETS_BUFFER_MAX_SIZE     2
#define SO_VM_SOCKETS_PEER_HOST_VM_ID     3
#define SO_VM_SOCKETS_TRUSTED             5
#define SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD 6
#define SO_VM_SOCKETS_NONBLOCK_TXRX       7
#define SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW 8

// Every badc Linux target is LP64 (__BITS_PER_LONG == 64), so the socket
// option uses the original timeout layout.
#define SO_VM_SOCKETS_CONNECT_TIMEOUT SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD

#define VMADDR_CID_ANY        -1U
#define VMADDR_PORT_ANY       -1U
#define VMADDR_CID_HYPERVISOR 0
#define VMADDR_CID_LOCAL      1
#define VMADDR_CID_HOST       2
#define VMADDR_FLAG_TO_HOST   0x01

#define VM_SOCKETS_INVALID_VERSION -1U
#define VM_SOCKETS_VERSION_EPOCH(_v) (((_v) & 0xFF000000) >> 24)
#define VM_SOCKETS_VERSION_MAJOR(_v) (((_v) & 0x00FF0000) >> 16)
#define VM_SOCKETS_VERSION_MINOR(_v) (((_v) & 0x0000FFFF))

struct sockaddr_vm {
    __kernel_sa_family_t svm_family;
    unsigned short svm_reserved1;
    unsigned int svm_port;
    unsigned int svm_cid;
    __u8 svm_flags;
    unsigned char svm_zero[sizeof(struct sockaddr) - sizeof(sa_family_t) -
                           sizeof(unsigned short) - sizeof(unsigned int) -
                           sizeof(unsigned int) - sizeof(__u8)];
};

#define IOCTL_VM_SOCKETS_GET_LOCAL_CID _IO(7, 0xb9)

#define SOL_VSOCK     287
#define VSOCK_RECVERR 1

#endif /* __linux__ */
