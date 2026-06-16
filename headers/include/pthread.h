// pthread.h -- POSIX threads on Linux + macOS.
//
// On recent Linux C libraries pthread_create / pthread_join have been
// folded into libc; older ones still ship a separate libpthread
// but the dynamic loader auto-pulls it in for any process linking
// libc, so dlopen(NULL, RTLD_NOW) finds the symbols either way.
// macOS keeps everything in libSystem (which is what `dlopen(NULL)`
// opens by default).
//
// The thread function's `arg` parameter flows through normally:
// when a c5 function's address is taken, the codegen emits a
// per-function shuffling thunk that copies the host's first
// int-arg register (rdi / x0) into the c5 stack slot the callee
// reads from. So the standard `void *(*)(void *)` start_routine
// shape works as you'd expect; just declare the parameter and
// read it.
//
// Windows doesn't have pthreads natively. <windows.h> has the
// CreateThread / WaitForSingleObject equivalents -- portable code
// `#ifdef _WIN32` over the choice of which API to call.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::pthread_create,           "_pthread_create")
#pragma binding(libc::pthread_join,             "_pthread_join")
#pragma binding(libc::pthread_exit,             "_pthread_exit")
#pragma binding(libc::pthread_detach,           "_pthread_detach")
#pragma binding(libc::pthread_self,             "_pthread_self")
#pragma binding(libc::pthread_equal,            "_pthread_equal")
#pragma binding(libc::pthread_getname_np,       "_pthread_getname_np")
#pragma binding(libc::pthread_setname_np,       "_pthread_setname_np")
#pragma binding(libc::pthread_kill,             "_pthread_kill")
#pragma binding(libc::pthread_threadid_np,      "_pthread_threadid_np")
#pragma binding(libc::pthread_get_stackaddr_np, "_pthread_get_stackaddr_np")
#pragma binding(libc::pthread_get_stacksize_np, "_pthread_get_stacksize_np")
#pragma binding(libc::pthread_cond_timedwait_relative_np, "_pthread_cond_timedwait_relative_np")
#pragma binding(libc::pthread_mutex_init,       "_pthread_mutex_init")
#pragma binding(libc::pthread_mutex_lock,       "_pthread_mutex_lock")
#pragma binding(libc::pthread_mutex_trylock,    "_pthread_mutex_trylock")
#pragma binding(libc::pthread_mutex_unlock,     "_pthread_mutex_unlock")
#pragma binding(libc::pthread_mutex_destroy,    "_pthread_mutex_destroy")
#pragma binding(libc::pthread_mutexattr_init,   "_pthread_mutexattr_init")
#pragma binding(libc::pthread_mutexattr_settype,"_pthread_mutexattr_settype")
#pragma binding(libc::pthread_mutexattr_destroy,"_pthread_mutexattr_destroy")
#pragma binding(libc::pthread_cond_init,        "_pthread_cond_init")
#pragma binding(libc::pthread_cond_destroy,     "_pthread_cond_destroy")
#pragma binding(libc::pthread_cond_wait,        "_pthread_cond_wait")
#pragma binding(libc::pthread_cond_timedwait,   "_pthread_cond_timedwait")
#pragma binding(libc::pthread_cond_signal,      "_pthread_cond_signal")
#pragma binding(libc::pthread_cond_broadcast,   "_pthread_cond_broadcast")
#pragma binding(libc::pthread_attr_init,        "_pthread_attr_init")
#pragma binding(libc::pthread_attr_destroy,     "_pthread_attr_destroy")
#pragma binding(libc::pthread_attr_setdetachstate, "_pthread_attr_setdetachstate")
#pragma binding(libc::pthread_attr_setstacksize, "_pthread_attr_setstacksize")
#pragma binding(libc::pthread_attr_setscope,    "_pthread_attr_setscope")
#pragma binding(libc::pthread_atfork,           "_pthread_atfork")
#pragma binding(libc::pthread_key_create,       "_pthread_key_create")
#pragma binding(libc::pthread_key_delete,       "_pthread_key_delete")
#pragma binding(libc::pthread_setspecific,      "_pthread_setspecific")
#pragma binding(libc::pthread_getspecific,      "_pthread_getspecific")
#pragma binding(libc::pthread_once,             "_pthread_once")

// pthread_mutex_t = 64 bytes on macOS (16-byte sig + 56-byte body).
#define PTHREAD_MUTEX_SIZE 64
// pthread_t is an opaque pointer-sized handle.
#define PTHREAD_T_SIZE     8
// macOS detach-state value passed to pthread_attr_setdetachstate.
#define PTHREAD_CREATE_DETACHED 2
#define PTHREAD_CREATE_JOINABLE 1
#define PTHREAD_SCOPE_SYSTEM  1
#define PTHREAD_SCOPE_PROCESS 2
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::pthread_create,           "pthread_create")
#pragma binding(libc::pthread_join,             "pthread_join")
#pragma binding(libc::pthread_exit,             "pthread_exit")
#pragma binding(libc::pthread_detach,           "pthread_detach")
#pragma binding(libc::pthread_self,             "pthread_self")
#pragma binding(libc::pthread_equal,            "pthread_equal")
#pragma binding(libc::pthread_setname_np,       "pthread_setname_np")
#pragma binding(libc::pthread_getname_np,       "pthread_getname_np")
#pragma binding(libc::pthread_getcpuclockid,    "pthread_getcpuclockid")
#pragma binding(libc::pthread_condattr_init,    "pthread_condattr_init")
#pragma binding(libc::pthread_condattr_destroy, "pthread_condattr_destroy")
#pragma binding(libc::pthread_condattr_setclock,"pthread_condattr_setclock")
#pragma binding(libc::pthread_kill,             "pthread_kill")
#pragma binding(libc::pthread_mutex_init,       "pthread_mutex_init")
#pragma binding(libc::pthread_mutex_lock,       "pthread_mutex_lock")
#pragma binding(libc::pthread_mutex_trylock,    "pthread_mutex_trylock")
#pragma binding(libc::pthread_mutex_unlock,     "pthread_mutex_unlock")
#pragma binding(libc::pthread_mutex_destroy,    "pthread_mutex_destroy")
#pragma binding(libc::pthread_mutexattr_init,   "pthread_mutexattr_init")
#pragma binding(libc::pthread_mutexattr_settype,"pthread_mutexattr_settype")
#pragma binding(libc::pthread_mutexattr_destroy,"pthread_mutexattr_destroy")
#pragma binding(libc::pthread_cond_init,        "pthread_cond_init")
#pragma binding(libc::pthread_cond_destroy,     "pthread_cond_destroy")
#pragma binding(libc::pthread_cond_wait,        "pthread_cond_wait")
#pragma binding(libc::pthread_cond_timedwait,   "pthread_cond_timedwait")
#pragma binding(libc::pthread_cond_signal,      "pthread_cond_signal")
#pragma binding(libc::pthread_cond_broadcast,   "pthread_cond_broadcast")
#pragma binding(libc::pthread_attr_init,        "pthread_attr_init")
#pragma binding(libc::pthread_attr_destroy,     "pthread_attr_destroy")
#pragma binding(libc::pthread_attr_setdetachstate, "pthread_attr_setdetachstate")
#pragma binding(libc::pthread_attr_setstacksize, "pthread_attr_setstacksize")
#pragma binding(libc::pthread_attr_setscope,    "pthread_attr_setscope")
// The Linux C library's pthread_atfork lives in libc_nonshared.a (a static stub),
// not as a dynamic export of libc.so.6 -- x86_64 keeps a weak legacy
// alias but aarch64 does not, so a dynamic import resolves on one and
// not the other. Bind the underlying dynamic symbol the stub forwards
// to; the inline below supplies pthread_atfork in terms of it.
#pragma binding(libc::__register_atfork,        "__register_atfork")
#pragma binding(libc::pthread_key_create,       "pthread_key_create")
#pragma binding(libc::pthread_key_delete,       "pthread_key_delete")
#pragma binding(libc::pthread_setspecific,      "pthread_setspecific")
#pragma binding(libc::pthread_getspecific,      "pthread_getspecific")
#pragma binding(libc::pthread_once,             "pthread_once")

// On Linux pthread_mutex_t is 40 bytes on x86_64, 48 on aarch64;
// 64 covers both with room.
#define PTHREAD_MUTEX_SIZE 64
#define PTHREAD_T_SIZE     8
// Linux detach-state value passed to pthread_attr_setdetachstate.
#define PTHREAD_CREATE_DETACHED 1
#define PTHREAD_CREATE_JOINABLE 0
#define PTHREAD_SCOPE_SYSTEM  0
#define PTHREAD_SCOPE_PROCESS 1
#endif

#ifdef _WIN32
// Stub the constants on Windows so `sizeof(struct ...)` consumers
// don't trip a missing-symbol error. The actual primitives there
// come from <windows.h>.
#define PTHREAD_MUTEX_SIZE 64
#define PTHREAD_T_SIZE     8
#define PTHREAD_CREATE_DETACHED 1
#define PTHREAD_CREATE_JOINABLE 0
#endif

// Opaque-buffer typedefs for the POSIX thread types. Each wraps a
// leading signature word plus a fixed-size buffer big enough for the
// underlying libc layout on every supported target. c5 code passes
// pointers to these into the bindings; the libc side reads the actual
// platform layout. The signature word is exposed (rather than folded
// into the buffer) so the static initialisers below can set it.
struct __c5_pthread_mutex { long __sig; char __opaque[56]; };
typedef struct __c5_pthread_mutex pthread_mutex_t;

struct __c5_pthread_mutexattr { char __opaque[16]; };
typedef struct __c5_pthread_mutexattr pthread_mutexattr_t;

struct __c5_pthread_cond { long __sig; char __opaque[56]; };
typedef struct __c5_pthread_cond pthread_cond_t;

// Static-storage initialisers for the mutex / condition variable
// types. Darwin's libpthread checks a signature word at offset 0 and
// rejects a zero-signature object from pthread_mutex_lock /
// pthread_cond_wait (EINVAL), so the macro must seed the magic the
// system <pthread/pthread_impl.h> uses for a statically initialised
// object. Linux and Windows take an all-zero object, so the signature
// word stays zero there.
#if defined(__APPLE__)
#define PTHREAD_MUTEX_INITIALIZER { 0x32AAABA7, {0} }
#define PTHREAD_COND_INITIALIZER  { 0x3CB0B1BB, {0} }
#else
#define PTHREAD_MUTEX_INITIALIZER { 0, {0} }
#define PTHREAD_COND_INITIALIZER  { 0, {0} }
#endif
#define PTHREAD_ONCE_INIT          0

struct __c5_pthread_condattr { char __opaque[16]; };
typedef struct __c5_pthread_condattr pthread_condattr_t;

struct __c5_pthread_attr { char __opaque[64]; };
typedef struct __c5_pthread_attr pthread_attr_t;

// `pthread_t` is pointer-sized on every supported POSIX target
// (an opaque struct pointer on macOS, `unsigned long` on
// Linux); we need 8 bytes of storage per handle so the libc
// can write a real ID and the c5-side join can pass it back
// unbroken. Plain `int` was 8 bytes pre-M31 but has been 4 since
// real i32 storage landed -- the gap is what made
// `demos/threads.c` print all zeroes (each pthread_create wrote
// 8 bytes into a 4-byte slot, smashing the next handle).
//
// `pthread_once_t` is `long` (8 bytes) on macOS and `int` (4)
// on Linux; we use `long long` to cover both. The libc
// reads only the low 4 bytes on Linux, so the wider slot is
// harmless. `pthread_key_t` is `unsigned long` on macOS and
// `unsigned int` on Linux -- same shape, same fix.
typedef long long pthread_t;
typedef long long pthread_key_t;
typedef long long pthread_once_t;

int pthread_create(pthread_t *thread, char *attr, int *start, char *arg);
int pthread_join(pthread_t thread, int **retval);
void pthread_exit(void *retval);
int pthread_detach(pthread_t thread);
pthread_t pthread_self();
int pthread_equal(pthread_t t1, pthread_t t2);
// Deliver a signal to a specific thread (POSIX).
int pthread_kill(pthread_t thread, int sig);
#ifdef __APPLE__
// Darwin sets only the calling thread's name (no pthread_t parameter).
int pthread_setname_np(const char *name);
int pthread_getname_np(pthread_t thread, char *name, unsigned long len);
// Darwin per-thread 64-bit id (`uint64_t *` out-parameter).
int pthread_threadid_np(pthread_t thread, unsigned long long *thread_id);
// Darwin stack introspection used for native stack-overflow guards.
void *pthread_get_stackaddr_np(pthread_t thread);
unsigned long pthread_get_stacksize_np(pthread_t thread);
// Darwin relative-timeout condition wait (the monotonic-clock analogue
// of pthread_cond_timedwait, which takes an absolute time).
int pthread_cond_timedwait_relative_np(pthread_cond_t *cond,
                                       pthread_mutex_t *mutex,
                                       const struct timespec *reltime);
#endif

#ifdef __linux__
// Linux takes the target thread as the first parameter (Darwin names
// only the calling thread). `pthread_getcpuclockid` yields a clock for
// thread CPU-time queries; the condattr setters select the clock a
// condition variable's absolute timed waits run against.
int pthread_setname_np(pthread_t thread, const char *name);
int pthread_getname_np(pthread_t thread, char *name, unsigned long len);
int pthread_getcpuclockid(pthread_t thread, int *clock_id);
int pthread_condattr_init(pthread_condattr_t *attr);
int pthread_condattr_destroy(pthread_condattr_t *attr);
int pthread_condattr_setclock(pthread_condattr_t *attr, int clock_id);
#endif
int pthread_mutex_init(char *mutex, char *attr);
int pthread_mutex_lock(char *mutex);
int pthread_mutex_trylock(char *mutex);
int pthread_mutex_unlock(char *mutex);
int pthread_mutex_destroy(char *mutex);
int pthread_mutexattr_init(char *attr);
int pthread_mutexattr_settype(char *attr, int kind);
int pthread_mutexattr_destroy(char *attr);
int pthread_cond_init(char *cond, char *attr);
int pthread_cond_destroy(char *cond);
int pthread_cond_wait(char *cond, char *mutex);
int pthread_cond_timedwait(char *cond, char *mutex, char *abstime);
int pthread_cond_signal(char *cond);
int pthread_cond_broadcast(char *cond);
int pthread_attr_init(char *attr);
int pthread_attr_destroy(char *attr);
int pthread_attr_setdetachstate(char *attr, int detachstate);
int pthread_attr_setstacksize(char *attr, unsigned long stacksize);
int pthread_attr_setscope(char *attr, int scope);
#ifdef __linux__
// Linux names the calling-convention pair (pthread_t, name).
int pthread_setname_np(pthread_t thread, const char *name);
// pthread_atfork is not a libc.so.6 dynamic symbol on every Linux port;
// forward to __register_atfork, which is, passing a null DSO handle (the
// process-global registration libc_nonshared.a's stub uses).
extern int __register_atfork(void (*prepare)(void), void (*parent)(void),
                             void (*child)(void), void *dso_handle);
static inline int pthread_atfork(void (*prepare)(void), void (*parent)(void),
                                 void (*child)(void)) {
    return __register_atfork(prepare, parent, child, 0);
}
#else
int pthread_atfork(void (*prepare)(void), void (*parent)(void), void (*child)(void));
#endif
int pthread_key_create(pthread_key_t *key, int *destructor);
int pthread_key_delete(pthread_key_t key);
int pthread_setspecific(pthread_key_t key, char *val);
char *pthread_getspecific(pthread_key_t key);
int pthread_once(pthread_once_t *once_control, int *init_routine);

// Mutex-type constants used by pthread_mutexattr_settype. Values
// match the POSIX defaults; the bound libc reads them by integer
// comparison so the exact platform mapping isn't c5's concern as
// long as `RECURSIVE` is non-zero (sqlite uses recursive mutexes).
#define PTHREAD_MUTEX_NORMAL        0
#define PTHREAD_MUTEX_RECURSIVE     2
#define PTHREAD_MUTEX_ERRORCHECK    1
#define PTHREAD_MUTEX_DEFAULT       0
