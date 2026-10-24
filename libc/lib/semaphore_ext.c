// <semaphore.h> on the Windows targets, where mingw-w64 declares it and
// winpthreads defines it: sem_t points to a count kept under a slim
// reader/writer lock, whose waiters sleep on a condition variable. As in
// winpthreads, a process-shared semaphore is refused with EPERM and the
// named ones with ENOSYS. The file compiles to nothing elsewhere; the
// native-link driver offers it like an archive member.

#ifdef _WIN32

#include <errno.h>
#include <semaphore.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

#define NS_PER_SEC 1000000000LL

struct sem {
    SRWLOCK lock;
    CONDITION_VARIABLE posted;
    int value;
};

static struct sem *record(sem_t *sem) { return sem ? (struct sem *)*sem : NULL; }

static int fail(int error) {
    errno = error;
    return -1;
}

int sem_init(sem_t *sem, int pshared, unsigned int value) {
    struct sem *s;
    if (!sem || value > SEM_VALUE_MAX)
        return fail(EINVAL);
    if (pshared)
        return fail(EPERM);
    // The lock and the condition variable are all zero at rest.
    if (!(s = calloc(1, sizeof *s)))
        return fail(ENOMEM);
    s->value = (int)value;
    *sem = s;
    return 0;
}

int sem_destroy(sem_t *sem) {
    struct sem *s = record(sem);
    if (!s)
        return fail(EINVAL);
    *sem = NULL;
    free(s);
    return 0;
}

int sem_wait(sem_t *sem) {
    struct sem *s = record(sem);
    if (!s)
        return fail(EINVAL);
    AcquireSRWLockExclusive(&s->lock);
    while (s->value == 0)
        SleepConditionVariableSRW(&s->posted, &s->lock, INFINITE, 0);
    s->value--;
    ReleaseSRWLockExclusive(&s->lock);
    return 0;
}

int sem_trywait(sem_t *sem) {
    struct sem *s = record(sem);
    int taken;
    if (!s)
        return fail(EINVAL);
    AcquireSRWLockExclusive(&s->lock);
    taken = s->value > 0;
    if (taken)
        s->value--;
    ReleaseSRWLockExclusive(&s->lock);
    return taken ? 0 : fail(EAGAIN);
}

// The deadline is on CLOCK_REALTIME and checked only when the call would
// block; a sleep the system timer ends before it sleeps again.
int sem_timedwait(sem_t *sem, const struct timespec *abstime) {
    struct sem *s = record(sem);
    int rc = 0;
    if (!s)
        return fail(EINVAL);
    AcquireSRWLockExclusive(&s->lock);
    while (s->value == 0) {
        struct timespec now;
        long long sec;
        DWORD ms = INFINITE - 1;
        if (abstime->tv_nsec < 0 || abstime->tv_nsec >= NS_PER_SEC) {
            rc = EINVAL;
            break;
        }
        clock_gettime(CLOCK_REALTIME, &now);
        sec = (long long)abstime->tv_sec - now.tv_sec;
        if (sec < (INFINITE - 1) / 1000) {
            long long ns = sec * NS_PER_SEC + abstime->tv_nsec - now.tv_nsec;
            if (ns <= 0) {
                rc = ETIMEDOUT;
                break;
            }
            ms = (DWORD)((ns + 999999) / 1000000);
        }
        SleepConditionVariableSRW(&s->posted, &s->lock, ms, 0);
    }
    if (!rc)
        s->value--;
    ReleaseSRWLockExclusive(&s->lock);
    return rc ? fail(rc) : 0;
}

int sem_post(sem_t *sem) {
    struct sem *s = record(sem);
    int full;
    if (!s)
        return fail(EINVAL);
    AcquireSRWLockExclusive(&s->lock);
    full = s->value == SEM_VALUE_MAX;
    if (!full)
        s->value++;
    ReleaseSRWLockExclusive(&s->lock);
    if (full)
        return fail(EOVERFLOW);
    WakeConditionVariable(&s->posted);
    return 0;
}

int sem_getvalue(sem_t *sem, int *sval) {
    struct sem *s = record(sem);
    if (!s)
        return fail(EINVAL);
    AcquireSRWLockShared(&s->lock);
    *sval = s->value;
    ReleaseSRWLockShared(&s->lock);
    return 0;
}

sem_t *sem_open(const char *name, int oflag, mode_t mode, unsigned int value) {
    errno = ENOSYS;
    return SEM_FAILED;
}

int sem_close(sem_t *sem) { return fail(ENOSYS); }

int sem_unlink(const char *name) { return fail(ENOSYS); }

#endif
