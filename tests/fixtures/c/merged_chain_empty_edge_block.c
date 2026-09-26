// A branch on a function's address, which -O decides, guards a loop whose
// step calls a helper, and a loop that never runs follows. Merging the
// blocks of the decided path moved them behind their head and left an
// empty edge block positioned inside the head's instructions; the next
// instruction placed in that block split the head, and the branch fold
// then read past the end of the function. Returns 0 when every check
// passes.

#include <stdint.h>

static uint64_t add(uint64_t a, uint64_t b)
{
    return a + b;
}

int steps(void)
{
    int b = 0;
    if (steps)
        for (; b < 1; b = add(b, 9))
            ;
    for (; 0;)
        ;
    return b;
}

int main(void)
{
    return steps() == 9 ? 0 : 1;
}
