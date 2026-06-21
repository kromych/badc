// The GCC / clang `__thread` storage-class keyword is equivalent to
// C11 `_Thread_local` for storage duration. badc lexes both to the same
// specifier, so this mirrors thread_local_basic.c with the GNU spelling.

#include <stdlib.h>

__thread int counter;
__thread int marker;

int main(void) {
    if (counter != 0) return 1;
    if (marker != 0) return 2;
    counter = 7;
    marker = 42;
    if (counter != 7) return 3;
    if (marker != 42) return 4;
    counter = counter + marker;
    if (counter != 49) return 5;
    return 0;
}
