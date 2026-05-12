// Regression: an object-like macro that expands to the name of
// a function-like macro must trigger the fn-like macro when the
// original call site provides `(args)`. C99 6.10.3.4
// "Rescanning and further replacement" specifies that after
// the object-like expansion `ALIAS` -> `assert`, the resulting
// token stream `assert(...)` is rescanned for further macro
// invocations. c5 used to expand the object-like macro in
// isolation -- the expanded identifier appeared in the output
// but its `(` continuation in the source never got re-tied --
// so the compiler saw a bare `assert` call and rejected with
// "unknown function `assert`".

#include <assert.h>

#define ALIAS assert

int main(void) {
    int x = 7;
    ALIAS(x == 7);          /* assert(x == 7); */
    ALIAS(x + 1 == 8);      /* assert(x + 1 == 8); */
    return 0;
}
