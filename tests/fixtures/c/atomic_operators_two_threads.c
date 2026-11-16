/* Two threads updating `_Atomic` objects through the operators (C11
   6.5.2.4p2, 6.5.16.2p3): each `++`, `--` and compound assignment is one
   read-modify-write, so no update is lost. The counters take the in-place
   instructions, the multiplication, the floating objects and the `_Bool`
   the compare-exchange retry, the 16-byte ones the paired compare-exchange
   or a lock, and a 3-byte structure, written whole by both threads, the
   access its layout gives it; a read of it never sees a mix of the two
   writes. The exit code is the line of the first mismatch. */
// snapshot-budget: exempt

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

#define ROUNDS 20000

struct rgb {
    unsigned char r, g, b;
};

static _Atomic int count;
static _Atomic long down = 2 * ROUNDS;
static _Atomic unsigned char wraps;
static _Atomic(long *) cursor;
static long slots[2 * ROUNDS + 1];
static _Atomic unsigned odd = 1;
static _Atomic double total;
static _Atomic long double half;
#ifdef __SIZEOF_INT128__
static _Atomic __int128 wide;
#endif
static _Atomic _Bool flag;
static _Atomic struct rgb color;
static _Atomic int torn;

static void *worker(void *arg) {
    unsigned char shade = (unsigned char)(long long)arg;
    struct rgb mine = {shade, shade, shade};
    int i;

    for (i = 0; i < ROUNDS; i++) {
        count++;
        down -= 1;
        ++wraps;
        cursor++;
        odd *= 3;
        total += 0.5;
        half += 0.25;
#ifdef __SIZEOF_INT128__
        wide += (__int128)1 << 64 | 1;
#endif
        flag ^= 1;
        color = mine;
        struct rgb seen = color;
        if (seen.r != seen.g || seen.g != seen.b)
            torn += 1;
    }
    return 0;
}

/* Run `worker` on two threads and wait for them. Windows has no pthreads
   in its C library; kernel32's CreateThread starts the threads there. */
static int run_threads(void) {
#ifdef _WIN32
    HANDLE threads[2];
    long long k;

    for (k = 0; k < 2; k++) {
        threads[k] = CreateThread(0, 0, (LPTHREAD_START_ROUTINE)worker, (void *)(k + 1), 0, 0);
        if (!threads[k])
            return 1;
    }
    for (k = 0; k < 2; k++) {
        WaitForSingleObject(threads[k], INFINITE);
        CloseHandle(threads[k]);
    }
#else
    void *handle;
    int (*create)(long long *, void *, void *(*)(void *), void *);
    int (*join)(long long, void **);
    long long threads[2];
    long long k;

    handle = dlopen(0, 2);
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    if (!create || !join)
        return 1;
    for (k = 0; k < 2; k++) {
        if (create(&threads[k], 0, worker, (void *)(k + 1)))
            return 2;
    }
    for (k = 0; k < 2; k++)
        join(threads[k], 0);
#endif
    return 0;
}

int main(void) {
    unsigned expect = 1;
    int i;

    cursor = slots;
    CHECK(run_threads() == 0);
    CHECK(count == 2 * ROUNDS);
    CHECK(down == 0);
    CHECK(wraps == (unsigned char)(2 * ROUNDS));
    CHECK(cursor == slots + 2 * ROUNDS);
    for (i = 0; i < 2 * ROUNDS; i++)
        expect *= 3;
    CHECK(odd == expect);
    CHECK(total == ROUNDS);
    CHECK(half == ROUNDS / 2);
#ifdef __SIZEOF_INT128__
    CHECK(wide == ((__int128)(2 * ROUNDS) << 64 | 2 * ROUNDS));
#endif
    CHECK(flag == 0);
    CHECK(torn == 0);
    return 0;
}
