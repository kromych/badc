#pragma once

// POSIX unnamed/named semaphores (POSIX.1-2001 <semaphore.h>). `sem_t`
// is opaque; c5 code only ever passes its address to the bindings,
// which read the platform layout.

#include <time.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
// Recent Linux C libraries merged the realtime semaphore symbols into libc; they
// were in librt before, which the loader still resolves transitively.
#pragma binding(libc::sem_init,      "sem_init")
#pragma binding(libc::sem_destroy,   "sem_destroy")
#pragma binding(libc::sem_wait,      "sem_wait")
#pragma binding(libc::sem_trywait,   "sem_trywait")
#pragma binding(libc::sem_timedwait, "sem_timedwait")
#pragma binding(libc::sem_clockwait, "sem_clockwait")
#pragma binding(libc::sem_post,      "sem_post")
#pragma binding(libc::sem_getvalue,  "sem_getvalue")
#pragma binding(libc::sem_open,    "sem_open")
#pragma binding(libc::sem_close,   "sem_close")
#pragma binding(libc::sem_unlink,  "sem_unlink")
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
// Darwin deprecates unnamed semaphores (sem_init/sem_getvalue fail with
// ENOSYS) and ships no sem_timedwait/sem_clockwait, which the SDK does not
// declare either.
#pragma binding(libc::sem_wait,    "_sem_wait")
#pragma binding(libc::sem_trywait, "_sem_trywait")
#pragma binding(libc::sem_post,    "_sem_post")
#pragma binding(libc::sem_destroy, "_sem_destroy")
#pragma binding(libc::sem_init,    "_sem_init")
#pragma binding(libc::sem_getvalue,"_sem_getvalue")
#pragma binding(libc::sem_open,    "_sem_open")
#pragma binding(libc::sem_close,   "_sem_close")
#pragma binding(libc::sem_unlink,  "_sem_unlink")
#endif

#ifdef _WIN32
// winpthreads' declarations, which libc/lib/semaphore_ext.c defines: sem_t
// points to the semaphore's record, and sem_open takes all four arguments.
#include <sys/types.h>
typedef void *sem_t;
#define SEM_VALUE_MAX 0x7fffffff
#define SEM_FAILED ((sem_t *) 0)
int sem_init(sem_t *sem, int pshared, unsigned int value);
int sem_destroy(sem_t *sem);
int sem_wait(sem_t *sem);
int sem_trywait(sem_t *sem);
int sem_timedwait(sem_t *sem, const struct timespec *abs_timeout);
int sem_post(sem_t *sem);
int sem_getvalue(sem_t *sem, int *sval);
sem_t *sem_open(const char *name, int oflag, mode_t mode, unsigned int value);
int sem_close(sem_t *sem);
int sem_unlink(const char *name);
#else
// On Linux, sem_t is 32 bytes (8-byte aligned) on x86_64 and aarch64; the
// leading word keeps the alignment and the buffer covers the rest.
struct __c5_sem { long __align; char __opaque[24]; };
typedef struct __c5_sem sem_t;

// sem_open returns SEM_FAILED on error: NULL on Linux, (sem_t*)-1 on macOS.
#ifdef __APPLE__
#define SEM_FAILED ((sem_t *) -1)
#else
#define SEM_FAILED ((sem_t *) 0)
#endif

int sem_init(sem_t *sem, int pshared, unsigned int value);
int sem_destroy(sem_t *sem);
int sem_wait(sem_t *sem);
int sem_trywait(sem_t *sem);
#ifdef __linux__
int sem_timedwait(sem_t *sem, struct timespec *abs_timeout);
int sem_clockwait(sem_t *sem, int clock, struct timespec *abs_timeout);
#endif
int sem_post(sem_t *sem);
int sem_getvalue(sem_t *sem, int *sval);
// Named semaphores. sem_open is variadic: (name, oflag[, mode, value]).
sem_t *sem_open(const char *name, int oflag, ...);
int sem_close(sem_t *sem);
int sem_unlink(const char *name);
#endif
