/* Four threads contending on atomic objects (C11 7.17.7): relaxed and
   acq_rel counters, a 2-byte counter that wraps, bits toggled back, a
   compare-exchange loop and two exchange locks guarding plain counters.
   Every total is checked once the threads are joined. The exit code is
   the line of the first mismatch. */

#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

#define RELAXED __ATOMIC_RELAXED
#define ACQUIRE __ATOMIC_ACQUIRE
#define RELEASE __ATOMIC_RELEASE
#define ACQ_REL __ATOMIC_ACQ_REL

#define THREADS 4
#define ROUNDS 10000

static long long relaxed_count;
static long long cas_count;
static long long down_count = THREADS * ROUNDS;
static short short_count;
static unsigned toggles;
static int lock;
static unsigned char byte_lock;
static long long locked_count;
static long long byte_locked_count;

static void *worker(void *arg) {
    unsigned bit = 1u << (unsigned)(long long)arg;
    int i;

    for (i = 0; i < ROUNDS; i++) {
        long long seen = __atomic_load_n(&cas_count, RELAXED);

        __atomic_fetch_add(&relaxed_count, 1, RELAXED);
        __atomic_fetch_sub(&down_count, 1, ACQ_REL);
        __atomic_fetch_add(&short_count, 1, RELAXED);
        __atomic_fetch_xor(&toggles, bit, RELEASE);
        __atomic_fetch_xor(&toggles, bit, ACQUIRE);
        while (!__atomic_compare_exchange_n(&cas_count, &seen, seen + 1, 1, ACQ_REL, RELAXED))
            ;
        while (__atomic_exchange_n(&lock, 1, ACQUIRE))
            ;
        locked_count++;
        __atomic_store_n(&lock, 0, RELEASE);
        while (__atomic_test_and_set(&byte_lock, ACQUIRE))
            ;
        byte_locked_count++;
        __atomic_clear(&byte_lock, RELEASE);
    }
    return 0;
}

/* Run `worker` on `THREADS` threads and wait for them. Windows has no
   pthreads; kernel32's CreateThread starts the others. */
static int run_threads(void) {
#ifdef _WIN32
    HANDLE threads[THREADS];
    long long k;

    for (k = 0; k < THREADS; k++) {
        threads[k] = CreateThread(0, 0, (LPTHREAD_START_ROUTINE)worker, (void *)k, 0, 0);
        if (!threads[k])
            return 1;
    }
    for (k = 0; k < THREADS; k++) {
        WaitForSingleObject(threads[k], INFINITE);
        CloseHandle(threads[k]);
    }
#else
    void *handle;
    int (*create)(long long *, void *, void *(*)(void *), void *);
    int (*join)(long long, void **);
    long long threads[THREADS];
    long long k;

    handle = dlopen(0, 2);
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    if (!create || !join)
        return 1;
    for (k = 0; k < THREADS; k++) {
        if (create(&threads[k], 0, worker, (void *)k))
            return 2;
    }
    for (k = 0; k < THREADS; k++)
        join(threads[k], 0);
#endif
    return 0;
}

static int contended(void) {
    CHECK(run_threads() == 0);
    CHECK(relaxed_count == THREADS * ROUNDS);
    CHECK(cas_count == THREADS * ROUNDS);
    CHECK(down_count == 0);
    CHECK(short_count == (short)(THREADS * ROUNDS));
    CHECK(toggles == 0);
    CHECK(locked_count == THREADS * ROUNDS);
    CHECK(byte_locked_count == THREADS * ROUNDS);
    return 0;
}

int main(void) {
    return contended();
}
