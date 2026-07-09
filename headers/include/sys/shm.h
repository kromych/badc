// sys/shm.h -- System V shared memory. Declared so headers that include it
// unconditionally (e.g. QEMU's osdep.h) resolve; the segment calls bind to
// libc. Constants that reach the host libc diverge per platform and are
// guarded accordingly.

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
