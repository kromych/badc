/* GCC 128-bit integer arithmetic: add / sub / neg / bitwise ops with
   carry and borrow across the 64-bit halves, mixed scalar operands,
   and a compound-assignment chain. Exit 0 on success; a distinct
   non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 lo_src = 0x0011223344556677ULL;
volatile u64 hi_src = 0x8899aabbccddeeffULL;
volatile u64 one = 1;

static int chk(u128 x, u64 lo, u64 hi, int code) {
    if ((u64)x != lo || (u64)(x >> 64) != hi)
        return code;
    return 0;
}

int main(void) {
    u128 v = ((u128)hi_src << 64) | lo_src;
    int r;

    /* Carry out of the low half: (2^64 - 1) + 1. */
    u128 c = (u128)0xffffffffffffffffULL + one;
    if ((r = chk(c, 0, 1, 1)))
        return r;

    /* Borrow into the high half: 2^64 - 1. */
    u128 d = c - one;
    if ((r = chk(d, 0xffffffffffffffffULL, 0, 2)))
        return r;

    /* Add with both halves live. */
    if ((r = chk(v + v, 0x00224466 * 0x100000000ULL + 0x88aaccee,
                 0x1133557799bbddfeULL, 3)))
        return r;

    /* Sub crossing the boundary. */
    if ((r = chk(((u128)one << 64) - v,
                 0xffeeddccbbaa9989ULL, 0x7766554433221101ULL, 4)))
        return r;

    /* Unary minus: -1 is all ones; -v two's complement. */
    s128 m = -(s128)one;
    if ((r = chk((u128)m, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 5)))
        return r;
    if ((r = chk((u128)0 - v, 0xffeeddccbbaa9989ULL, 0x7766554433221100ULL, 6)))
        return r;

    /* Bitwise complement, and, or, xor. */
    if ((r = chk(~v, 0xffeeddccbbaa9988ULL, 0x7766554433221100ULL, 7)))
        return r;
    if ((r = chk(v & ~(u128)0xffffULL, 0x0011223344550000ULL,
                 0x8899aabbccddeeffULL, 8)))
        return r;
    if ((r = chk(v | ((u128)one << 127), 0x0011223344556677ULL,
                 0x8899aabbccddeeffULL, 9)))
        return r;
    if ((r = chk(v ^ v, 0, 0, 10)))
        return r;

    /* Logical not: nonzero high half alone is still truthy. */
    if (!v || !((u128)one << 64) || !!(v ^ v))
        return 11;

    /* Mixed scalar operand converts to the 128-bit type. */
    if ((r = chk(v + one, 0x0011223344556678ULL, 0x8899aabbccddeeffULL, 12)))
        return r;
    if ((r = chk(lo_src + ((u128)one << 64), lo_src, 1, 13)))
        return r;

    /* Compound-assignment chain. */
    u128 tmp = v;
    tmp += (tmp >> 64) | (tmp << 64);
    if ((r = chk(tmp, 0x88aaccef11335576ULL, 0x88aaccef11335576ULL, 14)))
        return r;
    tmp -= one;
    tmp &= ~(u128)0xffULL;
    tmp |= 5;
    tmp ^= ((u128)one << 127);
    if ((r = chk(tmp, 0x88aaccef11335505ULL, 0x08aaccef11335576ULL, 15)))
        return r;

    /* Increment / decrement carry across the halves. */
    u128 inc = 0xffffffffffffffffULL;
    ++inc;
    if ((r = chk(inc, 0, 1, 16)))
        return r;
    inc--;
    if ((r = chk(inc, 0xffffffffffffffffULL, 0, 17)))
        return r;
    return 0;
}
