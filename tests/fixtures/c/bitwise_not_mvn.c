// Bitwise NOT `x ^ -1` folds to a single `mvn` on AArch64 instead of
// materialising the all-ones constant and xoring. `volatile` keeps the
// operands runtime values. Returns 0 when every case matches the
// reference.

typedef unsigned long u64;

static u64 notx(u64 x) { return ~x; }
static u64 andnot(u64 x, u64 y) { return (~x) & y; }
static u64 ch(u64 x, u64 y, u64 z) { return (x & y) ^ (~x & z); }

int main(void) {
    volatile u64 a = 0x0123456789abcdefUL;
    volatile u64 b = 0xfedcba9876543210UL;
    volatile u64 c = 0xaaaa5555aaaa5555UL;
    if (notx(a) != ~a) return 1;
    if (andnot(a, b) != ((~a) & b)) return 2;
    if (ch(a, b, c) != ((a & b) ^ (~a & c))) return 3;
    a = 0;
    if (notx(a) != ~0UL) return 4;
    a = ~0UL;
    if (notx(a) != 0UL) return 5;
    return 0;
}
