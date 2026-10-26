// XSI shared memory through <sys/ipc.h> and <sys/shm.h> included as POSIX
// pairs them: a private segment is created, attached, written, described by
// IPC_STAT and removed with IPC_RMID. ftok derives a key from an existing
// path, and SHMLBA is a multiple of the page size. The structure sizes are
// the C library's.
#include <sys/ipc.h>
#include <sys/shm.h>
#include <string.h>
#include <unistd.h>

#if defined(__APPLE__)
#define WANT_IPC_PERM 24
#define WANT_SHMID_DS 76
#elif defined(__linux__)
#define WANT_IPC_PERM 48
#define WANT_SHMID_DS 112
#endif

int main(void) {
#ifdef WANT_IPC_PERM
    struct shmid_ds ds;
    char *p;
    key_t key;
    int id;

    if (sizeof(struct ipc_perm) != WANT_IPC_PERM || sizeof(struct shmid_ds) != WANT_SHMID_DS)
        return 1;
    key = ftok("/", 'b');
    if (key == (key_t)-1 || key == IPC_PRIVATE) return 2;
    id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0600);
    if (id < 0) return 3;
    p = shmat(id, 0, 0);
    if (p == (char *)-1) return 4;
    strcpy(p, "segment");
    if (shmctl(id, IPC_STAT, &ds) != 0) return 5;
    // A fork in another thread of the process holds an attachment until the
    // child execs (the JIT runs fixtures beside tests that spawn children).
    for (int k = 0; ds.shm_nattch != 1 && k < 1000; k++)
        if (usleep(1000) != 0 || shmctl(id, IPC_STAT, &ds) != 0) return 5;
    if (ds.shm_segsz != 4096 || ds.shm_nattch != 1 || (ds.shm_perm.mode & 0777) != 0600)
        return 6;
    if (strcmp(p, "segment") != 0 || shmdt(p) != 0) return 7;
    if (shmctl(id, IPC_RMID, 0) != 0) return 8;
    if (SHMLBA < 4096 || SHMLBA % 4096 != 0) return 9;
#endif
    return 0;
}
