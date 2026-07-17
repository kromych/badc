// A struct-based 128-bit integer, the fallback shape used when the compiler
// has no __int128. It exercises 16-byte struct-by-value returns and
// parameters, designated compound literals, and carry / borrow arithmetic
// across the 64-bit halves. Returns 0 on success; a distinct non-zero code
// per failure.

#include <stdint.h>
#include <stdbool.h>

typedef struct Int128 {
    uint64_t lo;
    int64_t hi;
} Int128;

static inline Int128 make64(uint64_t a) {
    return (Int128){.lo = a, .hi = 0};
}
static inline Int128 make128(uint64_t lo, uint64_t hi) {
    return (Int128){.lo = lo, .hi = hi};
}
static inline Int128 add(Int128 a, Int128 b) {
    uint64_t lo = a.lo + b.lo;
    return make128(lo, (uint64_t)a.hi + b.hi + (lo < a.lo));
}
static inline Int128 sub(Int128 a, Int128 b) {
    return make128(a.lo - b.lo, (uint64_t)a.hi - b.hi - (a.lo < b.lo));
}
static inline Int128 neg(Int128 a) {
    uint64_t lo = ~a.lo + 1;
    return make128(lo, ~(uint64_t)a.hi + !lo);
}
static inline Int128 lshift(Int128 a, int n) {
    if (n >= 64) {
        return make128(0, a.lo << (n - 64));
    }
    return make128(a.lo << n, ((uint64_t)a.hi << n) | (n ? a.lo >> (64 - n) : 0));
}
static inline Int128 rshift(Int128 a, int n) {
    if (n >= 64) {
        return make128(a.hi >> (n - 64), a.hi >> 63);
    }
    return make128((a.lo >> n) | ((uint64_t)a.hi << (64 - n)), a.hi >> n);
}
static inline bool eq(Int128 a, Int128 b) {
    return a.lo == b.lo && a.hi == b.hi;
}
static inline bool lt(Int128 a, Int128 b) {
    return a.hi < b.hi || (a.hi == b.hi && a.lo < b.lo);
}

int main(void) {
    // Carry across the boundary: UINT64_MAX + 1.
    Int128 s = add(make64(0xffffffffffffffffULL), make64(1));
    if (s.lo != 0 || s.hi != 1) {
        return 1;
    }
    // Borrow: 2^64 - 1.
    Int128 d = sub(make128(0, 1), make64(1));
    if (d.lo != 0xffffffffffffffffULL || d.hi != 0) {
        return 2;
    }
    // -1 is all ones.
    Int128 n = neg(make64(1));
    if (n.lo != 0xffffffffffffffffULL || (uint64_t)n.hi != 0xffffffffffffffffULL) {
        return 3;
    }
    // 1 << 64 lands in the high half.
    Int128 l = lshift(make64(1), 64);
    if (l.lo != 0 || l.hi != 1) {
        return 4;
    }
    // 1 << 100.
    Int128 l2 = lshift(make64(1), 100);
    if (l2.lo != 0 || (uint64_t)l2.hi != (1ULL << 36)) {
        return 5;
    }
    // Arithmetic right shift keeps the sign.
    Int128 r = rshift(make128(0, 0x8000000000000000ULL), 4);
    if ((uint64_t)r.hi != 0xf800000000000000ULL) {
        return 6;
    }
    // Comparisons.
    if (!eq(s, make128(0, 1)) || !lt(make64(5), make64(9)) || lt(make64(9), make64(5))) {
        return 7;
    }
    return 0;
}
