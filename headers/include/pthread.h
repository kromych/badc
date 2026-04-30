// pthread.h -- POSIX threads on Linux + macOS.
//
// On Linux glibc >= 2.34 pthread_create / pthread_join have been
// folded into libc; older glibcs still ship a separate libpthread
// but the dynamic loader auto-pulls it in for any process linking
// libc, so dlopen(NULL, RTLD_NOW) finds the symbols either way.
// macOS keeps everything in libSystem (which is what `dlopen(NULL)`
// opens by default).
//
// The c4 dialect can't read the `arg` parameter pthread_create
// hands the thread function (the host ABI puts it in rdi/x0,
// while a c4 callee reads its first param off the c4 stack). The
// canonical workaround is shared globals + a mutex-protected
// counter from which each thread fetches its own slot index. See
// demos/threads.c for the pattern.
//
// Windows doesn't have pthreads natively. <windows.h> has the
// CreateThread / WaitForSingleObject equivalents -- portable code
// `#ifdef _WIN32` over the choice of which API to call.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::pthread_create,        "_pthread_create")
#pragma binding(libc::pthread_join,          "_pthread_join")
#pragma binding(libc::pthread_self,          "_pthread_self")
#pragma binding(libc::pthread_mutex_init,    "_pthread_mutex_init")
#pragma binding(libc::pthread_mutex_lock,    "_pthread_mutex_lock")
#pragma binding(libc::pthread_mutex_unlock,  "_pthread_mutex_unlock")
#pragma binding(libc::pthread_mutex_destroy, "_pthread_mutex_destroy")

// pthread_mutex_t = 64 bytes on macOS (16-byte sig + 56-byte body).
#define PTHREAD_MUTEX_SIZE 64
// pthread_t is an opaque pointer-sized handle.
#define PTHREAD_T_SIZE     8
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::pthread_create,        "pthread_create")
#pragma binding(libc::pthread_join,          "pthread_join")
#pragma binding(libc::pthread_self,          "pthread_self")
#pragma binding(libc::pthread_mutex_init,    "pthread_mutex_init")
#pragma binding(libc::pthread_mutex_lock,    "pthread_mutex_lock")
#pragma binding(libc::pthread_mutex_unlock,  "pthread_mutex_unlock")
#pragma binding(libc::pthread_mutex_destroy, "pthread_mutex_destroy")

// glibc pthread_mutex_t is 40 bytes on x86_64, 48 on aarch64;
// 64 covers both with room.
#define PTHREAD_MUTEX_SIZE 64
#define PTHREAD_T_SIZE     8
#endif

#ifdef _WIN32
// Stub the constants on Windows so `sizeof(struct ...)` consumers
// don't trip a missing-symbol error. The actual primitives there
// come from <windows.h>.
#define PTHREAD_MUTEX_SIZE 64
#define PTHREAD_T_SIZE     8
#endif

int pthread_create(int *thread, char *attr, int *start, char *arg);
int pthread_join(int thread, int **retval);
int pthread_self();
int pthread_mutex_init(char *mutex, char *attr);
int pthread_mutex_lock(char *mutex);
int pthread_mutex_unlock(char *mutex);
int pthread_mutex_destroy(char *mutex);
