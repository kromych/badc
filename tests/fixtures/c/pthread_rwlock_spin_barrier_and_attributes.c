// POSIX reader-writer locks admit readers together and a writer alone; the
// attribute getters read back what the setters stored; cancellation state
// round-trips; rand_r, asctime_r and readdir_r work on caller state. On
// Linux, spin locks exclude, a one-thread barrier names its serial thread,
// a process CPU clock reads, and a SIGRTMIN queued to the process arrives
// with its value. The object sizes are the C library's.
#define _GNU_SOURCE 1
#include <dirent.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#ifdef __APPLE__
#define RWLOCK_SIZE 200
#define RWLOCKATTR_SIZE 24
#else
#define RWLOCK_SIZE 56
#define RWLOCKATTR_SIZE 8
#endif

static pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
static int shared;

// With main holding a read lock another reader enters; with main holding
// the write lock it is turned away.
static void *reader(void *arg) {
    int v;
    if (arg) return (void *)(long)(pthread_rwlock_tryrdlock(&lock) == EBUSY ? 0 : 3);
    if (pthread_rwlock_tryrdlock(&lock) != 0) return (void *)1;
    v = shared;
    pthread_rwlock_unlock(&lock);
    return (void *)(long)(v == 7 ? 0 : 2);
}

static int rwlocks(void) {
    pthread_rwlockattr_t ra;
    pthread_rwlock_t local;
    pthread_t t;
    void *ret;
    int v = -1;

    if (sizeof(pthread_rwlock_t) != RWLOCK_SIZE || sizeof(pthread_rwlockattr_t) != RWLOCKATTR_SIZE)
        return 1;
    shared = 7;
    if (pthread_rwlock_rdlock(&lock) != 0 || pthread_rwlock_trywrlock(&lock) != EBUSY) return 2;
    if (pthread_create(&t, 0, reader, 0) != 0 || pthread_join(t, &ret) != 0 || ret != 0) return 3;
    if (pthread_rwlock_unlock(&lock) != 0 || pthread_rwlock_wrlock(&lock) != 0) return 4;
    if (pthread_create(&t, 0, reader, &t) != 0 || pthread_join(t, &ret) != 0 || ret != 0) return 5;
    if (pthread_rwlock_unlock(&lock) != 0) return 9;
    if (pthread_rwlockattr_init(&ra) != 0) return 6;
    if (pthread_rwlockattr_setpshared(&ra, PTHREAD_PROCESS_PRIVATE) != 0
        || pthread_rwlockattr_getpshared(&ra, &v) != 0 || v != PTHREAD_PROCESS_PRIVATE)
        return 7;
    if (pthread_rwlock_init(&local, &ra) != 0 || pthread_rwlock_wrlock(&local) != 0
        || pthread_rwlock_unlock(&local) != 0 || pthread_rwlock_destroy(&local) != 0)
        return 8;
    pthread_rwlockattr_destroy(&ra);
    return 0;
}

static int attributes(void) {
    pthread_attr_t a;
    pthread_mutexattr_t ma;
    size_t ss = 0;
    int v = -1, old = -1;

    if (pthread_attr_init(&a) != 0 || pthread_attr_setstacksize(&a, 1 << 20) != 0) return 10;
    if (pthread_attr_getstacksize(&a, &ss) != 0 || ss != 1 << 20) return 11;
    if (pthread_attr_getdetachstate(&a, &v) != 0 || v != PTHREAD_CREATE_JOINABLE) return 12;
    pthread_attr_destroy(&a);
    if (pthread_mutexattr_init(&ma) != 0) return 13;
    if (pthread_mutexattr_settype(&ma, PTHREAD_MUTEX_RECURSIVE) != 0
        || pthread_mutexattr_gettype(&ma, &v) != 0 || v != PTHREAD_MUTEX_RECURSIVE)
        return 14;
    if (pthread_mutexattr_getprotocol(&ma, &v) != 0 || v != PTHREAD_PRIO_NONE) return 15;
    if (pthread_mutexattr_setpshared(&ma, PTHREAD_PROCESS_PRIVATE) != 0
        || pthread_mutexattr_getpshared(&ma, &v) != 0 || v != PTHREAD_PROCESS_PRIVATE)
        return 16;
    pthread_mutexattr_destroy(&ma);
    if (pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &old) != 0 || old != PTHREAD_CANCEL_ENABLE)
        return 17;
    if (pthread_setcancelstate(old, &v) != 0 || v != PTHREAD_CANCEL_DISABLE) return 18;
    pthread_testcancel();
    return 0;
}

static int reentrant(void) {
    unsigned s1 = 5, s2 = 5;
    struct tm tm;
    char buf[26];
    DIR *d;
    struct dirent entry, *result = 0;

    if (rand_r(&s1) != rand_r(&s2) || s1 != s2) return 20;
    memset(&tm, 0, sizeof tm);
    tm.tm_year = 70;
    tm.tm_mday = 1;
    tm.tm_wday = 4;
    if (asctime_r(&tm, buf) != buf || strcmp(buf, "Thu Jan  1 00:00:00 1970\n") != 0) return 21;
    d = opendir(".");
    if (!d || readdir_r(d, &entry, &result) != 0 || result != &entry) return 22;
    closedir(d);
    return 0;
}

#ifdef __linux__
static int linux_only(void) {
    pthread_spinlock_t sp;
    pthread_barrier_t b;
    pthread_mutexattr_t ma;
    clockid_t cid;
    struct timespec ts = {0, 0};
    sigset_t set;
    siginfo_t info;
    union sigval value;
    int v = -1;

    if (sizeof(pthread_spinlock_t) != 4 || sizeof(pthread_barrier_t) != 32) return 30;
    if (pthread_spin_init(&sp, PTHREAD_PROCESS_PRIVATE) != 0 || pthread_spin_lock(&sp) != 0) return 31;
    if (pthread_spin_trylock(&sp) != EBUSY || pthread_spin_unlock(&sp) != 0) return 32;
    pthread_spin_destroy(&sp);
    if (pthread_barrier_init(&b, 0, 1) != 0) return 33;
    if (pthread_barrier_wait(&b) != PTHREAD_BARRIER_SERIAL_THREAD) return 34;
    pthread_barrier_destroy(&b);
    if (pthread_mutexattr_init(&ma) != 0 || pthread_mutexattr_setrobust(&ma, PTHREAD_MUTEX_ROBUST) != 0
        || pthread_mutexattr_getrobust(&ma, &v) != 0 || v != PTHREAD_MUTEX_ROBUST)
        return 35;
    pthread_mutexattr_destroy(&ma);
    if (clock_getcpuclockid(0, &cid) != 0 || clock_gettime(cid, &ts) != 0) return 36;
    if (SIGRTMIN < 32 || SIGRTMAX <= SIGRTMIN) return 37;
    sigemptyset(&set);
    sigaddset(&set, SIGRTMIN);
    if (sigprocmask(SIG_BLOCK, &set, 0) != 0) return 38;
    value.sival_int = 42;
    if (sigqueue(getpid(), SIGRTMIN, value) != 0) return 39;
    ts.tv_sec = 5;
    ts.tv_nsec = 0;
    if (sigtimedwait(&set, &info, &ts) != SIGRTMIN || info.si_value.sival_int != 42) return 40;
    return 0;
}
#else
static int linux_only(void) { return 0; }
#endif

int main(void) {
    int r = rwlocks();
    if (!r) r = attributes();
    if (!r) r = reentrant();
    if (!r) r = linux_only();
    return r;
}
