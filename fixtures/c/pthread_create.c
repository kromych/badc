#include <string.h>
#include <unistd.h>
#include <dlfcn.h>

// pthread_create + pthread_join reached through dlopen/dlsym.
//
// macOS: pthread lives in `libSystem`, which is what `dlopen(NULL,
// RTLD_NOW)` opens for us. Linux (glibc >= 2.34): pthread_create has
// been folded into libc, and the (now-empty) libpthread.so.0 is
// dlopened automatically by the dynamic loader, so the same
// `dlopen(NULL)` recipe finds the symbol. POSIX-only fixture.
//
// The thread we spawn ignores its `arg` and returns a constant. The
// argument can't reach the thread function as-written because c4
// callees read parameters from the c4 stack (where the c4 caller's
// `Op::Psh`s leave them), but pthread invokes the start routine via
// the platform ABI, with `arg` in `x0` / `rdi`. The return path is
// fine -- c4's epilogue moves the accumulator into the ABI return
// register, which `pthread_join` reads back through its `retval`
// out-pointer.
//
// To pass data into the thread you'd use a shared global, or build a
// register-aware entry stub. Out of scope for this fixture; the goal
// here is just to exercise the multi-arg dlsym call path end-to-end.

int *thread_main(int *arg) {
    return 11;
}

int main() {
    int *handle;
    int *create;
    int *join;
    // pthread_t is 8 bytes on every host we target; under M31 `int`
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
