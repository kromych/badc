// A tail call reads its arguments from spill slots at their frame
// offsets. A call moves the stack pointer by its argument window,
// the 32-byte home area on Win64, before marshaling; a tail call
// allocates no window, since the callee reuses the caller's, so its
// slot loads take no shift. With the shift the Win64 marshal read 32
// bytes past each slot and `forward` returned a wrong sum.
//
// `sink` stays out of line so the tail call remains, and the
// arguments stay live across `stir` so they spill whatever order
// the body takes. Only Win64 has a home area; the other targets
// run the same shape with no shift to get wrong.

#include <stdio.h>

int acc;

__attribute__((noinline)) static void stir(void) { acc ^= 1; }

__attribute__((noinline)) static int sink(int a, int b, int c, int d) {
    return a * 1 + b * 2 + c * 3 + d * 4;
}

__attribute__((noinline)) static int forward(int seed) {
    int v0  = seed + 0;
    int v1  = seed + 1;
    int v2  = seed + 2;
    int v3  = seed + 3;
    int v4  = seed + 4;
    int v5  = seed + 5;
    int v6  = seed + 6;
    int v7  = seed + 7;
    int v8  = seed + 8;
    int v9  = seed + 9;
    int v10 = seed + 10;
    int v11 = seed + 11;
    int v12 = seed + 12;
    int v13 = seed + 13;
    int v14 = seed + 14;
    int v15 = seed + 15;
    stir();

    int touch = v0 + v1 + v3 + v4 + v6 + v7 + v8 + v9 + v10 + v11
                + v12 + v14 + v15;
    if (touch == 0) return -1;

    return sink(v2, v5, v9, v13);
}

int main(void) {
    // `volatile` keeps the seed a runtime value so `forward` is emitted
    // with its spill slots and tail call rather than folded away.
    volatile int seed = 10;
    int r = forward(seed);
    // v2=12, v5=15, v9=19, v13=23 -> 12*1 + 15*2 + 19*3 + 23*4 = 12+30+57+92 = 191
    printf("%d\n", r);
    return r == 191 ? 0 : 1;
}
