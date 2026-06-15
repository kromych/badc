#include <string.h>
#include <unistd.h>
#include <dlfcn.h>

// pthread_create + pthread_join reached through dlopen/dlsym.
int *thread_main(int *arg) {
    return 11;
}

int main() {
    int *handle;
    int *create;
    int *join;
    // pthread_t is 8 bytes on every host we target; under  `int`
    // is 4 bytes, so passing `&tid` to pthread_create would let the
    // 8-byte write clobber the next stack slot. Use `long` for the
    // handle storage.
    long tid;
    int *retval;

    handle = dlopen(0, 2);              // RTLD_NOW
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);
    return retval;                      // 11
}
