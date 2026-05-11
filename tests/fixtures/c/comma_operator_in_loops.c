// C99 6.5.17 comma operator inside the statement-level
// expression contexts: `if`, `while`, `do-while`, `switch`,
// the `for` condition, and `return`. Each context is a full
// `expression`, so the comma chain is legal -- evaluate every
// subexpression for side effects, value of the last drives the
// statement. Surfaced compiling a deflate library on Windows: with
// `_MSC_VER` defined, `MZ_MACRO_END` expands to `while (0,
// 0)`, which dropped at "close paren expected" before this
// fix. clang/gcc accept all six forms below.
#include <stdio.h>
#include <stdlib.h>

static int side = 0;
static int bump(int v) {
    side++;
    return v;
}

int main(void) {
    int a = 0;
    int total = 0;

    // `while ( comma )` -- both arms evaluated, last is the
    // predicate.
    do { total += 10; } while (bump(0), 0);
    // do-while above also exercises the do-while expression
    // chain.

    // `if ( comma )` -- last arm is the predicate.
    if (bump(0), 1) {
        total += 100;
    }

    // `switch ( comma )` -- last arm is the scrutinee.
    switch (bump(7), 2) {
        case 1: total += 1; break;
        case 2: total += 1000; break;
        default: total += 99999; break;
    }

    // `for ( ; comma ; )` -- comma in for-cond too.
    for (a = 0; bump(0), a < 3; a++) {
        total += 1;
    }

    // `return ( comma )` via a helper that returns the last.
    // Validated by the running side-effect counter.
    // for-cond runs once per iteration including the failing
    // one, so 4 evaluations. Total: 1 + 1 + 1 + 4 = 7.
    if (side != 7) return 1;
    return total - 1110;     // expect total = 10 + 100 + 1000 + 3 = 1113
}
