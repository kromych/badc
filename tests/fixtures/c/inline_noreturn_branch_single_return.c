/* A guard that calls a _Noreturn function in one branch and returns in the
   other is a single-return function: control cannot fall off the noreturn
   branch (C11 6.7.4p8), so the walker seals that block with Unreachable
   rather than a placeholder return. That keeps `checked` single-return, so it
   is an inline candidate; inlined into `main` the constant argument folds
   `checked(21)` to 42 at -O. Without the Unreachable seal the placeholder
   return makes `checked` two-return and it stays out of line. Identical
   result at -O and -O0. `die` is same-unit, so its call is the scalar/void
   `Call` the inliner already admits -- no external call is involved. */

static _Noreturn void die(void) {
    for (;;) {
    }
}

static int checked(int x) {
    if (x < 0) {
        die(); /* noreturn: this block has no return */
    }
    return x * 2;
}

int main(void) {
    return checked(21); /* 42 */
}
