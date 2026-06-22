// A return value held in a callee-saved register across a call must be
// staged through a caller-saved register before the epilogue restores
// the callee-saved set, otherwise the restore clobbers it. `acc` lives
// across the puts() call, so the allocator parks it in a callee-saved
// register; it is then returned. The common path (a value already in
// the return register) is exercised by every other fixture.
#include <stdio.h>

static long held_across_call(long x) {
    long acc = x * 3 + 1;
    puts("");
    return acc;
}

int main(void) {
    if (held_across_call(10) != 31) return 1;
    if (held_across_call(-4) != -11) return 2;
    return 0;
}
