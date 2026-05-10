// Basic `_Thread_local` round-trip in the main thread. Doesn't
// exercise per-thread isolation -- that's `thread_local_per_thread.c`,
// which spawns a pthread to verify the storage is genuinely
// per-thread and not just a regular global. This fixture passes on
// any target where the parser accepts the keyword and the codegen
// has a TLS lowering (currently Linux/aarch64 + Linux/x86_64).

#include <stdlib.h>

_Thread_local int counter;
_Thread_local int marker;

int main() {
    if (counter != 0) return 1;     // BSS-zeroed by the loader
    if (marker  != 0) return 2;
    counter = 7;
    marker  = 42;
    if (counter != 7)  return 3;
    if (marker  != 42) return 4;
    counter = counter + marker;     // 49
    if (counter != 49) return 5;
    return 0;
}
