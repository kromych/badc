/* Four threads contending through MSVC's Interlocked intrinsics and the
   <windows.h> names over them: counters of every width, an add and a
   decrement, bits set, cleared and toggled back, a compare-exchange loop,
   pointer exchanges, and a spinlock on InterlockedCompareExchange guarding
   a plain counter, released by InterlockedExchange. On arm64 the _acq,
   _rel and _nf forms run too. Every total is checked once the threads are
   joined; the exit code is the line of the first mismatch. Elsewhere the
   program exits 0. */

#ifdef _WIN32
#include <windows.h>
#include <intrin.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

#define THREADS 4
#define ROUNDS 20000
#if defined(__aarch64__) || defined(_M_ARM64)
#define ARM64 1
#endif

static volatile LONG count;
static volatile LONG down = THREADS * ROUNDS;
static volatile LONG64 count64;
static volatile SHORT count16;
static volatile char count8;
static volatile LONG cas_count;
static volatile LONG64 cas_count64;
static volatile LONG set_bits;
static volatile LONG cleared_bits = 0xff00;
static volatile LONG64 toggles64;
static volatile SHORT toggles16;
static volatile char toggles8;
static volatile LONG lock;
static long long locked_count;
static void *volatile slot;
static volatile LONG swaps;
#ifdef ARM64
static volatile LONG ordered;
#endif

static DWORD WINAPI worker(LPVOID arg)
{
    LONG id = (LONG)(LONG_PTR)arg;
    static char token[THREADS];
    for (int i = 0; i < ROUNDS; i++) {
        InterlockedIncrement(&count);
        InterlockedExchangeAdd(&count, 2);
        InterlockedDecrement(&count);
        InterlockedDecrement(&down);
        InterlockedIncrement64(&count64);
        InterlockedExchangeAdd64(&count64, -1);
        InterlockedAdd64(&count64, 3);
        InterlockedIncrement16(&count16);
        _InterlockedExchangeAdd8(&count8, 1);
        LONG seen = cas_count;
        for (LONG was; (was = InterlockedCompareExchange(&cas_count, seen + 1, seen)) != seen;)
            seen = was;
        LONG64 seen64 = cas_count64;
        for (LONG64 was; (was = InterlockedCompareExchange64(&cas_count64, seen64 + 2, seen64)) != seen64;)
            seen64 = was;
        InterlockedOr(&set_bits, 1L << id);
        InterlockedAnd(&cleared_bits, ~(1L << (id + 8)));
        InterlockedXor64(&toggles64, 1LL << (id + 32));
        InterlockedXor16(&toggles16, (SHORT)(1 << id));
        _InterlockedXor8(&toggles8, (char)(1 << id));
        while (InterlockedCompareExchange(&lock, 1, 0) != 0)
            ;
        locked_count++;
        InterlockedExchange(&lock, 0);
        void *mine = &token[id];
        void *had = InterlockedExchangePointer(&slot, mine);
        if (had && InterlockedCompareExchangePointer(&slot, had, mine) == mine)
            InterlockedIncrement(&swaps);
#ifdef ARM64
        _InterlockedIncrement_acq(&ordered);
        _InterlockedExchangeAdd_rel(&ordered, 2);
        _InterlockedDecrement_nf(&ordered);
        InterlockedAdd(&ordered, 1);
#endif
    }
    return 0;
}

static int contended(void)
{
    HANDLE threads[THREADS];
    for (LONG_PTR k = 0; k < THREADS; k++) {
        threads[k] = CreateThread(0, 0, worker, (LPVOID)k, 0, 0);
        CHECK(threads[k] != 0);
    }
    for (int k = 0; k < THREADS; k++) {
        WaitForSingleObject(threads[k], INFINITE);
        CloseHandle(threads[k]);
    }
    CHECK(count == 2 * THREADS * ROUNDS);
    CHECK(down == 0);
    CHECK(count64 == 3LL * THREADS * ROUNDS);
    CHECK(count16 == (SHORT)(THREADS * ROUNDS));
    CHECK(count8 == (char)(THREADS * ROUNDS));
    CHECK(cas_count == THREADS * ROUNDS);
    CHECK(cas_count64 == 2LL * THREADS * ROUNDS);
    CHECK(set_bits == (1L << THREADS) - 1);
    CHECK(cleared_bits == (0xff00 & ~(((1L << THREADS) - 1) << 8)));
    CHECK(toggles64 == 0 && toggles16 == 0 && toggles8 == 0);
    CHECK(locked_count == THREADS * ROUNDS);
    CHECK(swaps <= THREADS * ROUNDS);
#ifdef ARM64
    CHECK(ordered == 3 * THREADS * ROUNDS);
#endif
    return 0;
}

/* Each form returns what MSVC documents: the new value for an increment,
   a decrement and InterlockedAdd, the old one for the rest. */
static int results(void)
{
    LONG v = 5;
    CHECK(InterlockedIncrement(&v) == 6 && InterlockedDecrement(&v) == 5);
    CHECK(InterlockedExchange(&v, 9) == 5 && v == 9);
    CHECK(InterlockedExchangeAdd(&v, 3) == 9 && v == 12);
    CHECK(InterlockedCompareExchange(&v, 1, 7) == 12 && v == 12);
    CHECK(InterlockedCompareExchange(&v, 1, 12) == 12 && v == 1);
    CHECK(InterlockedOr(&v, 6) == 1 && v == 7);
    CHECK(InterlockedAnd(&v, 5) == 7 && v == 5);
    CHECK(InterlockedXor(&v, 1) == 5 && v == 4);
    LONG64 w = -1;
    CHECK(InterlockedAdd64(&w, 2) == 1 && InterlockedIncrement64(&w) == 2);
    CHECK(InterlockedExchange64(&w, 1LL << 40) == 2 && w == 1LL << 40);
    CHECK(InterlockedCompareExchange64(&w, 3, 1LL << 40) == 1LL << 40 && w == 3);
    SHORT s = -1;
    CHECK(InterlockedIncrement16(&s) == 0 && InterlockedCompareExchange16(&s, 4, 0) == 0);
    CHECK(InterlockedExchange16(&s, 2) == 4 && InterlockedAnd16(&s, 3) == 2);
    char c = 0x7f;
    CHECK(InterlockedExchangeAdd8(&c, 1) == 0x7f && c == (char)0x80);
    CHECK(InterlockedExchange8(&c, 1) == (char)0x80 && InterlockedOr8(&c, 2) == 1 && c == 3);
    void *p = &v;
    CHECK(InterlockedCompareExchangePointer(&p, &w, &v) == &v && p == &w);
    CHECK(InterlockedExchangePointer(&p, 0) == &w && p == 0);
    return 0;
}

int main(void)
{
    int line = results();
    return line ? line : contended();
}
#else
int main(void)
{
    return 0;
}
#endif
