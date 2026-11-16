// A function returning an aggregate ends the returned object's lifetime
// ahead of the return, which reads it out of line. Slot coalescing must
// not take that read for the start of a new instance and share the
// object's storage with `t`, which is written just before the return.

#include <stdint.h>

union a {
    uint64_t b;
    int8_t c;
} e, *l = &e;
uint64_t d, h;
uint8_t f;
uint8_t *g;

union a k(uint32_t m, int16_t p, int8_t q, int r, int8_t *s) {
    int32_t t;
    uint8_t **u[3];
    int i, j;
    for (i = 0; i < 3; i++)
        u[i] = &g;
    union a v = {3};
    int32_t w[2][2];
    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++)
            w[i][j] = 1;
    (void)&t;
    f = f = 0;
    for ((void)f; f != 7;) {
        uint16_t x = 5;
        if (x)
            t = 0;
        return v;
    }
    return v;
}

int main(void) {
    *l = k(0, (int16_t)d, 0, (int)h, 0);
    return e.b == 3 ? 0 : 1;
}
