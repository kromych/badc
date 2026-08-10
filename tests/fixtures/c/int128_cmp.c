/* GCC 128-bit integer comparisons: equality and all orderings, signed
   vs unsigned edges (sign bit in the high half, equal high halves
   decided by the unsigned low half). Exit 0 on success; a distinct
   non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 lo_src = 0x0011223344556677ULL;
volatile u64 hi_src = 0x8899aabbccddeeffULL;
volatile u64 one = 1;

int main(void) {
    u128 v = ((u128)hi_src << 64) | lo_src;
    u128 w = ((u128)hi_src << 64) | (lo_src + one);
    s128 neg = -(s128)one;                    /* all ones */
    s128 min = (s128)((u128)one << 127);      /* sign bit only */
    s128 pos = (s128)one;

    /* Equality decided by either half. */
    if (!(v == v) || v != v)
        return 1;
    if (v == w || !(v != w))
        return 2;
    if (v == (v ^ ((u128)one << 127)))
        return 3;

    /* Unsigned ordering: high half first, low half on ties. */
    if (!(v < w) || v > w || !(v <= w) || !(w >= v) || w <= v || v >= w)
        return 4;
    if (!(v < (u128)neg) || !(((u128)one << 64) < v))
        return 5;
    if (!((u128)lo_src < ((u128)one << 64)))
        return 6;

    /* Signed ordering: all-ones is -1, sign bit only is the minimum. */
    if (!(neg < pos) || neg > pos || !(min < neg) || !(min < pos))
        return 7;
    if (!(neg >= min) || !(pos > min) || min > min || !(min <= min))
        return 8;
    /* Same bit patterns compare the other way unsigned. */
    if (!((u128)neg > (u128)pos) || !((u128)min > (u128)pos))
        return 9;

    /* Equal high halves, ordering from the unsigned low half, both
       signednesses. */
    s128 s1 = (s128)(((u128)one << 64) | 5);
    s128 s2 = (s128)(((u128)one << 64) | 0x8000000000000000ULL);
    if (!(s1 < s2) || s1 >= s2)
        return 10;
    if (!((u128)s1 < (u128)s2))
        return 11;

    /* Comparison against a converted scalar. */
    if (v < lo_src || !(v > one) || (u128)lo_src != lo_src)
        return 12;
    return 0;
}
