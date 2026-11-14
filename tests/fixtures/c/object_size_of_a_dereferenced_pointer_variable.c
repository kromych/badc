// __builtin_object_size reads its operand's value. `*(&p)` for a pointer
// variable `p` is the pointer `p` holds, not `p`'s own address, so it
// answers for the object `p` points at, unknown here; `&*(&p)` is `p`'s
// address and answers for `p`. An array row read as a value is its own
// closest subobject; a row's address answers for the array holding it.
// Exits 0 when each answer is gcc's.

#include <stddef.h>

static char rows[3][5];

struct info {
    unsigned head;
    unsigned bitmap[4][4];
    unsigned tail;
};

static struct info gi;

__attribute__((noinline)) static int check(unsigned char *data) {
    unsigned char *p = data;
    if (__builtin_object_size(*(&p), 0) != (size_t)-1)
        return 1;
    if (__builtin_object_size(*(&p), 1) != (size_t)-1)
        return 2;
    if (__builtin_object_size(*(&p), 2) != 0)
        return 3;
    if (__builtin_object_size(&*(&p), 0) != sizeof p)
        return 4;
    if (__builtin_object_size(*rows, 0) != sizeof rows)
        return 5;
    if (__builtin_object_size(*rows, 1) != sizeof rows[0])
        return 6;
    if (__builtin_object_size(*(&rows[1]), 1) != sizeof rows[1])
        return 7;
    if (__builtin_object_size(&rows[1], 1) != 2 * sizeof rows[1])
        return 8;
    if (__builtin_object_size(&gi.bitmap[0], 1) != sizeof gi.bitmap)
        return 9;
    if (__builtin_object_size(gi.bitmap[1], 1) != sizeof gi.bitmap[1])
        return 10;
    return 0;
}

int main(void) {
    unsigned char buf[16];
    return check(buf);
}
