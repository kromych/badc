/* Thread-locals declared in any order: the ones whose bytes are all zero
   join the zero fill after the initialized ones, and every reference, the
   template's relocations and each object's alignment follow them. */

#include <stdint.h>

static int g = 3;
_Thread_local char zero_first[100];
_Thread_local int zero_init[4] = {0};
_Thread_local int *ptr = &g;
_Alignas(32) _Thread_local char wide[32];
_Thread_local long seven = 7;
_Thread_local struct {
    int a;
    int b;
} pair = {0, 5};
static _Thread_local int tail;

static int block(void) {
    static _Thread_local int zero_block;
    static _Thread_local int init_block = 11;
    zero_block += 1;
    return zero_block + init_block;
}

int main(void) {
    if (*ptr != 3) return 1;
    if (seven != 7) return 2;
    if (pair.a != 0 || pair.b != 5) return 3;
    if ((uintptr_t)wide % 32) return 4;
    for (int i = 0; i < 100; i++)
        if (zero_first[i]) return 5;
    for (int i = 0; i < 4; i++)
        if (zero_init[i]) return 6;
    zero_first[99] = 1;
    wide[31] = 2;
    tail = 4;
    zero_init[3] = 9;
    if (seven != 7 || pair.b != 5 || *ptr != 3) return 7;
    if (zero_first[99] + wide[31] + tail + zero_init[3] != 16) return 8;
    if (block() != 12 || block() != 13) return 9;
    return 0;
}
