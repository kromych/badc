// sys/shm.h -- XSI shared memory. The segment calls bind to the C library;
// <sys/ipc.h> supplies struct ipc_perm, key_t and the IPC_* commands, as
// POSIX has this header include it.

#pragma once

#include <sys/ipc.h>

// shmat flags.
#define SHM_RDONLY 010000
#define SHM_RND 020000

#ifdef __linux__
#define SHM_R 0400
#define SHM_W 0200
#define SHM_REMAP 040000
#define SHM_EXEC 0100000
#define SHM_LOCK 11
#define SHM_UNLOCK 12
#define SHM_STAT 13
#define SHM_INFO 14
#define SHM_STAT_ANY 15
#define SHM_DEST 01000
#define SHM_LOCKED 02000
#define SHMLBA (__getpagesize())

typedef unsigned long shmatt_t;

struct shmid_ds {
    struct ipc_perm shm_perm;
    size_t shm_segsz;
    time_t shm_atime;
    time_t shm_dtime;
    time_t shm_ctime;
    pid_t shm_cpid;
    pid_t shm_lpid;
    shmatt_t shm_nattch;
    unsigned long __glibc_reserved5;
    unsigned long __glibc_reserved6;
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::__getpagesize, "__getpagesize")
int __getpagesize(void);
#elif defined(__APPLE__)
#define SHM_R IPC_R
#define SHM_W IPC_W
#define SHMLBA (16 * 1024)

typedef unsigned short shmatt_t;

#pragma pack(4)
struct shmid_ds {
    struct ipc_perm shm_perm;
    size_t shm_segsz;
    pid_t shm_lpid;
    pid_t shm_cpid;
    shmatt_t shm_nattch;
    time_t shm_atime;
    time_t shm_dtime;
    time_t shm_ctime;
    void *shm_internal;
};
#pragma pack()
#define __shmid_ds_new shmid_ds
#else
typedef long shmatt_t;

struct shmid_ds {
    struct ipc_perm shm_perm;
    unsigned long shm_segsz;
    long shm_atime;
    long shm_dtime;
    long shm_ctime;
    int shm_cpid;
    int shm_lpid;
    shmatt_t shm_nattch;
    char __pad[32];
};
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::shmget, "_shmget")
#pragma binding(libc::shmat, "_shmat")
#pragma binding(libc::shmdt, "_shmdt")
#pragma binding(libc::shmctl, "_shmctl")
#endif
#ifdef __linux__
#pragma binding(libc::shmget, "shmget")
#pragma binding(libc::shmat, "shmat")
#pragma binding(libc::shmdt, "shmdt")
#pragma binding(libc::shmctl, "shmctl")
#endif

#ifndef _WIN32
int shmget(key_t key, size_t size, int shmflg);
void *shmat(int shmid, const void *shmaddr, int shmflg);
int shmdt(const void *shmaddr);
int shmctl(int shmid, int cmd, struct shmid_ds *buf);
#endif
