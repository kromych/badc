// A 16-aligned thread-local in an image whose size is not a multiple of
// 16. The loader places each thread's copy of the image on the PT_TLS
// alignment: on x86_64 the block ends at the thread pointer minus the
// image size rounded up to that alignment, on aarch64 it starts past the
// 16-byte TCB rounded up to it, and on macOS and Windows the block is a
// heap allocation. With the alignment recorded as 8 the 16-byte boundary
// held only while the image size was a multiple of 16; here the objects
// total 40 bytes. Returns 0, distinct non-zero per failure.

#include <string.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <windows.h>

typedef struct __attribute__((aligned(16))) {
    long a, b;
} S16;

_Thread_local char head;
_Thread_local S16 obj;
_Thread_local char tail;

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

static int check(int base) {
    if (misaligned(&obj, 16)) return base + 1;
    obj.a = 3;
    obj.b = 4;
    head = 1;
    tail = 2;
    if (obj.a + obj.b != 7) return base + 2;
    if (head + tail != 3) return base + 3;
    return 0;
}

static int *thread_main(int *arg) {
    return (int *)(long)check(10);
}

// Run `thread_main` on a second thread and return what it returned.
// Windows has no pthreads; kernel32's CreateThread starts a thread with
// its own copy of the module's thread-local block.
static long second_thread_result(void) {
#ifdef _WIN32
    HANDLE handle;
    int code;

    code = 0;
    handle = CreateThread(0, 0, (int *)thread_main, 0, 0, 0);
    if (!handle) return -1;
    WaitForSingleObject(handle, INFINITE);
    GetExitCodeThread(handle, &code);
    CloseHandle(handle);
    return code;
#else
    int *handle;
    int *create;
    int *join;
    long tid;
    int *retval;

    handle = dlopen(0, 2);
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);
    return (long)retval;
#endif
}

int main(void) {
    int rc = check(0);
    if (rc) return rc;
    return (int)second_thread_result();
}
