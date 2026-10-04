// Once controls and thread-specific data (pthread_once, pthread_key_create,
// pthread_setspecific, pthread_key_delete): racing threads run an init
// routine once and none returns before it has finished; each thread reads
// back its own value; a thread that exits with a non-null value runs the
// key's destructor on it before pthread_join returns, again while the
// destructor sets a value, and not at all for a deleted key; the process
// exit runs none (POSIX _exit). On Windows a thread CreateThread starts runs
// the destructors too. The exit code is the line of the first failed check.
#include <pthread.h>
#include <stddef.h>
#include <time.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static pthread_once_t once = PTHREAD_ONCE_INIT;
static volatile int inits;
static int early;

static void init(void) {
    struct timespec pause = {0, 20000000};
    nanosleep(&pause, NULL);
    inits++;
}

static void *call_once(void *arg) {
    pthread_once(&once, init);
    if (inits != 1)
        early = 1;
    return NULL;
}

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_key_t key, plain, again, gone, at_exit;
static int values[4];
static int destroyed, sum, repeats;

static void destroy(void *v) {
    pthread_mutex_lock(&lock);
    destroyed++;
    sum += *(int *)v;
    pthread_mutex_unlock(&lock);
}

// Sets its key once more on the first call: the next pass runs it again.
static void destroy_again(void *v) {
    pthread_mutex_lock(&lock);
    if (++repeats == 1)
        pthread_setspecific(again, v);
    pthread_mutex_unlock(&lock);
}

static void never(void *v) {
    pthread_mutex_lock(&lock);
    destroyed += 100;
    pthread_mutex_unlock(&lock);
}

static void ends_process(void *v) {
#ifdef _WIN32
    TerminateProcess(GetCurrentProcess(), 99);
#else
    _exit(99);
#endif
}

static void *use_keys(void *arg) {
    int *v = arg;
    if (pthread_getspecific(key))
        return (void *)1;
    if (pthread_setspecific(key, v) || pthread_getspecific(key) != v)
        return (void *)2;
    if (pthread_setspecific(plain, v) || pthread_getspecific(plain) != v)
        return (void *)3;
    return NULL;
}

static void *no_value(void *arg) { return NULL; }

static void *set_again(void *arg) {
    pthread_setspecific(again, arg);
    return NULL;
}

static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
static int stage;

// Sets a value, then exits only once the key is deleted.
static void *outlives_key(void *arg) {
    pthread_setspecific(gone, arg);
    pthread_mutex_lock(&lock);
    stage = 1;
    pthread_cond_broadcast(&cond);
    while (stage != 2)
        pthread_cond_wait(&cond, &lock);
    pthread_mutex_unlock(&lock);
    return NULL;
}

#ifdef _WIN32
static DWORD WINAPI native_thread(void *arg) {
    pthread_setspecific(key, arg);
    return 0;
}
#endif

int main(void) {
    pthread_t t[8];
    void *rc;
    int i;

    for (i = 0; i < 8; i++)
        CHECK(pthread_create(&t[i], NULL, call_once, NULL) == 0);
    for (i = 0; i < 8; i++)
        CHECK(pthread_join(t[i], NULL) == 0);
    CHECK(inits == 1);
    CHECK(!early);
    CHECK(pthread_once(&once, init) == 0);
    CHECK(inits == 1);

    for (i = 0; i < 4; i++)
        values[i] = 1 << i;
    CHECK(pthread_key_create(&key, destroy) == 0);
    CHECK(pthread_key_create(&plain, NULL) == 0);
    CHECK(pthread_key_create(&again, destroy_again) == 0);
    CHECK(pthread_key_create(&gone, never) == 0);
    CHECK(pthread_key_create(&at_exit, ends_process) == 0);
    CHECK(key != plain && plain != again);

    CHECK(pthread_setspecific(key, &values[3]) == 0);
    for (i = 0; i < 2; i++)
        CHECK(pthread_create(&t[i], NULL, use_keys, &values[i]) == 0);
    for (i = 0; i < 2; i++) {
        CHECK(pthread_join(t[i], &rc) == 0);
        CHECK(rc == NULL);
    }
    CHECK(destroyed == 2);
    CHECK(sum == (values[0] | values[1]));
    CHECK(pthread_getspecific(key) == &values[3]);

    CHECK(pthread_create(&t[0], NULL, no_value, NULL) == 0);
    CHECK(pthread_join(t[0], NULL) == 0);
    CHECK(destroyed == 2);

    CHECK(pthread_create(&t[0], NULL, set_again, &values[0]) == 0);
    CHECK(pthread_join(t[0], NULL) == 0);
    CHECK(repeats == 2);

    CHECK(pthread_create(&t[0], NULL, outlives_key, &values[0]) == 0);
    pthread_mutex_lock(&lock);
    while (stage != 1)
        pthread_cond_wait(&cond, &lock);
    pthread_mutex_unlock(&lock);
    CHECK(pthread_key_delete(gone) == 0);
    pthread_mutex_lock(&lock);
    stage = 2;
    pthread_cond_broadcast(&cond);
    pthread_mutex_unlock(&lock);
    CHECK(pthread_join(t[0], NULL) == 0);
    CHECK(destroyed == 2);

#ifdef _WIN32
    {
        HANDLE h = CreateThread(NULL, 0, native_thread, &values[2], 0, NULL);
        CHECK(h != NULL);
        CHECK(WaitForSingleObject(h, INFINITE) == WAIT_OBJECT_0);
        CloseHandle(h);
        CHECK(destroyed == 3);
        CHECK(sum == (values[0] | values[1] | values[2]));
    }
#endif

    CHECK(pthread_key_delete(plain) == 0);
    CHECK(pthread_setspecific(at_exit, &values[0]) == 0);
    return 0;
}
