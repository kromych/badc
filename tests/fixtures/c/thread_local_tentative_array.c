// C99 6.9.2p2: a tentative definition of an incomplete array is
// completed to one element at the end of the unit. With thread storage
// duration the element lives in the thread-local image, one copy per
// thread, not in `.data`: a child thread starts from zero and its write
// stays out of the main thread's copy. Returns 0, distinct non-zero per
// failure.

#include <string.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <windows.h>

_Thread_local int ys[];

static int *thread_main(int *arg) {
    if (ys[0] != 0) return (int *)1;
    ys[0] = 99;
    if (ys[0] != 99) return (int *)2;
    return (int *)(long)ys[0];
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
    long child;

    ys[0] = 7;
    if (ys[0] != 7) return 3;
    child = second_thread_result();
    if (child != 99) return (int)child;
    if (ys[0] != 7) return 4;
    return 0;
}
