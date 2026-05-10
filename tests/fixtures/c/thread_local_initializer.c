// `_Thread_local int x = 7;` -- TLS variables with static
// initializers. Each thread sees its own copy seeded with
// the initializer's value (not zero). On Linux this lands
// in `.tdata` covered by PT_TLS; on macOS arm64 the
// per-thread storage section is `__thread_data` (file-
// backed, init template) rather than `__thread_bss`; on
// Win64 the IMAGE_TLS_DIRECTORY's StartAddressOfRawData /
// EndAddressOfRawData range covers the bytes (we already
// emitted everything as init template to sidestep an
// empty-template loader edge case).

#include <stdlib.h>

_Thread_local int counter = 7;
_Thread_local int marker = -3;
_Thread_local int zero_init;

int main() {
    if (counter != 7) return 1;
    if (marker != -3) return 2;
    if (zero_init != 0) return 3;
    counter = counter + marker;     // 4
    if (counter != 4) return 4;
    return 0;
}
