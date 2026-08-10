/* GCC 128-bit integer shifts: left / logical-right / arithmetic-right
   by 0, 1, 63, 64, 65, 127, with both constant and runtime counts.
   Exit 0 on success; a distinct non-zero code per failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 lo_src = 0x0011223344556677ULL;
volatile u64 hi_src = 0x8899aabbccddeeffULL;
volatile int counts[6] = {0, 1, 63, 64, 65, 127};

static int chk(u128 x, u64 lo, u64 hi, int code) {
    if ((u64)x != lo || (u64)(x >> 64) != hi)
        return code;
    return 0;
}

static const u64 shl_lo[6] = {0x0011223344556677ULL, 0x0022446688aacceeULL,
                              0x8000000000000000ULL, 0, 0, 0};
static const u64 shl_hi[6] = {0x8899aabbccddeeffULL, 0x1133557799bbddfeULL,
                              0x80089119a22ab33bULL, 0x0011223344556677ULL,
                              0x0022446688aacceeULL, 0x8000000000000000ULL};
static const u64 shr_lo[6] = {0x0011223344556677ULL, 0x80089119a22ab33bULL,
                              0x1133557799bbddfeULL, 0x8899aabbccddeeffULL,
                              0x444cd55de66ef77fULL, 0x0000000000000001ULL};
static const u64 shr_hi[6] = {0x8899aabbccddeeffULL, 0x444cd55de66ef77fULL,
                              0x0000000000000001ULL, 0, 0, 0};
static const u64 sar_lo[6] = {0x0000000000000001ULL, 0, 0,
                              0x8000000000000000ULL, 0xc000000000000000ULL,
                              0xffffffffffffffffULL};
static const u64 sar_hi[6] = {0x8000000000000000ULL, 0xc000000000000000ULL,
                              0xffffffffffffffffULL, 0xffffffffffffffffULL,
                              0xffffffffffffffffULL, 0xffffffffffffffffULL};

int main(void) {
    u128 v = ((u128)hi_src << 64) | lo_src;
    s128 x = (s128)(((u128)0x8000000000000000ULL << 64) | 1);
    int r, i;

    /* Runtime counts. */
    for (i = 0; i < 6; i++) {
        int n = counts[i];
        if ((r = chk(v << n, shl_lo[i], shl_hi[i], 20 + i)))
            return r;
        if ((r = chk(v >> n, shr_lo[i], shr_hi[i], 30 + i)))
            return r;
        if ((r = chk((u128)(x >> n), sar_lo[i], sar_hi[i], 40 + i)))
            return r;
    }

    /* Constant counts. */
    if ((r = chk(v << 0, shl_lo[0], shl_hi[0], 1)))
        return r;
    if ((r = chk(v << 1, shl_lo[1], shl_hi[1], 2)))
        return r;
    if ((r = chk(v << 63, shl_lo[2], shl_hi[2], 3)))
        return r;
    if ((r = chk(v << 64, shl_lo[3], shl_hi[3], 4)))
        return r;
    if ((r = chk(v << 65, shl_lo[4], shl_hi[4], 5)))
        return r;
    if ((r = chk(v << 127, shl_lo[5], shl_hi[5], 6)))
        return r;
    if ((r = chk(v >> 1, shr_lo[1], shr_hi[1], 7)))
        return r;
    if ((r = chk(v >> 64, shr_lo[3], shr_hi[3], 8)))
        return r;
    if ((r = chk(v >> 127, shr_lo[5], shr_hi[5], 9)))
        return r;
    if ((r = chk((u128)(x >> 1), sar_lo[1], sar_hi[1], 10)))
        return r;
    if ((r = chk((u128)(x >> 64), sar_lo[3], sar_hi[3], 11)))
        return r;
    if ((r = chk((u128)(x >> 127), sar_lo[5], sar_hi[5], 12)))
        return r;

    /* Compound shift assignment. */
    u128 t = v;
    t <<= 64;
    t >>= counts[3];
    if ((r = chk(t, lo_src, 0, 13)))
        return r;
    return 0;
}
