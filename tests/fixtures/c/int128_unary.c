/* GCC 128-bit integer unary operators and value contexts: `!`, `~`,
   unary minus, the controlling-expression truthiness test (which must
   read the value, not the object's address), a conditional yielding a
   128-bit value, and the short-circuit operators. Exit 0 on success; a
   distinct non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 one = 1;

static int chk(u128 x, u64 lo, u64 hi, int code) {
    if ((u64)x != lo || (u64)(x >> 64) != hi)
        return code;
    return 0;
}

int main(void) {
    u128 z = 0;
    u128 nz = (u128)one << 100;
    int r;

    /* Logical negation reads the value: zero only when both halves
       are zero. */
    if ((!z) != 1 || (!nz) != 0)
        return 1;

    /* Bitwise complement covers both halves. */
    if ((r = chk(~z, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 2)))
        return r;

    /* Two's-complement negation borrows into the high half. */
    if ((r = chk(-nz, 0, 0xfffffff000000000ULL, 3)))
        return r;

    /* A controlling expression tests the value. The object's address
       is never zero, so an address test would read every value as
       true. */
    if (z)
        return 4;
    if (!nz)
        return 5;
    if ((z ? 1 : 0) != 0 || (nz ? 1 : 0) != 1)
        return 6;
    if ((z && 1) || !(nz && 1) || (z || 0) || !(nz || 0))
        return 7;

    /* A conditional whose arms are 128-bit values. */
    u128 pick = one ? nz : z;
    if ((r = chk(pick, 0, 0x0000001000000000ULL, 8)))
        return r;

    /* Arithmetic right shift of a negative value sign-fills; the same
       bit pattern compares greater than a positive one unsigned. */
    s128 neg = -(s128)one;
    if ((r = chk((u128)(neg >> 4), 0xffffffffffffffffULL,
                 0xffffffffffffffffULL, 9)))
        return r;
    if (!((u128)neg > nz))
        return 10;
    return 0;
}
