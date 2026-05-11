// C99 6.8.6.4p3: a function declared `void` does not produce a
// value. Before this fix, a `void`-returning function lexed as
// `char`-returning and left whatever the function body had last
// computed in the c5 accumulator. A caller that observed the
// return value (e.g. through a function-pointer cast that
// re-typed the prototype as value-returning) would read that
// garbage.
//
// After the fix, the trailing `Op::Lev` is preceded by `Imm 0`
// for void callees, and a bare `return;` in the same function
// emits the same prefix. The caller reads `0`.

#include <stdio.h>

void no_value_void(int a, int b) {
    // The accumulator at this point holds `a * b + 7`. Without
    // the void-aware Imm-0, the matching Lev would return that
    // value. With the fix, the synthetic function-end Lev sees
    // Imm 0 first.
    int garbage = a * b + 7;
    (void)garbage;
}

void early_return_void(int x) {
    // Exercise the `return;` path: the explicit early-return
    // must also leave 0 in the accumulator, not `x`.
    if (x < 0) {
        return;
    }
    // Fall-through path: the function-end Lev path covers this.
}

// Mis-typed cast: the function pointer claims an int return. The
// fix makes the call read 0 regardless of body contents.
typedef int (*fn_int_int_int)(int, int);
typedef int (*fn_int_int)(int);

int main(void) {
    fn_int_int_int as_int_returning = (fn_int_int_int)no_value_void;
    int r1 = as_int_returning(6, 7); // 6*7+7 = 49 pre-fix
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
    int r3 = early(5); // function-end Lev
    if (r3 != 0) {
        printf("FAIL: void function-end leaked %d\n", r3);
        return 3;
    }

    // Calling a void function the normal way must compile fine.
    no_value_void(2, 3);
    early_return_void(0);

    return 0;
}
