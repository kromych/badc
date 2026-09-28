// `|` and `^` whose common type is `unsigned int` (C99 6.3.1.8) with a
// sign-extended operand: the result is 32 bits wide, as with `&`, `+`
// and `-`. The fuzzer's shape combined an unsigned call result with a
// promoted `int8_t`.

#include <stdint.h>

static uint32_t add(uint32_t a, uint32_t b)
{
    return a + b;
}

int main(void)
{
    volatile int8_t v8 = -86;
    volatile int16_t v16 = -86;
    volatile int32_t v32 = -86;
    volatile uint32_t vu = 0xFFFFFFAAu;
    int8_t s8 = v8;
    int16_t s16 = v16;
    int32_t s32 = v32;
    uint32_t u = vu;
    int64_t d;

    d = u ^ s8;
    if (d != 0) return 1;
    d = u | s8;
    if (d != 4294967210LL) return 2;
    d = u & s8;
    if (d != 4294967210LL) return 3;
    d = add(0, s8) ^ s8;
    if (d != 0) return 4;
    d = s8 ^ add(0, s8);
    if (d != 0) return 5;
    d = add(0, s16) ^ s16;
    if (d != 0) return 6;
    d = add(0, s32) | s32;
    if (d != 4294967210LL) return 7;
    d = u ^ -1;
    if (d != 0x55) return 8;
    d = s32 | u;
    if (d != 4294967210LL) return 9;

    // A 64-bit common type sign-extends the operand for real.
    unsigned long long ull = 0xFFFFFFFFFFFFFFAAull;
    d = (int64_t)(ull ^ s8);
    if (d != 0) return 10;
    // Both promote to `int`: the result is signed.
    uint16_t hu = 0xFFAA;
    d = hu ^ s8;
    if (d != -65536) return 11;
    return 0;
}
