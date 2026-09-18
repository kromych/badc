// The difference of two pointers has type ptrdiff_t (C99 6.5.6p9), and the
// element count is the byte distance divided at that width. A byte distance
// of 2 GiB and more fits no 32-bit divide, by a reciprocal or by a shift.
// The pointers are formed from integers and never dereferenced.
// Returns 0, or the number of the failed check.

#include <stddef.h>

struct T12 {
    int a, b, c;
};
struct T16 {
    long long a, b;
};

__attribute__((noinline)) static long long d12(struct T12 *p, struct T12 *q) { return p - q; }
__attribute__((noinline)) static long long d16(struct T16 *p, struct T16 *q) { return p - q; }
__attribute__((noinline)) static long long d4(int *p, int *q) { return p - q; }

int main(void) {
    struct T12 near[4];
    volatile unsigned long long base = 0x100000000000ULL;
    unsigned long long lo = base;
    // 24 GiB, 32 GiB and 256 GiB above `lo`; the last one less an element
    // keeps the top bits of the byte distance from being all alike.
    unsigned long long hi12 = lo + 12ULL * 0x80000000ULL;
    unsigned long long hi16 = lo + 16ULL * 0x80000000ULL;
    unsigned long long hi4 = lo + 4ULL * 0xfffffffffULL;

    if (sizeof(&near[3] - &near[0]) != sizeof(ptrdiff_t)) return 1;
    if (!_Generic(&near[3] - &near[0], ptrdiff_t: 1, default: 0)) return 2;
    if (&near[3] - &near[0] != 3) return 3;
    if (&near[0] - &near[3] != -3) return 4;

    if (d12((struct T12 *)hi12, (struct T12 *)lo) != 0x80000000LL) return 5;
    if (d12((struct T12 *)lo, (struct T12 *)hi12) != -0x80000000LL) return 6;
    if (d16((struct T16 *)hi16, (struct T16 *)lo) != 0x80000000LL) return 7;
    if (d16((struct T16 *)lo, (struct T16 *)hi16) != -0x80000000LL) return 8;
    if (d4((int *)hi4, (int *)lo) != 0xfffffffffLL) return 9;
    if (d4((int *)lo, (int *)hi4) != -0xfffffffffLL) return 10;
    return 0;
}
