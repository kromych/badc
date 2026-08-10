// GCC `__builtin_{add,sub,mul}_overflow` with a 128-bit operand or
// result. The builtins evaluate in infinite precision and report whether
// the result is representable in the destination type, so the operand
// types' signedness matters independently of the destination's. Covers
// the wrap / borrow / carry edges, the signed multiply's 2^127
// boundary, mixed operand signedness, a narrower destination fed by
// 128-bit operands, and a 128-bit destination fed by 64-bit operands.
// Every expected value is what gcc -O0 / -O2 and clang -O2 produce.
// Each check returns a distinct non-zero code on failure.

typedef unsigned __int128 u128;
typedef __int128 s128;

static int chk(int got_flag, u128 got, int want_flag, unsigned long long want_hi,
               unsigned long long want_lo, int code) {
    if (got_flag != want_flag) {
        return code;
    }
    if ((unsigned long long)got != want_lo) {
        return code + 1;
    }
    if ((unsigned long long)(got >> 64) != want_hi) {
        return code + 2;
    }
    return 0;
}

int main(void) {
    const u128 umax = ~(u128)0;
    const s128 smin = (s128)((u128)1 << 127);
    const s128 smax = (s128)(((u128)1 << 127) - 1);
    u128 ur;
    s128 sr;
    unsigned u32;
    int i32;
    unsigned long long u64;
    long long i64;
    int o, r;

    // Unsigned 128-bit: carry out of bit 127, borrow, and the product
    // that needs more than 128 bits.
    o = __builtin_add_overflow(umax, (u128)1, &ur);
    if ((r = chk(o, ur, 1, 0, 0, 1))) {
        return r;
    }
    o = __builtin_add_overflow(umax, (u128)0, &ur);
    if ((r = chk(o, ur, 0, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 4))) {
        return r;
    }
    o = __builtin_sub_overflow((u128)0, (u128)1, &ur);
    if ((r = chk(o, ur, 1, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 7))) {
        return r;
    }
    o = __builtin_mul_overflow((u128)1 << 64, (u128)1 << 64, &ur);
    if ((r = chk(o, ur, 1, 0, 0, 10))) {
        return r;
    }
    o = __builtin_mul_overflow((u128)1 << 127, (u128)1, &ur);
    if ((r = chk(o, ur, 0, 0x8000000000000000ULL, 0, 13))) {
        return r;
    }
    // Carry out of the cross-product sum into bit 128.
    o = __builtin_mul_overflow(((u128)3 << 64) | 5, (u128)1 << 63, &ur);
    if ((r = chk(o, ur, 1, 0x8000000000000002ULL, 0x8000000000000000ULL, 16))) {
        return r;
    }

    // Signed 128-bit: the sign-overflow edges and the multiply whose
    // magnitude reaches exactly 2^127, representable only when negative.
    o = __builtin_add_overflow(smax, (s128)1, &sr);
    if ((r = chk(o, (u128)sr, 1, 0x8000000000000000ULL, 0, 19))) {
        return r;
    }
    o = __builtin_add_overflow(smin, (s128)-1, &sr);
    if ((r = chk(o, (u128)sr, 1, 0x7fffffffffffffffULL, 0xffffffffffffffffULL, 22))) {
        return r;
    }
    o = __builtin_add_overflow(smax, (s128)-1, &sr);
    if ((r = chk(o, (u128)sr, 0, 0x7fffffffffffffffULL, 0xfffffffffffffffeULL, 25))) {
        return r;
    }
    o = __builtin_sub_overflow(smin, (s128)1, &sr);
    if ((r = chk(o, (u128)sr, 1, 0x7fffffffffffffffULL, 0xffffffffffffffffULL, 28))) {
        return r;
    }
    o = __builtin_mul_overflow(smin, (s128)-1, &sr);
    if ((r = chk(o, (u128)sr, 1, 0x8000000000000000ULL, 0, 31))) {
        return r;
    }
    o = __builtin_mul_overflow((s128)1 << 100, -((s128)1 << 27), &sr);
    if ((r = chk(o, (u128)sr, 0, 0x8000000000000000ULL, 0, 34))) {
        return r;
    }
    o = __builtin_mul_overflow((s128)1 << 100, (s128)1 << 27, &sr);
    if ((r = chk(o, (u128)sr, 1, 0x8000000000000000ULL, 0, 37))) {
        return r;
    }
    o = __builtin_mul_overflow(smin, (s128)0, &sr);
    if ((r = chk(o, (u128)sr, 0, 0, 0, 40))) {
        return r;
    }

    // Mixed operand signedness: an unsigned 128-bit value plus a
    // negative one is the exact sum, not a conversion to either domain.
    o = __builtin_add_overflow((u128)1 << 127, -1, &ur);
    if ((r = chk(o, ur, 0, 0x7fffffffffffffffULL, 0xffffffffffffffffULL, 43))) {
        return r;
    }
    o = __builtin_sub_overflow(umax, (s128)-1, &ur);
    if ((r = chk(o, ur, 1, 0, 0, 46))) {
        return r;
    }
    o = __builtin_add_overflow(umax, (s128)0, &sr);
    if ((r = chk(o, (u128)sr, 1, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 49))) {
        return r;
    }
    o = __builtin_mul_overflow(umax, (s128)-1, &sr);
    if ((r = chk(o, (u128)sr, 1, 0, 1, 52))) {
        return r;
    }

    // Narrower destination fed by 128-bit operands: the stored value is
    // the truncation, the flag also covers what the truncation lost.
    o = __builtin_add_overflow((u128)100, (u128)23, &u32);
    if ((r = chk(o, (u128)u32, 0, 0, 123, 55))) {
        return r;
    }
    o = __builtin_add_overflow((u128)0xffffffff, (u128)1, &u32);
    if ((r = chk(o, (u128)u32, 1, 0, 0, 58))) {
        return r;
    }
    o = __builtin_sub_overflow((s128)5, (s128)7, &i32);
    if ((r = chk(o, (u128)(s128)i32, 0, 0xffffffffffffffffULL, 0xfffffffffffffffeULL, 61))) {
        return r;
    }
    o = __builtin_mul_overflow((s128)0x10000, (s128)0x10000, &i32);
    if ((r = chk(o, (u128)(s128)i32, 1, 0, 0, 64))) {
        return r;
    }
    o = __builtin_sub_overflow((u128)0, (u128)1, &u64);
    if ((r = chk(o, (u128)u64, 1, 0, 0xffffffffffffffffULL, 67))) {
        return r;
    }
    o = __builtin_mul_overflow((s128)-3, (s128)5, &i64);
    if ((r = chk(o, (u128)(s128)i64, 0, 0xffffffffffffffffULL, 0xfffffffffffffff1ULL, 70))) {
        return r;
    }
    o = __builtin_add_overflow((s128)1 << 63, (s128)0, &i64);
    if ((r = chk(o, (u128)(s128)i64, 1, 0xffffffffffffffffULL, 0x8000000000000000ULL, 73))) {
        return r;
    }

    // 64-bit operands with a 128-bit destination: the exact result
    // always fits, including the cases that overflow 64 bits.
    o = __builtin_mul_overflow(-9223372036854775807LL - 1, -1LL, &sr);
    if ((r = chk(o, (u128)sr, 0, 0, 0x8000000000000000ULL, 76))) {
        return r;
    }
    o = __builtin_add_overflow(0xffffffffffffffffULL, 1ULL, &ur);
    if ((r = chk(o, ur, 0, 1, 0, 79))) {
        return r;
    }
    // A negative exact result is not representable unsigned.
    o = __builtin_sub_overflow(0, 1, &ur);
    if ((r = chk(o, ur, 1, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 82))) {
        return r;
    }
    return 0;
}
