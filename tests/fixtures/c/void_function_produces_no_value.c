// C99 6.8.6.4p3: a function declared `void` does not produce a
// value. Observing one through a mistyped function-pointer cast
// is undefined behaviour. This fixture pins c5's specific
// observable value (0) for two void-exit paths so a regression
// that lets the body's last computation leak into the caller
// would surface here:
//
//   * The body falls off the end (no `return` statement).
//   * The body uses a bare `return;`.

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
