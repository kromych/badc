// `~` on a promoted `uint8_t` or `uint16_t` yields an `int` (C99
// 6.5.3.3p4), so a relational operator against an `unsigned int`
// converts it to the unsigned common type (6.3.1.8): `~(uint8_t)0` is
// -1, which compares equal to 0xFFFFFFFF, not above it. The fuzzer's
// shape compared the complement of an assignment to a `uint8_t` with a
// `uint32_t` parameter. Returns 0 when every check passes.

#include <stdint.h>

static volatile uint32_t p = 0xFFFFFFFFu;
static volatile uint32_t q = 7u;
static uint8_t g8;

static int compare(uint8_t *pb, uint32_t limit)
{
    return (~((*pb) = 0)) > limit;
}

int main(void)
{
    uint8_t z = 0;
    uint16_t w = 0;
    int8_t s = 0;
    if (compare(&z, p) != 0) return 1;
    if (((~z) > p) || ((~w) > p) || ((~s) > p)) return 2;
    if (((~z) < q) || !((~z) >= p) || !((~z) <= p)) return 3;
    if (((~z) / p) != 1 || ((~z) % q) != 3) return 4;
    if ((uint32_t)(~z) != p || (g8 = 0, (~g8) > p)) return 5;
    if ((~z) * 2u != 4294967294u || (~z) / 2u != 2147483647u) return 6;
    if ((~(uint32_t)z) > p || (~z) >> 1 != -1) return 7;
    // A non-zero operand: ~0x0F is -16, below every unsigned value but the
    // top sixteen.
    z = 0x0F;
    if (!((~z) > q) || ((~z) > p) || (~z) != -16) return 8;
    return 0;
}
