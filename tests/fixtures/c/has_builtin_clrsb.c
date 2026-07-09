// `__has_builtin(NAME)` preprocessor operator and `__builtin_clrsb` /
// `__builtin_clrsbll` (count leading redundant sign bits). Each check
// returns a distinct non-zero code on failure; success returns 0.

// __has_builtin routes to the builtin for supported names and to a
// fallback for unsupported ones (the shape QEMU's host-utils.h uses).
#if __has_builtin(__builtin_clz)
#define HAVE_CLZ 1
#else
#define HAVE_CLZ 0
#endif

#if __has_builtin(__builtin_bitreverse8)
#define HAVE_BITREV 1
#else
#define HAVE_BITREV 0
#endif

// The forced-on form host-utils.h uses for clrsb.
#if __has_builtin(__builtin_clrsb) || !defined(__clang__)
#define HAVE_CLRSB 1
#else
#define HAVE_CLRSB 0
#endif

int main(void) {
    // Supported vs unsupported builtins report correctly.
    if (HAVE_CLZ != 1) {
        return 1;
    }
    if (HAVE_BITREV != 0) {
        return 2;
    }
    if (HAVE_CLRSB != 1) {
        return 3;
    }

    // clrsb on 32-bit signed values.
    if (__builtin_clrsb(0) != 31) {
        return 4;
    }
    if (__builtin_clrsb(-1) != 31) {
        return 5;
    }
    if (__builtin_clrsb(1) != 30) {
        return 6;
    }
    if (__builtin_clrsb(0x40000000) != 0) {
        return 7;
    }
    if (__builtin_clrsb(0x00FFFFFF) != 7) {
        return 8;
    }

    // clrsbll on 64-bit signed values.
    if (__builtin_clrsbll(0LL) != 63) {
        return 9;
    }
    if (__builtin_clrsbll(-1LL) != 63) {
        return 10;
    }
    if (__builtin_clrsbll(1LL) != 62) {
        return 11;
    }

    // Runtime (non-constant) operands go through the same lowering.
    volatile int v = 0x000000FF;
    volatile long long w = -1024;
    if (__builtin_clrsb(v) != 23) {
        return 12;
    }
    if (__builtin_clrsbll(w) != 53) {
        return 13;
    }
    return 0;
}
