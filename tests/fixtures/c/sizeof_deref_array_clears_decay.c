// C99 6.5.3.4: `sizeof(*arr)` evaluates `*arr` for its type
// only. `arr` is an array of type T[N]; per 6.3.2.1p3 it
// decays to a T * rvalue, the unary `*` dereferences to a T
// lvalue, and `sizeof` therefore returns `sizeof(T)` -- not
// `N * sizeof(T)`.
//
// The c5-internal side channel `last_array_decay_size`
// carries the element count from the identifier-load path
// for the *bare-array* `sizeof(arr)` case. The unary `*`
// consumes the decay, so the channel must clear before the
// enclosing `sizeof` reads it; otherwise `sizeof(*arr)`
// returns the count and the canonical
// `sizeof(arr) / sizeof(*arr)` array-length idiom (C99
// 6.5.3.4 example) reports 1 instead of N.

#include <stdio.h>

static char *kw[] = {
    "<<=", ">>=", "...", "==", "!=", "<=", ">=", "->", "+=",
    "-=",  "*=",  "/=",  "++", "--", "%=", "&=", "|=", "^=",
    "&&",  "||",  "<<",  ">>", "##",
};

int main() {
  if ((int)sizeof(kw) != 23 * 8) return 1;
  if ((int)sizeof(*kw) != 8) return 2;
  if ((int)(sizeof(kw) / sizeof(*kw)) != 23) return 3;
  return 0;
}
