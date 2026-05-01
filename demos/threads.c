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
// `arg` flows into the worker: the codegen emits a per-function
// arg-shuffling thunk whenever a c5 function's address is taken,
// so when pthread_create / CreateThread invokes worker_main with
// the host ABI's first int register set, the thunk re-spills it
// onto the c5 stack at the slot the c5 callee reads from. We use
// that channel to hand each worker its logical id; everything
// else (the task queue, the result table) stays in globals.
//
// Cross-platform: POSIX pthreads on macOS / Linux, Win32
// CreateThread + CRITICAL_SECTION on Windows. Build/run:
//
//   cargo run -- -O -o threads demos/threads.c
//   ./threads

#define NUM_THREADS   4
#define NUM_TASKS     12
#define FIB_BASE      28      // task K computes fib(FIB_BASE + K)

// Shared state -- read/written under g_lock.
int   g_next_task;       // next unclaimed task index
int  *g_results;         // results[NUM_TASKS]
int  *g_picked_by;       // which worker_id claimed each task
char *g_lock;            // pthread_mutex_t* or CRITICAL_SECTION*

// Per-platform thread handles.
#ifdef _WIN32
int *g_handles;
int *g_thread_ids;
#else
int *g_threads;          // pthread_t[NUM_THREADS] (8 bytes each)
#endif

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

// Worker entry. The arg-shuffling thunk that the codegen emits
// in front of every address-taken function copies the host's
// first int-arg register (rdi / x0 / rcx) into the c5 stack slot
// that this `arg` parameter reads from. We pass the worker's
// logical id (cast to int * because that's what pthread_create's
// `void *arg` is typed as in the c5 prototype).
//
// Returns 0 -- well-defined for both pthread `void *(*)()` and
// Win32 `DWORD (WINAPI *)()`, since either ABI takes the return
// value out of rax.
int worker_main(int *arg) {
    int my_id;
    int task;
    int answer;

    my_id = (int)arg;

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

    printf("threads demo: %d workers / %d tasks\n", NUM_THREADS, NUM_TASKS);

    // Pass each worker its logical id (1-based; 0 is reserved for
    // "no worker has touched this slot yet" in g_picked_by).
    i = 0;
    while (i < NUM_THREADS) {
#ifdef _WIN32
        g_handles[i] = CreateThread(0, 0, worker_main, (char *)(i + 1),
                                    0, g_thread_ids + i);
#else
        pthread_create(g_threads + i, 0, worker_main, (char *)(i + 1));
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
