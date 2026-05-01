// `_Thread_local` per-thread isolation test. Spawns a pthread,
// has the child mutate a TLS variable, joins, and verifies the
// main thread's view of the same variable is untouched. If the
// codegen accidentally lowered TLS as a regular global, the child's
// write would be visible after the join and we'd see a non-zero
// failure code.
//
// The child returns its own observed `counter` value (set to 99 in
// the child) via the pthread return path; main confirms that and
// then re-checks main's `counter` is still 1 (set before the spawn).
//
// Linux-only: pthread_create + dlopen come from glibc, the TLS
// codegen is the Linux Local Exec model. Wired into the same
// per-platform fixture lists native_elf and native_elf_x64 already
// gate by host_can_run_elf().

#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <dlfcn.h>

_Thread_local int counter;

int *thread_main(int *arg) {
    // Child thread: TLS starts zero (loader's per-thread copy of
    // .tdata; ours is all .tbss). Mutate it; the main thread's
    // counter must NOT be affected.
    if (counter != 0) return 0xbad1;
    counter = 99;
    if (counter != 99) return 0xbad2;
    return counter;     // 99 -- pthread_join in main reads this
}

int main() {
    int *handle;
    int *create;
    int *join;
    int tid;
    int *retval;

    counter = 1;
    handle = dlopen(0, 2);              // RTLD_NOW
    create = dlsym(handle, "pthread_create");
    join = dlsym(handle, "pthread_join");
    create(&tid, 0, thread_main, 0);
    join(tid, &retval);

    // The child thread saw and returned 99.
    if (retval != 99) return 1;
    // The main thread's counter is unchanged -- the child's write
    // landed in its own per-thread TLS region, not ours.
    if (counter != 1) return 2;
    return 0;
}
