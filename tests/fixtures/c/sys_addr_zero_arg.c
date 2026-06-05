// C99 6.7.6.3 declarator with empty `()` plus dispatch-table use:
// take the address of a zero-arg libc fn and call through the
// resulting function pointer. The sys-trampoline path used to
// close the trampoline body with `Terminator::TailExt`, which
// jumps to libc's PLT without a matching epilogue. libc's `ret`
// then popped the saved `rbp` from the trampoline's prologue as
// its return address and the next instruction landed in stack
// memory.
//
// Pin: any zero-arg trampoline call returns through the standard
// prologue / epilogue pair. `getpid()` returns the current
// process id, which is non-zero on every supported host; reading
// it through the function pointer verifies the trampoline
// handles return-value forwarding too.

#include <unistd.h>

typedef int (*pid_fn)(void);
typedef unsigned (*uid_fn)(void);

static pid_fn pGetpid = getpid;
static uid_fn pGeteuid = geteuid;

int main(void) {
    int pid = pGetpid();
    if (pid <= 0) {
        return 1;
    }
    unsigned euid = pGeteuid();
    (void)euid;
    return 42;
}
