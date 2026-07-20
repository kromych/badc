/* C99 6.3.1.4 conversions between the GCC 128-bit integer types and
   the floating types. Converting to a floating type rounds once, to
   nearest, ties to even, so a value wider than the target's significand
   must be pre-reduced with a sticky bit rather than split across two
   roundings; converting from a floating type truncates toward zero.
   Results are compared through the object representation, so a rounding
   difference in the last place cannot pass. Only conversions C99
   defines are checked: an operand whose integral part is out of range
   for the target type is left undefined by 6.3.1.4p1, and the reference
   compilers disagree there between targets. Exit 0 on success; a
   distinct non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned int u32;
typedef unsigned __int128 u128;
typedef __int128 s128;

/* `volatile` keeps the operands out of reach of constant folding, so
   the runtime conversion sequence is the thing under test. */
volatile u64 vhi, vlo;
volatile double vd;
volatile float vf;

static u128 mk(u64 hi, u64 lo) { return ((u128)hi << 64) | lo; }

static u64 dbits(double d) {
    union {
        double d;
        u64 u;
    } c;
    c.d = d;
    return c.u;
}

static u32 fbits(float f) {
    union {
        float f;
        u32 u;
    } c;
    c.f = f;
    return c.u;
}

/* The same 128 bits read as both signednesses, converted to both
   floating types, compared bit-exactly. */
static int chk_to_fp(u64 hi, u64 lo, u64 ud, u32 uf, u64 sd, u32 sf, int code) {
    vhi = hi;
    vlo = lo;
    if (dbits((double)mk(vhi, vlo)) != ud)
        return code;
    if (fbits((float)mk(vhi, vlo)) != uf)
        return code + 1;
    if (dbits((double)(s128)mk(vhi, vlo)) != sd)
        return code + 2;
    if (fbits((float)(s128)mk(vhi, vlo)) != sf)
        return code + 3;
    return 0;
}

/* A non-negative operand, whose truncation is in range for both
   128-bit types. */
static int chk_from_fp(double d, u64 hi, u64 lo, int code) {
    u128 u;
    s128 s;
    vd = d;
    u = (u128)vd;
    if ((u64)(u >> 64) != hi || (u64)u != lo)
        return code;
    s = (s128)vd;
    if ((u64)((u128)s >> 64) != hi || (u64)(u128)s != lo)
        return code + 1;
    return 0;
}

/* A negative operand: in range for the signed type only. */
static int chk_from_fp_neg(double d, u64 hi, u64 lo, int code) {
    s128 s;
    vd = d;
    s = (s128)vd;
    if ((u64)((u128)s >> 64) != hi || (u64)(u128)s != lo)
        return code;
    return 0;
}

int main(void) {
    int r;

    /* Exact small values: no rounding in either direction. */
    if ((r = chk_to_fp(0, 0, 0x0000000000000000ULL, 0x00000000U,
                       0x0000000000000000ULL, 0x00000000U, 1)))
        return r;
    if ((r = chk_to_fp(0, 1, 0x3ff0000000000000ULL, 0x3f800000U,
                       0x3ff0000000000000ULL, 0x3f800000U, 5)))
        return r;
    if ((r = chk_to_fp(0, 5, 0x4014000000000000ULL, 0x40a00000U,
                       0x4014000000000000ULL, 0x40a00000U, 9)))
        return r;

    /* 2^53 is the last integer with a neighbour in `double`; 2^53+1 is
       a tie and rounds to even, back down to 2^53, while 2^53+3 rounds
       up to 2^53+4. */
    if ((r = chk_to_fp(0, 1ULL << 53, 0x4340000000000000ULL, 0x5a000000U,
                       0x4340000000000000ULL, 0x5a000000U, 13)))
        return r;
    if ((r = chk_to_fp(0, (1ULL << 53) + 1, 0x4340000000000000ULL, 0x5a000000U,
                       0x4340000000000000ULL, 0x5a000000U, 17)))
        return r;
    if ((r = chk_to_fp(0, (1ULL << 53) + 3, 0x4340000000000002ULL, 0x5a000000U,
                       0x4340000000000002ULL, 0x5a000000U, 21)))
        return r;

    /* The 2^64 boundary: the widest low half, bit 63 alone, and the
       first value with the high half live. */
    if ((r = chk_to_fp(0, ~0ULL, 0x43f0000000000000ULL, 0x5f800000U,
                       0x43f0000000000000ULL, 0x5f800000U, 25)))
        return r;
    if ((r = chk_to_fp(0, 1ULL << 63, 0x43e0000000000000ULL, 0x5f000000U,
                       0x43e0000000000000ULL, 0x5f000000U, 29)))
        return r;
    if ((r = chk_to_fp(1, 0, 0x43f0000000000000ULL, 0x5f800000U,
                       0x43f0000000000000ULL, 0x5f800000U, 33)))
        return r;
    /* 5 * 2^64: the value a low-half-only conversion gets wrong. */
    if ((r = chk_to_fp(5, 0, 0x4414000000000000ULL, 0x60a00000U,
                       0x4414000000000000ULL, 0x60a00000U, 37)))
        return r;

    /* A 113-bit odd value: everything below bit 60 is discarded, so
       only the sticky bit carries it. Its neighbour differs one bit up
       in the high half and must land one ulp away. */
    if ((r = chk_to_fp(1ULL << 48, 1, 0x46f0000000000000ULL, 0x77800000U,
                       0x46f0000000000000ULL, 0x77800000U, 41)))
        return r;
    if ((r = chk_to_fp((1ULL << 48) | 1, 1, 0x46f0000000000010ULL, 0x77800000U,
                       0x46f0000000000010ULL, 0x77800000U, 45)))
        return r;

    /* 2^128-1 rounds up to 2^128 as a `double` and overflows `float` to
       infinity; the same bits read as signed are -1. */
    if ((r = chk_to_fp(~0ULL, ~0ULL, 0x47f0000000000000ULL, 0x7f800000U,
                       0xbff0000000000000ULL, 0xbf800000U, 49)))
        return r;
    /* 2^127 unsigned, -2^127 signed. */
    if ((r = chk_to_fp(1ULL << 63, 0, 0x47e0000000000000ULL, 0x7f000000U,
                       0xc7e0000000000000ULL, 0xff000000U, 53)))
        return r;
    /* 2^127-1, the signed maximum: rounds up to 2^127 in both
       precisions and stays positive. */
    if ((r = chk_to_fp(0x7fffffffffffffffULL, ~0ULL, 0x47e0000000000000ULL,
                       0x7f000000U, 0x47e0000000000000ULL, 0x7f000000U, 57)))
        return r;
    /* An arbitrary value with both halves populated. */
    if ((r = chk_to_fp(0x0011223344556677ULL, 0x8899aabbccddeeffULL,
                       0x4731223344556678ULL, 0x7989119aU, 0x4731223344556678ULL,
                       0x7989119aU, 61)))
        return r;

    /* Floating -> 128-bit truncates toward zero (C99 6.3.1.4). */
    if ((r = chk_from_fp(0.0, 0, 0, 65)))
        return r;
    if ((r = chk_from_fp(3.999, 0, 3, 67)))
        return r;
    if ((r = chk_from_fp(0.5, 0, 0, 69)))
        return r;
    if ((r = chk_from_fp(-0.5, 0, 0, 71)))
        return r;
    if ((r = chk_from_fp_neg(-3.999, ~0ULL, ~0ULL - 2, 73)))
        return r;

    /* Values that do not fit in 64 bits must fill the high half. */
    if ((r = chk_from_fp(1.5e19, 0, 0xd02ab486cedc0000ULL, 75)))
        return r;
    if ((r = chk_from_fp(18446744073709551616.0, 1, 0, 77)))
        return r;
    if ((r = chk_from_fp(9903520314283042199192993792.0, 1ULL << 29, 0, 79)))
        return r;
    /* -2^127, the signed minimum, is exactly representable. */
    if ((r = chk_from_fp_neg(-170141183460469231731687303715884105728.0,
                             1ULL << 63, 0, 81)))
        return r;

    /* A `float` operand widens to `double` exactly, so it truncates the
       same way. */
    vf = 2.5f;
    if ((u64)(u128)vf != 2 || (u64)((u128)vf >> 64) != 0)
        return 83;
    vf = -3.5f;
    if ((u64)(u128)(s128)vf != ~0ULL - 2 || (u64)((u128)(s128)vf >> 64) != ~0ULL)
        return 84;

    /* A round trip through `double` reproduces a value that fits in the
       significand, and preserves the high half of one that does not. */
    vhi = 0;
    vlo = 1ULL << 52;
    if ((u64)(u128)(double)mk(vhi, vlo) != (1ULL << 52))
        return 85;
    vhi = 5;
    vlo = 0;
    if ((u64)((u128)(double)mk(vhi, vlo) >> 64) != 5)
        return 86;

    /* C99 6.3.1.8: mixing a 128-bit operand with a `double` converts
       the 128-bit operand, so the result is `double`. */
    vhi = 0;
    vlo = 3;
    vd = 1.5;
    if (dbits(mk(vhi, vlo) + vd) != 0x4012000000000000ULL)
        return 87;
    if (dbits((double)(s128)mk(vhi, vlo) * vd) != 0x4012000000000000ULL)
        return 88;

    return 0;
}
