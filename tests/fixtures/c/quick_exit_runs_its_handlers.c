// C11 7.22.4.7: quick_exit runs the at_quick_exit handlers, last registered
// first, and then ends as _Exit does, running no atexit handler. The last
// handler exits 5 when the others ran in order; an atexit handler that ran
// would exit 99.
#include <stdlib.h>

static int order;

static void first(void) { order = order * 10 + 1; }
static void second(void) { order = order * 10 + 2; }
static void by_atexit(void) { _Exit(99); }
static void last(void) { _Exit(order == 21 ? 5 : 6); }

int main(void) {
    atexit(by_atexit);
    at_quick_exit(last);
    at_quick_exit(first);
    at_quick_exit(second);
    quick_exit(3);
}
