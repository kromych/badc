// sys/ipc.h -- XSI interprocess communication: the access permission
// structure the shared memory, semaphore and message queue headers share,
// the commands and flags common to them, and ftok.

#pragma once

#include <sys/types.h>

#define IPC_CREAT 01000
#define IPC_EXCL 02000
#define IPC_NOWAIT 04000
#define IPC_RMID 0
#define IPC_SET 1
#define IPC_STAT 2

#ifdef __linux__
#define IPC_PRIVATE ((key_t)0)
#define IPC_INFO 3

// glibc's, the size of the kernel's ipc64_perm.
struct ipc_perm {
    key_t __key;
    uid_t uid;
    gid_t gid;
    uid_t cuid;
    gid_t cgid;
    mode_t mode;
    unsigned short __seq;
    unsigned short __pad2;
    unsigned long __glibc_reserved1;
    unsigned long __glibc_reserved2;
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::ftok, "ftok")
#elif defined(__APPLE__)
#define IPC_PRIVATE ((key_t)0)
#define IPC_R 000400
#define IPC_W 000200
#define IPC_M 010000

#pragma pack(4)
struct ipc_perm {
    uid_t uid;
    gid_t gid;
    uid_t cuid;
    gid_t cgid;
    mode_t mode;
    unsigned short _seq;
    key_t _key;
};
#pragma pack()
#define __ipc_perm_new ipc_perm

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::ftok, "_ftok")
#else
#define IPC_PRIVATE 0

struct ipc_perm {
    int __key;
    unsigned int uid;
    unsigned int gid;
    unsigned int cuid;
    unsigned int cgid;
    unsigned short mode;
    unsigned short __seq;
    char __pad[16];
};
#endif

#if defined(__linux__) || defined(__APPLE__)
key_t ftok(const char *path, int id);
#endif
