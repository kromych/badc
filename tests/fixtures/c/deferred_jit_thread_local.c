// DEFERRED: thread-local reads under the in-process JIT.
//
// The native ELF and Mach-O output is correct: the kernel /
// loader installs the PT_TLS block and sets the thread pointer
// (`fs` on x86_64, `tpidr_el0` on aarch64), so reading a
// `_Thread_local` returns its initial value. Run as a native
// linux-x64 binary this fixture exits 0.
//
// Under `--jit` it fails. The JIT loads code and data into mmap
// regions and calls `main` in-process, but does not allocate a
// TLS block or install a thread pointer for the c5 program --
// `fs` / `tpidr_el0` belong to the host runtime. So a
// `_Thread_local` access reads the host thread's TLS region at
// the c5 template offset and returns a stale value. This is
// independent of static locals: a translation unit with only
// `_Thread_local` variables fails the same way under `--jit`.
//
// The static local here is incidental (it predates the
// corrected diagnosis). Installing a c5 TLS thread pointer
// in-process without disturbing the host runtime's own
// `fs` / `tpidr_el0` is the deferred work.
#include <stdlib.h>

// Force a static-local to land in the .data segment. When this
// fixture is run via the elf-fixture lane the bug surfaces; the
// TLS read reads 0 instead of 7.
static int s_local_to_force_layout_shift(int dummy) {
    static int cache[3];
    cache[dummy] = dummy;
    return cache[dummy];
}

_Thread_local int counter = 7;
_Thread_local int marker = -3;

int main() {
    // Touch the function so it's emitted (and its static-local
    // backing is allocated in .data).
    s_local_to_force_layout_shift(0);

    if (counter != 7) return 1;
    if (marker != -3) return 2;
    counter = counter + marker;
    if (counter != 4) return 3;
    return 0;
}
