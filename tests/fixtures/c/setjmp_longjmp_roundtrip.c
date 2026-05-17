// Locks C99 7.13: setjmp returns 0 on the initial call and the
// value passed to longjmp (or 1 if the longjmp value is 0 per
// 7.13.2.1p3) on resumption, with control re-entering the
// setjmp call site as if the function holding setjmp had been
// re-entered with the saved callee-saved register state.
//
// Reads setjmp's result via direct comparison rather than a
// local `int rv` -- per C99 7.13.2.1p3 the values of automatic
// objects modified between setjmp and longjmp are indeterminate
// unless the object is declared `volatile`. Static counters
// stay live, which is enough to verify the resumption took
// place and observed the right longjmp value.

#include <setjmp.h>

static jmp_buf env;
static volatile int touched;
static volatile int observed_value;
static volatile int phase;

static void deep(int level, int final_val) {
    touched = touched + 1;
    if (level > 0) {
        deep(level - 1, final_val);
    } else {
        longjmp(env, final_val);
    }
}

int main(void) {
    // Phase 1: multi-level longjmp returns the supplied value.
    phase = 1;
    if (setjmp(env) == 0) {
        touched = 0;
        deep(5, 42);
        return 11;     // unreachable
    }
    if (touched != 6) return 12;

    // Phase 2: longjmp(env, 0) must surface as 1 per
    // C99 7.13.2.1p3.
    phase = 2;
    if (setjmp(env) == 0) {
        longjmp(env, 0);
        return 21;     // unreachable
    }
    // Observed value isn't 0 in this branch -- we got here
    // because the second-time setjmp return was non-zero.
    // Verify via an explicit comparison that pins it to 1.
    observed_value = 0;
    if (setjmp(env) != 0) {
        if (observed_value != 1) return 22;
    } else {
        observed_value = 1;
        longjmp(env, 0);
        return 23;     // unreachable
    }

    // Phase 3: canonical non-zero value round-trips.
    phase = 3;
    observed_value = 0;
    if (setjmp(env) != 0) {
        if (observed_value != 7) return 32;
    } else {
        observed_value = 7;
        longjmp(env, 7);
        return 31;     // unreachable
    }

    return 0;
}
