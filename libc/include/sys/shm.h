// sys/shm.h -- System V shared memory. Declared so headers that include it
// unconditionally (e.g. a platform-portability header) resolve; the segment
// calls bind to libc. Constants that reach the host libc diverge per platform
// and are guarded accordingly.

#pragma once

#include <sys/types.h>

// Control commands shared with <sys/ipc.h>.
#define IPC_CREAT 01000
#define IPC_EXCL 02000
#define IPC_NOWAIT 04000
#define IPC_RMID 0
#define IPC_SET 1
#define IPC_STAT 2
#define IPC_PRIVATE 0

// shmat flags.
#define SHM_RDONLY 010000
#define SHM_RND 020000

#ifdef __linux__
// The kernel's ipc64_perm and shmid64_ds from <asm-generic/ipcbuf.h> and
// <asm-generic/shmbuf.h>.
typedef unsigned long shmatt_t;

struct ipc_perm {
    key_t __key;
    uid_t uid;
    gid_t gid;
    uid_t cuid;
    gid_t cgid;
    mode_t mode;
    unsigned short __seq;
    unsigned short __pad2;
    unsigned long __unused1;
    unsigned long __unused2;
};

struct shmid_ds {
    struct ipc_perm shm_perm;
    size_t shm_segsz;
    time_t shm_atime;
    time_t shm_dtime;
    time_t shm_ctime;
    pid_t shm_cpid;
    pid_t shm_lpid;
    shmatt_t shm_nattch;
    unsigned long __unused4;
    unsigned long __unused5;
};
#else
typedef long shmatt_t;

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

int shmget(key_t key, unsigned long size, int shmflg);
void *shmat(int shmid, const void *shmaddr, int shmflg);
int shmdt(const void *shmaddr);
int shmctl(int shmid, int cmd, struct shmid_ds *buf);
