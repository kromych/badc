// C99 6.3.1.4: converting an unsigned integer to a floating type uses
// the unsigned value. A 64-bit unsigned value with bit 63 set exceeds
// the signed range, where a signed convert instruction would yield a
// negative result, so the unsigned conversion sequence is required.
// Narrower unsigned types and signed sources keep the signed convert.
#include <stdio.h>

int main(void) {
    unsigned long long a = 9223372036854775808ULL;  // 2^63, exact in double
    unsigned long long b = 12345678901234567890ULL; // rounds
    unsigned long long c = 18446744073709551615ULL;  // 2^64-1, rounds to 2^64
    unsigned long lo = 100;                          // fast path, bit 63 clear
    long long s = -1;                                // signed stays negative

    if ((double)a != 9223372036854775808.0) {
        return 1;
    }
    if ((double)b != 12345678901234567168.0) {
        return 2;
    }
    if ((double)c != 18446744073709551616.0) {
        return 3;
    }
    if ((double)lo != 100.0) {
        return 4;
    }
    if ((double)s != -1.0) {
        return 5;
    }
    if ((float)a != 9223372036854775808.0f) {
        return 6;
    }
    return 0;
}
