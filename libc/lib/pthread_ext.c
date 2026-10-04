// <pthread.h>'s threads, mutexes, condition variables, once controls and
// thread-specific data, and <sched.h>'s yield and priority range, on the
// Windows targets, where mingw-w64 declares them (winpthreads) and msvcrt
// defines none. Threads are kernel32's, mutexes and condition variables its
// slim reader/writer lock and condition variable, whose all-zero states the
// static initializers spell, and thread-specific data its TLS slots. The
// file compiles to nothing elsewhere; the native-link driver offers it like
// an archive member.

#ifdef _WIN32

#include <errno.h>
#include <limits.h>
#include <pthread.h>
#include <sched.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

// ntdll's shutdown query: TRUE once the process has begun to exit.
#pragma dylib(ntdll, "ntdll.dll")
#pragma binding(ntdll::RtlDllShutdownInProgress, "RtlDllShutdownInProgress")
BOOLEAN RtlDllShutdownInProgress(void);

#define NS_PER_SEC 1000000000LL

// A thread's record, which its pthread_t points to. pthread_create's
// threads carry their handle; a thread started otherwise is given a
// detached record without one the first time it needs a record.
struct thread {
    void *(*start)(void *);
    void *arg;
    void *result;
    HANDLE handle;
    long state;
};

enum { JOINABLE, DETACHED, EXITED };

// The FLS slot holding the calling thread's record. Its callback runs when a
// thread exits, and also on the thread that ends the process.
static DWORD self_slot = FLS_OUT_OF_INDEXES;

// Keys are TLS indices, below TLS_MINIMUM_AVAILABLE + TLS_EXPANSION_SLOTS.
// TlsAlloc hands out an index whose slot is null in every thread and TlsFree
// runs nothing, as pthread_key_create and pthread_key_delete require.
#define KEYS 1088
static void (*destructors[KEYS])(void *);
static unsigned char live[KEYS];
static unsigned keys_end;
static SRWLOCK keys_lock = SRWLOCK_INIT;

// POSIX's minimum number of destructor passes, as glibc makes.
#define DESTRUCTOR_PASSES 4

static void run_destructors(void) {
    int pass, ran = 1;
    for (pass = 0; ran && pass < DESTRUCTOR_PASSES; pass++) {
        unsigned k, end;
        ran = 0;
        AcquireSRWLockShared(&keys_lock);
        end = keys_end;
        ReleaseSRWLockShared(&keys_lock);
        for (k = 0; k < end; k++) {
            void (*destructor)(void *);
            void *value;
            AcquireSRWLockShared(&keys_lock);
            destructor = destructors[k];
            ReleaseSRWLockShared(&keys_lock);
            if (!destructor || !(value = TlsGetValue(k)))
                continue;
            TlsSetValue(k, NULL);
            destructor(value);
            ran = 1;
        }
    }
}

// A thread pthread_create did not start ends here with its record still in
// the slot. A process ends without running destructors (POSIX _exit), and
// the callback runs then too, on the exiting thread.
static void WINAPI thread_detach(void *record) {
    if (RtlDllShutdownInProgress())
        return;
    run_destructors();
    free(record);
}

static DWORD self_index(void) {
    DWORD index = __atomic_load_n(&self_slot, __ATOMIC_ACQUIRE);
    DWORD expected = FLS_OUT_OF_INDEXES;
    if (index != FLS_OUT_OF_INDEXES)
        return index;
    index = FlsAlloc(thread_detach);
    if (index == FLS_OUT_OF_INDEXES)
        return index;
    if (!__atomic_compare_exchange_n(&self_slot, &expected, index, 0, __ATOMIC_ACQ_REL,
                                     __ATOMIC_ACQUIRE)) {
        FlsFree(index);
        index = expected;
    }
    return index;
}

static struct thread *current(void) {
    DWORD index = self_index();
    return index == FLS_OUT_OF_INDEXES ? NULL : FlsGetValue(index);
}

// The record of a thread pthread_create did not start: detached, since
// nothing can join it, and freed when the thread exits.
static struct thread *adopt(void) {
    DWORD index = self_index();
    struct thread *t;
    if (index == FLS_OUT_OF_INDEXES || !(t = calloc(1, sizeof *t)))
        return NULL;
    t->state = DETACHED;
    if (!FlsSetValue(index, t)) {
        free(t);
        return NULL;
    }
    return t;
}

// The calling thread leaves `t` with `result`. A joinable thread's record
// goes to the thread that joins or detaches it, a detached one's here.
static void finish(struct thread *t, void *result) {
    t->result = result;
    run_destructors();
    FlsSetValue(self_slot, NULL);
    if (__atomic_exchange_n(&t->state, EXITED, __ATOMIC_ACQ_REL) == DETACHED) {
        if (t->handle)
            CloseHandle(t->handle);
        free(t);
    }
}

static DWORD WINAPI thread_start(void *record) {
    struct thread *t = record;
    FlsSetValue(self_slot, t);
    finish(t, t->start(t->arg));
    return 0;
}

// Windows has seven thread priority levels; a POSIX priority takes the
// level at or beyond it toward normal, as winpthreads maps it.
static int level_of(int priority) {
    if (priority <= THREAD_PRIORITY_IDLE)
        return THREAD_PRIORITY_IDLE;
    if (priority <= THREAD_PRIORITY_LOWEST)
        return THREAD_PRIORITY_LOWEST;
    if (priority >= THREAD_PRIORITY_TIME_CRITICAL)
        return THREAD_PRIORITY_TIME_CRITICAL;
    if (priority >= THREAD_PRIORITY_HIGHEST)
        return THREAD_PRIORITY_HIGHEST;
    return priority;
}

int pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start)(void *),
                   void *arg) {
    size_t stack = attr ? attr->__stacksize : 0;
    int priority = THREAD_PRIORITY_NORMAL;
    struct thread *t;
    if (self_index() == FLS_OUT_OF_INDEXES || !(t = calloc(1, sizeof *t)))
        return EAGAIN;
    t->start = start;
    t->arg = arg;
    t->state = attr && attr->__state & PTHREAD_CREATE_DETACHED ? DETACHED : JOINABLE;
    if (attr)
        priority = attr->__state & PTHREAD_INHERIT_SCHED ? GetThreadPriority(GetCurrentThread())
                                                         : level_of(attr->__param.sched_priority);
    // Suspended until the record is complete: a detached thread may exit and
    // close its handle before CreateThread returns.
    t->handle = CreateThread(NULL, stack, thread_start, t,
                             CREATE_SUSPENDED | (stack ? STACK_SIZE_PARAM_IS_A_RESERVATION : 0),
                             NULL);
    if (!t->handle) {
        free(t);
        return EAGAIN;
    }
    if (priority != THREAD_PRIORITY_NORMAL)
        SetThreadPriority(t->handle, priority);
    *thread = (pthread_t)t;
    ResumeThread(t->handle);
    return 0;
}

int pthread_join(pthread_t thread, void **result) {
    struct thread *t = (struct thread *)thread;
    if (t == current())
        return EDEADLK;
    if (!t->handle || __atomic_load_n(&t->state, __ATOMIC_ACQUIRE) == DETACHED)
        return EINVAL;
    WaitForSingleObject(t->handle, INFINITE);
    if (result)
        *result = t->result;
    CloseHandle(t->handle);
    free(t);
    return 0;
}

int pthread_detach(pthread_t thread) {
    struct thread *t = (struct thread *)thread;
    long state = JOINABLE;
    if (!t->handle)
        return EINVAL;
    if (__atomic_compare_exchange_n(&t->state, &state, DETACHED, 0, __ATOMIC_ACQ_REL,
                                    __ATOMIC_ACQUIRE))
        return 0;
    if (state == DETACHED)
        return EINVAL;
    CloseHandle(t->handle);
    free(t);
    return 0;
}

void pthread_exit(void *result) {
    struct thread *t = current();
    if (t && t->handle)
        finish(t, result);
    else
        run_destructors();
    ExitThread(0);
}

pthread_t pthread_self(void) {
    struct thread *t = current();
    return (pthread_t)(t ? t : adopt());
}

int pthread_equal(pthread_t t1, pthread_t t2) { return t1 == t2; }

int pthread_attr_init(pthread_attr_t *attr) {
    attr->__state = PTHREAD_CREATE_JOINABLE | PTHREAD_EXPLICIT_SCHED | PTHREAD_SCOPE_SYSTEM;
    attr->__stack = NULL;
    attr->__stacksize = 0;
    attr->__param.sched_priority = THREAD_PRIORITY_NORMAL;
    return 0;
}

int pthread_attr_destroy(pthread_attr_t *attr) { return 0; }

int pthread_attr_setdetachstate(pthread_attr_t *attr, int state) {
    if (state != PTHREAD_CREATE_JOINABLE && state != PTHREAD_CREATE_DETACHED)
        return EINVAL;
    attr->__state = (attr->__state & ~PTHREAD_CREATE_DETACHED) | state;
    return 0;
}

int pthread_attr_setstacksize(pthread_attr_t *attr, size_t size) {
    attr->__stacksize = size;
    return 0;
}

// Windows threads all contend system-wide.
int pthread_attr_setscope(pthread_attr_t *attr, int scope) {
    if (scope == PTHREAD_SCOPE_SYSTEM)
        return 0;
    return scope == PTHREAD_SCOPE_PROCESS ? ENOTSUP : EINVAL;
}

int pthread_attr_setschedpolicy(pthread_attr_t *attr, int policy) {
    if (policy == SCHED_OTHER)
        return 0;
    return policy == SCHED_FIFO || policy == SCHED_RR ? ENOTSUP : EINVAL;
}

int pthread_attr_setschedparam(pthread_attr_t *restrict attr,
                               const struct sched_param *restrict param) {
    if (param->sched_priority < THREAD_PRIORITY_IDLE ||
        param->sched_priority > THREAD_PRIORITY_TIME_CRITICAL)
        return EINVAL;
    attr->__param = *param;
    return 0;
}

int pthread_attr_getschedparam(const pthread_attr_t *restrict attr,
                               struct sched_param *restrict param) {
    *param = attr->__param;
    return 0;
}

int pthread_attr_setinheritsched(pthread_attr_t *attr, int inherit) {
    if (inherit != PTHREAD_INHERIT_SCHED && inherit != PTHREAD_EXPLICIT_SCHED)
        return EINVAL;
    attr->__state = (attr->__state & ~PTHREAD_INHERIT_SCHED) | inherit;
    return 0;
}

// A thread's stack grows into one guard page.
int pthread_attr_getguardsize(const pthread_attr_t *restrict attr, size_t *restrict size) {
    SYSTEM_INFO info;
    GetSystemInfo(&info);
    *size = info.dwPageSize;
    return 0;
}

int pthread_attr_getstack(const pthread_attr_t *restrict attr, void **restrict addr,
                          size_t *restrict size) {
    *addr = attr->__stack;
    *size = attr->__stacksize;
    return 0;
}

#define SRW(m) ((PSRWLOCK)&(m)->__lock)
#define OWNER(m) __atomic_load_n(&(m)->__owner, __ATOMIC_RELAXED)
#define SET_OWNER(m, id) __atomic_store_n(&(m)->__owner, (id), __ATOMIC_RELAXED)

int pthread_mutexattr_init(pthread_mutexattr_t *attr) {
    *attr = PTHREAD_MUTEX_DEFAULT;
    return 0;
}

int pthread_mutexattr_destroy(pthread_mutexattr_t *attr) { return 0; }

int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type) {
    if (type != PTHREAD_MUTEX_NORMAL && type != PTHREAD_MUTEX_ERRORCHECK &&
        type != PTHREAD_MUTEX_RECURSIVE)
        return EINVAL;
    *attr = type;
    return 0;
}

int pthread_mutex_init(pthread_mutex_t *restrict mutex, const pthread_mutexattr_t *restrict attr) {
    mutex->__lock = NULL;
    mutex->__owner = 0;
    mutex->__count = 0;
    mutex->__type = attr ? (int)*attr : PTHREAD_MUTEX_DEFAULT;
    return 0;
}

int pthread_mutex_destroy(pthread_mutex_t *mutex) {
    if (!TryAcquireSRWLockExclusive(SRW(mutex)))
        return EBUSY;
    ReleaseSRWLockExclusive(SRW(mutex));
    return 0;
}

// A recursive or error-checking mutex the caller holds already: the
// recursive one counts another level, the other refuses (`busy`).
static int relock(pthread_mutex_t *mutex, int busy) {
    if (mutex->__type != PTHREAD_MUTEX_RECURSIVE)
        return busy;
    if (mutex->__count == UINT_MAX)
        return EAGAIN;
    mutex->__count++;
    return 0;
}

int pthread_mutex_lock(pthread_mutex_t *mutex) {
    DWORD self;
    if (mutex->__type == PTHREAD_MUTEX_NORMAL) {
        AcquireSRWLockExclusive(SRW(mutex));
        return 0;
    }
    self = GetCurrentThreadId();
    if (OWNER(mutex) == self)
        return relock(mutex, EDEADLK);
    AcquireSRWLockExclusive(SRW(mutex));
    SET_OWNER(mutex, self);
    mutex->__count = 1;
    return 0;
}

int pthread_mutex_trylock(pthread_mutex_t *mutex) {
    DWORD self;
    if (mutex->__type == PTHREAD_MUTEX_NORMAL)
        return TryAcquireSRWLockExclusive(SRW(mutex)) ? 0 : EBUSY;
    self = GetCurrentThreadId();
    if (OWNER(mutex) == self)
        return relock(mutex, EBUSY);
    if (!TryAcquireSRWLockExclusive(SRW(mutex)))
        return EBUSY;
    SET_OWNER(mutex, self);
    mutex->__count = 1;
    return 0;
}

int pthread_mutex_unlock(pthread_mutex_t *mutex) {
    if (mutex->__type != PTHREAD_MUTEX_NORMAL) {
        if (OWNER(mutex) != GetCurrentThreadId())
            return EPERM;
        if (--mutex->__count)
            return 0;
        SET_OWNER(mutex, 0);
    }
    ReleaseSRWLockExclusive(SRW(mutex));
    return 0;
}

#define CV(c) ((PCONDITION_VARIABLE)&(c)->__cv)

int pthread_condattr_init(pthread_condattr_t *attr) {
    *attr = CLOCK_REALTIME;
    return 0;
}

int pthread_condattr_destroy(pthread_condattr_t *attr) { return 0; }

int pthread_condattr_setclock(pthread_condattr_t *attr, clockid_t clock) {
    if (clock != CLOCK_REALTIME && clock != CLOCK_MONOTONIC)
        return EINVAL;
    *attr = clock;
    return 0;
}

int pthread_cond_init(pthread_cond_t *restrict cond, const pthread_condattr_t *restrict attr) {
    cond->__cv = NULL;
    cond->__clock = attr ? *attr : CLOCK_REALTIME;
    return 0;
}

int pthread_cond_destroy(pthread_cond_t *cond) { return 0; }

int pthread_cond_signal(pthread_cond_t *cond) {
    WakeConditionVariable(CV(cond));
    return 0;
}

int pthread_cond_broadcast(pthread_cond_t *cond) {
    WakeAllConditionVariable(CV(cond));
    return 0;
}

// Sleeps on `cond` for at most `ms`, `mutex` released meanwhile. A recursive
// mutex gives up every level it holds and takes them back on waking.
static int cond_sleep(pthread_cond_t *cond, pthread_mutex_t *mutex, DWORD ms) {
    DWORD self = 0;
    unsigned count = 0;
    BOOL woken;
    if (mutex->__type != PTHREAD_MUTEX_NORMAL) {
        self = GetCurrentThreadId();
        if (OWNER(mutex) != self)
            return EPERM;
        count = mutex->__count;
        SET_OWNER(mutex, 0);
    }
    woken = SleepConditionVariableSRW(CV(cond), SRW(mutex), ms, 0);
    if (self) {
        SET_OWNER(mutex, self);
        mutex->__count = count;
    }
    return woken ? 0 : ETIMEDOUT;
}

int pthread_cond_wait(pthread_cond_t *restrict cond, pthread_mutex_t *restrict mutex) {
    return cond_sleep(cond, mutex, INFINITE);
}

// The deadline is read on the condition's clock; a sleep that ends before
// it, the system timer's granularity being coarser, sleeps again.
int pthread_cond_timedwait(pthread_cond_t *restrict cond, pthread_mutex_t *restrict mutex,
                           const struct timespec *restrict abstime) {
    if (abstime->tv_nsec < 0 || abstime->tv_nsec >= NS_PER_SEC)
        return EINVAL;
    for (;;) {
        struct timespec now;
        long long sec, ns;
        DWORD ms = INFINITE - 1;
        int rc;
        clock_gettime(cond->__clock, &now);
        sec = (long long)abstime->tv_sec - now.tv_sec;
        if (sec < 0)
            return ETIMEDOUT;
        if (sec < (INFINITE - 1) / 1000) {
            ns = sec * NS_PER_SEC + abstime->tv_nsec - now.tv_nsec;
            if (ns <= 0)
                return ETIMEDOUT;
            ms = (DWORD)((ns + 999999) / 1000000);
        }
        rc = cond_sleep(cond, mutex, ms);
        if (rc != ETIMEDOUT)
            return rc;
    }
}

enum { ONCE_NEW = PTHREAD_ONCE_INIT, ONCE_RUNNING, ONCE_DONE };
static SRWLOCK once_lock = SRWLOCK_INIT;
static CONDITION_VARIABLE once_done = CONDITION_VARIABLE_INIT;

int pthread_once(pthread_once_t *once, void (*init)(void)) {
    long state = __atomic_load_n(once, __ATOMIC_ACQUIRE);
    if (state == ONCE_DONE)
        return 0;
    if (state == ONCE_NEW && __atomic_compare_exchange_n(once, &state, ONCE_RUNNING, 0,
                                                         __ATOMIC_ACQUIRE, __ATOMIC_ACQUIRE)) {
        init();
        AcquireSRWLockExclusive(&once_lock);
        __atomic_store_n(once, ONCE_DONE, __ATOMIC_RELEASE);
        ReleaseSRWLockExclusive(&once_lock);
        WakeAllConditionVariable(&once_done);
        return 0;
    }
    AcquireSRWLockExclusive(&once_lock);
    while (__atomic_load_n(once, __ATOMIC_ACQUIRE) != ONCE_DONE)
        SleepConditionVariableSRW(&once_done, &once_lock, INFINITE, 0);
    ReleaseSRWLockExclusive(&once_lock);
    return 0;
}

int pthread_key_create(pthread_key_t *key, void (*destructor)(void *)) {
    DWORD index = TlsAlloc();
    if (index == TLS_OUT_OF_INDEXES)
        return EAGAIN;
    if (index >= KEYS) {
        TlsFree(index);
        return EAGAIN;
    }
    AcquireSRWLockExclusive(&keys_lock);
    destructors[index] = destructor;
    live[index] = 1;
    if (index >= keys_end)
        keys_end = index + 1;
    ReleaseSRWLockExclusive(&keys_lock);
    *key = index;
    return 0;
}

int pthread_key_delete(pthread_key_t key) {
    int was_live;
    if (key >= KEYS)
        return EINVAL;
    AcquireSRWLockExclusive(&keys_lock);
    was_live = live[key];
    live[key] = 0;
    destructors[key] = NULL;
    ReleaseSRWLockExclusive(&keys_lock);
    if (!was_live)
        return EINVAL;
    TlsFree(key);
    return 0;
}

// A value set on a thread pthread_create did not start gives the thread a
// record, so that its destructors run when it exits.
int pthread_setspecific(pthread_key_t key, const void *value) {
    if (value && !current() && !adopt())
        return ENOMEM;
    return TlsSetValue(key, (void *)value) ? 0 : EINVAL;
}

void *pthread_getspecific(pthread_key_t key) { return TlsGetValue(key); }

int sched_yield(void) {
    Sleep(0);
    return 0;
}

int sched_get_priority_min(int policy) {
    if (policy != SCHED_OTHER && policy != SCHED_FIFO && policy != SCHED_RR) {
        errno = EINVAL;
        return -1;
    }
    return THREAD_PRIORITY_IDLE;
}

int sched_get_priority_max(int policy) {
    if (policy != SCHED_OTHER && policy != SCHED_FIFO && policy != SCHED_RR) {
        errno = EINVAL;
        return -1;
    }
    return THREAD_PRIORITY_TIME_CRITICAL;
}

#endif
