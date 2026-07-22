// GCC bit / byte builtins fold in an integer constant expression: a `case`
// label, an array bound, and `_Static_assert` all accept them. The byte-swap
// builtins carry their fixed-width unsigned result type (uint16_t / uint32_t
// / uint64_t); the bit builtins yield `int`. Values match GCC and clang.
// Returns 0 on success; distinct non-zero per failure.

// Byte-order helper of the shape network headers use for `case htons(...)`.
#define bswap16(x) __builtin_bswap16(x)

// Compile-time fold values, cross-checked against GCC and clang.
_Static_assert(__builtin_bswap16(0x1234) == 0x3412, "bswap16");
_Static_assert(__builtin_bswap16(0x00FF) == 0xFF00, "bswap16 high byte");
_Static_assert(__builtin_bswap32(0x12345678u) == 0x78563412u, "bswap32");
_Static_assert(__builtin_bswap32(0x000000FFu) == 0xFF000000u, "bswap32 top byte");
// The result is unsigned, so a byte-swap that sets the top bit stays positive.
_Static_assert(__builtin_bswap32(0x000000FFu) > 0, "bswap32 unsigned result");
_Static_assert(__builtin_bswap64(0x0123456789ABCDEFull) == 0xEFCDAB8967452301ull, "bswap64");
_Static_assert(__builtin_ffs(0) == 0, "ffs zero");
_Static_assert(__builtin_ffs(1) == 1, "ffs one");
_Static_assert(__builtin_ffs(0x1234) == 3, "ffs lowest set bit");
_Static_assert(__builtin_ffsll(0x8000000000000000ull) == 64, "ffsll sign bit");
_Static_assert(__builtin_clrsb(0) == 31, "clrsb zero");
_Static_assert(__builtin_clrsb(1) == 30, "clrsb one");
_Static_assert(__builtin_parity(0xFF) == 0, "parity even");
_Static_assert(__builtin_parity(0x1234) == 1, "parity odd");

// File-scope array bounds folded from bit / byte builtins (a VLA is rejected
// at file scope, so these compile only if the builtins are constant).
static int swap_table[__builtin_bswap16(0x0100)]; // 0x0001 -> 1 element
static int ffs_table[__builtin_ffs(0x1234)];      // 3 elements

int classify(unsigned short v) {
    switch (v) {
        // `case htons(...)` shape: the builtin folds to a case label.
        case bswap16(0x1234): return 1;           // matches 0x3412
        case __builtin_bswap16(0x00FF): return 2; // matches 0xFF00
        default: return 0;
    }
}

int main(void) {
    if (sizeof(swap_table) / sizeof(swap_table[0]) != 1) return 1;
    if (sizeof(ffs_table) / sizeof(ffs_table[0]) != 3) return 2;
    // Negative control: an unmatched value falls to the default arm, so the
    // switch really discriminates rather than always returning a case.
    if (classify(0x3412) != 1) return 3;
    if (classify(0xFF00) != 2) return 4;
    if (classify(0x1234) != 0) return 5;

    // The same folds hold as run-time values, so the constant and run-time
    // paths agree. A volatile operand forces the run-time lowering.
    if (__builtin_bswap32(0x12345678u) != 0x78563412u) return 6;
    if (__builtin_ffs(0x1234) != 3) return 7;
    volatile unsigned x = 0x12345678u;
    if (__builtin_bswap32(x) != 0x78563412u) return 8;
    volatile unsigned short s = 0x1234;
    if (__builtin_bswap16(s) != 0x3412) return 9;
    return 0;
}
