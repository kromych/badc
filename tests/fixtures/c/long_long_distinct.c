// Verify `long` and `long long` are distinct type tags, with the
// per-target widths that C99 / Microsoft pick:
//   * Linux + macOS (LP64):  long = 8, long long = 8
//   * Windows (LLP64):       long = 4, long long = 8
//
// The fixture is designed to pass on every supported target;
// each platform's expected sizes are gated by `__BADC_WINDOWS__`.
#include <stdio.h>

int main() {
    // long long is always 8 bytes regardless of target.
    if (sizeof(long long) != 8) return 1;
    if (sizeof(unsigned long long) != 8) return 2;

    // long is 8 on LP64, 4 on LLP64.
#ifdef __BADC_WINDOWS__
    if (sizeof(long) != 4) return 3;
    if (sizeof(unsigned long) != 4) return 4;
#else
    if (sizeof(long) != 8) return 3;
    if (sizeof(unsigned long) != 8) return 4;
#endif

    // C99 size-ordering: long <= long long.
    if (sizeof(long) > sizeof(long long)) return 5;

    // long long round-trips through storage at full 64-bit width
    // even on LLP64 where the same value would truncate in a long.
    long long lv = 0x123456789ABCDEFLL;
    if (lv != 0x123456789ABCDEFLL) return 6;

    // Negative long long round-trips.
    long long neg = -1LL;
    if (neg != -1LL) return 7;

    // Mixed long / long long arithmetic per C99 6.3.1.8: the
    // common type is the one with higher rank (long long).
    long ls = 100;
    long long lls = 200;
    long long sum = ls + lls;
    if (sum != 300) return 8;

    // Pointer arithmetic on long *: byte stride is sizeof(long),
    // 4 on Windows / 8 elsewhere.
    long arr[3];
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;
    long *p = arr;
    if (*(p + 1) != 20) return 9;
    if (*(p + 2) != 30) return 10;

    // Pointer arithmetic on long long *: byte stride is 8 always.
    long long llarr[3];
    llarr[0] = 100LL;
    llarr[1] = 200LL;
    llarr[2] = 300LL;
    long long *q = llarr;
    if (*(q + 1) != 200LL) return 11;
    if (*(q + 2) != 300LL) return 12;

    printf("OK\n");
    return 0;
}
