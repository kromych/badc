/* C99 6.8.6.4p3: a `void` function's return is not a value.
 *
 * c5 previously left the accumulator with whatever the function
 * body's last computation produced; a caller that ignored the
 * prototype (called the void function through a cast to a
 * value-returning shape) could read that garbage as a return
 * value. The codegen now emits `Op::Imm 0` before every `Op::Lev`
 * in a void-returning function, so misclassified calls get a
 * predictable 0 instead of stack-resident scratch.
 *
 * Exercise both shapes:
 *   1. `return;` mid-body
 *   2. fall-off-end (the synthetic Lev the compiler appends)
 * Also confirm that `return <expr>;` in a void function is now
 * rejected -- but a fixture can only check positive behavior;
 * the rejection is in `tests/fixtures/c/...` -- we leave the
 * negative case for the unit tests.
 */

#include <stdio.h>

static void void_with_early_return(int flag) {
    int junk = 0xDEADBEEF;
    (void)junk; /* keep the compiler honest -- exercise the accumulator */
    if (flag) {
        return; /* mid-body Lev */
    }
    /* Fall-off-end Lev. The synthetic Lev also gets the zero. */
}

static void void_with_complex_body(void) {
    int a = 1 + 2 + 3;
    int b = a * 7;
    (void)b;
    /* No explicit return; falls off the end. */
}

/* Misclassified call: invoke a void function through a value-
 * returning function-pointer cast. The accumulator's value
 * after the call is what an `int`-returning caller would read.
 * With the fix, it must be `0`. */
int via_value_cast(int flag) {
    /* `int (*)(int)` -- pretend the void function is int-valued. */
    int (*as_int_fn)(int) = (int (*)(int)) void_with_early_return;
    return as_int_fn(flag);
}

int via_value_cast_noarg(void) {
    int (*as_int_fn)(void) = (int (*)(void)) void_with_complex_body;
    return as_int_fn();
}

int main(void) {
    int r;

    /* Early-return path. */
    r = via_value_cast(1);
    if (r != 0) {
        printf("FAIL early-return: got %d, want 0\n", r);
        return 1;
    }

    /* Fall-off-end path. */
    r = via_value_cast(0);
    if (r != 0) {
        printf("FAIL fall-through: got %d, want 0\n", r);
        return 2;
    }

    /* No-arg void function via fall-off-end. */
    r = via_value_cast_noarg();
    if (r != 0) {
        printf("FAIL noarg: got %d, want 0\n", r);
        return 3;
    }

    return 0;
}
