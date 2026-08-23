// Per-thread isolation of an address-constant `_Thread_local`
// initializer. The relocation is applied once, to the initialization
// template; each thread's copy must start from the relocated value and
// a store in one thread must not reach another's copy. A template
// relocated after the first copy was taken, or one copy shared between
// threads, fails here.
//
// Linux-only, matching thread_local_per_thread.c: pthread_create /
// pthread_join are resolved through dlopen so the fixture needs no
// pthread header.

#include <stdlib.h>
#include <dlfcn.h>

static int empty_heap = 7;
static int arr[4] = { 1, 2, 3, 4 };

__thread int *heap = &empty_heap;
__thread int *elem = &arr[2];

int *thread_main(int *arg) {
    (void)arg;
    // The child's own copy of the template: relocated, not zero.
    if (heap != &empty_heap) return (int *)0xbad1;
    if (elem != &arr[2] || *elem != 3) return (int *)0xbad2;
    // Mutating the child's copy must leave main's untouched.
    heap = 0;
    elem = 0;
    return (int *)99;
}

int main() {
    int *handle;
    int *create;
    int *join;
    long tid;
    int *retval;

    if (heap != &empty_heap) return 1;
    if (elem != &arr[2]) return 2;

    handle = dlopen(0, 2);              // RTLD_NOW
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);
    if (retval != (int *)99) return 3;

    // Main's copy survived the child's stores.
    if (heap != &empty_heap || *heap != 7) return 4;
    if (elem != &arr[2] || *elem != 3) return 5;

    // A second thread observes its own relocated copy, not the first
    // thread's zeroed one.
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);
    if (retval != (int *)99) return 6;
    return 0;
}
