// POSIX thread lifecycle and attributes (pthread_create, pthread_join,
// pthread_exit, pthread_detach, pthread_self, pthread_attr_*): a thread's
// result reaches pthread_join whether it returns or calls pthread_exit, each
// thread has its own identity, detached threads run to completion unjoined,
// a thread created with a stack larger than the default can use it, and the
// attribute setters keep what they are given. The exit code is the line of
// the first failed check.
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <stddef.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static pthread_t seen_self;

static void *returns(void *arg) {
    seen_self = pthread_self();
    return (char *)arg + 1;
}

static void *exits(void *arg) {
    pthread_exit((char *)arg + 2);
    return NULL;
}

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t done = PTHREAD_COND_INITIALIZER;
static int finished;

static void *detached(void *arg) {
    pthread_mutex_lock(&lock);
    finished++;
    pthread_cond_signal(&done);
    pthread_mutex_unlock(&lock);
    return arg;
}

// `depth` frames of a little over 2 KiB each, every one read back after the
// call below it returns.
static int deep(int depth) {
    volatile char frame[2048];
    int below;
    frame[0] = (char)depth;
    frame[sizeof frame - 1] = (char)depth;
    below = depth ? deep(depth - 1) : 0;
    return below + frame[0] - frame[sizeof frame - 1];
}

static void *uses_stack(void *arg) { return (void *)(size_t)(deep((int)(size_t)arg) == 0); }

int main(void) {
    pthread_t t, me = pthread_self();
    pthread_attr_t attr;
    struct sched_param param;
    void *result, *addr;
    size_t size;
    char base[4];
    int i, lo, hi;

    CHECK(pthread_equal(me, pthread_self()));
    CHECK(pthread_create(&t, NULL, returns, base) == 0);
    CHECK(pthread_join(t, &result) == 0);
    CHECK(result == base + 1);
    CHECK(pthread_equal(seen_self, t));
    CHECK(!pthread_equal(seen_self, me));
    CHECK(pthread_create(&t, NULL, exits, base) == 0);
    CHECK(pthread_join(t, &result) == 0);
    CHECK(result == base + 2);
    CHECK(pthread_join(me, &result) == EDEADLK);

    // Four threads detached at creation and one detached after it.
    CHECK(pthread_attr_init(&attr) == 0);
    CHECK(pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) == 0);
    for (i = 0; i < 4; i++)
        CHECK(pthread_create(&t, &attr, detached, NULL) == 0);
    CHECK(pthread_attr_destroy(&attr) == 0);
    CHECK(pthread_create(&t, NULL, detached, NULL) == 0);
    CHECK(pthread_detach(t) == 0);
    pthread_mutex_lock(&lock);
    while (finished < 5)
        pthread_cond_wait(&done, &lock);
    pthread_mutex_unlock(&lock);

    // About 10 MiB of stack, beyond the 8 MiB default.
    CHECK(pthread_attr_init(&attr) == 0);
    CHECK(pthread_attr_setstacksize(&attr, 16 << 20) == 0);
    CHECK(pthread_attr_getstack(&attr, &addr, &size) == 0);
    CHECK(size == 16 << 20);
    CHECK(pthread_attr_getguardsize(&attr, &size) == 0);
    CHECK(size > 0);
    CHECK(pthread_create(&t, &attr, uses_stack, (void *)(size_t)5000) == 0);
    CHECK(pthread_join(t, &result) == 0);
    CHECK(result == (void *)1);
    CHECK(pthread_attr_destroy(&attr) == 0);

    // An explicit SCHED_OTHER priority within the policy's range.
    lo = sched_get_priority_min(SCHED_OTHER);
    hi = sched_get_priority_max(SCHED_OTHER);
    CHECK(lo <= hi);
    CHECK(sched_yield() == 0);
    CHECK(pthread_attr_init(&attr) == 0);
    CHECK(pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM) == 0);
    CHECK(pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) == 0);
    CHECK(pthread_attr_setschedpolicy(&attr, SCHED_OTHER) == 0);
    param.sched_priority = (lo + hi) / 2;
    CHECK(pthread_attr_setschedparam(&attr, &param) == 0);
    param.sched_priority = lo - 1;
    CHECK(pthread_attr_getschedparam(&attr, &param) == 0);
    CHECK(param.sched_priority == (lo + hi) / 2);
    CHECK(pthread_create(&t, &attr, returns, base) == 0);
    CHECK(pthread_join(t, &result) == 0);
    CHECK(result == base + 1);
    CHECK(pthread_attr_destroy(&attr) == 0);
    return 0;
}
