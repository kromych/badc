/* GCC 128-bit integer division and remainder: unsigned and signed,
   small and larger-than-64-bit divisors, truncation toward zero with
   the C99 6.5.5 sign rules, and the div/mod identity. Exit 0 on
   success; a distinct non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 lo_src = 0x0011223344556677ULL;
volatile u64 hi_src = 0x8899aabbccddeeffULL;
volatile u64 ten = 10;

static int chk(u128 x, u64 lo, u64 hi, int code) {
    if ((u64)x != lo || (u64)(x >> 64) != hi)
        return code;
    return 0;
}

int main(void) {
    u128 v = ((u128)hi_src << 64) | lo_src;
    u128 umax_half = (((u128)1 << 127) - 1); /* 2^127 - 1 */
    int r;

    /* Unsigned by a small divisor. */
    if ((r = chk(umax_half / ten, 0xccccccccccccccccULL,
                 0x0cccccccccccccccULL, 1)))
        return r;
    if ((r = chk(umax_half % ten, 7, 0, 2)))
        return r;

    /* Unsigned by a divisor above 2^64. */
    u128 dl = ((u128)1 << 64) + 3;
    if ((r = chk(v / dl, 0x8899aabbccddeefdULL, 0, 3)))
        return r;
    if ((r = chk(v % dl, 0x664421ffddbb9980ULL, 0, 4)))
        return r;

    /* Dividend below the divisor. */
    if ((r = chk((u128)lo_src / dl, 0, 0, 5)))
        return r;
    if ((r = chk((u128)lo_src % dl, lo_src, 0, 6)))
        return r;

    /* Signed, truncating toward zero (C99 6.5.5p6). */
    s128 sv = -(s128)(((u128)3 << 100) + 12345);
    if ((r = chk((u128)(sv / 7), 0x9249249249248b66ULL,
                 0xfffffff924924924ULL, 7)))
        return r;
    if ((r = chk((u128)(sv % 7), 0xfffffffffffffffdULL,
                 0xffffffffffffffffULL, 8)))
        return r;
    s128 sd = -((s128)1 << 70);
    if ((r = chk((u128)(sv / sd), 0x00000000c0000000ULL, 0, 9)))
        return r;
    if ((r = chk((u128)(sv % sd), 0xffffffffffffcfc7ULL,
                 0xffffffffffffffffULL, 10)))
        return r;
    if ((r = chk((u128)((-sv) / sd), 0xffffffff40000000ULL,
                 0xffffffffffffffffULL, 11)))
        return r;
    if ((r = chk((u128)((-sv) % sd), 0x0000000000003039ULL, 0, 12)))
        return r;

    /* Identity: a == (a / b) * b + a % b. */
    if (v != (v / ten) * ten + v % ten)
        return 13;
    if (sv != (sv / sd) * sd + sv % sd)
        return 14;

    /* Compound assignment. */
    u128 t = v;
    t /= ten;
    t %= dl;
    if ((r = chk(t, 0xbd6d3699962c5c28ULL, 0, 15)))
        return r;
    return 0;
}
