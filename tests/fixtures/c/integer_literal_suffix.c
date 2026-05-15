// Locks C99 6.4.4.1 paragraph 5: a decimal integer literal's
// type is determined by its suffix:
//   * no suffix   -> int / long / long long (first that fits)
//   * `u`/`U`     -> unsigned int / unsigned long / unsigned long long
//   * `l`/`L`     -> long / long long
//   * `ll`/`LL`   -> long long
//   * combinations -> the union (e.g. `ull` is unsigned long long)
//
// Dropping the suffix on the floor and typing every numeric
// literal as `int` truncates subsequent 64-bit arithmetic
// through the int rank: `(1ULL << 36) - 1` then routes through
// the signed-int common-width sign-extension and ends up as
// `0xffffffffffffffff` instead of `0xfffffffff`.
//
// Each failure returns a distinct nonzero code.

typedef unsigned long long uint64_t;

int main(void) {
    // The dominant repro: shift past the int width, then any
    // arithmetic that mixes the shift result with an int literal
    // must preserve the unsigned long long type.
    {
        uint64_t mask = (1ULL << 36) - 1;
        if (mask != 0xfffffffffULL) return 11;
    }

    // The same with a runtime shift count.
    {
        int n = 36;
        uint64_t mask = (1ULL << n) - 1;
        if (mask != 0xfffffffffULL) return 12;
    }

    // ull literal kept across arithmetic.
    {
        uint64_t a = 0x123456789ULL;
        uint64_t b = a + 1ULL;
        if (b != 0x12345678aULL) return 13;
    }

    // Comparison preserves the unsigned 64-bit width: 0xfff...
    // as ull must NOT compare equal to (int)-1.
    {
        uint64_t v = 0xffffffffffffffffULL;
        if (v == (uint64_t)(int)-1 && v == 0xffffffffULL) return 14;
        // v is all ones; (int)-1 promoted to ull is also all
        // ones; v == ull(-1) is true, v == 0xffffffff is false.
        if (v != 0xffffffffffffffffULL) return 15;
    }

    // Hex literal with ULL suffix at the upper edge of u64.
    {
        uint64_t v = 0xFFFFFFFFFFFFFFFFULL;
        if (v + 1ULL != 0ULL) return 16;
    }

    return 0;
}
