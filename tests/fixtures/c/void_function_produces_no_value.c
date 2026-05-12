// C99 6.8.6.4p3: a function declared `void` does not produce a
// value. Observing one through a mistyped function-pointer cast
// is undefined behaviour, and gcc / clang make no portable
// guarantee about what's left in the platform's return register
// (measured: gcc 15.2 -O0 leaks the body's last computed value,
// gcc -O2 happens to materialise 0 after dead-code elimination,
// Apple clang leaks whichever argument was passed in the return-
// register slot). c5 deliberately picks the strongest of these:
// the function-exit lowering clears the C-level "return slot" so
// the observed value is always 0, independent of optimisation
// level or argument shape. The fixture pins that c5 choice; any
// regression that lets the body's accumulator state survive into
// the caller would surface here.
//
// Two paths exercise the fix:
//   * The body falls off the end (no `return` statement) -- the
//     function-exit lowering must clear the return slot.
//   * The body uses a bare `return;` -- the explicit return
//     statement must clear the same slot.

#include <stdio.h>

void no_value_void(int a, int b) {
    // If c5 ever forgets to clear the return slot, this leaks
    // `a * b + 7` to the caller through the int-returning cast.
    int leaked = a * b + 7;
    (void)leaked;
}

void early_return_void(int x) {
    // Exercise the explicit `return;` path: the caller must
    // still read 0, not `x`.
    if (x < 0) {
        return;
    }
    // Fall-through reaches the function-end exit path instead.
}

// Mis-typed cast: the function pointer claims an int return. A
// conforming caller would never write this, but C lets you, and
// the question is what value the caller observes. The standard
// says "no value," gcc and clang materialise 0; c5 matches.
typedef int (*fn_int_int_int)(int, int);
typedef int (*fn_int_int)(int);

int main(void) {
    fn_int_int_int as_int_returning = (fn_int_int_int)no_value_void;
    int r1 = as_int_returning(6, 7); // 6*7+7 = 49 if the slot leaks
    if (r1 != 0) {
        printf("FAIL: void callee leaked %d through the int-returning cast\n", r1);
        return 1;
    }

    fn_int_int early = (fn_int_int)early_return_void;
    int r2 = early(-1); // explicit `return;`
    if (r2 != 0) {
        printf("FAIL: void `return;` leaked %d\n", r2);
        return 2;
    }
    int r3 = early(5); // falls off the end
    if (r3 != 0) {
        printf("FAIL: void function-end leaked %d\n", r3);
        return 3;
    }

    // Calling a void function the normal way must compile fine.
    no_value_void(2, 3);
    early_return_void(0);

    return 0;
}
