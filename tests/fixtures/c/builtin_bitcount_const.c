// GCC bit-count builtins (`__builtin_clz` / `ctz` / `popcount` and the 64-bit
// `ll` forms) and `__builtin_constant_p` fold to integer constant expressions
// when their argument is constant. A common idiom sizes a file-scope array
// from an `ilog2`-style expression; without folding the bound looks like a VLA
// and is rejected at file scope. Values match GCC and clang, including the
// clz/ctz-at-zero result (the bit width) and the target-dependent `l` width.
// Returns 0 on success; distinct non-zero per failure.

#define ilog2_const(n) (63 - __builtin_clzll((unsigned long long)(n)))

// File-scope bounds that only fold if the builtins are integer constant
// expressions.
static int pow2_table[1 << ilog2_const(1024)];
static int cp_table[__builtin_constant_p(7) ? 5 : 1];

// Compile-time fold values, cross-checked against GCC and clang.
_Static_assert(63 - __builtin_clzll(1024ULL) == 10, "clzll of 1024");
_Static_assert(__builtin_clz(1u) == 31, "clz of 1");
_Static_assert(__builtin_clz(0x80000000u) == 0, "clz of high bit");
_Static_assert(__builtin_clzll(1ull) == 63, "clzll of 1");
_Static_assert(__builtin_ctz(8u) == 3, "ctz of 8");
_Static_assert(__builtin_ctzll(0x100000000ull) == 32, "ctzll of 2^32");
_Static_assert(__builtin_popcount(0xFFu) == 8, "popcount byte");
_Static_assert(__builtin_popcountll(0xFFFFFFFFFFFFFFFFull) == 64, "popcountll full");
// `__builtin_constant_p` is 1 for a constant argument.
_Static_assert(__builtin_constant_p(42) == 1, "constant_p of literal");

int main(void) {
    if (sizeof(pow2_table) / sizeof(pow2_table[0]) != 1024) {
        return 1;
    }
    if (sizeof(cp_table) / sizeof(cp_table[0]) != 5) {
        return 2;
    }
    // The same folds hold as ordinary run-time initializers, so the constant
    // and run-time paths agree.
    int a = 63 - __builtin_clzll(1024ULL);
    int b = __builtin_ctz(8u);
    int c = __builtin_popcountll(0xFFFFFFFFFFFFFFFFull);
    if (a != 10 || b != 3 || c != 64) {
        return 3;
    }
    return 0;
}
