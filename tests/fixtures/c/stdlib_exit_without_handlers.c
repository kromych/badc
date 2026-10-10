// C99 7.20.4.4: `_Exit`, declared by <stdlib.h>, ends the program with the
// status it is given and runs no atexit handler. The status is 7: a handler
// that ran would leave 2, and a return from main 0.
#include <stdlib.h>

static void handler(void) { _Exit(2); }

int main(void) {
    atexit(handler);
    _Exit(7);
}
