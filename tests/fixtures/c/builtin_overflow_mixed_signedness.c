// GCC `__builtin_{add,sub,mul}_overflow` with operands whose signedness
// or width differs from the result's: the operation is exact (gcc:
// "performed in infinite signed precision") and the flag reports whether
// the exact value fits the type the result points to; the stored value
// is that value converted to it. Each operand/result signedness pair at
// 64 bits, and 64-bit operands into a 32-bit result. The expected flags
// and values are gcc 16's and clang 22's. Each check returns its own id.

#define CHECK(id, OP, A, B, RT, OVF, VAL)                                    \
    do {                                                                     \
        RT r_;                                                               \
        if (__builtin_##OP##_overflow(A, B, &r_) != (OVF) || r_ != (RT)(VAL)) \
            return id;                                                       \
    } while (0)

int main(void) {
    typedef unsigned long long u64;
    typedef long long s64;
    typedef unsigned int u32;

    // Signed operands, unsigned 64-bit result: a negative value overflows.
    CHECK(1, add, -1LL, 0LL, u64, 1, 0xffffffffffffffffull);
    CHECK(2, add, -1, 0, u64, 1, 0xffffffffffffffffull);
    CHECK(3, sub, 0LL, 1LL, u64, 1, 0xffffffffffffffffull);
    CHECK(4, add, 0x7fffffffffffffffLL, 0x7fffffffffffffffLL, u64, 0, 0xfffffffffffffffeull);
    CHECK(5, mul, -1LL, 1LL, u64, 1, 0xffffffffffffffffull);
    CHECK(6, mul, -2LL, -3LL, u64, 0, 6);

    // Unsigned operands, signed 64-bit result.
    CHECK(10, add, 0xffffffffffffffffull, 0ull, s64, 1, -1);
    CHECK(11, add, 0x7fffffffffffffffull, 1ull, s64, 1, 0x8000000000000000ull);
    CHECK(12, sub, 0ull, 1ull, s64, 0, -1);
    CHECK(13, sub, 0ull, 0x8000000000000000ull, s64, 0, 0x8000000000000000ull);
    CHECK(14, sub, 0ull, 0x8000000000000001ull, s64, 1, 0x7fffffffffffffffull);
    CHECK(15, mul, 0x80000000ull, 0x100000000ull, s64, 1, 0x8000000000000000ull);

    // Mixed operands.
    CHECK(20, add, -1LL, 0xffffffffffffffffull, u64, 0, 0xfffffffffffffffeull);
    CHECK(21, add, -1LL, 0xffffffffffffffffull, s64, 1, -2);
    CHECK(22, sub, 5ull, -3LL, u64, 0, 8);
    CHECK(23, sub, -3LL, 5ull, s64, 0, -8);
    CHECK(24, mul, -2LL, 0x4000000000000000ull, s64, 0, 0x8000000000000000ull);
    CHECK(25, mul, -2LL, 0x4000000000000001ull, s64, 1, 0x7ffffffffffffffeull);
    CHECK(26, mul, -1LL, 0x8000000000000000ull, u64, 1, 0x8000000000000000ull);

    // Same signedness at 64 bits stays as it was.
    CHECK(30, add, 0xffffffffffffffffull, 1ull, u64, 1, 0);
    CHECK(31, add, 0x7fffffffffffffffLL, 1LL, s64, 1, 0x8000000000000000ull);
    CHECK(32, sub, (s64)0x8000000000000000ull, 1LL, s64, 1, 0x7fffffffffffffffull);
    CHECK(33, mul, 0x100000000ull, 0x100000000ull, u64, 1, 0);

    // 64-bit operands, 32-bit result: the exact value decides.
    CHECK(40, add, 0xffffffffffffffffull, 1ull, u32, 1, 0);
    CHECK(41, mul, 0x100000000ull, 0x100000000ull, u32, 1, 0);
    CHECK(42, add, -1LL, 0LL, u32, 1, 0xffffffffu);
    CHECK(43, add, 0xffffffffull, 0LL, u32, 0, 0xffffffffu);
    CHECK(44, sub, 0x100000005ull, 0x100000000ull, int, 0, 5);
    CHECK(45, add, -0x80000000LL, -1LL, int, 1, 0x7fffffff);
    return 0;
}
