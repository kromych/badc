#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#include <windows.h>
#else
#include <pthread.h>
#endif

// Multi-threaded "compute pool" demo.
//
// Spawns NUM_THREADS OS-level threads, each pulling work from a
// shared task queue under a mutex; once the queue drains, every
// worker exits and main() prints the per-task results.
//
// The c5 dialect can't read the start-function's `arg` parameter
// (the host ABI puts it in rdi/x0/rcx, while a c5 callee fetches
// args off the c5 stack), so workers don't carry per-thread state
// in. Everything they need lives in globals; each thread fetches
// its next task by atomically incrementing the shared counter
// inside the mutex.
//
// Cross-platform: POSIX pthreads on macOS / Linux, Win32
// CreateThread + CRITICAL_SECTION on Windows. Build/run:
//
//   cargo run -- --emit-native -O -o threads demos/threads.c
//   ./threads

#define NUM_THREADS   4
#define NUM_TASKS     12
#define FIB_BASE      28      // task K computes fib(FIB_BASE + K)

// Shared state -- read/written under g_lock.
int   g_next_task;       // next unclaimed task index
int  *g_results;         // results[NUM_TASKS]
int  *g_picked_by;       // which worker_no claimed each task
char *g_lock;            // pthread_mutex_t* or CRITICAL_SECTION*

// Per-platform thread handles.
#ifdef _WIN32
int *g_handles;
int *g_thread_ids;
#else
int *g_threads;          // pthread_t[NUM_THREADS] (8 bytes each)
#endif

// Each worker labels itself when it claims its first task. Stored
// outside the lock since each slot is written by exactly one
// thread (the one whose pthread_self/GetCurrentThreadId hash maps
// here). Plain int so badc's c5 dialect doesn't need a slot type.
int  g_worker_seq;       // running counter -- inside lock

void lock() {
#ifdef _WIN32
    EnterCriticalSection(g_lock);
#else
    pthread_mutex_lock(g_lock);
#endif
}

void unlock() {
#ifdef _WIN32
    LeaveCriticalSection(g_lock);
#else
    pthread_mutex_unlock(g_lock);
#endif
}

// Naive recursive fib -- intentionally exponential so each task
// runs long enough that the threads actually overlap. The
// iterative version finishes too fast for the first worker to
// drop the lock before the others wake up, and the demo's whole
// point is to *see* multiple workers picking up tasks.
int compute_fib(int n) {
    if (n < 2) return n;
    return compute_fib(n - 1) + compute_fib(n - 2);
}

// Worker entry. The host calling convention hands us our `arg` in
// the platform's first integer register, which a c5 callee can't
// read -- so we don't try. Everything the worker needs is shared
// global state.
//
// Returns 0 (well-defined for both pthread `void *(*)()` and
// Win32 `DWORD (WINAPI *)()` -- c4's epilogue zero-fills rax so
// either ABI sees a clean return value).
int worker_main() {
    int my_id;
    int task;
    int answer;

    lock();
    my_id = g_worker_seq;
    g_worker_seq = my_id + 1;
    unlock();

    while (1) {
        lock();
        if (g_next_task >= NUM_TASKS) {
            unlock();
            return 0;
        }
        task = g_next_task;
        g_next_task = task + 1;
        g_picked_by[task] = my_id;
        unlock();

        answer = compute_fib(task + FIB_BASE);

        lock();
        g_results[task] = answer;
        unlock();
    }
}

int main() {
    int i;
    int total;

#ifdef _WIN32
    g_handles    = malloc(sizeof(int) * NUM_THREADS);
    g_thread_ids = malloc(sizeof(int) * NUM_THREADS);
    g_lock       = malloc(CRITICAL_SECTION_SIZE);
    InitializeCriticalSection(g_lock);
#else
    g_threads    = malloc(PTHREAD_T_SIZE * NUM_THREADS);
    g_lock       = malloc(PTHREAD_MUTEX_SIZE);
    pthread_mutex_init(g_lock, 0);
#endif

    g_results    = malloc(sizeof(int) * NUM_TASKS);
    g_picked_by  = malloc(sizeof(int) * NUM_TASKS);
    memset((char *)g_results, 0, sizeof(int) * NUM_TASKS);
    memset((char *)g_picked_by, 0, sizeof(int) * NUM_TASKS);
    g_next_task   = 0;
    g_worker_seq  = 0;

    printf("threads demo: %d workers / %d tasks\n", NUM_THREADS, NUM_TASKS);

    i = 0;
    while (i < NUM_THREADS) {
#ifdef _WIN32
        g_handles[i] = CreateThread(0, 0, worker_main, 0, 0, g_thread_ids + i);
#else
        pthread_create(g_threads + i, 0, worker_main, 0);
#endif
        i = i + 1;
    }

    i = 0;
    while (i < NUM_THREADS) {
#ifdef _WIN32
        WaitForSingleObject(g_handles[i], INFINITE);
        CloseHandle(g_handles[i]);
#else
        pthread_join((int)g_threads[i], 0);
#endif
        i = i + 1;
    }

    printf("\nresults:\n");
    total = 0;
    i = 0;
    while (i < NUM_TASKS) {
        printf("  task %2d: fib(%2d) = %-10d  (worker %d)\n",
               i, i + FIB_BASE, g_results[i], g_picked_by[i]);
        total = total + g_results[i];
        i = i + 1;
    }
    printf("  sum   : %d\n", total);

#ifdef _WIN32
    DeleteCriticalSection(g_lock);
    free(g_handles);
    free(g_thread_ids);
#else
    pthread_mutex_destroy(g_lock);
    free(g_threads);
#endif
    free(g_lock);
    free(g_results);
    free(g_picked_by);
    return 0;
}
