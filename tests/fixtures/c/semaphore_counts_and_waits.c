// POSIX unnamed semaphores: sem_init's count is what sem_getvalue reads,
// sem_trywait takes a unit or fails with EAGAIN, sem_timedwait fails with
// ETIMEDOUT at a past deadline and EINVAL for a bad one when it would block
// but takes an available unit whatever the deadline, and a thread blocked
// in sem_wait wakes for another thread's sem_post. On
// Windows, as in winpthreads, a process-shared semaphore fails with EPERM
// and the named ones with ENOSYS. macOS has no unnamed semaphores.

#ifdef __APPLE__
int main(void) { return 0; }
#else
#include <errno.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>

static sem_t ready, go;

static void *worker(void *arg) {
    sem_post(&ready);
    if (sem_wait(&go))
        return (void *)1;
    return arg;
}

int main(void) {
    struct timespec past = {0, 0}, bad = {0, 2000000000L};
    pthread_t t;
    void *result = 0;
    int v = -1;
    if (sem_init(&ready, 0, 2) || sem_getvalue(&ready, &v) || v != 2)
        return 1;
    if (sem_trywait(&ready) || sem_wait(&ready))
        return 2;
    errno = 0;
    if (sem_trywait(&ready) != -1 || errno != EAGAIN)
        return 3;
    errno = 0;
    if (sem_timedwait(&ready, &past) != -1 || errno != ETIMEDOUT)
        return 4;
    errno = 0;
    if (sem_timedwait(&ready, &bad) != -1 || errno != EINVAL)
        return 5;
    if (sem_post(&ready) || sem_timedwait(&ready, &past))
        return 6;
    if (sem_init(&go, 0, 0) || pthread_create(&t, 0, worker, (void *)7))
        return 7;
    if (sem_wait(&ready) || sem_post(&go) || pthread_join(t, &result) || result != (void *)7)
        return 8;
    if (sem_getvalue(&go, &v) || v != 0 || sem_destroy(&go) || sem_destroy(&ready))
        return 9;
#ifdef _WIN32
    errno = 0;
    if (sem_init(&go, 1, 0) != -1 || errno != EPERM)
        return 10;
    errno = 0;
    if (sem_open("/named", 0, 0, 0) != SEM_FAILED || errno != ENOSYS)
        return 11;
    errno = 0;
    if (sem_unlink("/named") != -1 || errno != ENOSYS)
        return 12;
#endif
    return 0;
}
#endif
