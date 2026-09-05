// C99 6.9.2p2: a tentative definition of an incomplete array is
// completed to one element at the end of the unit. With thread storage
// duration the element lives in the thread-local image, one copy per
// thread, not in `.data`: a child thread starts from zero and its write
// stays out of the main thread's copy. Returns 0, distinct non-zero per
// failure.

#include <string.h>
#include <stdlib.h>
#include <dlfcn.h>

_Thread_local int ys[];

static int *thread_main(int *arg) {
    if (ys[0] != 0) return (int *)1;
    ys[0] = 99;
    if (ys[0] != 99) return (int *)2;
    return (int *)(long)ys[0];
}

int main(void) {
    int *handle;
    int *create;
    int *join;
    long tid;
    int *retval;

    ys[0] = 7;
    if (ys[0] != 7) return 3;
    handle = dlopen(0, 2);
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);
    if ((long)retval != 99) return (int)(long)retval;
    if (ys[0] != 7) return 4;
    return 0;
}
