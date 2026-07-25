// AArch64 128-bit compare-and-swap via the pre-LSE ldxp/stxp exclusive
// pair -- the shape the kernel's __ll_sc__cmpxchg128 uses when the CPU has
// no native 16-byte CAS. The 128-bit object is split into 64-bit halves so
// every asm operand is a plain 64-bit register, and the memory operand uses
// the `Q` constraint (a base register with no offset) the exclusive forms
// require. Unlike the recognized load/store idioms this is not lowered to an
// intrinsic: each instruction goes through the per-instruction inline-asm
// encoder, which is why it exercises the generic `ldxp` encoding and runs on
// native aarch64 only. Two variants mirror the kernel's plain and
// release-ordered instantiations (stxp vs stlxp + dmb ish).
//
// unsigned long long keeps each half 64-bit; the object is a 16-byte
// __int128 so the `Q` operand covers the whole pair.

typedef unsigned long long u64;
typedef unsigned __int128 u128;

union u128_halves {
    u128 full;
    struct {
        u64 lo, hi;
    };
};

// Compare *ptr against (ol, oh); store (nl, nh) and return 1 when it matched,
// otherwise leave *ptr and return 0. The prior halves are published through
// rlo / rhi. Plain (no barrier) variant: stxp.
static int cmpxchg128(volatile u128 *ptr, u64 ol, u64 oh, u64 nl, u64 nh,
                      u64 *rlo, u64 *rhi) {
    u64 rl, rh;
    unsigned int tmp;
    __asm__ volatile("       prfm    pstl1strm, %[v]\n"
                     "1:     ldxp    %[rl], %[rh], %[v]\n"
                     "       cmp     %[rl], %[ol]\n"
                     "       ccmp    %[rh], %[oh], 0, eq\n"
                     "       b.ne    2f\n"
                     "       stxp    %w[tmp], %[nl], %[nh], %[v]\n"
                     "       cbnz    %w[tmp], 1b\n"
                     "2:"
                     : [v] "+Q"(*ptr), [rl] "=&r"(rl), [rh] "=&r"(rh),
                       [tmp] "=&r"(tmp)
                     : [ol] "r"(ol), [oh] "r"(oh), [nl] "r"(nl), [nh] "r"(nh)
                     : "cc", "memory");
    *rlo = rl;
    *rhi = rh;
    return rl == ol && rh == oh;
}

// Release-ordered variant: stlxp plus a trailing dmb ish, the kernel's _mb
// instantiation.
static int cmpxchg128_mb(volatile u128 *ptr, u64 ol, u64 oh, u64 nl, u64 nh,
                         u64 *rlo, u64 *rhi) {
    u64 rl, rh;
    unsigned int tmp;
    __asm__ volatile("       prfm    pstl1strm, %[v]\n"
                     "1:     ldxp    %[rl], %[rh], %[v]\n"
                     "       cmp     %[rl], %[ol]\n"
                     "       ccmp    %[rh], %[oh], 0, eq\n"
                     "       b.ne    2f\n"
                     "       stlxp   %w[tmp], %[nl], %[nh], %[v]\n"
                     "       cbnz    %w[tmp], 1b\n"
                     "       dmb     ish\n"
                     "2:"
                     : [v] "+Q"(*ptr), [rl] "=&r"(rl), [rh] "=&r"(rh),
                       [tmp] "=&r"(tmp)
                     : [ol] "r"(ol), [oh] "r"(oh), [nl] "r"(nl), [nh] "r"(nh)
                     : "cc", "memory");
    *rlo = rl;
    *rhi = rh;
    return rl == ol && rh == oh;
}

int main(void) {
    union u128_halves obj;
    u64 rl, rh;

    obj.lo = 0x1111222233334444ULL;
    obj.hi = 0x5555666677778888ULL;

    // Matching CAS: swaps, returns the prior pair and success.
    if (!cmpxchg128(&obj.full, 0x1111222233334444ULL, 0x5555666677778888ULL,
                    0xaaaabbbbccccddddULL, 0x1122334455667788ULL, &rl, &rh))
        return 1;
    if (rl != 0x1111222233334444ULL || rh != 0x5555666677778888ULL) return 2;
    if (obj.lo != 0xaaaabbbbccccddddULL || obj.hi != 0x1122334455667788ULL)
        return 3;

    // Mismatching CAS: leaves the object, returns the current pair and fail.
    if (cmpxchg128(&obj.full, 0, 0, 0xdeadULL, 0xbeefULL, &rl, &rh)) return 4;
    if (rl != 0xaaaabbbbccccddddULL || rh != 0x1122334455667788ULL) return 5;
    if (obj.lo != 0xaaaabbbbccccddddULL || obj.hi != 0x1122334455667788ULL)
        return 6;

    // Release-ordered matching CAS: swaps.
    if (!cmpxchg128_mb(&obj.full, 0xaaaabbbbccccddddULL, 0x1122334455667788ULL,
                       0x0102030405060708ULL, 0x090a0b0c0d0e0f00ULL, &rl, &rh))
        return 7;
    if (rl != 0xaaaabbbbccccddddULL || rh != 0x1122334455667788ULL) return 8;
    if (obj.lo != 0x0102030405060708ULL || obj.hi != 0x090a0b0c0d0e0f00ULL)
        return 9;

    // Release-ordered mismatching CAS: leaves the object.
    if (cmpxchg128_mb(&obj.full, 1, 2, 3, 4, &rl, &rh)) return 10;
    if (rl != 0x0102030405060708ULL || rh != 0x090a0b0c0d0e0f00ULL) return 11;

    return 0;
}
