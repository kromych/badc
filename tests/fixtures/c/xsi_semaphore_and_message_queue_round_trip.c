// XSI semaphore sets and message queues (<sys/sem.h>, <sys/msg.h>) with the
// C library's layouts and command numbers: a private set of two semaphores
// takes values through semctl's union semun argument, semop moves them and
// refuses to block under IPC_NOWAIT, and IPC_STAT reports the set; a
// private queue returns messages by type, truncates under MSG_NOERROR and
// refuses a short buffer with E2BIG, and IPC_STAT counts what it holds.
// snapshot-budget: exempt
#include <errno.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <unistd.h>

#if defined(_SEM_SEMUN_UNDEFINED)
union semun {
    int val;
    struct semid_ds *buf;
    unsigned short *array;
};
#endif

#if defined(__APPLE__)
#define WANT_SEMID_DS 72
#define WANT_MSQID_DS 116
#elif defined(__x86_64__)
#define WANT_SEMID_DS 104
#define WANT_MSQID_DS 120
#else
#define WANT_SEMID_DS 88
#define WANT_MSQID_DS 120
#endif

struct message {
    long mtype;
    char mtext[16];
};

static int semaphores(void) {
    struct sembuf ops[2];
    struct semid_ds ds;
    unsigned short values[2] = {3, 0};
    union semun arg;
    int id = semget(IPC_PRIVATE, 2, IPC_CREAT | 0600);

    if (id < 0) return 10;
    arg.array = values;
    if (semctl(id, 0, SETALL, arg) != 0) return 11;
    arg.val = 7;
    if (semctl(id, 1, SETVAL, arg) != 0) return 12;
    if (semctl(id, 0, GETVAL) != 3 || semctl(id, 1, GETVAL) != 7) return 13;
    ops[0].sem_num = 0;
    ops[0].sem_op = -2;
    ops[0].sem_flg = 0;
    ops[1].sem_num = 1;
    ops[1].sem_op = 1;
    ops[1].sem_flg = SEM_UNDO;
    if (semop(id, ops, 2) != 0) return 14;
    ops[0].sem_op = -2;
    ops[0].sem_flg = IPC_NOWAIT;
    if (semop(id, ops, 1) != -1 || errno != EAGAIN) return 15;
    memset(values, 0xff, sizeof values);
    arg.array = values;
    if (semctl(id, 0, GETALL, arg) != 0 || values[0] != 1 || values[1] != 8) return 16;
    if (semctl(id, 0, GETPID) != getpid()) return 17;
    arg.buf = &ds;
    if (semctl(id, 0, IPC_STAT, arg) != 0) return 18;
    if (ds.sem_nsems != 2 || (ds.sem_perm.mode & 0777) != 0600) return 19;
    if (semctl(id, 0, IPC_RMID) != 0) return 20;
    return 0;
}

static int messages(void) {
    struct message m;
    struct msqid_ds ds;
    int id = msgget(IPC_PRIVATE, IPC_CREAT | 0600);

    if (id < 0) return 30;
    m.mtype = 1;
    strcpy(m.mtext, "first");
    if (msgsnd(id, &m, 6, 0) != 0) return 31;
    m.mtype = 2;
    strcpy(m.mtext, "second message");
    if (msgsnd(id, &m, 15, IPC_NOWAIT) != 0) return 32;
    if (msgctl(id, IPC_STAT, &ds) != 0) return 33;
    if (ds.msg_qnum != 2 || ds.msg_lspid != getpid() || (ds.msg_perm.mode & 0777) != 0600)
        return 34;
    memset(&m, 0, sizeof m);
    if (msgrcv(id, &m, sizeof m.mtext, 2, 0) != 15 || m.mtype != 2 ||
        strcmp(m.mtext, "second message") != 0)
        return 35;
    if (msgrcv(id, &m, 3, 0, IPC_NOWAIT) != -1 || errno != E2BIG) return 36;
    memset(&m, 0, sizeof m);
    if (msgrcv(id, &m, 3, 0, MSG_NOERROR) != 3 || m.mtype != 1 || memcmp(m.mtext, "fir", 4) != 0)
        return 37;
    if (msgrcv(id, &m, sizeof m.mtext, 0, IPC_NOWAIT) != -1 || errno != ENOMSG) return 38;
    if (msgctl(id, IPC_STAT, &ds) != 0 || ds.msg_qnum != 0 || ds.msg_lrpid != getpid())
        return 39;
    if (msgctl(id, IPC_RMID, 0) != 0) return 40;
    return 0;
}

int main(void) {
    int r;

    if (sizeof(struct sembuf) != 6 || sizeof(struct semid_ds) != WANT_SEMID_DS ||
        sizeof(struct msqid_ds) != WANT_MSQID_DS)
        return 1;
    if (MSG_NOERROR != 010000) return 2;
    if ((r = semaphores()) != 0) return r;
    return messages();
}
