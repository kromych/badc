// Mutex types and condition variables (pthread_mutex_*, pthread_mutexattr_settype,
// pthread_cond_*): a recursive mutex counts its levels, an error-checking one
// refuses a relock and an unlock by a thread that does not hold it, trylock
// reports a mutex another thread holds, a signal hands items one at a time, a
// broadcast wakes every waiter, and a timed wait returns ETIMEDOUT no earlier
// than its deadline on the condition's clock. The exit code is the line of
// the first failed check.
#include <errno.h>
#include <pthread.h>
#include <time.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static pthread_mutex_t m;
static pthread_cond_t idle = PTHREAD_COND_INITIALIZER;

static void *try_lock(void *arg) {
    int rc = pthread_mutex_trylock(&m);
    if (rc == 0)
        pthread_mutex_unlock(&m);
    return (void *)(long long)rc;
}

static void *unlock(void *arg) { return (void *)(long long)pthread_mutex_unlock(&m); }

static int from_thread(void *(*fn)(void *)) {
    pthread_t t;
    void *rc;
    if (pthread_create(&t, NULL, fn, NULL) || pthread_join(t, &rc))
        return -1;
    return (int)(long long)rc;
}

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
static pthread_cond_t room = PTHREAD_COND_INITIALIZER;
static int slot, full, go, awake, sum;

#define ITEMS 1000

static void *consume(void *arg) {
    int i;
    for (i = 0; i < ITEMS; i++) {
        pthread_mutex_lock(&lock);
        while (!full)
            pthread_cond_wait(&cond, &lock);
        sum += slot;
        full = 0;
        pthread_cond_signal(&room);
        pthread_mutex_unlock(&lock);
    }
    return NULL;
}

static void *wait_go(void *arg) {
    pthread_mutex_lock(&lock);
    while (!go)
        pthread_cond_wait(&cond, &lock);
    awake++;
    pthread_mutex_unlock(&lock);
    return NULL;
}

static long long ms_since(clockid_t clock, const struct timespec *t0) {
    struct timespec t1;
    clock_gettime(clock, &t1);
    return (t1.tv_sec - t0->tv_sec) * 1000LL + (t1.tv_nsec - t0->tv_nsec) / 1000000;
}

// A timed wait 50 ms ahead on `clock` with nothing to wake it.
static int times_out(pthread_cond_t *c, clockid_t clock) {
    struct timespec t0, deadline;
    int rc;
    clock_gettime(clock, &t0);
    deadline = t0;
    deadline.tv_nsec += 50000000;
    if (deadline.tv_nsec >= 1000000000) {
        deadline.tv_nsec -= 1000000000;
        deadline.tv_sec++;
    }
    pthread_mutex_lock(&lock);
    rc = pthread_cond_timedwait(c, &lock, &deadline);
    pthread_mutex_unlock(&lock);
    return rc == ETIMEDOUT && ms_since(clock, &t0) >= 50;
}

int main(void) {
    pthread_mutexattr_t attr;
    pthread_t t[4];
    struct timespec past = {1, 0};
    int i;

    CHECK(pthread_mutexattr_init(&attr) == 0);
    CHECK(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE) == 0);
    CHECK(pthread_mutex_init(&m, &attr) == 0);
    CHECK(pthread_mutex_lock(&m) == 0);
    CHECK(pthread_mutex_lock(&m) == 0);
    CHECK(pthread_mutex_trylock(&m) == 0);
    CHECK(from_thread(try_lock) == EBUSY);
    CHECK(from_thread(unlock) == EPERM);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(from_thread(try_lock) == EBUSY);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(from_thread(try_lock) == 0);
    CHECK(pthread_mutex_unlock(&m) == EPERM);
    // A recursive mutex held once is released for a wait and held after it.
    CHECK(pthread_mutex_lock(&m) == 0);
    CHECK(pthread_cond_timedwait(&idle, &m, &past) == ETIMEDOUT);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(pthread_mutex_destroy(&m) == 0);

    CHECK(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK) == 0);
    CHECK(pthread_mutex_init(&m, &attr) == 0);
    CHECK(pthread_mutex_lock(&m) == 0);
    CHECK(pthread_mutex_lock(&m) == EDEADLK);
    CHECK(pthread_mutex_trylock(&m) == EBUSY);
    CHECK(from_thread(unlock) == EPERM);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(pthread_mutex_unlock(&m) == EPERM);
    CHECK(pthread_mutex_destroy(&m) == 0);
    CHECK(pthread_mutexattr_destroy(&attr) == 0);

    CHECK(pthread_mutex_init(&m, NULL) == 0);
    CHECK(pthread_mutex_lock(&m) == 0);
    CHECK(from_thread(try_lock) == EBUSY);
    CHECK(pthread_mutex_unlock(&m) == 0);
    CHECK(from_thread(try_lock) == 0);
    CHECK(pthread_mutex_destroy(&m) == 0);

    // One item at a time through a single slot.
    CHECK(pthread_create(&t[0], NULL, consume, NULL) == 0);
    for (i = 1; i <= ITEMS; i++) {
        pthread_mutex_lock(&lock);
        while (full)
            pthread_cond_wait(&room, &lock);
        slot = i;
        full = 1;
        pthread_cond_signal(&cond);
        pthread_mutex_unlock(&lock);
    }
    CHECK(pthread_join(t[0], NULL) == 0);
    CHECK(sum == ITEMS * (ITEMS + 1) / 2);

    for (i = 0; i < 4; i++)
        CHECK(pthread_create(&t[i], NULL, wait_go, NULL) == 0);
    pthread_mutex_lock(&lock);
    go = 1;
    pthread_cond_broadcast(&cond);
    pthread_mutex_unlock(&lock);
    for (i = 0; i < 4; i++)
        CHECK(pthread_join(t[i], NULL) == 0);
    CHECK(awake == 4);

    pthread_mutex_lock(&lock);
    CHECK(pthread_cond_timedwait(&cond, &lock, &past) == ETIMEDOUT);
    past.tv_nsec = 1000000000;
    CHECK(pthread_cond_timedwait(&cond, &lock, &past) == EINVAL);
    pthread_mutex_unlock(&lock);
    CHECK(times_out(&cond, CLOCK_REALTIME));
#ifndef __APPLE__
    {
        pthread_condattr_t cattr;
        pthread_cond_t mono;
        CHECK(pthread_condattr_init(&cattr) == 0);
        CHECK(pthread_condattr_setclock(&cattr, CLOCK_MONOTONIC) == 0);
        CHECK(pthread_cond_init(&mono, &cattr) == 0);
        CHECK(pthread_condattr_destroy(&cattr) == 0);
        CHECK(times_out(&mono, CLOCK_MONOTONIC));
        CHECK(pthread_cond_destroy(&mono) == 0);
    }
#endif
#ifdef PTHREAD_RECURSIVE_MUTEX_INITIALIZER
    {
        static pthread_mutex_t r = PTHREAD_RECURSIVE_MUTEX_INITIALIZER;
        static pthread_mutex_t e = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER;
        CHECK(pthread_mutex_lock(&r) == 0);
        CHECK(pthread_mutex_lock(&r) == 0);
        CHECK(pthread_mutex_unlock(&r) == 0);
        CHECK(pthread_mutex_unlock(&r) == 0);
        CHECK(pthread_mutex_lock(&e) == 0);
        CHECK(pthread_mutex_lock(&e) == EDEADLK);
        CHECK(pthread_mutex_unlock(&e) == 0);
    }
#endif
    return 0;
}
