/* GCC 128-bit integer multiplication: the widening 64x64 -> 128 shape
   (including the mul-high `(u128)a * b >> 64` idiom), full 128x128 low
   multiply, and signed products. Exit 0 on success; a distinct
   non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 a_src = 0xdeadbeefcafebabeULL;
volatile u64 b_src = 0xfeedface12345678ULL;

static int chk(u128 x, u64 lo, u64 hi, int code) {
    if ((u64)x != lo || (u64)(x >> 64) != hi)
        return code;
    return 0;
}

static u64 mulhi(u64 a, u64 b) {
    return (u64)(((u128)a * b) >> 64);
}

int main(void) {
    u64 a = a_src, b = b_src;
    int r;

    /* Widening 64x64 -> 128. */
    u128 p = (u128)a * b;
    if ((r = chk(p, 0xe5cf045c04bb5d10ULL, 0xddbf64749b833a3bULL, 1)))
        return r;
    if (mulhi(a, b) != 0xddbf64749b833a3bULL)
        return 2;
    if ((u64)((u128)a * b) != a * b)
        return 3;

    /* 128x128 keeps the low 128 bits. */
    u128 sq = p * p;
    if ((r = chk(sq, 0x6189c7899734a100ULL, 0x95fa4ab660420218ULL, 4)))
        return r;

    /* Signed product of two negatives is positive. */
    s128 sp = (s128)-5 * (s128)-7;
    if ((r = chk((u128)sp, 35, 0, 5)))
        return r;
    /* Mixed signs. */
    sp = (s128)((u128)1 << 100) * -3;
    if ((r = chk((u128)sp, 0, 0xffffffd000000000ULL, 6)))
        return r;

    /* Scalar operand converts: u128 * u64 and u64 * u128. */
    u128 v = ((u128)1 << 96) + 5;
    if ((r = chk(v * (u64)16, 80, 0x0000001000000000ULL, 7)))
        return r;
    if ((r = chk((u64)16 * v, 80, 0x0000001000000000ULL, 8)))
        return r;

    /* Compound multiply assignment. */
    u128 t = p;
    t *= 0x9e3779b97f4a7c15ULL;
    if ((r = chk(t, 0xe1dd0fbafb126250ULL, 0xab464fc984a537a7ULL, 9)))
        return r;
    return 0;
}
