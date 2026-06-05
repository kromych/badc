// SSA-emit regression: aarch64 prologue must save x19 before the
// body emits any ImmData / ImmCode op. The writer's mach-o /
// elf adrp/add patcher rewrites those placeholders to target
// x19 regardless of the SSA emit's chosen scratch reg, and x19
// is callee-saved per AAPCS64. Without the save, a function
// registered via atexit (or any other libc caller that keeps a
// live value in x19 across the call) returned with x19
// clobbered; libsystem's __cxa_finalize_ranges then walked a
// corrupt iterator and crashed.
//
// The fixture mirrors the minimal repro: a void atexit handler
// that touches a global. Reproducing the bug required a working
// atexit / __cxa_finalize chain, which means the program has to
// reach normal `exit()`. The check is a normal-exit indicator
// rather than a return value -- the smoke runner enforces a 0
// exit status.

#include <stdlib.h>

static int seenInterrupt = 0;

static void onExit(void) {
    if (seenInterrupt) seenInterrupt = 2;
}

int main(void) {
    atexit(onExit);
    return 0;
}
