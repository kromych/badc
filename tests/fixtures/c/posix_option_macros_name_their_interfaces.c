// POSIX.1-2008 XBD <unistd.h>: _POSIX_VERSION is defined, and an option
// defined with a value other than -1 has its interfaces present (XBD 2.1.6:
// a value of 0 asks the program to query sysconf at run time, with every
// declaration present all the same). Each such option's functions are
// named here, so a header that advertises one it does not declare stops
// the compile, and one it does not bind stops the link. Spot values are
// the C library's: glibc 2.43's on Linux and the macOS SDK's.
#define _GNU_SOURCE 1
#include <aio.h>
#include <dirent.h>
#include <fcntl.h>
#include <grp.h>
#include <pthread.h>
#include <pwd.h>
#include <regex.h>
#include <sched.h>
#include <semaphore.h>
#include <signal.h>
#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <time.h>
#include <unistd.h>
#if defined(_POSIX_MESSAGE_PASSING) && _POSIX_MESSAGE_PASSING != -1
#include <mqueue.h>
#endif

#ifndef _POSIX_VERSION
#error _POSIX_VERSION is not defined
#endif

typedef void (*fn)(void);
static const fn named[] = {
#if defined(_POSIX_ADVISORY_INFO) && _POSIX_ADVISORY_INFO != -1
    (fn)posix_fadvise,
    (fn)posix_madvise,
    (fn)posix_memalign,
#endif
#if defined(_POSIX_ASYNCHRONOUS_IO) && _POSIX_ASYNCHRONOUS_IO != -1
    (fn)aio_cancel,
    (fn)aio_error,
    (fn)aio_fsync,
    (fn)aio_read,
    (fn)aio_return,
    (fn)aio_suspend,
    (fn)aio_write,
    (fn)lio_listio,
#endif
#if defined(_POSIX_BARRIERS) && _POSIX_BARRIERS != -1
    (fn)pthread_barrier_init,
    (fn)pthread_barrier_wait,
    (fn)pthread_barrier_destroy,
    (fn)pthread_barrierattr_init,
    (fn)pthread_barrierattr_destroy,
#endif
#if defined(_POSIX_CLOCK_SELECTION) && _POSIX_CLOCK_SELECTION != -1
    (fn)clock_nanosleep,
    (fn)pthread_condattr_getclock,
    (fn)pthread_condattr_setclock,
#endif
#if defined(_POSIX_CPUTIME) && _POSIX_CPUTIME != -1
    (fn)clock_getcpuclockid,
#endif
#if defined(_POSIX_FSYNC) && _POSIX_FSYNC != -1
    (fn)fsync,
#endif
#if defined(_POSIX_MAPPED_FILES) && _POSIX_MAPPED_FILES != -1
    (fn)mmap,
    (fn)munmap,
    (fn)msync,
#endif
#if defined(_POSIX_MEMLOCK) && _POSIX_MEMLOCK != -1
    (fn)mlockall,
    (fn)munlockall,
#endif
#if defined(_POSIX_MEMLOCK_RANGE) && _POSIX_MEMLOCK_RANGE != -1
    (fn)mlock,
    (fn)munlock,
#endif
#if defined(_POSIX_MEMORY_PROTECTION) && _POSIX_MEMORY_PROTECTION != -1
    (fn)mprotect,
#endif
#if defined(_POSIX_MESSAGE_PASSING) && _POSIX_MESSAGE_PASSING != -1
    (fn)mq_close,
    (fn)mq_getattr,
    (fn)mq_notify,
    (fn)mq_open,
    (fn)mq_receive,
    (fn)mq_send,
    (fn)mq_setattr,
    (fn)mq_timedreceive,
    (fn)mq_timedsend,
    (fn)mq_unlink,
#endif
#if defined(_POSIX_PRIORITY_SCHEDULING) && _POSIX_PRIORITY_SCHEDULING != -1
    (fn)sched_get_priority_max,
    (fn)sched_get_priority_min,
    (fn)sched_getparam,
    (fn)sched_getscheduler,
    (fn)sched_rr_get_interval,
    (fn)sched_setparam,
    (fn)sched_setscheduler,
    (fn)sched_yield,
#endif
#if defined(_POSIX_READER_WRITER_LOCKS) && _POSIX_READER_WRITER_LOCKS != -1
    (fn)pthread_rwlock_init,
    (fn)pthread_rwlock_destroy,
    (fn)pthread_rwlock_rdlock,
    (fn)pthread_rwlock_wrlock,
    (fn)pthread_rwlock_tryrdlock,
    (fn)pthread_rwlock_trywrlock,
    (fn)pthread_rwlock_unlock,
    (fn)pthread_rwlockattr_init,
    (fn)pthread_rwlockattr_destroy,
#endif
#if defined(_POSIX_REALTIME_SIGNALS) && _POSIX_REALTIME_SIGNALS != -1
    (fn)sigqueue,
    (fn)sigtimedwait,
    (fn)sigwaitinfo,
#endif
#if defined(_POSIX_REGEXP) && _POSIX_REGEXP != -1
    (fn)regcomp,
    (fn)regexec,
    (fn)regerror,
    (fn)regfree,
#endif
#if defined(_POSIX_SEMAPHORES) && _POSIX_SEMAPHORES != -1
    (fn)sem_init,
    (fn)sem_destroy,
    (fn)sem_open,
    (fn)sem_close,
    (fn)sem_unlink,
    (fn)sem_post,
    (fn)sem_wait,
    (fn)sem_trywait,
    (fn)sem_getvalue,
#endif
#if defined(_POSIX_SHARED_MEMORY_OBJECTS) && _POSIX_SHARED_MEMORY_OBJECTS != -1
    (fn)shm_open,
    (fn)shm_unlink,
#endif
#if defined(_POSIX_SHELL) && _POSIX_SHELL != -1
    (fn)system,
    (fn)popen,
    (fn)pclose,
#endif
#if defined(_POSIX_SPAWN) && _POSIX_SPAWN != -1
    (fn)posix_spawn,
    (fn)posix_spawnp,
    (fn)posix_spawn_file_actions_init,
    (fn)posix_spawn_file_actions_destroy,
    (fn)posix_spawnattr_init,
    (fn)posix_spawnattr_destroy,
#endif
#if defined(_POSIX_SPIN_LOCKS) && _POSIX_SPIN_LOCKS != -1
    (fn)pthread_spin_init,
    (fn)pthread_spin_destroy,
    (fn)pthread_spin_lock,
    (fn)pthread_spin_trylock,
    (fn)pthread_spin_unlock,
#endif
#if defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO != -1
    (fn)fdatasync,
#endif
#if defined(_POSIX_THREAD_ATTR_STACKADDR) && _POSIX_THREAD_ATTR_STACKADDR != -1
    (fn)pthread_attr_getstack,
    (fn)pthread_attr_setstack,
#endif
#if defined(_POSIX_THREAD_ATTR_STACKSIZE) && _POSIX_THREAD_ATTR_STACKSIZE != -1
    (fn)pthread_attr_getstacksize,
    (fn)pthread_attr_setstacksize,
#endif
#if defined(_POSIX_THREAD_CPUTIME) && _POSIX_THREAD_CPUTIME != -1
    (fn)pthread_getcpuclockid,
#endif
#if defined(_POSIX_THREAD_PRIO_INHERIT) && _POSIX_THREAD_PRIO_INHERIT != -1
    (fn)pthread_mutexattr_getprotocol,
    (fn)pthread_mutexattr_setprotocol,
#endif
#if defined(_POSIX_THREAD_PRIO_PROTECT) && _POSIX_THREAD_PRIO_PROTECT != -1
    (fn)pthread_mutex_getprioceiling,
    (fn)pthread_mutex_setprioceiling,
    (fn)pthread_mutexattr_getprioceiling,
    (fn)pthread_mutexattr_setprioceiling,
#endif
#if defined(_POSIX_THREAD_PRIORITY_SCHEDULING) && _POSIX_THREAD_PRIORITY_SCHEDULING != -1
    (fn)pthread_attr_getinheritsched,
    (fn)pthread_attr_setinheritsched,
    (fn)pthread_attr_getschedpolicy,
    (fn)pthread_attr_setschedpolicy,
    (fn)pthread_attr_getscope,
    (fn)pthread_attr_setscope,
    (fn)pthread_getschedparam,
    (fn)pthread_setschedparam,
    (fn)pthread_setschedprio,
#endif
#if defined(_POSIX_THREAD_PROCESS_SHARED) && _POSIX_THREAD_PROCESS_SHARED != -1
    (fn)pthread_mutexattr_getpshared,
    (fn)pthread_mutexattr_setpshared,
    (fn)pthread_condattr_getpshared,
    (fn)pthread_condattr_setpshared,
    (fn)pthread_rwlockattr_getpshared,
    (fn)pthread_rwlockattr_setpshared,
#endif
#if defined(_POSIX_THREAD_ROBUST_PRIO_INHERIT) && _POSIX_THREAD_ROBUST_PRIO_INHERIT != -1
    (fn)pthread_mutex_consistent,
    (fn)pthread_mutexattr_getrobust,
    (fn)pthread_mutexattr_setrobust,
#endif
#if defined(_POSIX_THREAD_SAFE_FUNCTIONS) && _POSIX_THREAD_SAFE_FUNCTIONS != -1
    (fn)getpwnam_r,
    (fn)getpwuid_r,
    (fn)getgrgid_r,
    (fn)getgrnam_r,
    (fn)localtime_r,
    (fn)gmtime_r,
    (fn)asctime_r,
    (fn)ctime_r,
    (fn)strtok_r,
    (fn)rand_r,
    (fn)readdir_r,
    (fn)strerror_r,
    (fn)flockfile,
    (fn)funlockfile,
#endif
#if defined(_POSIX_THREADS) && _POSIX_THREADS != -1
    (fn)pthread_create,
    (fn)pthread_join,
    (fn)pthread_detach,
    (fn)pthread_exit,
    (fn)pthread_self,
    (fn)pthread_equal,
    (fn)pthread_once,
    (fn)pthread_key_create,
    (fn)pthread_key_delete,
    (fn)pthread_getspecific,
    (fn)pthread_setspecific,
    (fn)pthread_mutex_init,
    (fn)pthread_mutex_lock,
    (fn)pthread_mutex_unlock,
    (fn)pthread_cond_wait,
    (fn)pthread_cond_timedwait,
    (fn)pthread_cond_signal,
    (fn)pthread_cond_broadcast,
    (fn)pthread_cancel,
    (fn)pthread_setcancelstate,
    (fn)pthread_setcanceltype,
    (fn)pthread_testcancel,
    (fn)pthread_kill,
    (fn)pthread_sigmask,
    (fn)pthread_atfork,
#endif
#if defined(_POSIX_TIMEOUTS) && _POSIX_TIMEOUTS != -1
    (fn)pthread_mutex_timedlock,
    (fn)pthread_rwlock_timedrdlock,
    (fn)pthread_rwlock_timedwrlock,
    (fn)sem_timedwait,
#endif
#if defined(_POSIX_TIMERS) && _POSIX_TIMERS != -1
    (fn)clock_getres,
    (fn)clock_gettime,
    (fn)clock_settime,
    (fn)nanosleep,
    (fn)timer_create,
    (fn)timer_delete,
    (fn)timer_getoverrun,
    (fn)timer_gettime,
    (fn)timer_settime,
#endif
#if defined(_XOPEN_SHM) && _XOPEN_SHM != -1
    (fn)ftok,
    (fn)msgctl,
    (fn)msgget,
    (fn)msgrcv,
    (fn)msgsnd,
    (fn)semctl,
    (fn)semget,
    (fn)semop,
    (fn)shmat,
    (fn)shmctl,
    (fn)shmdt,
    (fn)shmget,
#endif
    0,
};

int main(void) {
    int i = 0;
#ifdef __linux__
    if (_POSIX_VERSION != 200809L) return 1;
    if (_POSIX_MAPPED_FILES != 200809L) return 2;
    if (_POSIX_MEMLOCK != 200809L) return 3;
    if (_POSIX_TIMERS != 200809L) return 4;
    if (_POSIX_FSYNC != 200809L) return 5;
    if (_POSIX_READER_WRITER_LOCKS != 200809L) return 6;
    if (_POSIX_THREADS != 200809L) return 7;
    if (_POSIX_SEMAPHORES != 200809L) return 8;
    if (_POSIX_CPUTIME != 0) return 9;
    if (_POSIX_MONOTONIC_CLOCK != 0) return 10;
    if (_POSIX_SPORADIC_SERVER != -1) return 11;
    if (_POSIX_TRACE != -1) return 12;
    if (_POSIX_ASYNCHRONOUS_IO != 200809L || _POSIX_PRIORITIZED_IO != 200809L) return 13;
    if (_POSIX_MESSAGE_PASSING != 200809L) return 14;
    if (_XOPEN_SHM != 1 || _XOPEN_REALTIME != 1) return 15;
#endif
#ifdef __APPLE__
    if (_POSIX_VERSION != 200112L) return 1;
    if (_POSIX_MAPPED_FILES != 200112L) return 2;
    if (_POSIX_MEMLOCK != -1) return 3;
    if (_POSIX_TIMERS != -1) return 4;
    if (_POSIX_FSYNC != 200112L) return 5;
    if (_POSIX_READER_WRITER_LOCKS != 200112L) return 6;
    if (_POSIX_THREADS != 200112L) return 7;
    if (_POSIX_SEMAPHORES != -1) return 8;
    if (_POSIX_CPUTIME != -1) return 9;
    if (_POSIX_MONOTONIC_CLOCK != -1) return 10;
    if (_POSIX_SPORADIC_SERVER != -1) return 11;
    if (_POSIX_TRACE != -1) return 12;
    if (_POSIX_ASYNCHRONOUS_IO != -1 || _POSIX_PRIORITIZED_IO != -1) return 13;
    if (_POSIX_MESSAGE_PASSING != -1) return 14;
    if (_XOPEN_SHM != 1 || _XOPEN_REALTIME != -1) return 15;
#endif
    while (named[i])
        i++;
    return i > 0 ? 0 : 99;
}
