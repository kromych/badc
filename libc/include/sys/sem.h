// sys/sem.h -- XSI semaphore sets, with the C library's layouts and command
// numbers. <sys/ipc.h> supplies struct ipc_perm, key_t and the IPC_*
// commands, as POSIX has this header include it.

#pragma once

#include <stddef.h>
#include <sys/ipc.h>

#if defined(__linux__) || defined(__APPLE__)
struct sembuf {
    unsigned short sem_num;
    short sem_op;
    short sem_flg;
};
#endif

#ifdef __linux__
#define SEM_UNDO 0x1000
#define GETPID 11
#define GETVAL 12
#define GETALL 13
#define GETNCNT 14
#define GETZCNT 15
#define SETVAL 16
#define SETALL 17
#define SEM_STAT 18
#define SEM_INFO 19
#define SEM_STAT_ANY 20
// glibc leaves union semun to the program and says so.
#define _SEM_SEMUN_UNDEFINED 1

// glibc's: x86-64 keeps the kernel's reserved word after each time, 104
// bytes; aarch64 has the generic 88-byte record.
struct semid_ds {
    struct ipc_perm sem_perm;
    time_t sem_otime;
#ifdef __x86_64__
    unsigned long __sem_otime_high;
#endif
    time_t sem_ctime;
#ifdef __x86_64__
    unsigned long __sem_ctime_high;
#endif
    unsigned long sem_nsems;
    unsigned long __glibc_reserved3;
    unsigned long __glibc_reserved4;
};

struct seminfo {
    int semmap;
    int semmni;
    int semmns;
    int semmnu;
    int semmsl;
    int semopm;
    int semume;
    int semusz;
    int semvmx;
    int semaem;
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::semctl, "semctl")
#pragma binding(libc::semget, "semget")
#pragma binding(libc::semop, "semop")
#pragma binding(libc::semtimedop, "semtimedop")

#ifdef _GNU_SOURCE
int semtimedop(int semid, struct sembuf *sops, size_t nsops, const struct timespec *timeout);
#endif
#elif defined(__APPLE__)
#define SEM_UNDO 010000
#define GETNCNT 3
#define GETPID 4
#define GETVAL 5
#define GETALL 6
#define GETZCNT 7
#define SETVAL 8
#define SETALL 9

// The SDK's 72-byte record under pack(4).
#pragma pack(4)
struct semid_ds {
    struct ipc_perm sem_perm;
    int sem_base;
    unsigned short sem_nsems;
    time_t sem_otime;
    int sem_pad1;
    time_t sem_ctime;
    int sem_pad2;
    int sem_pad3[4];
};
#pragma pack()
#define __semid_ds_new semid_ds

#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
union semun {
    int val;
    struct semid_ds *buf;
    unsigned short *array;
};
typedef union semun semun_t;
#define SEM_A 0200
#define SEM_R 0400
#endif

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::semctl, "_semctl")
#pragma binding(libc::semget, "_semget")
#pragma binding(libc::semop, "_semop")
#endif

#if defined(__linux__) || defined(__APPLE__)
int semctl(int semid, int semnum, int cmd, ...);
int semget(key_t key, int nsems, int semflg);
int semop(int semid, struct sembuf *sops, size_t nsops);
#endif
