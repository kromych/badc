// C99 6.5.17: the comma operator inside `(...)` evaluates each
// subexpression for its side effects and yields the value of the
// last. The parser's parenthesized-expression arm consumes the
// successive `expr(Assign)` calls but used to drop the per-comma
// `ast_acc` snapshot, leaving the AST holding only the final
// rhs. The walker then emitted no code for the prior arms and
// any side-effect-only step in front of the value-producing
// arm went missing -- in a real-world stretchy-buffer macro this
// dropped the grow call that allocated the buffer, so every
// subsequent element store dereferenced the still-NULL
// pointer.
//
// The fixture pins the shape by leaning entirely on the side
// effect of the lhs: a counter assignment whose value the rhs
// then reads back.

#include <stdio.h>

static int counter;

static int bump_to(int v) {
    counter = v;
    return v;
}

int main(void) {
    counter = 0;
    int observed = (bump_to(7), counter);
    if (observed != 7) {
        fprintf(stderr, "got %d expected 7\n", observed);
        return 1;
    }
    counter = 1;
    // Three-arm chain: every arm but the last contributes only a
    // side effect; the chain's value is `counter` after both
    // bumps applied.
    int chained = (bump_to(11), bump_to(13), counter);
    if (chained != 13) {
        fprintf(stderr, "got %d expected 13\n", chained);
        return 2;
    }
    return 0;
}
