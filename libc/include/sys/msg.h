// sys/msg.h -- XSI message queues, with the C library's layouts and flags.
// <sys/ipc.h> supplies struct ipc_perm, key_t and the IPC_* commands, as
// POSIX has this header include it.

#pragma once

#include <sys/ipc.h>

#if defined(__linux__) || defined(__APPLE__)
typedef unsigned long msgqnum_t;
typedef unsigned long msglen_t;

#define MSG_NOERROR 010000
#endif

#ifdef __linux__
#ifdef _GNU_SOURCE
#define MSG_EXCEPT 020000
#define MSG_COPY 040000

struct msgbuf {
    long mtype;
    char mtext[1];
};
#endif
#define MSG_STAT 11
#define MSG_INFO 12
#define MSG_STAT_ANY 13

// glibc's 120-byte record; it names the byte count msg_cbytes through a
// macro over the reserved member.
struct msqid_ds {
    struct ipc_perm msg_perm;
    time_t msg_stime;
    time_t msg_rtime;
    time_t msg_ctime;
    unsigned long __msg_cbytes;
    msgqnum_t msg_qnum;
    msglen_t msg_qbytes;
    pid_t msg_lspid;
    pid_t msg_lrpid;
    unsigned long __glibc_reserved4;
    unsigned long __glibc_reserved5;
};
#define msg_cbytes __msg_cbytes

struct msginfo {
    int msgpool;
    int msgmap;
    int msgmax;
    int msgmnb;
    int msgmni;
    int msgssz;
    int msgtql;
    unsigned short msgseg;
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::msgctl, "msgctl")
#pragma binding(libc::msgget, "msgget")
#pragma binding(libc::msgrcv, "msgrcv")
#pragma binding(libc::msgsnd, "msgsnd")
#elif defined(__APPLE__)
// The SDK's 116-byte record under pack(4).
#pragma pack(4)
struct msqid_ds {
    struct ipc_perm msg_perm;
    int msg_first;
    int msg_last;
    msglen_t msg_cbytes;
    msgqnum_t msg_qnum;
    msglen_t msg_qbytes;
    pid_t msg_lspid;
    pid_t msg_lrpid;
    time_t msg_stime;
    int msg_pad1;
    time_t msg_rtime;
    int msg_pad2;
    time_t msg_ctime;
    int msg_pad3;
    int msg_pad4[4];
};
#pragma pack()
#define __msqid_ds_new msqid_ds

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::msgctl, "_msgctl")
#pragma binding(libc::msgget, "_msgget")
#pragma binding(libc::msgrcv, "_msgrcv")
#pragma binding(libc::msgsnd, "_msgsnd")
#endif

#if defined(__linux__) || defined(__APPLE__)
int msgctl(int msqid, int cmd, struct msqid_ds *buf);
int msgget(key_t key, int msgflg);
ssize_t msgrcv(int msqid, void *msgp, size_t msgsz, long msgtyp, int msgflg);
int msgsnd(int msqid, const void *msgp, size_t msgsz, int msgflg);
#endif
