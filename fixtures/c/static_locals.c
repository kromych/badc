// M29 -- function-scope `static` storage. Each `static T name [=
// init];` declaration gets a persistent slot in the data segment.
// The symbol is bound as Glo for the function's body and restored
// to its prior class on block exit, so the next function with the
// same-named static gets its own fresh slot.
//
// SQLite uses static locals for cached state (one-time
// initialisations, hash tables, etc.).

#include <stdlib.h>

static int counter(void) {
    static int count = 0;
    count = count + 1;
    return count;
}

static int two_statics(int reset) {
    static int a = 100;
    static int b;
    if (reset) {
        a = 100;
        b = 0;
    }
    a = a + 1;
    b = b + a;
    return a + b;
}

// Two functions with the same-named static -- each must have its
// own independent storage.
static int next_x(void) {
    static int x = 0;
    x = x + 1;
    return x;
}
static int next_y(void) {
    static int x = 1000;
    x = x + 1;
    return x;
}

int main() {
    if (counter() != 1) return 1;
    if (counter() != 2) return 2;
    if (counter() != 3) return 3;

    // a starts at 101 (the increment) the first call; b starts at 0+101=101.
    // Result: 101 + 101 = 202.
    if (two_statics(0) != 202) return 4;
    // a = 102; b = 101 + 102 = 203. Result: 305.
    if (two_statics(0) != 305) return 5;
    // Reset: a -> 100, b -> 0. Then a = 101, b = 101. Result: 202.
    if (two_statics(1) != 202) return 6;

    if (next_x() != 1) return 7;
    if (next_x() != 2) return 8;
    if (next_y() != 1001) return 9;
    if (next_y() != 1002) return 10;
    if (next_x() != 3) return 11;

    return 0;
}
