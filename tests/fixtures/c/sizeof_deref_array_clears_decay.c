// `sizeof(*arr)` for a decayed array pointer must report the
// element size, not the array's element count. The unary `*`
// handler consumes the array decay so the side-channel
// `last_array_decay_size` has to clear after the deref --
// otherwise `sizeof(*arr)` lands on the count via
// the array-aware sizeof branch.
//
// Surfaced by chibicc's `read_punct`, which scans
// `static char *kw[]` for the punctuator strings and uses
// `sizeof(kw) / sizeof(*kw)` to bound the loop. Before the
// fix, the loop ran 23/N iterations instead of 23 and the
// `++` / `--` punctuators (past the truncation point)
// degenerated into pairs of single `+` / `-` tokens.

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
