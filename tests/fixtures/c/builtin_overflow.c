// GCC `__builtin_{add,sub,mul}_overflow(a, b, dst)`: store the wrapped
// `a op b` through `dst` and return whether the true result overflowed
// `dst`'s type. Covers signed / unsigned at 32 and 64 bits and the
// boundary cases, then the type-specific
// `__builtin_{s,u}{add,sub,mul}{,l,ll}_overflow` forms, whose name
// fixes the type instead of the result pointer's pointee. Each check
// returns a distinct non-zero code on failure; success returns 0.

#include <stdint.h>

int main(void) {
    int32_t s32;
    uint32_t u32;
    int64_t s64;
    uint64_t u64;

    // Signed 32-bit add: INT32_MAX + 1 overflows to INT32_MIN.
    if (!__builtin_add_overflow((int32_t)0x7fffffff, (int32_t)1, &s32) ||
        s32 != (int32_t)0x80000000) {
        return 1;
    }
    if (__builtin_add_overflow((int32_t)100, (int32_t)23, &s32) || s32 != 123) {
        return 2;
    }
    // Signed 32-bit sub: INT32_MIN - 1 overflows.
    if (!__builtin_sub_overflow((int32_t)(-2147483647 - 1), (int32_t)1, &s32) ||
        s32 != 0x7fffffff) {
        return 3;
    }
    // Unsigned 32-bit add wrap and sub borrow.
    if (!__builtin_add_overflow((uint32_t)0xffffffffu, (uint32_t)1, &u32) || u32 != 0) {
        return 4;
    }
    if (!__builtin_sub_overflow((uint32_t)3, (uint32_t)5, &u32) ||
        u32 != 0xfffffffeu) {
        return 5;
    }
    // 32-bit multiply overflow and exact.
    if (!__builtin_mul_overflow((int32_t)0x10000, (int32_t)0x10000, &s32) || s32 != 0) {
        return 6;
    }
    if (__builtin_mul_overflow((int32_t)3, (int32_t)7, &s32) || s32 != 21) {
        return 7;
    }

    // Signed 64-bit add / sub boundaries.
    if (!__builtin_add_overflow((int64_t)0x7fffffffffffffffLL, (int64_t)1, &s64) ||
        s64 != (int64_t)0x8000000000000000LL) {
        return 8;
    }
    if (!__builtin_sub_overflow((int64_t)(-9223372036854775807LL - 1), (int64_t)1, &s64) ||
        s64 != 0x7fffffffffffffffLL) {
        return 9;
    }
    // Signed 64-bit multiply: overflow, exact, and the INT64_MIN * -1 case.
    if (!__builtin_mul_overflow((int64_t)0x100000000LL, (int64_t)0x100000000LL, &s64) ||
        s64 != 0) {
        return 10;
    }
    if (__builtin_mul_overflow((int64_t)1000000, (int64_t)1000000, &s64) ||
        s64 != 1000000000000LL) {
        return 11;
    }
    if (!__builtin_mul_overflow((int64_t)(-9223372036854775807LL - 1), (int64_t)-1, &s64) ||
        s64 != (int64_t)0x8000000000000000LL) {
        return 12;
    }
    if (__builtin_mul_overflow((int64_t)5, (int64_t)-3, &s64) || s64 != -15) {
        return 13;
    }

    // Unsigned 64-bit add wrap, sub borrow, and multiply.
    if (!__builtin_add_overflow((uint64_t)0xffffffffffffffffULL, (uint64_t)1, &u64) ||
        u64 != 0) {
        return 14;
    }
    if (!__builtin_sub_overflow((uint64_t)3, (uint64_t)5, &u64) ||
        u64 != 0xfffffffffffffffeULL) {
        return 15;
    }
    if (!__builtin_mul_overflow((uint64_t)0x100000000ULL, (uint64_t)0x100000000ULL, &u64) ||
        u64 != 0) {
        return 16;
    }
    if (__builtin_mul_overflow((uint64_t)123456789, (uint64_t)987654321, &u64) ||
        u64 != 121932631112635269ULL) {
        return 17;
    }

    // The type-specific forms over their own types.
    {
        int si;
        unsigned int ui;
        long sl;
        unsigned long ul;
        long long sll;
        unsigned long long ull;

        if (!__builtin_sadd_overflow(2147483647, 1, &si) || si != -2147483647 - 1) {
            return 18;
        }
        if (__builtin_sadd_overflow(100, 23, &si) || si != 123) {
            return 19;
        }
        if (!__builtin_ssub_overflow(-2147483647 - 1, 1, &si) || si != 2147483647) {
            return 20;
        }
        if (!__builtin_smul_overflow(65536, 65536, &si) || si != 0) {
            return 21;
        }
        if (!__builtin_uadd_overflow(4294967295u, 1u, &ui) || ui != 0) {
            return 22;
        }
        if (!__builtin_usub_overflow(3u, 5u, &ui) || ui != 4294967294u) {
            return 23;
        }
        if (!__builtin_umul_overflow(65536u, 65536u, &ui) || ui != 0) {
            return 24;
        }
        if (__builtin_saddl_overflow(1L, 2L, &sl) || sl != 3) {
            return 25;
        }
        if (__builtin_ssubl_overflow(5L, 3L, &sl) || sl != 2) {
            return 26;
        }
        if (__builtin_smull_overflow(6L, 7L, &sl) || sl != 42) {
            return 27;
        }
        if (__builtin_uaddl_overflow(1UL, 2UL, &ul) || ul != 3) {
            return 28;
        }
        if (!__builtin_usubl_overflow(0UL, 1UL, &ul) || ul != (unsigned long)-1) {
            return 29;
        }
        if (!__builtin_saddll_overflow(9223372036854775807LL, 1LL, &sll) ||
            sll != -9223372036854775807LL - 1) {
            return 30;
        }
        if (!__builtin_smulll_overflow(4294967296LL, 4294967296LL, &sll) || sll != 0) {
            return 31;
        }
        if (!__builtin_uaddll_overflow(0xffffffffffffffffULL, 1ULL, &ull) || ull != 0) {
            return 32;
        }
        if (!__builtin_usubll_overflow(0ULL, 1ULL, &ull) ||
            ull != 0xffffffffffffffffULL) {
            return 33;
        }
        if (!__builtin_umulll_overflow(0x100000000ULL, 0x100000000ULL, &ull) || ull != 0) {
            return 34;
        }
        if (__builtin_ssubll_overflow(5LL, 3LL, &sll) || sll != 2) {
            return 35;
        }
    }
    return 0;
}
