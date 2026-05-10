// Regression: an object-like macro that expands to the name of
// a function-like macro must trigger the fn-like macro when the
// original call site provides `(args)`. C99 6.10.3.4
// "Rescanning and further replacement".
//
// stb_rect_pack.h does:
//   #include <assert.h>
//   #define STBRP_ASSERT assert
//   ...
//   STBRP_ASSERT(node->next->x > x0);
// `STBRP_ASSERT` is object-like -> `assert`; the rescan then
// fires the function-like `assert(...)` from <assert.h>. c5
// used to expand the object-like macro in isolation -- the
// `assert` identifier appeared in the output but its `(`
// continuation in the source never got re-tied -- so the
// compiler saw a bare `assert` call and rejected with "unknown
// function `assert`".

#include <assert.h>

#define ALIAS assert

int main(void) {
    int x = 7;
    ALIAS(x == 7);          /* assert(x == 7); */
    ALIAS(x + 1 == 8);      /* assert(x + 1 == 8); */
    return 0;
}
