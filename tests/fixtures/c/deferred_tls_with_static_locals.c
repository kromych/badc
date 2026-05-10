// DEFERRED (#47): Linux ELF TLS init layout with static locals.
//
// `_Thread_local int x = 7;` works in isolation -- the TLS
// template stores 8 bytes per slot and the loader copies them
// into each thread's per-thread region; reading `x` via
// `mrs x16, tpidr_el0; add x16, x16, #tls_off; ldr w19,
// [x16]` returns 7.
//
// But once the source pulls in any function that carries a
// `static` local (most notably <stdio.h>'s
// `__c5_lazy_stream`'s `static char *__c5_stream_cache[3]`),
// the TLS template offset assignment and the loader's per-
// thread layout diverge: the same `tpidr_el0 + tls_off` lands
// on the wrong slot and the read returns either 0 or the
// adjacent variable's value.
//
// Likely cause: `tls_init_size` in the compiler tracks the
// last-written-byte boundary for the TLS template, but the
// per-target writer (elf.rs) is computing the .tdata /
// .tbss split or the PT_TLS p_filesz/p_memsz pair from a
// stale view that includes the static-local block.
//
// macOS native and Linux without the static-local interaction
// both pass.
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
