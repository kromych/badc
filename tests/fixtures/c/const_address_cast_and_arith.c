// C99 6.6 address constants in static initializers: the address of a
// global, optionally cast to another pointer type, and offset by an
// integer constant. A pointer cast before the `&` sets the arithmetic
// stride to its pointee size, so `(uint8_t*)&g + offsetof(T, f)` is a
// byte offset. mimalloc's per-heap tables use this shape.

#include <stddef.h>

typedef struct { long a; int b; char c; } T;

static T g = { 100, 200, 'z' };

static void *tbl[] = {
    &g,                                  // plain address
    (char *)&g,                          // cast address
    ((char *)&g),                        // parenthesized cast address
    (char *)&g + offsetof(T, b),         // byte arithmetic via char cast
    (int *)((char *)&g + offsetof(T, b)),// nested cast + arithmetic
    (char *)&g + 4,                      // explicit byte offset
    (char *)&g - 0,                      // subtraction
};

int main(void) {
    if (tbl[0] != &g) return 1;
    if (tbl[1] != (char *)&g) return 2;
    if (tbl[2] != (char *)&g) return 3;
    if (*(int *)tbl[3] != 200) return 4;
    if (*(int *)tbl[4] != 200) return 5;
    if ((char *)tbl[5] != (char *)&g + 4) return 6;
    if (tbl[6] != &g) return 7;
    return 0;
}
