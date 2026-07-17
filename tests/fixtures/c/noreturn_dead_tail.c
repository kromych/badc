/* A statement-level call to a noreturn function ends its block; the
 * unreachable tail is pruned. Control flow around the untaken guard
 * must be unaffected. */
#include <stdlib.h>

static int side = 0;
static int helper(void) { return 5; }

static int f(int v) {
    if (v == 42) {
        abort();
    }
    side = helper();
    return side;
}

int main(void) {
    if (f(1) != 5)
        return 1;
    if (side != 5)
        return 2;
    return 0;
}
