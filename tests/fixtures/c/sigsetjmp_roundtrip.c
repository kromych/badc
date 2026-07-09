// POSIX sigsetjmp / siglongjmp round-trip with savemask 0 (the shape an
// emulator's execution-loop unwind uses). sigsetjmp returns 0 on the
// direct call; siglongjmp rewinds control to it yielding the passed
// value; a volatile object updated before the jump keeps its value
// after it (C99 7.13.2.1). Returns 0 on success.

#include <setjmp.h>

static sigjmp_buf env;

int main(void) {
    volatile int step = 0;
    int r = sigsetjmp(env, 0);
    if (r == 0) {
        step = 1;
        siglongjmp(env, 7);
        return 100; // unreachable
    }
    if (r != 7 || step != 1) {
        return 1;
    }
    return 0;
}
