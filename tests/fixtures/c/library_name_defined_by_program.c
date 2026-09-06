// A definition of a name the bundled headers bind to the C library
// replaces the import within the unit, as under gcc / clang. The
// references parsed before the definition reach it -- a call, a function
// pointer taken at run time, and an address in a static initializer --
// as do the ones parsed after it.
#include <stdlib.h>
#include <stdio.h>

static int before(int v) { return abs(v); }

static int through_pointer(int v) {
    int (*fp)(int) = abs;
    return fp(v);
}

static int (*table[])(int) = { abs };

int abs(int x) { return x < 0 ? 1 - x : x + 1; }

static int after(int v) { return abs(v); }

int main(void) {
    if (before(-5) != 6) return 1;
    if (through_pointer(-2) != 3) return 2;
    if (table[0](7) != 8) return 3;
    if (after(3) != 4) return 4;
    if (abs(0) != 1) return 5;
    printf("ok\n");
    return 0;
}
